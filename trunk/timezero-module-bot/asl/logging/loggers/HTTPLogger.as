import asl.logging.Level;
import asl.logging.Layout;
import asl.logging.Logger;

class asl.logging.loggers.HTTPLogger extends Logger {
	private var _url : String;
	private var _username : String;
	private var _password : String;
	private var _method : String;
	private var _loadVars : LoadVars;
	private var _isBusy : Boolean = false;
	private var _buffer : Array = new Array();
	
	/**
	 * Creates a new HTTP logger with the given parameters.
	 * 
	 * @param  url      The URL this logger sends the messages to. The default is "http://127.0.0.1/httplogger.php".
	 * @param  username HTTPLogger will send this parameter as "username" to the target CGI script. The default is "root".
	 * @param  password HTTPLogger will send this parameter as "password" to the target CGI script. The default is "" (no password).<br>
	 *                   Note that all data is sent unencrypted by default, which is unsecure!
	 * @param  method   The method to use, could be "POST" or "GET". "POST" is the default.
	 */
	public function HTTPLogger(url : String, username : String, password : String, method : String) {
		// get parameters, set default values if the parameter isn't specified or is incorrect
		_url = (url == null) ? "http://127.0.0.1/httplogger.php" : url;
		_username = (username == null) ? "root" : username;
		_password = (password == null) ? "" : password;
		_method = (method == null && method != "POST" && method != "GET") ? "POST" : method;
		
		// create LoadVars object and apply onLoad method
		_createNewLoadVars();
	}
	
	private function _createNewLoadVars() : Void {
		_loadVars = new LoadVars();
		_loadVars.onLoad = asl.utils.Delegate.create(this, _onLoad);
	}
	
	/**
	 * This function is called by the LoadVars object.
	 * 
	 * @param  success  true if no errors occured during transfer, otherwise false.
	 */
	private function _onLoad(success : Boolean) : Void {
		if (!success) {
			// a failure occured
			// TODO: throw own exception
		} else {
			// no failure
		}
		
		_createNewLoadVars();
		_isBusy = false;
		
		if (_buffer.length > 0) {
			_sendToServer();
		}
	}
	
	/**
	 * Send the next queued message to the server.
	 */
	private function _sendToServer() : Void {
		if (!_isBusy) {
			_isBusy = true;
			_loadVars.username = _username;
			_loadVars.password = _password;
			_loadVars.text = "";
			_loadVars.text += _buffer.shift();
			
			// send data
			_loadVars.sendAndLoad(_url, _loadVars, _method);
		}
	}
	
	public function log(level : Number) {
		//if (!isEnabled(level)) return;
		
		arguments.shift();
		var message : String = "";
		for (var i : Number = 0; i < arguments.length; i++) {
			message += arguments[i];
		}
		_buffer.push(_layout.format(level, message));
		_sendToServer();
	}
	
	public function trace() : Void {
		var args : Array = arguments;
		args.splice(0, 0, Level.TRACE);
		log.apply(this, args);
	}
	public function info() : Void {
		var args : Array = arguments;
		args.splice(0, 0, Level.INFO);
		log.apply(this, args);
	}
	public function warning() : Void {
		var args : Array = arguments;
		args.splice(0, 0, Level.WARNING);
		log.apply(this, args);
	}
	public function error() : Void {
		var args : Array = arguments;
		args.splice(0, 0, Level.ERROR);
		log.apply(this, args);
	}
	public function fatal() : Void {
		var args : Array = arguments;
		args.splice(0, 0, Level.FATAL);
		log.apply(this, args);
	}
};