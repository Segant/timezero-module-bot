module flow.FlashEncoder;

private import tango.io.compress.ZlibStream;
private import tango.io.model.IConduit;
private import flow.io.DataWriter;
private import flow.io.BitWriter;
private import flow.Rectangle;
private import flow.Header;
private import flow.Tag;


public class FlashEncoder {
	protected OutputStream m_baseStream;
	protected DataWriter m_writer;
	protected bool m_zlibStream;

	public this(OutputStream output) {
		m_baseStream = output;
		m_writer = new DataWriter(output);
		m_zlibStream = false;
	}

	private void enableCompressing() {
		delete(m_writer);
		m_baseStream = new ZlibOutput(m_baseStream);
		m_zlibStream = true;
		m_writer = new DataWriter(m_baseStream);
	}

	import tango.io.Stdout;

	public void writeRectangle(Rectangle x) {
		BitWriter bitWriter = BitWriter(m_writer);
		uint bits = x.bits;
		Stdout(bits).newline;
		bitWriter.write(bits, 5);
		bitWriter.write(x.minX, bits);
		bitWriter.write(x.maxX, bits);
		bitWriter.write(x.minY, bits);
		bitWriter.write(x.maxY, bits);
		bitWriter.flush();
	}

	public void writeHeader(Header x) {
		char[3] header;
		if (x.compressed) {
			header[] = ['C', 'W', 'S'];
		} else {
			header[] = ['F', 'W', 'S'];
		}
		m_writer.write(header.ptr, 3);

		m_writer.writeUByte(x.swfVersion);
		m_writer.writeUInt(x.fileSize);

		if (x.compressed) {
			enableCompressing();
		}

		writeRectangle(x.frameSize);
		m_writer.writeUShort(x.frameRate);
		m_writer.writeUShort(x.frameCount);
	}

	public void writeTag(Tag x, bool extendLength = false) {
		if (!extendLength && x.data.length < 63) {
			m_writer.writeUShort((x.type << 6) | x.data.length);
		} else {
			m_writer.writeUShort((x.type << 6) | 0x3F);
			m_writer.writeUInt(x.data.length);
		}

		m_writer.write(x.data.ptr, x.data.length);
	}

	public void close() {
		m_baseStream.close();
	}
};