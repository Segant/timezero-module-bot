/**
* Encodes and decodes a Goauld string.
* @authors Mika Palmu
* @version 2.0
*/

class asl.encrypting.Goauld {

	/**
	* Variables
	* @exclude
	*/
	public static var shiftValue:Number = 6;

	/**
	* Encodes a Goauld string with the character code shift value.
	*/
	public static function encrypt(src:String):String {
		var result:String = new String("");
		for (var i:Number = 0; i<src.length; i++) {
			var charCode:Number = src.substr(i, 1).charCodeAt(0);
			result += String.fromCharCode(charCode^shiftValue);
		}
		return result;
	}

	/**
	* Decodes a Goauld string with the character code shift value.
	*/
	public static function decrypt(src:String):String {
		var result:String = new String("");
		for (var i:Number = 0; i<src.length; i++) {
			var charCode:Number = src.substr(i, 1).charCodeAt(0);
			result += String.fromCharCode(charCode^shiftValue);
		}
		return result;
	}
}