class asl.utils.Hook {
	public static var ON_CALL : String = "onCall";
	public static var ON_CHANGE : String = "onChange";
	
	private var _type : String;
	
	private var _scope : Object;
	private var _currentScope : Object;
	private var _name : String;
	private var _oldValue : Object;
	
	private var _callback : Function;
	
	public function get scope() : Object {
		return _scope;
	}
	public function get name() : String {
		return _name;
	}
	public function get type() : String {
		return _type;
	}
	public function get hookedObject() : Object {
		return _oldValue;
	}
	
	public function Hook(type : String, scope : Object, name : String, callback : Function) {
		_type = type;
		_scope = scope;
		_currentScope = _scope;
		_name = name;
		_oldValue = _scope[_name];
		_callback = callback;
		
		switch(_type) {
			case ON_CALL:
				_scope[_name] = function () {
					var hook : Object = arguments.callee.hook;
					return hook._onCall(this, arguments);
				};
				_scope[_name].hook = this;
				break;
				
			case ON_CHANGE:
				var watchFunction : Function = function (prop, oldVal : Object, newVal : Object) {
					var hook : Object = arguments.callee.hook;
					return hook._onChange(oldVal, newVal);
				};
				watchFunction.hook = this;
				_scope.watch(_name, watchFunction);
				break;
		}
	}
	
	public function remove() {
		switch(_type) {
			case ON_CALL:
				_scope[_name] = _oldValue;
				break;
			case ON_CHANGE:
				_scope.unwatch(_name);
				break;
		}
	}
	public function invoke(args : Array) : Object {
		return _oldValue.apply(_currentScope, args);
	}
	
	private function _onCall(scope : Object, args : Array) : Object {
		_currentScope = scope;
		var result : Object = _callback.apply(_currentScope, [args, this]);
		_currentScope = _scope;
		return result;
	}
	private function _onChange(oldVal : Object, newVal : Object) : Object {
		return _callback.apply(_scope, [oldVal, newVal, this]);
	}
};