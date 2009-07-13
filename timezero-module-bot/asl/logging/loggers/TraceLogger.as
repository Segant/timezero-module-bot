import asl.logging.Level;
import asl.logging.Layout;
import asl.logging.Logger;

import asl.logging.loggers.TraceLoggerHelper;

class asl.logging.loggers.TraceLogger extends Logger {
	private var _lvl : Number;
	private var _layout : Layout;
	
	public function TraceLogger() {
		_lvl = Level.NONE;
		_layout = null;
	}
	
	public function log(level : Number) {
		//if (!isEnabled(level)) return;
		
		arguments.shift();
		var message : String = "";
		for (var i : Number = 0; i < arguments.length; i++) {
			message += arguments[i];
		}
		TraceLoggerHelper._trace(_layout.format(level, message + isEnabled(level) + level + _lvl));
	}
	
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