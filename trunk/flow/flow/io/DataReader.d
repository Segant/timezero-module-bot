module flow.io.DataReader;

private import tango.io.Conduit;
private import tango.core.ByteSwap;
private import tango.core.Exception : IOException;

public class DataReader : InputFilter {
	protected bool swapBytes;

	public this (InputStream input, bool swapBytes = false) {
		super(input);
		this.swapBytes = swapBytes;
	}

	public void[] readExact(void* dst, uint bytes) {
		auto tmp = dst [0 .. bytes];

		if (fill (tmp) != bytes)
			throw new IOException("end-of-flow whilst reading");

		return tmp;
	}

	public uint fill(void[] dst) {
		uint len = 0;

		while (len < dst.length) {
			uint i = read (dst [len .. $]);
			if (i is IConduit.Eof)
				return (len > 0) ? len : IConduit.Eof;
			len += i;
		}

		return len;
	}

	private template readPOD(T) {
		public T readPOD() {
			T x;
			readExact(&x, x.sizeof);

			if (swapBytes) {
				static if (T.sizeof == 2) {
					ByteSwap.swap16(&x, x.sizeof);
				} else static if (T.sizeof == 4) {
					ByteSwap.swap32(&x, x.sizeof);
				} else static if (T.sizeof == 8) {
					ByteSwap.swap64(&x, x.sizeof);
				}
			}

			return x;
		}
	}

	public alias readPOD!(byte) readByte;
	public alias readPOD!(ubyte) readUByte;
	public alias readPOD!(short) readShort;
	public alias readPOD!(ushort) readUShort;
	public alias readPOD!(int) readInt;
	public alias readPOD!(uint) readUInt;
	public alias readPOD!(float) readFloat;
	public alias readPOD!(double) readDouble;
}