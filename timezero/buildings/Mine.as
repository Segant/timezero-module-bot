import timezero.Building;
import asl.core.IllegalStateException;

class timezero.buildings.Mine extends Building {	
	public function Mine() {
		if (_root.base.battle.modulename != Building.MINE) {
			throw new IllegalStateException();
		} else {
			super(_root.base.battle.bld17);
		}
	}
	
	public function findMonsters() : Void {
		_root.chat_battle();
	}
	public function goto(dir : Number) : Void {
		_building.GoTo(dir);
	}
	public function isPassable(dir : Number) : Boolean {
		return _building["b" + dir]._visible;
	}
	public function get timeout() : Boolean {
		return _building.wait_timer;
	}
	public function get hasMonsters() : Boolean {
		return _building.monsters != undefined && _building.monsters._totalframes != undefined;
	}
	public function get room() : Number {
		return _root.USER.ROOM;
	}
	public function xy2room(x : Number, y : Number) : Number {
		if (x < 0) {
			x = -x * 2 - 1;
		} else {
			x = x * 2;
		}
		
		if (y < 0) {
			y = -y * 2 - 1;
		} else {
			y = y * 2;
		}
		
		return (x + (y << 5));
	}
	public function room2xy(room : Number) : Object {
		var x : Number = room & 31;
		var y : Number = room >> 5 & 31;
		
		if (x % 2 == 1) {
			x = -(x + 1) / 2;
		} else {
			x = x / 2;
		}
		if (y % 2 == 1) {
			y = -(y + 1) / 2;
		} else {
			y = y / 2;
		}
		
		return {x : x, y : y};
	}
	
	/** Building interface */
	public function name() : String {
		return "bld17";
	}
	public function canExit() : Boolean {
		return _root.USER.ROOM == 0;
	}
	public function exit() : Void {
		if (canExit()) {
			_root.ComeOut();
		}
	}
}