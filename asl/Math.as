import asl.fp;

class asl.math {
	/**
	 * Functions from Math
	 */
	public static var abs : Function = _global.Math.abs;
	public static var acos : Function = _global.Math.acos;
	public static var asin : Function = _global.Math.asin;
	public static var atan : Function = _global.Math.atan;
	public static var atan2 : Function = _global.Math.atan2;
	public static var ceil : Function = _global.Math.ceil;
	public static var cos : Function = _global.Math.cos;
	public static var exp : Function = _global.Math.exp;
	public static var floor : Function = _global.Math.floor;
	public static var ln : Function = _global.Math.log;
	public static var round : Function = _global.Math.round;
	public static var sin : Function = _global.Math.sin;
	public static var sqrt : Function = _global.Math.sqrt;
	public static var tan : Function = _global.Math.tan;
	public static var max : Function = _global.Math.max;
	public static var min : Function = _global.Math.min;
	public static var pow : Function = _global.Math.pow;
	public static var power : Function = _global.Math.pow;
	
	/**
	 * Constants from Math
	 */
	public static var E : Number = _global.Math.E;
	public static var LN2 : Number = _global.Math.LN2;
	public static var LN10 : Number = _global.Math.LN10;
	public static var SQRT1_2 : Number = _global.Math.SQRT1_2;
	public static var SQRT2 : Number = _global.Math.SQRT2;
	public static var LOG2E : Number = _global.Math.LOG2E;
	public static var LOG10E : Number = _global.Math.LOG10E;
	public static var PI : Number = _global.Math.PI;
	
	public static function log(a : Number, b : Number) {
		return ln(a) / ln(b);
	}
	public static function log10(a : Number) {
		return ln(a) / LN10;
	}
	
	/**
	 * Finds the maximum number in a list.
	 * @return
	 */
	public static function maxl() : Number {
		var values : Array;
		
		if (fp.typeMatch(arguments, [Array])) {
			values = arguments[0];
		} else {
			values = arguments;
		}
		
		return fp.foldl(max, 0, values);
	}
	
	public static function minl() : Number {
		var values : Array;
		
		if (fp.typeMatch(arguments, [Array])) {
			values = arguments[0];
		} else {
			values = arguments;
		}
		
		return fp.foldl(min, 0, values);
	}
	
	public static function rand() : Number {
		var from : Number = 0;
		var to : Number = 1;
		
		if (fp.typeMatch(arguments, [Number, Number])) {
			from = arguments[0];
			to = arguments[1];
		}
		
		return from + _global.Math.random() * (to - from);
	}
	
	public static function sign(num : Number) : Number {
		if (num > 0) {
			return 1;
		} else if (num < 0) {
			return -1;
		} else {
			return 0;
		}
	}
	public static function mod(a : Number, b : Number) {
		return a - Math.floor(a / b) * b;
	}
	public static function gcd(a : Number, b : Number) : Number {
		while (a != 0 && b != 0) {
			if (a > b) a = a % b;
			else b = b % a;
		}
		if (a == 0) return b;
		return a;
	}
	public static function lcm(a : Number, b : Number) : Number {
		return a / gcd(a, b) * b;
	}
}