import asl.utils.ObjectUtilites;

class asl.utils.Dumper {
	public static function toString(object : Object, name : String, showFunctions : Boolean) : String {
		var dumper = new asl.utils.Dumper(showFunctions);
		return dumper._realToString(object, name);
	}
	
	private function ObjectDumper(showFunctions : Boolean) {
		_dumped = new Array();
		_showFunctions = showFunctions;
	}
	private var _showFunctions : Boolean;
	private var _dumped : Array;
	private var _result : String;
	
	private function escapeString(s : String) : String {
		return s.split("\t").join("\\t").split("\n").join("\n");
	}
	
	private function _processObjectChild(object : Object, level : Number, name : String, path : String) {
		if (ObjectUtilites.isPrimitiveType(object)) {
			if (ObjectUtilites.isString(object)) {
				_result += _doIndent(level) + name + " = \"" + escapeString(object) + "\"\n";
			} else {
				_result += _doIndent(level) + name + " = " + object + "\n";
			}
		} else if (ObjectUtilites.isArray(object)) {
			if (object["__visited"]) {
				_result += _doIndent(level) + name +" visited array(" + object["__visit_path"] + ")\n";
			} else {
				object["__visited"] = true;
				object["__visit_path"] = path;
				ObjectUtilites.setPropertyFlags(object, ["__visited", "__visit_path"], true, true, false);
				
				_result += _doIndent(level) + name + " [\n";
				for (var x : String in object) {
					_processObjectChild(object[x], level + 1, x, path + "." + x);
				}
				_result += _doIndent(level) + "]\n";
			}
		} else if (ObjectUtilites.isFunction(object)) {
			if (_showFunctions) {
				_result += _doIndent(level) + name + " function\n";
			}
		} else if ((object == undefined || object == null) && object != _global) {
			_result += _doIndent(level) + name + " = " + object + "\n";
		} else {
			if (object["__visited"]) {
				_result += _doIndent(level) + name + " visited object(" + object["__visit_path"] + ")\n";
			} else {
				object["__visited"] = true;
				object["__visit_path"] = path;
				ObjectUtilites.setPropertyFlags(object, ["__visited", "__visit_path"], true, true, false);
				
				_result += _doIndent(level) + name + " {\n";
				for (var x : String in object) {
					_processObjectChild(object[x], level + 1, x, path + "." + x);
				}
				_result += _doIndent(level) + "}\n";
			}
		}
	}
	
	private function _realToString(object : Object, name : String) : String {
		_result = "";
		_processObjectChild(object, 0, name, name);
		return _result;
	}
	
	private function _doIndent(indent : Number) : String {
		var result : String = "";
		for (var i : Number = 0; i < indent; i++) {
			result += "\t";
		}
		return result;
	}
}
