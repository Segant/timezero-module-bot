import asl.utils.ObjectUtilites;
import asl.utils.ClassUtilites;
import asl.collections.List;
import asl.collections.IndexOutOfBoundsException;

class asl.collections.ArrayList implements List {
	private var _data : Array;
	
	public function ArrayList() {
		if (ObjectUtilites.isNumber(arguments[0])) {
			_data = new Array(arguments[0]);
		} else if (ObjectUtilites.isArray(arguments[0])) {
			_data = arguments[0];
		} else {
			_data = new Array(arguments.length);
			for (var i : Number = 0; i < arguments.length; i++) {
				_data[i] = arguments[i];
			}
		}
	}
	
	private function _rangeCheck(index : Number) {
		if (index < 0 || index >= _data.length) {
			throw new IndexOutOfBoundsException(index);
		}
	}
	
	public function get(index : Number) : Object {
		_rangeCheck(index);
		return _data[index];
	}
	public function set(index : Number, object : Object) : Object {
		_rangeCheck(index);
		var result : Object = _data[index];
		_data[index] = object;
		return result;
	}
	public function insert(index : Number, object : Object) : Void {
		if (index < 0 || index > _data.length) {
			throw new IndexOutOfBoundsException(index);
		}
		_data.splice(index, 0, object);
	}
	public function add(object : Object) : Boolean {
		_data.push(object);
		return true;
	}
	public function removeAt(index : Number) : Object {
		return _data.splice(index, 1)[0];
	}
	
	public function indexOf(object : Object) : Number {
		return _data.indexOf(object);
	}
    public function lastIndexOf(object : Object) : Number {
		return _data.lastIndexOf(object);
	}
	
    public function subList(fromIndex : Number, toIndex : Number) : List {
		return new ArrayList(_data.slice(fromIndex, toIndex));
	}
	
	public function isEmpty() : Boolean {
		return _data.length == 0;
	}
	
	public function contains(object : Object) : Boolean {
		return indexOf(object) != -1;
	}
	
	public function clear() : Void {
		delete _data;
		_data = new Array();
	}
	
	public function length() : Number {
		return _data.length;
	}
};