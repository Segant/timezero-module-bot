class asl.utils.ArrayUtilites {
	public static function filter(array : Array, filterFunction : Function) : Array {
		var result : Array = new Array();
		
		for(var i : Number = 0; i < array.length; i++) {
			if(filterFunction(array[i])) result.push(array[i]);
		}
		
		return result;
	}
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
	public static function countOf(array : Array, filterFunction : Function) : Number {
		var result : Number = 0;
		
		for(var i : Number = 0; i < array.length; i++) {
			if(filterFunction(array[i])) {
				result++;
			}
		}
		
		return result;
	}
	public static function clone(array : Array) : Array {
		return array.slice();
	}
}