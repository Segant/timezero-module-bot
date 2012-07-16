import asl.core.IllegalArgumentException;
import asl.math;
import asl.traits;

class asl.fp {
	/**
	 * Does nothing with the argument and returns it.
	 * @param	arg
	 * @return  arg
	 */
	public static function id(arg : Object) : Object {
		return arg;
	}
	
	/**
	 * Examples:
		 * fp.curry(asl.math.max, 99)(100) == 100
		 * fp.curry(asl.math.max, 99)(12) == 12
	 * @param	f
	 * @param	args
	 * @return
	 */
	public static function curry(f : Function, args : FunctionArguments) : Function {
		var self : Object = undefined;
		if (arguments.length == 3) {
			self = arguments[2];
		}
		
		return function() {
			return f.apply(self == undefined ? this : self, args.concat(arguments));
		}
	}
	
	/**
	 * Examples:
		 * f = fp.curried(asl.math.max, 2)
		 * f1 = f(1)
		 * f1(2) == 2
		 * f1(0) == 0
		 * 
		 * f13 = f(13)
		 * f13(3) == 13
		 * f(4)(5) == 5
	 * @param	f
	 * @param	n
	 * @return
	 */
	public static function curried(f : Function, n : Number) : Function {
		return function(args : Array, arg : Object) {
			args = args.slice(0, args.length - 1)
			args.push(arg);
			
			if (args.length == n) {
				return f.apply(this, args);
			} else {
				return fp.curry(arguments.callee, FunctionArguments([args]), this); 
			}
		}
	}
	
	/**
	 * Flips function arguments.
	 * Examples:
		 * f = function(a, b) { return a - b; }
		 * ff = fp.flip(f)
		 * f(1, 2) == -1
		 * ff(1, 2) == 1
		 * 
		 * f = function(a, b, c) { return a * b * b * c * c * c; }
		 * ff = fp.flip(f)
		 * f(1, 2, 3) == 1 * 2 * 2 * 3 * 3 * 3 == 108
		 * ff(1, 2, 3) == 3 * 2 * 2 * 1 * 1 * 1 == 12
	 * @param	f
	 * @return
	 */
	public static function flip(f : Function) : Function {
		return function() {
			arguments.reverse();
			return f.apply(this, arguments); 
		}
	}
	
	/**
	 * Examples:
		 * fp.map(function(a){return [a];}, [1, 2, 3]) == [[1],[2],[3]];
		 * fp.map(function(a){return 2*a;}, [1, 2, 3]) == [2, 4, 6];
	 * @param	f
	 * @param	list
	 * @return
	 */
	public static function map(f : Function, list : Array) : Array {
		var result : Array = [];
		for (var i in list) {
			result.push(f(list[i]));
		}
		return result;
	}
	
	/**
	 * Examples:
		 * fp.foldl(function(acc, next) {return acc[next];}, 
		 *          {a:[[1,[false]]]}, ["a", 0, 1, 0]) == false;
		 * fp.foldl(asl.math.max, 0, [1, 4, 2]) == 4;
		 * fp.foldl(function(acc, next) {return next - acc; },
		 *          0, [1, 4, 2]) == (2 - (4 - (1 - 0))) == -1;
	 * @param	f
	 * @param	init
	 * @param	list
	 * @return
	 */
	public static function foldl(f : Function, init : Object, list : Array) {
		var result : Object = init;
		for (var i in list) {
			result = f(result, list[i]);
		}
		return result;
	}
	
	/**
	 * Examples:
		 * fp.foldr(function(next, acc) {return acc.concat(next);},
		 *          [], [1, 2, 3]) == [3, 2, 1];
	 * @param	f
	 * @param	list
	 * @param	init
	 * @return
	 */
	public static function foldr(f : Function, list : Array, init : Object) {
		var result : Object = init;
		for (var i = list.length - 1; i >= 0; i--) {
			result = f(list[i], result);
		}
		return result;
	}
	
	/**
	 * Removes all objects in the list not satisfying predicate.
	 * Examples:
		 * fp.filter(fp.id, [1,0,2,0,0,3]) == [1,2,3];
		 * fp.filter(function(a){return a > 0}, [1, 2, 0, -1]) == [1, 2];
	 * @param	f
	 * @param	list
	 * @return
	 */
	public static function filter(f : Function, list : Array) : Array{
		var result : Array = [];
		for (var i in list) {
			if (f(list[i])) {
				result.push(list[i]);
			}
		}
		return result;
	}
	
	/**
	 * Counts the number of objects in the list satisfying predicate.
	 * Examples:
		 * fp.count(fp.id, [1, 2, 3, 0, 0]) == 3;
		 * fp.count(function(a){return a > 0}, [1, 2, 0, -1]) == 2;
	 * @param	f    a predicate
	 * @param	list a list
	 * @return
	 */
	public static function count(f : Function, list : Array) : Number {
		var result : Number = 0;
		for (var i in list) {
			if (f(list[i])) {
				result += 1;
			}
		}
		return result;
	}
	
	/**
	 * Examples:
		 * fp.zip([1, 2], [true, false]) == [[1,true], [2,false]];
		 * fp.zip([1], [true, false]) == [[1,true]];
	 * @return
	 */
	public static function zip() : Array {
		var count : Number = fp.foldl(
			function(acc, next) { return math.min(acc.length, next.length); },
			[], arguments);
	    var result : Array = new Array(count);
		
		for (var i = 0; i < count; i++) {
			var next : Array = new Array(arguments.length);
			for (var k in arguments) {
				next[k] = arguments[k][i];
			}
			result[i] = next;
		}
		return result;
	}
	
	/**
	 * Finds a sum of the given monoid on the list.
	 * Examples:
		 * ordering = function(i) { 
		 * 	   return { 
		 *         val : (!!i) ? i : 0,
		 *         add : function(that) {
		 *             matcher = fp.curry(fp.match, [[this.val, that.val]]);
		 *             if (matcher([-1, fp.ANY]) return -1;
		 *             if (matcher([1, fp.ANY]) return 1;
		 *             if (matcher([0, fp.ANY]) return that.val;
		 *         }
		 *     };
		 * }
		 * 
		 * compare = function() {
		 *     if (arguments.length != 2) {
		 *         throw new IllegalArgumentException("not enough arguments");
		 *     }
		 * 
		 *     var a : Object = arguments[0];
		 *     var b : Object = arguments[1];
		 * 
		 *     if (fp.typeMatch([a, b], [String, String]) {
		 *         if (a.length != 1 || b.length != 1) {
		 *             throw new IllegalArgumentException("can only compare strings of length 1 and numbers");
		 *         }
		 *         a = a.charCodeAt(0);
		 *         b = b.charCodeAt(0);
		 *     }
		 * 
		 *     if (fp.typeMatch([a, b], [Number, Number]) {
		 *         return (a < b) ? -1 :
	     *                ((a > b) ? 1 : 0);
		 *     } else {
		 *         throw new IllegalArgumentException("can only compare strings of length 1 and numbers");
		 *     }
		 * }
		 * 
		 * compareLists = function(a, b) {
		 *     return fp.foldm(ordering, 
		 *         [compare(a.length, b.length)].concat(
		 *             fp.map(function(pair) { return compare(pair[0], pair[1]); }, fp.zip(a, b))
		 *         ));
		 * 
	 * @param	monoid   monoid constructor. must return an object
	 *                   with a method add(m). This method must satisfy
	 *                   a.add(b).add(c) == a.add(b.add(c)),
	 * 					 monoid().add(monoid(b)) == monoid(b) and
	 *                   monoid(a).add(monoid()) == monoid(a)
	 * @param	list
	 * @return           folded monoid
	 */
	public static function foldm(monoid : Function, list : Array) : Object {
		var result : Object = monoid(list[0]);
		for (var i = 1; i < list.length; i++) {
			result = result.add(monoid(list[i]));
		}
		return result;
		
	}
	
	/**
	 * Returns a new function which calls the given function
	 * with the given scope.
	 * Examples:
		 * f = function(){return this.a};
		 * fd = fp.delegate({a:1}, f);
		 * fd() == 1;
		 * fd.apply({a:2}) == 1;
		 * f.apply({a:2}) == 2;
	 * @param	obj
	 * @param	func
	 * @return
	 */
	public static function delegate(obj : Object, func : Function) : Function {
		var proxy = function () {
            var _object = arguments.callee.object;
            var _func = arguments.callee.func;
            return (_func.apply(_object, arguments));
        }
		
        proxy.object = obj;
        proxy.func = func;
        return proxy;
	}
	
	/**
	 * Used in typeMatch and match
	 */
	public static var ANY = { };
	public static var UNDEFINED = { };
	public static var NULL = { };
	
	/**
	 * Recursively matches type of an object to a given type-pattern.
	 * Possible uses include matching on function's variadic arguments.
	 * Example:
		 * fp.typeMatch("test", String) == true
		 * fp.typeMatch({}, Object) == true
		 * fp.typeMatch(new asl.core.Error(), asl.core.Error) == true
		 * fp.typeMatch([123, false, "re"], [Number, Boolean, String]) == true
		 * fp.typeMatch(function() { }, Function) == true
		 * fp.typeMatch({a:function(){}, b:123}, {a:Function, b:Number}) == true
		 * fp.typeMatch([123, false, "rer"], Array) == true
		 * fp.typeMatch([1, undefined, null, true], [Number, fp.ANY, fp.ANY, fp.ANY]) == true  
	 * @param	obj
	 * @param	desc
	 * @return
	 */
	public static function typeMatch(obj : Object, desc : Object) : Boolean {
		if (desc == fp.ANY) {
			return true;
		} else if (traits.isPrimitiveObject(desc)) {
			for (var i in desc) {
				if (traits.hasProperty(obj, i) != true) return false;
				if (!fp.typeMatch(obj[i], desc[i])) return false;
			}
			
			return true;
		} else if (traits.isArray(desc)) {
			if (!traits.isArray(obj)) return false;
			if (obj.length != desc.length) return false;
			
			for (var i in desc) {
				if (!fp.typeMatch(obj[i], desc[i])) return false;
			}
			
			return true;
		} else if (traits.isClass(desc)) {
			return traits.instanceOf(obj, desc);
		} else {
			throw IllegalArgumentException("desc must be one of: array, type, or primitive object");
		}
	}
	/**
	 * Works the same way as typeMatch, but also supports matching on values.
	 * Examples:
		 * fp.match([1, 2, 3], [1, 2, Number]) == true
		 * fp.match( { a:2, b:[], c:new XMLSocket() }, { a:2, b:[], c:XMLSocket } ) == true
		 * fp.match([1, undefined, null, true], [1, fp.ANY, fp.ANY, true]) == true
		 * fp.match([1, undefined, null, true], [1, fp.UNDEFINED, fp.NULL, true]) == true
		 * fp.match([1, undefined, null, true], [1, Object, Object, true]) == false
	 * @param	obj
	 * @param	desc
	 */
	public static function match(obj : Object, desc : Object) {
		if (desc == fp.ANY) {
			return true;
		} else if (desc == fp.UNDEFINED) {
			return obj == undefined;
	    } else if (desc == fp.NULL) {
			return obj == null;
		} else if (traits.isPrimitiveObject(desc)) {
			for (var i in desc) {
				if (traits.hasProperty(obj, i) != true) return false;
				if (!fp.match(obj[i], desc[i])) return false;
			}
			
			return true;
		} else if (traits.isArray(desc)) {
			if (!traits.isArray(obj)) return false;
			if (obj.length != desc.length) return false;
			
			for (var i in desc) {
				if (!fp.match(obj[i], desc[i])) return false;
			}
			
			return true;
		} else if (traits.isPrimitiveType(desc)) {
			return obj == desc;
		} else if (traits.isClass(desc)) {
			return traits.instanceOf(obj, desc);
		} else if (traits.isFunction(desc)) {
			return obj == desc;
		} else {
			return obj == desc;
		}
	}
}