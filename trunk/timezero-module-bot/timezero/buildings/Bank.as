import timezero.Building;

class timezero.buildings.Bank implements Building {
	private static function sleep(intval:Number):Void {
		function jump():Void
		{
			clearInterval(int2);
			play();
		}
	
		stop();
		var int2 = setInterval(jump, intval);
	}

	private static function getPsw()
	{
		var myroot = _root.base.battle.bld4;
		var _loc2 = _root.dct(myroot.key, myroot.psw);
		_root.SetQuality();
		return (_loc2);
	} // End of the function

	public static function openCell(num : Number, pass)
	{
		var myroot = _root.base.battle.bld4;
		var this_bank = "$bkey_" + _root.USER.X + "_" + _root.USER.Y + "_" + _root.USER.Z; //имя банка для ключа
		var BANK_KEY = _global.ItemType.BANK_KEY; //тип объекта как я понял
		var _loc6 = _root.GetListKeys(BANK_KEY, this_bank); //получаем список всех ключей перса для текущего банка в котором стоим
		var legitimKey : Boolean = false; //правильный ли ключь пытаемся юзать - от этого ли банка?
		
		for (var i in _loc6)
			legitimKey = (_loc6[i].hz == num); //хз - это номер ключа
		
///		Chat.sendToClient("legitimKey = " + legitimKey, 4, true);
		if (legitimKey)
		{
			var _loc5 = new XML(pass);
			var _loc3 = _loc5.toString();

			myroot.psw = _loc3;

			_root.SendCmd("<BK go=\"1\" sell=\"" + num + "\" " + getPsw() + " />");

///			_root.base.battle.bld4.showCell();
			return true;
		}
		else return false;
	}

	public static function exitBank()
	{
        _root.ComeOut();
	}
	
	public static function closeCell(num : Number, pass)
	{
		var myroot = _root.base.battle.bld4;

        var _loc5 = new XML(pass);
        var _loc3 = _loc5.toString();
			
		myroot.psw = _loc3;
		
		_root.SendCmd("<BK sell=\"" + num + "\" go=\"0\" " + getPsw() + " />");
		_root.SendCmd("<GETBOX />");
        myroot.mr2.Close();
        myroot.bg.removeMovieClip();		

///		_root.base.battle.bld4.showCell();

	}
	
	public static function get items()
	{
		return _root.base.battle.bld4.cellBox;
	}
	public static function putItem(item : Object, section : Number, swap_section : Boolean, num : Number)
	{
        _root.SendCmd("<BK sell=\"" + num + "\" d=\"" + item.id + "\"" + (item.count > 0 ? (" c=\"" + item.count + "\"") : ("")) + " s=\"" + section + "\" " + getPsw() + " />");
//		_root.base.battle.bld4.pickup_func(item, item.count, false, section - 1, swap_section)
	}
}