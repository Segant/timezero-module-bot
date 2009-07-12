module flow.Header;

private import flow.Rectangle;

public struct Header {
	public bool compressed;
	public ubyte swfVersion;
	public uint fileSize;

	public Rectangle frameSize;
	public ushort frameRate;
	public ushort frameCount;
};