class asl.logging.Level {
	public static var TRACE : Number = 0;
	public static var INFO : Number = 1; 
	public static var WARNING : Number = 2; 
	public static var ERROR : Number = 3;
	public static var FATAL : Number = 4;
	public static var NONE : Number = 5;
	
	public static function toString(level : Number) {
		return ["Trace", "Info", "Warning", "Error", "Fatal", "None"][level];
	}
	
	public static function isValid(level : Number) {
		return level >= 0 && level <= 5;
	}
};