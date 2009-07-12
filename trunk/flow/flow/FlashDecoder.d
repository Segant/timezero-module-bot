module flow.FlashDecoder;

private import tango.io.compress.ZlibStream;
private import tango.io.model.IConduit;
private import flow.io.DataReader;
private import flow.io.BitReader;
private import flow.Rectangle;
private import flow.Header;
private import flow.Tag;

public class FlashDecoder {
	protected InputStream m_baseStream;
	protected DataReader m_reader;
	protected bool m_zlibStream;

	public this(InputStream input) {
		m_baseStream = input;
		m_reader = new DataReader(input);
		m_zlibStream = false;
	}

	private void enableDecompressing() {
		delete(m_reader);
		m_baseStream = new ZlibInput(m_baseStream);
		m_zlibStream = true;
		m_reader = new DataReader(m_baseStream);
	}
import tango.io.Stdout;
	public Rectangle readRectangle() {
		Rectangle result;

		BitReader bitReader = BitReader(m_reader);
		uint bits = bitReader.read(5);
		Stdout(bits).newline;
		result.minX = bitReader.read(bits);
		result.maxX = bitReader.read(bits);
		result.minY = bitReader.read(bits);
		result.maxY = bitReader.read(bits);

		return result;
	}

	public Header readHeader() {
		Header result;

		char header[3];
		m_reader.read(header);

		if (header == ['F', 'W', 'S']) {
			result.compressed = false;
		} else if (header == ['C', 'W', 'S']) {
			result.compressed = true;
		} else {
			throw new IOException("Incorrect flash input stream.");
		}

		result.swfVersion = m_reader.readUByte();
		result.fileSize = m_reader.readUInt();

		if (result.compressed) {
			enableDecompressing();
		}

		result.frameSize = readRectangle();
		result.frameRate = m_reader.readUShort();

		result.frameCount = m_reader.readUShort();

		return result;
	}

	public Tag readTag() {
		Tag result;

		uint block = m_reader.readUShort();

		result.type = block >> 6;
		size_t length = block & 63;

		if (length == 63) {
			length = m_reader.readUInt();
		}

		result.data = new ubyte[length];
		m_reader.readExact(result.data.ptr, length);

		return result;
	}
	public void close() {
		m_baseStream.close();
	}
};