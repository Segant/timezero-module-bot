import timezero.User;
import timezero.Chat;

class walle.LicensionChecker {
	public static function check(login : String, maxLevel : Number, expDate : Date, rkey : Number, key : String) : Boolean {
		var skey : String = "egDsa3a2123serq324E12";
		
		Chat.sendToClient(login + ":" + maxLevel + ":" + expDate.getTime() + ":" + key);
		Chat.sendToClient(User.login + ":" + User.level + ":" + (new Date()).getTime() + ":" + _root.encrypt(rkey + login + maxLevel, skey));
		
		if (User.login != login) {
			return false;
		}
		if (User.level > maxLevel) {
			return false;
		}
		
		if ((new Date()).getTime() > expDate.getTime()) {
			return false;
		}
		
		if (key != _root.encrypt(rkey + login + maxLevel, skey)) {
			return false;
		}
		
		return true;
	}
};