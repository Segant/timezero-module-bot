module flow.io.BitWriter;

private import flow.io.DataWriter;

public struct BitWriter {
	private uint m_position;
	private ubyte m_buffer;
	private DataWriter m_writer;

	public void flush() {
		if (m_position != 8) {
			m_writer.writeUByte(m_buffer);
			m_position = 8;
		}
	}

	public void write(uint v, uint n) {
		v &= (1 << n) - 1;

		while (n >= m_position) {
			m_buffer |= v >> (n - m_position);
			n -= m_position;
			v &= (1 << n) - 1;
			m_writer.writeUByte(m_buffer);
			m_buffer = 0;
			m_position = 8;
		}

		if (n != 0) {
			m_buffer |= v << (8 - n);
			m_position = 8 - n;
		}
	}

	public static BitWriter opCall(DataWriter output) {
		BitWriter result;
		result.m_writer = output;
		result.m_position = 8;
		return result;
	}
}