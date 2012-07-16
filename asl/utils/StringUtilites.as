class asl.utils.StringUtilites {
	public static function isDigit(s : String) : Boolean {
		var digits : String = "0123456789";
		return s.length == 1 && digits.indexOf(s) != -1;
	};
	public static function isAlphabetical(s : String) : Boolean {
		var alphas : String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
		return s.length == 1 && alphas.indexOf(s) != -1;
	};
	public static function isWhitespace(s : String) : Boolean {
		var wspaces : String = " \t\r";
		return s.length == 1 && wspaces.indexOf(s) != -1;
	};
	public static function getUTF8BytesCount(data : String) : Number {
		var result : Number = 0;
		
		for(var i : Number = 0; i < data.length; i++) {
			var code : Number = data.charCodeAt(i);
			
			if (code < 0x80) {
				result++;
			} else if (code < 0x0800) {
				result += 2;
			} else if (code < 0x10000) {
				result += 3;
			} else if (code < 0x110000) {
				result += 4;
			} else {
				return -1;
			}
		}
		return result;
	};
	public static function getUTF8Bytes(data : String) : Array {
		var result : Array = new Array();
			
		for(var i : Number = 0; i < data.length; i++) {
			var code : Number = data.charCodeAt(i);
			
			if (code < 0x80) {
				result.push(code);
			} else if (code < 0x0800) {
				result.push(0xC0 | ((code >> 6) & 0x3f));
                result.push(0x80 | (code & 0x3f));
			} else if (code < 0x10000) {
				result.push(0xe0 | ((code >> 12) & 0x3f));
                result.push(0x80 | ((code >> 6)  & 0x3f));
                result.push(0x80 | (code & 0x3f));
			} else if (code < 0x110000) {
				result.push(0xf0 | ((code >> 18) & 0x3f));
                result.push(0x80 | ((code >> 12) & 0x3f));
                result.push(0x80 | ((code >> 6)  & 0x3f));
                result.push(0x80 | (code & 0x3f));
			} else {
				return null;
			}
		}
		
		return result;
	};
	public static function bytesToBase16(data : Array) : String
	{
		var result : String = "";
		var hexChars : String = "0123456789ABCDEF";
		for(var i : Number = 0; i < data.length; i++)
			result += hexChars[data[i] >> 4 & 0xF] + hexChars[data[i] & 0xF];
		return result;
	}
	public static function trimBegin(s : String) : String {
		while(s.substr(0, 1) == ' ') s = s.substr(1);
		return s;
	}
	public static function trimEnd(s : String) : String {
		while(s.substr(s.length - 1, 1) == ' ') s = s.substr(0, s.length - 1);
		return s;
	}
	public static function trim(s : String) : String {
		return trimEnd(trimBegin(s));
	}
	
	public static function split(string : String, delims : Array) : Array {
		var result : Array = new Array(string);
		
		for(var i = 0; i < delims.length; i++)
			for(var k = 0; k < result.length; k++) {
				var tmp : Array = result[k].split(delims[i]);
				
				for(var t = 0; t < tmp.length; t++)
					if(tmp[t].length == 0)
						tmp.splice(t, 1);
				
				result.splice(k, 1, tmp);
			}
			
		return result;
	}
}