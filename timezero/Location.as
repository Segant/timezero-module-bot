import timezero.Building;
import timezero.CurrentLocation;

class timezero.Location {
	private var _x : Number;
	private var _y : Number;
	
	public function get x() : Number {
		return _x;
	}
	public function get y() : Number {
		return _x;
	}
	
	public function Location(x : Number, y : Number) {
		_x = x;
		_y = y;
	}
	
	public function toString() : String {
		return _root.LocationCoordinate(x, y);
	}

	public static function getDirection(from : Location, to : Location) : Number {
		var dx : Number = from.x - to.x;
		var dy : Number = from.y - to.y;
		
		if (dx < 0) {
			if (dy < 0) {
				return 1;
			} else if (dy == 0) {
				return 4;
			} else {
				return 7;
			}
		} else if (dx == 0) {
			if (dy < 0) {
				return 2;
			} else if (dy == 0) {
				return 5;
			} else {
				return 8;
			}
		} else {
			if (dy < 0) {
				return 3;
			} else if (dy == 0) {
				return 6;
			} else {
				return 9;
			}
		}
	}
	public static function goto(num : Number) : Void {
		if (num != 5 && num <= 9 && num >= 1) {
			_root.GoToLocation(num);
		}
	}
	public static function findMonsters() : Void {
		_root.chat_test();
	}
	public static function get current() : CurrentLocation {
		return new CurrentLocation();
	}
}