module flow.io.DataWriter;

private import tango.io.Conduit;
private import tango.core.ByteSwap;
private import tango.core.Exception : IOException;

public class DataWriter : OutputFilter {
	protected bool swapBytes;

	public this(OutputStream baseStream, bool swapBytes = false) {
		super(baseStream);
		this.swapBytes = swapBytes;
	}

	public uint write(void* dst, uint bytes) {
		return host.write(dst[0..bytes]);
	}
	private template writePOD(T) {
		public void writePOD(T x) {
			if (swapBytes) {
				static if (T.sizeof == 2) {
					ByteSwap.swap16(&x, x.sizeof);
				} else static if (T.sizeof == 4) {
					ByteSwap.swap32(&x, x.sizeof);
				} else static if (T.sizeof == 8) {
					ByteSwap.swap64(&x, x.sizeof);
				}
			}

			if (write(&x, x.sizeof) != x.sizeof) {
				throw new IOException("end-of-flow whilst writing");
			}
		}
	}

	public alias writePOD!(byte) writeByte;
	public alias writePOD!(ubyte) writeUByte;
	public alias writePOD!(short) writeShort;
	public alias writePOD!(ushort) writeUShort;
	public alias writePOD!(int) writeInt;
	public alias writePOD!(uint) writeUInt;
	public alias writePOD!(float) writeFloat;
	public alias writePOD!(double) writeDouble;
}