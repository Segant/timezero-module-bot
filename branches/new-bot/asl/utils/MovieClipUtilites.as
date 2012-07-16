class asl.utils.MovieClipUtilites {
	public static getChilds(mc : MovieClip) : Array {
		var result : Array = new Array();
		
		for(var i in mc) {
			if(typeof(mc[i]) == movieclip && mc[i]._parent == mc) {
				result.push(mc[i]);
			}
		}
		
		return result;
	}
}