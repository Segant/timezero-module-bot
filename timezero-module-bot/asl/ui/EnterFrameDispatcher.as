import asl.utils.Delegate;
import asl.utils.ObjectUtilites;
import asl.events.*;

class asl.ui.EnterFrameDispatcher implements IEventDispatcher {
	private static var _singleton : EnterFrameDispatcher = null;
	public static var ON_ENTER_FRAME : String = "onEnterFrame";
	private var _dispatcher : EventDispatcher;
	
	private function EnterFrameDispatcher() {
		_dispatcher = new EventDispatcher(this);
		
		if (_root._asl_ui_EnterFrameDispatcher == undefined) {
			var mc : MovieClip = _root.createEmptyMovieClip("_asl_ui_EnterFrameDispatcher", 9877);
			ObjectUtilites.removePropertyFlags(_root, ["_asl_ui_EnterFrameDispatcher"], false, false, true);
			mc.onEnterFrame = Delegate.create(this, _dispatch);
		}
	}
	
	public static function get instance() : EnterFrameDispatcher {
		if (!_singleton) {
			_singleton = new EnterFrameDispatcher();
		}
		
		return _singleton;
	}
	
	private function _dispatch() {
		dispatchEvent(new Event({type : ON_ENTER_FRAME}));
	}
	
	public function dispatchEvent(event : Event) : Void {
		_dispatcher.dispatchEvent(event);
	}
	public function addEventListener(type : String, scope : Object, handler : Function) : Void {
		_dispatcher.addEventListener.apply(_dispatcher, arguments);
	}
	public function removeEventListener(type : String, scope : Object, handler : Function) : Void {
		_dispatcher.removeEventListener(type, scope, handler);
	}
	public function hasEventListener(type : String) : Boolean {
		return _dispatcher.hasEventListener(type);
	}
};