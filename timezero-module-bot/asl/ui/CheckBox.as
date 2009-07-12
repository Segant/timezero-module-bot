import asl.ui.Widget;
import asl.events.*;

class asl.ui.CheckBox extends Widget {
	public static var ON_CLICK : String = "onClick";
	
	private var square : MovieClip;
	private var tick : MovieClip;
	
	private var _enabled : Boolean;
	private var _checked : Boolean;
	
	public function CheckBox() {
        super();
        square.onRelease = function () {
			_parent.onClick();
            //_parent.checked = !_parent.checked;
        };
		_enabled = true;
        tick._visible = _checked = false;
	}
	
	private function onClick() {
		dispatchEvent(new Event({type : ON_CLICK}));
	}
	
	public function set checked(value : Boolean) {
		var val : Boolean = Boolean(value);
		
        if(_checked != val) {
        	_checked = tick._visible = val;
		}
    }
    public function get checked() : Boolean {
        return _checked;
    }
	
	public function set enabled(value : Boolean) {
		var val : Boolean = Boolean(value);
		
		if(_enabled != val) {
			_enabled = val;
			tick._alpha = val ? 100 : 30;
		}
	}
	public function get enabled() : Boolean {
		return _enabled;
	}
}