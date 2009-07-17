import asl.events.*;

class walle.XOMLoader extends EventDispatcher {
	public static var ON_LOAD : String = "onLoad";
	
	public function XOMReader() {
		super(this);
	}
	
	private function _parseNode(xml : XMLNode, result : Object) : Void {		
		for (var i : Number = 0; i < xml.childNodes.length; i++) {
			var node : XMLNode = xml.childNodes[i];
			var type : String = node.nodeName;
			var name : String = node.attributes.name || i;
				
			switch(type) {
				case "object":
					result[name] = new Object();
					_parseNode(node, result[name]);
					break;
				case "array":
					result[name] = new Array();
					_parseNode(node, result[name]);
					break;
				case "unsigned":
					result[name] = Number(node.attributes.value) || 0;
					break;
				case "boolean":
					switch(node.attributes.value) {
						case "1":
						case "true":
						case "yes":
							result[name] = true;
							break;
						default:
							result[name] = false;
							break;
					}
					break;
				case "integer":
					result[name] = Number(node.attributes.value) || 0;
					break;
				case "real":
					result[name] = Number(node.attributes.value) || 0;
					break;
				case "date":
					var args : Array = node.attributes.value.split('.');
					var day : Number = Number(args[0]);
					var month : Number = Number(args[1]);
					var year : Number = Number(args[2]);
					
					result[name] = new Date(year, month - 1, day);
					break;
				case "string":
					result[name] = node.attributes.value;
					break;
				case "comment":
					break;
			}
		}
	}
	
	public function loadURL(url : String) {
		var xml : XML = new XML();
		var loader : XOMLoader = this;
		var xmlURL : String = url;
		
		xml.ignoreWhite = true;
		
		xml.onLoad = function(success : Boolean) {
			var result : Object = undefined;
			if (success) {
				result = new Object();
				loader._parseNode(xml, result);
			}
			loader.dispatchEvent(new Event({
				type : ON_LOAD, 
				success : success, 
				url : xmlURL,
				result : result
			}));
		};
		
		xml.load(url);
	}
};