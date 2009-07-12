class asl.Math {
	public static var abs : Function = _global.Math.abs;
	public static var acos : Function = _global.Math.acos;
	public static var asin : Function = _global.Math.asin;
	public static var atan : Function = _global.Math.atan;
	public static var atan2 : Function = _global.Math.atan2;
	public static var ceil : Function = _global.Math.ceil;
	public static var cos : Function = _global.Math.cos;
	public static var E : Number = _global.Math.E;
	public static var EXPONENT : Number = _global.Math.E;
	public static var exp : Function = _global.Math.exp;
	public static var floor : Function = _global.Math.floor;
	public static var LN2 : Number = _global.Math.LN2;
	public static var LN10 : Number = _global.Math.LN10;
	public static var ln : Function = _global.Math.log;
	public static function log(a : Number, b : Number)
	{
		return ln(a) / ln(b);
	}
	public static function log10(a : Number)
	{
		return ln(a) / LN10;
	}
	public static var LOG2E : Number = _global.Math.LOG2E;
	public static var LOG10E : Number = _global.Math.LOG10E;
	public static var max : Function = _global.Math.max;
	public static function maxFromArray() : Number
	{
		var values : Array;
		if(arguments[0] instanceof Array) values = arguments[0];
		else values = arguments;
		if(values.length == 0) return 0;
		
		var result : Number = values[0];
		for(var i : Number = 1; i < values.length; i++) result = max(result, values[i]);
		return result;
	}
	public static var min : Function = _global.Math.min;
	public static function minFromArray() : Number
	{
		var values : Array;
		if(arguments[0] instanceof Array) values = arguments[0];
		else values = arguments;
		if(values.length == 0) return 0;
		
		var result : Number = values[0];
		for(var i : Number = 1; i < values.length; i++) result = min(result, values[i]);
		return result;
	}
	public static var PI : Number = _global.Math.PI;
	public static var pow : Function = _global.Math.pow;
	public static var power : Function = _global.Math.pow;
	public static var randomFloat : Function = _global.Math.random;
	public static function randomFloatInRange(from : Number, to : Number) : Number
	{
		return from + randomFloat() * (to - from);
	}
	public static function randomInteger() : Number
	{
		return round(randomFloat() * Number.MAX_VALUE);
	}
	public static function randomIntegerInRange(from : Number, to : Number) : Number
	{
		return from + round(randomFloat() * (to - from));
	}
	public static var round : Function = _global.Math.round;
	public static var sin : Function = _global.Math.sin;
	public static var sqrt : Function = _global.Math.sqrt;
	public static var SQRT1_2 : Number = _global.Math.SQRT1_2;
	public static var SQRT2 : Number = _global.Math.SQRT2;
	public static var tan : Function = _global.Math.tan;
	
	public static function sign(num : Number) : Number
	{
		if(num > 0) return 1;
		if(num < 0) return -1;
		return 0;
	}
	public static function factorial(num : Number) : Number
	{
		var result : Number = 1;
		for(var i : Number = 2; i < num; i++) result *= i;
		return result;
	}
	public static function permutations(a : Number, b : Number) : Number
	{
		return factorial(b) / factorial(b - a);
	}
	public static function combinations(a : Number, b : Number) : Number
	{
		return permutations(a, b) / factorial(a);
	}
	public static function sumFromZero(a : Number) : Number
	{
		return a * (a + 1) / 2;
	}
	public static function sumOfRange(from : Number, to : Number) : Number
	{
		if(from < to) return (to * (to + 1) - from * (from + 1)) / 2;
		else return 0;
	}
	public static function module(a : Number, b : Number)
	{
		return a - Math.floor(a / b) * b;
	}
	public static function gcd(a : Number, b : Number) : Number
	{
		while(a != 0 && b != 0)
		{
			if(a > b) a = a % b;
			else b = b % a;
		}
		if(a == 0) return b;
		return a;
	}
	public static function lcm(a : Number, b : Number) : Number
	{
		return a / gcd(a, b) * b;
	}
}