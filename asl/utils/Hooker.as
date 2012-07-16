import asl.utils.ObjectUtilites;
import asl.utils.Hook;

class asl.utils.Hooker {
	public static function setOnCall(scope : Object, name : String, dstFunc : Function) : Hook {
		if (ObjectUtilites.hasProperty(scope, name) && ObjectUtilites.isFunction(scope[name])) {
			var wasChangeable : Boolean = true; 
			if (!ObjectUtilites.isPropertyChangeable(scope, name)) {
				ObjectUtilites.adjustPropertyFlags(scope, [name], true, false, false);
				wasChangeable = false;
			}
			
			var result : Hook = new Hook(Hook.ON_CALL, scope, name, dstFunc);
			
			if (!wasChangeable) {
				ObjectUtilites.removePropertyFlags(scope, [name], true, false, false);
			}
			
			return result;
		}
		
		return null;
	}
	public static function setOnChange(scope : Object, name : String, dstFunc : Function) : Hook {
		if (ObjectUtilites.hasProperty(scope, name)) {
			return new Hook(Hook.ON_CHANGE, scope, name, dstFunc);
		}
		
		return null;
	}
}