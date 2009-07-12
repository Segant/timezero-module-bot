module flow.Rectangle;

private int mostSignificantBitSet(uint value) {
	uint result = 0;

	while (value != 0) {
		++result;
		value >>= 1;
	}

	return result - 1;
}
private int max(int a, int b) {
	return (a > b) ? a : b;
}

import tango.io.Stdout;

public struct Rectangle {
	public uint minX;
	public uint maxX;
	public uint minY;
	public uint maxY;

	public uint bits() {
		int result = mostSignificantBitSet(minX);

		Stdout(maxX, mostSignificantBitSet(maxX)).newline;
		result = max(result, mostSignificantBitSet(maxX));
		result = max(result, mostSignificantBitSet(minY));
		result = max(result, mostSignificantBitSet(maxY));
		return result + 2;
	}
};