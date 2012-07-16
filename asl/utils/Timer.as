import asl.events.*;
import mx.utils.Delegate;

class asl.utils.Timer implements IEventDispatcher {
	public static var TIMER : String = "TIMER";
	public static var TIMER_COMPLETE : String = "TIMER_COMPLETE";
	
	// The total number of times the timer has fired since it started at zero.
	private var _currentCount : Number;
	
	// The delay, in milliseconds, between timer events.
	private var _delay : Number;
	
	// The total number of times the timer is set to run.
	private var _repeatCount : Number;
	
	// The timer's current state; true if the timer is running, otherwise false.
	private var _running : Boolean;
	
	// Internal interval which lets the Timer tick.
	private var _intervalID : Number;
	
	private var _dispatcher : EventDispatcher;
	
	/**
	* Constructs a new Timer object with the specified delay and repeatCount states.
	* The timer does not start automatically; you must call the start() method to start it.
	* @param	delay 		The delay, in milliseconds, between timer events
	* @param	repeatCount The total number of times the timer is set to run
	*/
	public function Timer(delay : Number, repeatCount : Number) {
		_currentCount = 0;
		_delay = delay;
		_repeatCount = (repeatCount != undefined) ? repeatCount : 0;
		_running = false;
		_dispatcher = new EventDispatcher(this);
	}
	
	/**
	* Stops the timer, if it is running, and sets the currentCount property back to 0, like the reset button of a stopwatch. Then,
	* when start() is called, the timer instance runs for the specified number of repetitions, as set by the repeatCount value.
	*/
	public function reset() : Void {
		stop();
		_currentCount = 0;
	}
	
	/**
	* Starts the timer, if it is not already running.
	*/
	public function start() : Void {
		clearInterval(_intervalID);
		_intervalID = setInterval(Delegate.create(this, _onTick), _delay);
		
		_running = true;
	}
	
	/**
	* Dispatches a TIMER event and checks if the timer should still be ticking, if not, it dispatches a
	* TIMER_COMPLETE event and stops the timer.
	*/
	private function _onTick() : Void {
		this.dispatchEvent(new Event({type : TIMER}));
		
		_currentCount += 1;
		
		if (_currentCount >= _repeatCount && _repeatCount != 0) {
			this.dispatchEvent(Event.IEvent({type : TIMER_COMPLETE}));
			reset();
		}
	}
	
	/**
	* Stops the timer. When start() is called after stop(), the timer instance runs for the remaining number of repetitions,
																	* as set by the repeatCount property.
	*/
	public function stop() : Void {
		clearInterval(_intervalID);
		
		_running = false;
	}
	
	/**
	* The total number of times the timer has fired since it started at zero. If the timer has been reset,
	* only the fires since the reset are counted.
	*/
	public function get currentCount() : Number {
		return _currentCount;
	}
	
	/**
	* The delay, in milliseconds, between timer events. If you set the delay interval while the timer is running, the timer
	* will restart at the same repeatCount iteration.
	*/
	public function get delay() : Number {
		return _delay;
	}
	public function set delay(value : Number) : Void {
		_delay = value;
	}
	
	/**
	* The total number of times the timer is set to run. If the repeat count is set to 0, the timer continues forever or
	* until the stop() method is invoked or the program stops. If the repeat count is nonzero, the timer runs the specified
	* number of times. If repeatCount is set to a total that is the same or less then currentCount the timer stops and will
	* not fire again.
	*/
	public function get repeatCount() : Number {
		return _repeatCount;
	}
	public function set repeatCount(value : Number) : Void {
		_repeatCount = value;
	}
	
	/**
	* The timer's current state; true if the timer is running, otherwise false.
	*/
	public function get running() : Boolean {
		return _running;
	}
	
	/**
	* Returns a string representation of this class, (optionally) including the package in which it resides.
	* @return	String which contains this class's name and (optional) package
	*/
	public function toString(returnFullyQualifiedName : Boolean) : String {
		if (returnFullyQualifiedName) {
			return "asl.utils.Timer";
		}
		return "Timer";
	}
	
	public function addEventListener(type : String, scope : Object, handler : Function) : Void {
		_dispatcher.addEventListener(type, scope, handler);
	}
    public function removeEventListener(type : String, scope : Object, handler : Function) : Void {
		_dispatcher.removeEventListener(type, scope, handler);
	}
    public function dispatchEvent(event : Event) : Void {
		_dispatcher.dispatchEvent(event);
	}
    public function hasEventListener(type : String) : Boolean {
		return _dispatcher.hasEventListener(type);
	}
}