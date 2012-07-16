import asl.utils.ObjectUtilites;
import asl.collections.Stack;
import asl.collections.UnderflowException;

class asl.collections.ArrayStack implements Stack {
	private var _data : Array;
	
	public function ArrayStack() {
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
	
	/** Stack interface */
	public function push(o : Object) : Void {
		_data.push(o);
	}
	public function pop() : Object {
		if (_data.length == 0) {
			throw new UnderflowException();
		}
		return _data.pop();
	}
	public function peek() : Object {
		return _data[_data.length - 1];
	}
	
	/** Collection interface */
	public function add(object : Object) : Boolean {
		push(object);
		return true;
	}
	public function contains(object : Object) : Boolean {
		return _data.indexOf(object) != -1;
	}
	public function clear() : Void {
		_data = new Array();
	}
	public function isEmpty() : Boolean {
		return _data.length == 0;
	}
};