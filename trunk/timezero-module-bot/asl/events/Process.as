import asl.events.*;

class asl.events.Process {
	private static var _dispatcher : ProcessDispatcher = null;
	private var _active : Boolean = false;
	
	public function get active() : Boolean {
		return _active;
	}
	
	public function start() : Void {
		_active = true;
		
		if (!_dispatcher) {
			_dispatcher = new ProcessDispatcher();
		}
		_dispatcher.add(this);
	}
	public function stop() : Void { 
		_active = false;
	}
	
	public function step() : Void { }
	
	private function wait() : Void { }
	private function waitForEvent(dispatcher : IEventDispatcher, type : String) : Void {
		_dispatcher.waitForEvent(this, dispatcher, type);
	}
	private function wait 
	private static var STATE_WAIT_PROCESS : Number = 5;
	
	public function wake() : Void { }
};