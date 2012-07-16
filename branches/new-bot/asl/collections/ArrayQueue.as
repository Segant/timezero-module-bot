import asl.utils.ObjectUtilites;
import asl.collections.Queue;
import asl.collections.UnderflowException;

class asl.collections.ArrayQueue implements Queue {
	private var _data : Array;
	
	public function ArrayQueue() {
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
	
	/** Queue interface */
	public function enqueue(object : Object) : Void {
		_data.push(object);
	}
	public function dequeue() : Object {
		if (_data.length == 0) {
			throw new UnderflowException();
		}
		return _data.shift();
	}
	
	/** Collection interface */
	public function add(object : Object) : Boolean {
		enqueue(object);
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