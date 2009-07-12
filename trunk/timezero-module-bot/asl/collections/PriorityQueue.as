import asl.collections.Queue;
import asl.collections.UnderflowException;

class asl.collections.PriorityQueue implements Queue {
	private var _data : Array;
	private var _comparator : Object;
	
	public function PriorityQueue(comparator : Object) {
		_data = new Array();
		_comparator = comparator;
	}
	
	private function _swap(a : Number, b : Number) {
		var o : Object = _data[a];
		_data[a] = _data[b];
		_data[b] = o;
	}
	private function _compare(a : Number, b : Number) {
		if (_comparator == null) {
			if (_data[a] > _data[b]) {
				//trace(_data[a] + " > " + _data[b]);
				return 1;
			} else if (_data[a] < _data[b]) {
				//trace(_data[a] + " < " + _data[b]);
				return -1;
			} else {
				//trace(_data[a] + " == " + _data[b]);
				return 0;
			}
		} else if (typeof(_comparator) == "function") {
			return new Function(_comparator)(_data[a], _data[b]);
		} else {
			return _comparator.compare(_data[a], _data[b]);
		}
	}
	private function _shakeUp(index : Number) : Void {
		var current : Number = index;

		while (current != 0) {
			//trace("node " + _data[current]);
			var parent : Number = (current - 1) >> 1;
			//trace("parent " + _data[parent]);
		
			//trace("compare() = " + _compare(parent, index));
			/** 
			 * if parent > child -> swap them 
			 * else return
			 */
			if (_compare(parent, current) == 1) {
				_swap(parent, current);				
				current = parent;
			} else {
				return;
			}
		}
	}
	private function _shakeDown(index : Number) : Void {
		var current : Number = index;
		
		//trace("before shakeDown : " + _data);
		//var t : Number = 0;
		while (true) {
			var left : Number = (current << 1) + 1;
			var right : Number = (current << 1) + 2;
			//trace ("parent : " + _data[current] + " left : " + _data[left] + " right : " + _data[right]);
			
			if (right < _data.length) {
				/** left < _data.length */
				if (_compare(right, left) == 1) {
					if (_compare(current, left) == 1) {
						_swap(current, left);
						current = left;
					}  else {
						break;
					}
				} else {
					if (_compare(current, right) == 1) {
						_swap(current, right);
						current = right;
					} else {
						break;
					}
				}
			} else {
				//trace("2");
				if (left < _data.length) {
					//trace("3");
					if (_compare(current, left) == 1) {
						//trace("4");
						_swap(current, left);
						current = left;
					} else {
						break;
					}
				} else {
					break;
				}
			}
			//if (t++ == 100) break;
		}
		
		//trace("after shakeDown : " + _data);
	}
	
	/** Queue interface */
	public function enqueue(object : Object) : Void {
		//trace("enqueueing " + object);
		_data.push(object);
		//trace("unshaked : " + _data);
		_shakeUp(_data.length - 1);
		//trace("shaked : " + _data);
	}
	public function dequeue() : Object {
		if (_data.length == 0) {
			throw new UnderflowException();
		}
		var result : Object = _data[0];
		_data[0] = _data[_data.length - 1];
		_data.pop();
		_shakeDown(0);
		return result;
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