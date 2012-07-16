import timezero.Location;
import timezero.Building;
import timezero.buildings.Arena;

class timezero.CurrentLocation extends Location {
	public function CurrentLocation() {
		_x = _root.USER.X - 360;
		_y = _root.USER.Y - 360;
	}
	
	public function get inBuilding() {
		return _root.base.battle.modulename != "world";
	}
	public function get building() : Building {
		if (inBuilding) {
			switch(_root.base.battle.modulename) {
				case "bld1":
					return new Arena();
					break;
			}
		} else {
			return null;
		}
	}
};