class asl.traits {
	/**
	 * From SWF file format specification:
		 *   ActionTypeOf pushes the object type to the stack, 
		 * which is equivalent to the ActionScript TypeOf()
		 * method. The possible types are:
			 * “number”
			 * “boolean”
			 * “string”
			 * “object”
			 * “movieclip”
			 * “null”
			 * “undefined”
			 * “function”
		 * 
		 *   ActionInstanceOf implements the ActionScript 
		 * instanceof() operator. This is a Boolean operator
		 * that indicates whether the left operand (typically 
		 * an object) is an instance of the class represented 
		 * by a constructor function passed as the right operand.
		 *   Additionally, with SWF 7 or later, ActionInstanceOf 
		 * also supports with interfaces. If the rightoperand 
		 * constructor is a reference to an interface object, and 
		 * the left operand implements this interface, ActionInstanceOf 
		 * accurately reports that the left operand is an instance 
		 * of the right operand.
	 *
	 * From Action Script 2 Online Reference:
		 * object instanceof classConstructor
		 * Tests whether object is an instance of classConstructor 
		 * or a subclass of classConstructor. The instanceof operator 
		 * does not convert primitive types to wrapper objects. 
		 * For example, the following code returns true:
			 * new String("Hello") instanceof String;
		 * Whereas the following code returns false:
			 * "Hello" instanceof String;
	 */
	
	/**
	 * Checks whether passed value is String.
	 */
	public static function isString(value : Object) : Boolean {
		return (typeof(value) == "string" || value instanceof String);
	}
	
	/**
	 * Checks whether passed value is Array.
	 */
	public static function isArray(value : Object) : Boolean {
		return (typeof(value) == "array" || value instanceof Array);
	}
	
	/**
	 * Checks whether passed value is Number.
	 */
	public static function isNumber(value : Object) : Boolean {
		return (typeof(value) == "number" || value instanceof Number);
	}

	/**
	 * Checks whether passed value is Boolean.
	 */
	public static function isBoolean(value : Object) : Boolean {
		return (typeof(value) == "boolean" || value instanceof Boolean);
	}

	/**
	 * Checks whether passed value is Function.
	 */
	public static function isFunction(value : Object) : Boolean {
		return (typeof(value) == "function" || value instanceof Function);
	}

	/**
	 * Checks whether passed value is MovieClip.
	 */
	public static function isMovieClip(value : Object) : Boolean {
		return (typeof(value) == "movieclip" || value instanceof MovieClip);
	}
	
	public static function isClass(obj : Object) : Boolean {
		return !!(obj.prototype);
	}

	public static function isPrimitiveType(value : Object) : Boolean {
		return isString(value) || isNumber(value) || isBoolean(value);
	}
	
	public static function isPrimitiveObject(value : Object) : Boolean {
		return value.constructor == Object;
	}
	
	public static function instanceOf(obj : Object, cls : Object) {
		if (cls == String) return isString(obj);
		if (cls == Function) return isFunction(obj);
		if (cls == Boolean) return isBoolean(obj);
		if (cls == Number) return isNumber(obj);
		if (cls == MovieClip) return isMovieClip(obj);
		if (cls == Array) return isArray(obj);
		
		return obj instanceof cls;
	}
	
	public static function typeOf(obj : Object) : Object {
		return obj.constructor;
	}
	
	public static function hasProperty(object : Object, name : String) : Boolean {
		var f : Boolean = object.hasOwnProperty(name);
		return f == true || f == undefined;
	}
}