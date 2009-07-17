import asl.events.*;
import asl.collections.Queue;

class asl.events.ProcessDispatcher {
	private static var STATE_RUNNING = 0;
	private static var STATE_WAIT : Number = 1;
	private static var STATE_WAIT_CALL : Number = 2;
	private static var STATE_WAIT_EVENT : Number = 3;
	private static var STATE_WAIT_UNTIL : Number = 4;
	private static var STATE_WAIT_PROCESS : Number = 5;
	private var _processes : Queue = new asl.collections.ArrayQueue();
	
	public function ProcessDispatcher() {
		
	}
	
	public function add(process : Process) : Void {
		_processes.enqueue({
			process : process,
			state : STATE_RUNNING
		});
	}
	public function remove(process : Process) : Void {
	
	}
	
	private function _onEnterFrame() : Void {
		
	}
};