import asl.utils.Delegate;
import asl.collections.Queue;
import asl.utils.Timer;
import asl.fp;

class walle.Logger {
	public static var MESSAGE : String = "Message";
	public static var HINT : String = "Hint";
	public static var WARNING : String = "Warning";
	public static var ERROR : String = "Error";
	
	private var _host : String;
	private var _port : Number;
	private var _socket : XMLSocket;
	private var _messages : Queue;
	private var _errorCount : Number;
	private var _connected : Boolean;
	private var _timer : Timer;
	
	public function Logger() {
		_host = null;
		_port = 0;
		_socket = new XMLSocket();
		_socket.onConnect = fp.delegate(this, _onConnect);
		_socket.onData = fp.delegate(this, _onData);
		_socket.onClose = fp.delegate(this, _onClose);
		_messages = new asl.collections.ArrayQueue();
		_errorCount = 0;
		_connected = false;
		_timer = new Timer(500);
	}
	
	public function connect(host : String, port : Number) : Void {
		_host = host;
		_port = port;
		_errorCount = 0;
		_connected = false;
		
		_socket.connect(host, port);
	}
	public function close() : Void {
		if (_connected) {
			log(MESSAGE, "Closing connection.");
			_socket.close();
			_connected = false;
		}
	}
	
	public function log(type : String, message : String) : Void {
		var date : Date = new Date();
		var time : String = date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
		_messages.enqueue(time + " [" + type + "] : " + message);
	}

	private function _onConnect(success : Boolean) : Void {
		if (!success) {
			if (_errorCount < 5) {
				_socket.connect(_host, _port);
				_errorCount++;
			} else {
				_errorCount = 0;
			}
		} else {
			_connected = true;
			_timer.addEventListener(Timer.TIMER, this, _onTimerEvent);
			log(MESSAGE, "Connected.");
		}
	}
	private function _onData(data : String) : Void {
		
	}
	private function _onClose() : Void {
		_connected = false;
		_timer.removeEventListener(Timer.TIMER, this, _onTimerEvent);
	}
	
	private function _onTimerEvent() : Void {
		if (_connected) {
			if (!_messages.isEmpty()) {
				_socket.send(_messages.dequeue());
			}
		}
	}
};