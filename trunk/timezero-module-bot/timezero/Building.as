import asl.utils.Hook;
import asl.utils.Hooker;
import com.timezero.platform.events.*;

class timezero.Building implements IEventDispatcher {
	/** Events */
	public static var ON_CLOSE : String = "onClose";
	
	public static var ARENA : String = "bld1";
	public static var MINE : String = "bld17";
	public static var PORTAL : String = "bld11";
	
	private var _dispatcher : EventDispatcher;
	private var _building : MovieClip;
	private var _doneHook : Hook;
	
	public function Building(building : MovieClip) {
		_dispatcher = new EventDispatcher(this);
		_building = building;
		var _this : Building = this;
		_doneHook = Hooker.setOnCall(_building, "Done", function(args : Array, hook : Hook) {
			_this._onClose();
			hook.remove();
		});
	}
	
	private function _onClose() {
		dispatchEvent({type : ON_CLOSE});
		_building = null;
	}
	
	public function type() : String {
		return _building._name;
	}
	public function canExit() : Boolean {
		return false;
	}
	public function exit() : Void {
		return;
	}
	
	/** IEventDispatcher interface */
	public function addEventListener(type : String, scope : Object, handler : Function, priority : Number) {
		_dispatcher.addEventListener(type, scope, handler, priority);
	}
    public function removeEventListener(type : String, scope : Object, handler : Function) {
		_dispatcher.removeEventListener(type, scope, handler);
	}
    public function dispatchEvent(event : Object) : Boolean {
		return _dispatcher.dispatchEvent(event);
	}
    public function hasEventListener(type : String) : Boolean {
		return _dispatcher.hasEventListener(type);
	}
};