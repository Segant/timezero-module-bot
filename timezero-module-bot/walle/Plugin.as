import walle.XOMLoader;

class walle.Plugin {
	public function initialize() : Boolean { }
	public function shutdown() : Void { }
	
	public function get pluginName() : String {
		return ClassUtilites.getPath(ObjectUtilites.getClass(this));
	}
};