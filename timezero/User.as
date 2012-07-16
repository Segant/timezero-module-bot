import timezero.*;

class timezero.User
{
	public static function get login() : String
	{
		return _root.USER.login;
	}
	public static function get password() : String
	{
		return _root.COnline();
	}
	public static function get inArena() : Boolean
	{
		return _root.base.battle.modulename == "bld1";
	}
	public static function get inBattle() : Boolean
	{
		return _root.base.battle.modulename == "btl";
	}
	public static function get inMine() : Boolean
	{
		return _root.base.battle.modulename == "bld17";
	}
	public static function get inBank() : Boolean
	{
		return _root.base.battle.modulename == "bld4";
	}
	public static function get inPortal() : Boolean 
	{
		return _root.base.battle.modulename == "bld11";
	}
	public static function get inHospital() : Boolean
	{
		return _root.base.battle.modulename == "bld5";
	}
	public static function get inArsenal() : Boolean
	{
		return _root.base.battle.modulename == "bld2";
	}
	public static function get inShop() : Boolean
	{
		return _root.base.battle.modulename == "bld3";
	}
	public static function get inWorld() : Boolean
	{
		return _root.base.battle.modulename == "world";
	}
	public static function get dazzling() : Number
	{
		return _root.getUser(true).dazzling;
	}
	public static function get hallucination() : Number
	{
		return _root.getUser(true).hallucination;
	}
	public static function get currentMassa() : Number
	{
		return _root.GetMassa().tk;
	}
	public static function get maxMassa() : Number
	{
		return _root.GetMassa().max;
	}
	public static function get level() : Number
	{
		return 0 + Number(_root.USER.level);
	}
	public static function get HP() : Number
	{
		return _root.USER.HP;
	}
	public static function get AP() : Number
	{
		return Number(_global.MAP.iam.OD) || 0;
	}
	public static function get profession() : Number
	{
		return _root.USER.pro;
	}
	public static function get maxHP() : Number
	{
		return _root.USER.maxHP;
	}
	public static function get isMan() : Boolean
	{
		return _root.USER.man == 1;
	}
	public static function get isVIP() : Boolean
	{
		return _root.CheckVip();
	}
	public static function get locationTimeout() : Number
	{
		var time : Number = _root.CalcTimeDifferent(_root.USER.loc_time);
		if(time <= 0) return 0;
		return time;
	}
	public static function get location() : Location
	{
		return Location.current;
	}
	public static function get inventory() : Array
	{
		return _root.BoxList;
	}
	
	public static function fullUpdate()
	{
		_root.FullUpdateMe();
	}
}