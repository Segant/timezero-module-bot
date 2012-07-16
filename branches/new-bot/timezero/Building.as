import asl.utils.Hook;
import asl.utils.Hooker;
import asl.events.*;

class timezero.Building extends EventDispatcher {
	/** Events */
	public static var ON_CLOSE : String = "onClose";
	
	public static var ARENA : String = "bld1";
	public static var MINE : String = "bld17";
	public static var PORTAL : String = "bld11";
	private var _building : MovieClip;
	private var _doneHook : Hook;
	
	public function Building(building : MovieClip) {
		var sup : Function = asl.utils.ClassUtilites.getSuperClass(Function(this));
		sup.apply(this, [this]);
		
		_building = building;
		var _this : Building = this;
		_doneHook = Hooker.setOnCall(_building, "Done", function(args : Array, hook : Hook) {
			_this._onClose();
			hook.remove();
		});
	}
	
	private function _onClose() {
		dispatchEvent(new Event({type : ON_CLOSE}));
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
};