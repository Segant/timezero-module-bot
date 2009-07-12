class timezero.Client {
	public static function get chatConnection() : net.XMLSocketConnection {
		return _root._chat_sock;
	}
	public static function get gameConnection() : net.XMLSocketConnection {
		return _root._game_sock;
	}
	
	public static function alert(message : String) {
		_root.Alert(message);
	}
};