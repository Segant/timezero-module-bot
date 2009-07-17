class asl.utils.ObjectUtilites {
	private static var _setPropertyFlags : Function = _global.setPropertyFlags || _global.ASSetPropFlags;
	
	/**
	 * Checks wherever passed-in value is <code>String</code>.
	 */
	public static function isString(value : Object) : Boolean {
		return (typeof(value) == "string" || value instanceof String);
	}
	
	/**
	 * Checks wherever passed-in value is <code>Array</code>.
	 */
	public static function isArray(value : Object) : Boolean {
		return (typeof(value) == "array" || value instanceof Array);
	}
	
	/**
	 * Checks wherever passed-in value is <code>Number</code>.
	 */
	public static function isNumber(value : Object) : Boolean {
		return (typeof(value) == "number" || value instanceof Number);
	}

	/**
	 * Checks wherever passed-in value is <code>Boolean</code>.
	 */
	public static function isBoolean(value : Object) : Boolean {
		return (typeof(value) == "boolean" || value instanceof Boolean);
	}

	/**
	 * Checks wherever passed-in value is <code>Function</code>.
	 */
	public static function isFunction(value : Object) : Boolean {
		return (typeof(value) == "function" || value instanceof Function);
	}

	/**
	 * Checks wherever passed-in value is <code>MovieClip</code>.
	 */
	public static function isMovieClip(value : Object) : Boolean {
		return (typeof(value) == "movieclip" || value instanceof MovieClip);
	}

	public static function isPrimitiveType(value : Object) : Boolean {
		return isString(value) || isNumber(value) || isBoolean(value);
	}
	
	public static function hasProperty(object : Object, name : String) : Boolean {
		var f : Boolean = object.hasOwnProperty(name);
		return f == true || f == undefined;
	}
	public static function isPropertyChangeable(object : Object, name : String) : Boolean {
		if (!hasProperty(object, name)) {
			return false;
		}
		
		var uniqueObject : Object = new Object();
		var copy : Object = object[name];
		
		object[name] = uniqueObject;
		if (object[name] != uniqueObject) {
			return false;
		} else {
			object[name] = copy;
			return true;
		}
	}
	public static function isPropertyDeleteable(object : Object, name : String) : Boolean {
		if (!hasProperty(object, name)) {
			return false;
		}
		
		var copy : Object = object[name];
		
		delete(object[name]);
		
		if (!object.hasOwnProperty(name)) {
			object[name] = copy;
			return true;
		} else {
			return false;
		}
	}
	public static function isPropertyEnumerable(object : Object, name : String) : Boolean {
		var f : Boolean = object.isPropertyEnumerable(name);
		return f == true;
	}
	
	private static function makeFlags(changeable : Boolean, deleteable : Boolean, 
			enumerable : Boolean) {
		var flags : Number = 0;
		
		if(!changeable) {
			flags |= 4;
		}
		if(!deleteable) {
			flags |= 2;
		}
		if(!enumerable) {
			flags |= 1;
		}
		
		return flags;
	}
	
	public static function setPropertyFlags(object : Object, names : Array, 
			changeable : Boolean, deleteable : Boolean, enumerable : Boolean) {
		var flags : Number = makeFlags(changeable, deleteable, enumerable);
		_setPropertyFlags(object, names, flags, 7);
	}
	public static function adjustPropertyFlags(object : Object, names : Array,
			changeable : Boolean, deleteable : Boolean, enumerable : Boolean) {
		var flags : Number = makeFlags(changeable, deleteable, enumerable);
		_setPropertyFlags(object, names, flags, 0);
	}
	public static function removePropertyFlags(object : Object, names : Array,
			changeable : Boolean, deleteable : Boolean, enumerable : Boolean) {
		var flags : Number = makeFlags(changeable, deleteable, enumerable);
		flags = ~(flags | (~7));
		_setPropertyFlags(object, names, 0, flags);
	}
	
	public static function getClass(object : Object) : Function {
		return Object(object).__constructor__;
	}
	public static function getSuperClass(object : Object) : Function {
		return new Function(getClass(object).prototype.constructor);
	}
}