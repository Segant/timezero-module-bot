/**
 * Encodes and decodes a ROT13 string.
 * @authors Mika Palmu
 * @version 2.0
 */

class asl.encrypting.ROT13 {

	/**
	 * Variables
	 * @exclude
	 */
	private static var chars:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMabcdefghijklmnopqrstuvwxyzabcdefghijklm";

	/**
	 * Encodes or decodes a ROT13 string.
	 */
	public static function encrypt(src:String):String {
		var calculated:String = new String("");
		for (var i:Number = 0; i<src.length; i++) {
			var character:String = src.charAt(i);
			var pos:Number = chars.indexOf(character);
			if (pos > -1) character = chars.charAt(pos+13);
			calculated += character;
		}
		return calculated;
	}
	
	public static function decrypt(src:String):String {
		var calculated:String = new String("");
		for (var i:Number = 0; i<src.length; i++) {
			var character:String = src.charAt(i);
			var pos:Number = chars.indexOf(character);
			if (pos > -1) character = chars.charAt(pos+13);
			calculated += character;
		}
		return calculated;
	}
}