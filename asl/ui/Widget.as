/** Original timezero api */
import asl.events.*;

class asl.ui.Widget extends MovieClip implements IEventDispatcher {
	/** MovieClip fields */
	private var _alpha : Number;
	private var _currentframe : Number;
	private var _droptarget : String;
	private var _focusrect : Boolean;
	private var _framesloaded : Number;
	private var _height : Number;
	private var _highquality : Number;
	private var _lockroot : Boolean;
	private var _name : String;
	private var _parent : MovieClip;
	private var _quality : String;
	private var _rotation : Number;
	private var _soundbuftime : Number;
	private var _target : String;
	private var _totalframes : Number;
	private var _url : String;
	private var _visible : Boolean;
	private var _width : Number;
	private var _x : Number;
	private var _xmouse : Number;
	private var _xscale : Number;
	private var _y : Number;
	private var _ymouse : Number;
	private var _yscale : Number;
	
	/** New Widget fields */
	private var _dispatcher : EventDispatcher;
	
	public function get name() : String {
		return _name;
	}
	public function set name(value : String) {
		_name = value;
	}
	
	public function Widget() {
		_dispatcher = new EventDispatcher(this);
		_xscale = 100;
		_yscale = 100;
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
};