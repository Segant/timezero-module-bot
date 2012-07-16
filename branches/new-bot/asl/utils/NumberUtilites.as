class asl.utils.NumberUtilites {
	public static function toArray(x : Number, count : Number) {
		var a : Array = [
			(x >> 24) & 0xFF,
			(x >> 16) & 0xFF,
			(x >> 8) & 0xFF,
			x & 0xFF
		];
		
		return a.slice(4 - count, 4);
	}
};