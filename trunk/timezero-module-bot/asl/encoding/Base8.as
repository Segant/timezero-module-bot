/**
 * Encodes and decodes a base8 (hex) string.
 * @authors Mika Palmu
 * @version 2.0
 */

class asl.encoding.Base8 {
	/**
	 * Encodes a base8 string from array of bytes.
	 */
	public static function encode(src : Array) : String {
		var result:String = new String("");
		
		for (var i:Number = 0; i<src.length; i++) {
			var x : String = src[i].toString(16);
			if (x.length == 1) x = "0" + x;
			result += x;
		}
		return result;
	}
	
	/**
	 * Decodes a base8 string to array of bytes.
	 */
	public static function decode(src : String) : Array {
		var result : Array = new Array();
		
		for (var i:Number = 0; i<src.length; i+=2) {
			result.push(parseInt(src.substr(i, 2), 16));
		}
		return result;
	}
}