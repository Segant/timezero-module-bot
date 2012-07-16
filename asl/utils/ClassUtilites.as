import asl.utils.ObjectUtilites;

class asl.utils.ClassUtilites {
	public static function isClass(object : Object) : Boolean {
		return !!(object.prototype);
	}
	public static function findClass(className : String) : Function {
		if (className == null) {
			return null;
		}
		
		var result = _global;
		var tokens = className.split(".");
		
		for (var i = 0; i < tokens.length; i++) {
			result = result[tokens[i]];
		}
		
		if(result == _global || result == undefined || result == null) {
			return null;
		}
		
		return new Function(result);
	}
	
	public static function getPath(cls : Function, scope : Object) : String {
		if (cls.__path__) {
			return cls.__path__;
		} else {
			var o = Function(cls).prototype;
			var callee : Function;
			
			var find : Function = function(s : String, target : Object) {
				for (var i : String in target) {
					var current : Function = target[i];
					
					if (current.__constructor__ === Object) {
						i = callee(s + i + ".", current);
						
						if (i) {
							return i;
						}
					} else if (current.prototype === o) {
						return s + i;
					}
				}
			};
			
			callee = find;
			
			cls["__path__"] = find("", scope || _global) || null;
			ObjectUtilites.setPropertyFlags(new Object(cls), new Array("__path__"), true, true, true);
			
			return cls["__path__"] || null;
		}
	}
	public static function getPackage(cls : Function, scope : Object) : String {
		var path : String = getPath(cls, scope);
		if (path == null) {
			return null;
		}
		var package : Array = path.split(".");
		package.pop();
		return package.join(".");
	}
	public static function getName(cls : Function, scope : Object) : String {
		var path:String = getPath(cls, scope);
		if (path == null) {
			return null;
		}
		var p : Array = path.split(".");
		return p.pop() || null;
	}

	public static function createInstance(cls : Function, args : Array) : Object {
		if (args == null) args = [];
		
		var result : Object = new Object();
		result.__proto__ = cls.prototype;
		result.__constructor__ = cls;
		cls.apply(result, args);
		return result;
	}
	public static function isSubClass(superClass : Function, subClass : Function) : Boolean {
		var proto : Object = subClass.prototype;
		
		while(proto.__proto__ != undefined){
			if(proto.__proto__ === superClass.prototype){
				return true;
			}
			proto = proto.__proto__;
		}
		
		return false;
 	}
	public static function getSuperClass(cls : Function) : Function {
		return new Function(cls.prototype.constructor);
	}
}