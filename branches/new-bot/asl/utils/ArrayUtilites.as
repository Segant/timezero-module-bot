class asl.utils.ArrayUtilites {
	public static function indexOf(array : Array, object : Object) : Number {
		var from : Number;
		if(!arguments[2]) {
			from = 0;
		} else {
			from = Number(arguments[2]);
		}
		
		if(!arguments[3]) {
			for(var i : Number = from; i < array.length; i++) {
				if(array[i] == object) {
					return i;
				}
			}
		} else {
			for(var i : Number = from; i < array.length; i++) {
				if(arguments[3](array[i], object)) {
					return i;
				}
			}
		}
		
		return -1;
	}
	public static function clone(array : Array) : Array {
		return array.slice();
	}
}