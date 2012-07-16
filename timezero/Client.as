class timezero.Client {
	public static function get chatConnection() : Object {
		return _root._chat_sock;
	}
	public static function get gameConnection() : Object {
		return _root._game_sock;
	}
	
	public static function alert(message : String) {
		_root.Alert(message);
	}
};