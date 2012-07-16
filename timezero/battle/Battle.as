import timezero.*;
import asl.events.*;

class timezero.battle.Battle extends EventDispatcher {
	public static function get inBattle() : Boolean {
		return _root.inBattle();
	}
	public static function get inPlanningMode() : Boolean {
		return _global.MAP.PlanningMode;
	}
	public static function get turnsCount() {
		return _global.MAP.history.length;
	}
	public static function endOfTurn() {
		if (_root.inBattle()) {
			_global.btl.nextFullTurn();
			_root.doBattleEnter(true);
			_global.MAP.skipMult = 1;
		}
	}
	
	//Имхо г*в*о =)  //чьё имхо-то? )
	public static function attack(user : Object, once : Boolean, byxy : Boolean, zone : Number)
	{
		if(!_root.inBattle()) return null;
		
		var btl = _root.base.battle.btl;
		var SavedShiftPressed = _root.ShiftPressed;
		if(!once) _root.ShiftPressed = function(){ return true; };
		
		if(!byxy)
		{
			if(!zone)
			{
				btl.Fire2User(user, 2); //Корпус
			}
			else 
			{
				btl.Fire2User(user, zone);
			}
		}
		else
		{
			var SavedCtrlPressed = _global.CtrlPressed;
			_global.CtrlPressed = true;
			
				btl.MAP_x = user.bx;
				btl.MAP_y = user.by;
				btl.PressTile(true);
				
			_global.CtrlPressed = SavedCtrlPressed;
		}
		
		if(!once) _root.ShiftPressed = SavedShiftPressed;
	}
	public static function rotate(dir : Number)
	{
		_root.base.battle.btl.myRotate(dir);
	}
	public static function goto(dir : Number)
	{
		_root.base.battle.btl.myGoTo(dir);
	}
	public static function dropFourthSection()
	{
		_root.base.battle.btl.drop4Box(true);
	}
	public static function pickup(item : Object, section : Number)
	{
		_root.base.battle.btl.pickup_func(item, undefined, false, section - 1);
	}
	public static function undoAllActions()
	{
		_root.FullUndoBattleAction();
	}
	public static function setFlag(x : Number, y : Number)
	{
		_root.base.battle.btl.SetNewFlag(x, y);
	}
	public static function getAllVIP()
	{
		_root.base.battle.btl.getAllT(true);
	}
	public static function reload()
	{
		_root.ReloadSelectedWeapon();
	}
	public static function endOfBattle()
	{
		_root.base.battle.btl.ExitBattle(true);
	}
	public static function exit()
	{
		if(!inBattle && User.inBattle) _root.ToNormalMode();
	}
	
	public static function get currentWeapon() : Object
	{
		return _global.tkWeapon;
	}
	public static function unequipWeapon(weapon : Object)
	{
		_root.ChangeItemSlot(weapon, "");
	}
	public static function addToHistory(text : String)
	{
		_root.AddHistory(text);
	}
	
	public static function isPSG(item : Object)
	{
		if ((item.category == "b3") && (item.name == "v1"))
			return true;
		else
			return false;
	}
	
	public static function isPPSH(item : Object)
	{
		if ((item.category == "b5") && (item.name == "v1"))
			return true;
		else
			return false;
	}
	
	public static function isSpawnOffRifle(item : Object)
	{
		if ((item.category == "b1") && (item.name == "v1"))
			return true;
		else
			return false;
	}
	
	public static function isSharpKnife(item : Object)
	{
		if ((item.category == "b1") && (item.name == "k2"))
			return true;
		else
			return false;
	}
	
	public static function isButterflyKnife(item : Object)
	{
		if ((item.category == "b2") && (item.name == "k6"))
			return true;
		else
			return false;
	}
	
	public static function isRamboKnife(item : Object)
	{
		if ((item.category == "b2") && (item.name == "k7"))
			return true;
		else
			return false;
	}
	
	public static function isWarKnife(item : Object)
	{
		if ((item.category == "b2") && (item.name == "k4"))
			return true;
		else
			return false;
	}
	
	public static function isGuardian(item : Object)
	{
		if ((item.category == "b2") && (item.name == "p7"))
			return true;
		else
			return false;
	}
	
	public static function isKnownWeapom(item : Object)
	{
		return (isGuardian(item) || isWarKnife(item) || isRamboKnife(item) || isButterflyKnife(item) || isSharpKnife(item) || isSpawnOffRifle(item) || isPPSH(item) || isPSG(item));
	}
	
	public static function isKnife(item : Object)
	{
		return (isWarKnife(item) || isRamboKnife(item) || isButterflyKnife(item) || isSharpKnife(item));
	}
	
	public static function addEventListener(type : String, scope : Object, handler : Function, priority : Number){};
    public static function removeEventListener(type : String, scope : Object, handler : Function){};
    public static function dispatchEvent(event : Object) : Boolean{return false;};
    public static function hasEventListener(type : String) : Boolean{return false;};
}