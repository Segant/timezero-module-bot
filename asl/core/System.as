class asl.core.System {
	public static function inIDE() : Boolean {
		//XXX: doesnt work
		return (_global.ASnative(302, 0) != undefined) ? true : false;
	}
};