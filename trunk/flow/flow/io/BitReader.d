module flow.io.BitReader;

private import flow.io.DataReader;

public struct BitReader {
	private uint position;
	private ubyte buffer;
	private DataReader input;

	public void reset() {
		position = 8;
		buffer = input.readUByte();
	}

	public uint read(uint n) {
		uint v = 0;

		while (n > position) {
			n -= position;
			v |= buffer << n;
			buffer = input.readUByte();
			position = 8;
		}

		position -= n;
		v |= buffer >> position;
		buffer &= 0xff >> (8 - position);

		return v;
	}

	public static BitReader opCall(DataReader input) {
		BitReader result;
		result.input = input;
		result.reset();
		return result;
	}
}