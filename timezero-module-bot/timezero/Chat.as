import timezero.ChatCache;
import com.timezero.platform.events.*;

import asl.utils.ObjectUtilites;

dynamic class timezero.Chat {
	public static var ON_CHAT_MESSAGE : String = "onChatMessage";
	
	private static var lastMessageTime : Number = 0;
	private static var oldSendCommandToBrowser : Function;
	
	private static var initialized : Boolean = false;
	private static var hook : asl.utils.Hook;
	
	public static function initialize() : Boolean {
		if (!initialized) {
			EventDispatcher.IEventDispatcher(timezero.Chat);
			
			hook = asl.utils.Hooker.setOnCall(_root, "SendCommandToBrowser", 
			function(args : Array, hook : asl.utils.Hook) {
				var result : Object = hook.invoke(args);
				
				if (args[0] == "S") {  
					ChatCache.addInput(args[1]);
				}
				
				return result;
			});
			
			ChatCache.initialize();
			
			return initialized = true;
		}
	}
	public static function shutdown() { 
		if (initialized) {
			hook.remove();
			
			ChatCache.shutdown();
			
			initialized = false;
		}
	}
	
	public static function sendToServer(message, logins) {
		if (initialized) {
			if(logins) {
				for(var i in logins) {
					if(logins[i].isPrivate) {
						message = "private [" + logins[i].message + "] " + message;
					} else {
						message = "to [" + logins[i].message + "] " + message;
					}
				}
			}
			
			ChatCache.addOutput(message);
		}
	}
	public static function sendToClient(message : String, color : Number, always : Boolean, html : Boolean) {
		if (initialized) {
			if(color < 0 || color > 16 || isNaN(color)) {
				color = 0;
			}
			
			var f : Function = new Function(hook.hookedObject);
			f("S", " " + message + "\t" + color + (always ? "\t1" : "\t0") + (html ? "\ttrue" : "")); 
		}
	}
}