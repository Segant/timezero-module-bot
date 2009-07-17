import asl.logging.Level;
import asl.logging.Layout;
import asl.logging.Logger;

class walle.TimezeroChatLogger extends Logger {
	private var _lvl : Number;
	private var _layout : Layout;
	
	public function TimezeroChatLogger() {
		_lvl = Level.NONE;
		_layout = null;
	}
	
	public function log(level : Number) {
		if (!isEnabled(level)) return;
		
		arguments.shift();
		var message : String = "";
		for (var i : Number = 0; i < arguments.length; i++) {
			message += arguments[i];
		}
		timezero.Chat.sendToClient(_layout.format(level, message));
	}
};