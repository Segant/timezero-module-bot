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
	
	public function trace() : Void {
		var args : Array = arguments;
		args.splice(0, 0, Level.TRACE);
		log.apply(this, args);
	}
	public function info() : Void {
		var args : Array = arguments;
		args.splice(0, 0, Level.INFO);
		log.apply(this, args);
	}
	public function warning() : Void {
		var args : Array = arguments;
		args.splice(0, 0, Level.WARNING);
		log.apply(this, args);
	}
	public function error() : Void {
		var args : Array = arguments;
		args.splice(0, 0, Level.ERROR);
		log.apply(this, args);
	}
	public function fatal() : Void {
		var args : Array = arguments;
		args.splice(0, 0, Level.FATAL);
		log.apply(this, args);
	}
};