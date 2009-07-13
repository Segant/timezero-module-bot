import asl.logging.Level;
import asl.logging.Layout;

class asl.logging.Logger {
	private var _lvl : Number;
	private var _layout : Layout;
	
	public function isEnabled(level : Number) : Boolean {
		return level > _lvl;
	}
	public function set level(value : Number) {
		if (Level.isValid(value)) {
			_lvl = value;
		} else {
			_lvl = Level.NONE;
		}
	}
	public function get level() : Number {
		return _lvl;
	}
	
	public function set layout(value : Layout) { 
		_layout = value;
	}
	public function get layout() : Layout {
		return _layout;
	}
	
	public function log(level : Number) { }
	
	public function trace() : Void { }
	public function info() : Void { }
	public function warning() : Void { }
	public function error() : Void { }
	public function fatal() : Void { }
};