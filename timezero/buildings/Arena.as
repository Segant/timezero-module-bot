import timezero.Building;
import asl.core.IllegalStateException;

class timezero.buildings.Arena extends Building {
	public function Arena() {
		if (_root.base.battle.modulename != Building.ARENA) {
			throw new IllegalStateException();
		} else {
			super(_root.base.battle.bld17);
		}
	}
	
	public static function get room() : Number {
		return _root.USER.ROOM;
	}
	public static function get floor() : Number {
		return Math.floor(_root.USER.ROOM / 100);
	}
	public static function set room(nroom : Number) {
		var croom : Number = _root.USER.ROOM;
		var nfloor : Number = Math.floor(nroom / 100);
		var cfloor : Number = Math.floor(croom / 100);
		
		if(!_root.CanChangeRoom()) return;
		
		if(croom != nroom)
		{
			if(nfloor != cfloor)
			{
				_root.base.battle.bld1.ChangeFloor(nfloor);
				_root.base.battle.bld1.__gofloat = nroom;
				_root.base.battle.bld1.__scroll = Math.floor((nroom % 100) / 16) * 16;
			}
			else
			{
				_root.base.battle.bld1.chRoom(nroom);
			}
		}
	}
	public static function set floor(nfloor : Number) {
		if(!_root.CanChangeRoom()) return;
		
		var cfloor : Number = Math.floor(_root.USER.ROOM / 100);
		if(cfloor != nfloor) {
			room = nfloor * 100;
		}
	}
	
	public static function findMonsters() {
		_root.SendCmd("<FIND bot=\"1\" />");
	}
	
	public static function exit() {
		_root.ComeOut();
	}
}