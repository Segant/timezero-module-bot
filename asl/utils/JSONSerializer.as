import asl.utils.ArrayUtilites;
import asl.utils.ObjectUtilites;


class asl.utils.JSONSerializer {
	private static function _join(obj : Object, func : Function) {
		var array : Array = [];
		for (var i in obj) {
			array.push(func(obj[i], i));
		}
		return array.join(",");
	}
	private static function _escape(str : String) {
		str
	}
	
	public static function serialize(obj : Object) {
		if (ObjectUtilites.isBoolean(obj) || 
			ObjectUtilites.isNumber(obj)) {
			return obj.toString();
		}
		
		if (ObjectUtilites.isFunction(obj)) {
			return "{ \"type\": \"function\"}";
		}
		
		if (ObjectUtilites.isMovieClip(obj)) {
			return "{ \"type\": \"movieclip\"}";
		}
		
		if (ObjectUtilites.isArray(obj)) {
			return "[" + _join(obj, function(o : Object) {
				return JSONSerializer.serialize(o);
			}) + "]";
		}
		
		if (ObjectUtilites.isString(obj)) {
			var str : String = String(obj);
			return "\"" + str + "\"";
		}
		
		return "{" + _join(obj, function(o : Object, i : String) {
			return i + ":" + JSONSerializer.serialize(o);
		}) + "}";
	}
};