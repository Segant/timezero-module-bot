import asl.*;
import asl.utils.*;
import asl.hashing.CRC32;
import asl.events.*;
import timezero.Chat;

class timezero.ChatCache {
	private static var output : Array = new Array();
	private static var input : Array = new Array();
	private static var newInput : Array = new Array();
	private static var timer : Timer = new Timer(300);
	
	private static var initialized : Boolean = false;
	public static function initialize() : Boolean{
		if (!initialized) {
			timer.addEventListener(Timer.TIMER, ChatCache, _onTimer);
			timer.start();
			
			return initialized = true;
		}
	}
	
	public static function shutdown() {
		if (initialized) {
			timer.removeEventListener(Timer.TIMER, ChatCache, _onTimer);
			timer.stop();
			
			initialized = false;
		}
	}
	
	public static function addOutput(message : String) {
		if (initialized) {
			output.push(message);
		}
	}
	public static function addInput(msg : String) {
		if (initialized) {
			var crc32 : CRC32 = new CRC32();
			crc32.update(StringUtilites.getUTF8Bytes(msg));
			var crc : String = crc32.digestAsString();
			
			for(var i : Number = 0; i < input.length; i++) {
				if(input[i] == crc) {
					return;
				}
			}
			
			var current_string : String = msg.split("\t")[0];
						
			var time : Array = current_string.substr(0, 5).split(":");
			if(time[0].substr(0, 1) == "0") time[0] = time[0].substr(1);
			if(time[1].substr(0, 1) == "0") time[1] = time[1].substr(1);
			var hours = Number(time[0]);
			var minutes = Number(time[1]);
			
			current_string = current_string.substr(7); // + 2 из-за пробела и скобки [
			var sender : String = current_string.substring(0, current_string.indexOf("]"));
			current_string = current_string.substr(current_string.indexOf("]") + 1);
			
			var stop_parse_logins = false;
			var logins = new Array();
			while(!stop_parse_logins)
			{
				var tmp2 = new Object();
				var current_login_start = current_string.indexOf("[") + 1;
				var current_login_end = current_string.indexOf("]");
				var login = current_string.substring(current_login_start, current_login_end);
				var tmp = current_string.substring(0, current_login_start - 1);
				
				if(tmp == " to ") logins.push({login : login, isPrivate : true});
				else if(tmp == " private ") logins.push({login : login, isPrivate : false});
				else
				{
					stop_parse_logins = true;
					break;
				}
			
				current_string = current_string.substr(current_login_end + 2);
			}
			
			Chat.dispatchEvent(Event.IEvent({
				type : Chat.ON_CHAT_MESSAGE,
				hours : hours,
				minutes : minutes,
				sender : sender, 
				logins : logins, 
				message : current_string
			}));
				
			input.push(crc);
		}
	}
	
	private static function _onTimer(e : Event) {
		if (initialized) {
			if(output.length > 0) {
				_root.sendChat(output.pop());
			}
		}
	}
}