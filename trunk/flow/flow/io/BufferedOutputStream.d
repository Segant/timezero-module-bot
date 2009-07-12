module flow.io.BufferedOutputStream;

private import tango.io.Conduit;

extern (C) protected void* memcpy(void* dst, void* src, uint size);

public class BufferedOutputStream : OutputFilter {
	protected ubyte[] m_buffer;
	protected size_t m_count;

	public this(OutputStream baseStream, size_t size = 8196) {
		super(baseStream);
		m_buffer = new ubyte[size];
	}

	private uint flushBuffer() {
        if (m_count > 0) {
			uint result = host.write(m_buffer[0..m_count - 1]);
			m_count = 0;
			return result;
        }

		return 0;
    }

    public override uint write(void[] src) {
		uint result = 0;

		if (src.length > m_buffer.length) {
			result += flushBuffer();
			result += host.write(src);
		} else {
			if (src.length > m_buffer.length - m_count) {
				result += flushBuffer();
			}

			memcpy(m_buffer.ptr + m_count, src.ptr, src.length);
			m_count += src.length;
			result += src.length;
		}

		return result;
    }

    public override OutputStream flush() {
		flushBuffer();
		host.flush();

		return this;
    }
}