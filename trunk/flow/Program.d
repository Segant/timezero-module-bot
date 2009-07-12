module Program;

private import tango.io.model.IConduit;
private import Array = tango.core.Array;
private import flow.Rectangle;
private import flow.Header;
private import flow.TagType;
private import flow.Tag;
private import flow.FlashEncoder;
private import flow.FlashDecoder;
private import tango.io.FileConduit;
private import tango.io.FilePath;
private import tango.io.Stdout;

void decompressSWF(InputStream input, OutputStream output) {
	FlashDecoder decoder = new FlashDecoder(input);
	FlashEncoder encoder = new FlashEncoder(output);

	Header header = decoder.readHeader();
	header.compressed = false;
	encoder.writeHeader(header);

	while (true) {
		Tag tag = decoder.readTag();

		encoder.writeTag(tag);

		if (tag.type == TagType.END) {
			break;
		}
	}

	encoder.close();
	decoder.close();
}
void decompressSWF(char[] from, char[] to) {
	FileConduit input = new FileConduit(from);
	FileConduit output = new FileConduit(to, FileConduit.WriteCreate);
	decompressSWF(input, output);
	input.close();
	output.close();
}

void compressSWF(InputStream input, OutputStream output) {
	FlashDecoder decoder = new FlashDecoder(input);
	FlashEncoder encoder = new FlashEncoder(output);

	Header header = decoder.readHeader();
	header.compressed = true;
	encoder.writeHeader(header);

	while (true) {
		Tag tag = decoder.readTag();

		encoder.writeTag(tag);

		if (tag.type == TagType.END) {
			break;
		}
	}

	encoder.close();
	decoder.close();
}
void compressSWF(char[] from, char[] to) {
	FileConduit input = new FileConduit(from);
	FileConduit output = new FileConduit(to, FileConduit.WriteCreate);
	compressSWF(input, output);
	input.close();
	output.close();
}

/*void disassembleSWF(char[] from) {
	FileConduit input = new FileConduit(from);
	FlashDecoder decoder = new FlashDecoder(input);

	Header header = decoder.readHeader();

	while (true) {
		Tag tag = decoder.readTag();

		if (tag.type == TagType.DOACTION) {
			Disassembler disassembler = new Disassembler();
			disassembler.disassemble(tag.data);
		}

		if (tag.type == TagType.END) {
			break;
		}
	}

	decoder.close();
	input.close();
}*/

int printUsage() {
	Stderr("Usage flow [arguments]                 ").newline;
	Stderr(" Arguments :                           ").newline;
	Stderr("  --decompress        [in] [out]       ").newline;
	Stderr("  --compress          [in] [out]       ").newline;
	Stderr("  --information       [in]             ").newline;
	Stderr("  --inject            [in1] [in2] [out]").newline;

	return 1;
}

int main(char[][] args) {
	if (args.length < 2) {
		return printUsage();
	}
	switch (args[1]) {
		case "--decompress":
			if (args.length != 4) {
				return printUsage();
			}

			char[] input = args[2];
			char[] output = args[3];

			if (!FilePath(input).exists()) {
				Stderr("Couldn't find " ~ input).newline;
				return printUsage();
			}

			decompressSWF(input, output);

			break;

		case "--compress":
			if (args.length != 4) {
				return printUsage();
			}

			char[] input = args[2];
			char[] output = args[3];

			if (!FilePath(input).exists()) {
				Stderr("Couldn't find " ~ input).newline;
				return printUsage();
			}

			compressSWF(input, output);

			break;

		case "--information":
			if (args.length != 3) {
				return printUsage();
			}

			char[] input = args[2];

			if (!FilePath(input).exists()) {
				Stderr("Couldn't find " ~ input).newline;
				return printUsage();
			}

			FlashDecoder decoder = new FlashDecoder(new FileConduit(args[2]));
			Header header = decoder.readHeader();

			Stdout.formatln(
				"Compressed   : {}\n" ~
				"Version      : {}\n" ~
				"Frame rate   : {}\n" ~
				"Movie width  : {}\n" ~
				"Movie height : {}\n" ~
				"Total frames : {}\n",
				header.compressed, header.swfVersion, header.frameRate / 256.0,
				header.frameSize.maxX / 20.0, header.frameSize.maxY / 20.0,
				header.frameCount);

			break;

		/*case "--disassemble":
			if (args.length != 3) {
				return printUsage();
			}

			char[] input = args[2];

			if (!FilePath(input).exists()) {
				Stderr("Couldn't find " ~ input).newline;
				return printUsage();
			}

			disassembleSWF(input);

			break;*/

		case "--inject" :
			if (args.length != 5) {
				return printUsage();
			}

			char[] in1 = args[2];
			char[] in2 = args[3];
			char[] to = args[4];

			if (!FilePath(in1).exists()) {
				Stderr("Couldn't find " ~ in1).newline;
				return printUsage();
			}
			if (!FilePath(in2).exists()) {
				Stderr("Couldn't find " ~ in2).newline;
				return printUsage();
			}

			Tag findActionBlock(char[] src) {
				FileConduit input = new FileConduit(src);
				FlashDecoder decoder = new FlashDecoder(input);

				Header header = decoder.readHeader();

				while (true) {
					Tag tag = decoder.readTag();

					if (tag.type == TagType.DOACTION) {
						decoder.close();
						input.close();
						return tag;
					}

					if (tag.type == TagType.END) {
						decoder.close();
						input.close();
						break;
					}
				}

				assert(0);
			}

			Tag action = findActionBlock(in1);

			FileConduit input = new FileConduit(in2);
			FileConduit output = new FileConduit(to, FileConduit.WriteCreate);
			
			FlashDecoder decoder = new FlashDecoder(input);
			FlashEncoder encoder = new FlashEncoder(output);

			Header header = decoder.readHeader();
			encoder.writeHeader(header);

			bool success = false;
			while (true) {
				Tag tag = decoder.readTag();

				if (tag.type == TagType.DOACTION) {
					if (!success) {
						if (tag.data[0] == 0x88) {
							uint index = 3;
							uint length = tag.data[1] + tag.data[2] * 256;
							index += length;
							ubyte[] t = [0x96, 0x09, 0x00, 0x00, 0x5f, 0x67, 0x6c, 0x6f, 0x62, 0x61, 0x6c, 0x00, 0x17];
							tag.data = tag.data[0..index] ~ action.data[0..$-1] ~ tag.data[index..$];
						}

						success = true;
					}
				}

				encoder.writeTag(tag);

				if (tag.type == TagType.END) {
					break;
				}
				
			}
			encoder.close();
			decoder.close();
			input.close();
			output.close();

			break;

		default:
			return printUsage();
	}

	return 0;
}