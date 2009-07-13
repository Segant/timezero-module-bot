import asl.logging.Level;
import asl.logging.Layout;
import asl.logging.Logger;

class asl.logging.loggers.NullLogger implements Logger {
	private var _lvl : Number;
	private var _layout : Layout;
	
	public function NullLogger() {
		_lvl = Level.NONE;
		_layout = null;
	}
	
	public function log(level : Number) { }
	
	public function trace() : Void { }
	public function info() : Void { }
	public function warning() : Void { }
	public function error() : Void { }
	public function fatal() : Void { }
};