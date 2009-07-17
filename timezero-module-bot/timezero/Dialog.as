import com.timezero.platform.events.*;

class timezero.Dialog {
	public static var ON_DIALOG : String = "onDialog";
	
	private static var initialized : Boolean = false;
	private static var hook : asl.utils.Hook;
	
	private static function onDialog(login : String, to : String, img : String, 
			question : String, answers : Array) {
		dispatchEvent({
			type : ON_DIALOG,
			login : login,
			to : to,
			img : img,
			question : question,
			answers : answers
		});
	}
	
	public static function initialize() : Boolean {
		if (!initialized) {
			EventDispatcher.IEventDispatcher(timezero.Dialog);
			
			hook = asl.utils.Hooker.setOnCall(_root, "ShowDialogWin", 
			function(args : Array, hook : asl.utils.Hook) {
				timezero.Chat.sendToClient("Dialog : " + args.toString());
				/** login, to, img, question, answers */
				var login : String = args[0];
				var to : String = args[1];
				var img : String = args[2];
				var question : String = args[3];
				var answers : Array = args[4];
				
				Dialog.onDialog(login, to, img, question, answers);
				
				return hook.invoke(args);
			});
			
			return initialized = true;
		}
	}
	public static function shutdown() { 
		if (initialized) {
			hook.remove();
			
			initialized = false;
		}
	}
	
	public static function addEventListener(type : String, scope : Object, handler : Function, priority : Number) { }
    public static function removeEventListener(type : String, scope : Object, handler : Function) { }
    public static function dispatchEvent(event : Object) : Boolean { return false; }
    public static function hasEventListener(type : String) : Boolean { return false; }
}