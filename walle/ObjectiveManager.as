import asl.collections.Stack;
import asl.utils.ClassUtilites;
import asl.core.IllegalArgumentException;

import walle.Objective;

class walle.ObjectiveManager {
	private var _stack : Stack;
	#include "objectives/all.as"
	
	public function ObjectiveManager() {
		_stack = new asl.collections.ArrayStack();
	}
	
	public function get current() : Objective {
		var o = _stack.peek();
		return o;
	}
	
	public function clear() {
		_stack.clear();
	}
	
	public function add(name : String, args : Array) : Void {
		var objClass : Function = ClassUtilites.findClass("walle.objectives." + name);
		
		if (!objClass) {
			throw new IllegalArgumentException("Could not find " + name + " objective.");
		}
		
		_stack.push(ClassUtilites.createInstance(objClass, args));
		_stack.peek().onAdd(this);
	}
	public function remove(objective : Objective, retValue : Object) : Void {
		if (_stack.isEmpty()) {
			throw new asl.collections.UnderflowException();
		}
		if (_stack.peek() != objective) {
			throw new IllegalArgumentException("You can remove only top objectives");
		}
		
		_stack.pop();
		objective.onRemove();
		if (_stack.peek() != null) {
			_stack.peek().onResult(objective, retValue);
		}
	}
};