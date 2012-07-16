class timezero.battle.Players
{
	/** TODO:
	 * 1) Упорядочить
	 * 2) Десант, разные типы механоидов/крыс/студней/стичей...
	 */
	
	public static function isWoman(object : Object)
	{
		return object.man == 0;
	}
	public static function isMan(object : Object)
	{
		return object.man == 1;
	}
	public static function isCyberMine(object : Object)
	{
		return object.man == 2;
	}
	public static function isRat(object : Object)
	{
		return object.man == 3;
	}
	public static function isStich(object : Object)
	{
		return object.man == 4;
	}
	public static function isRobocop(object : Object)
	{
		return object.man == 5;
	}
	public static function isWitchJelly(object : Object)
	{
		return object.man == 6;
	}
	public static function isVzzik(object : Object)
	{
		return object.man == 7;
	}
	public static function isDingo(object : Object)
	{
		return object.man == 8;
	}
	public static function isErgo(object : Object)
	{
		return object.man == 9;
	}
	public static function isUnknownMan(object : Object)
	{
		return object.man == 10;
	}
	public static function isGecko(object : Object)
	{
		return object.man == 12;
	}
	public static function isScorp(object : Object)
	{
		return object.man == 16;
	}
	public static function isWorm(object : Object)
	{
		return object.man == 17;
	}
	public static function isArachnid(object : Object)
	{
		return (object.man == 18) && (object.run == 1);
	}
	public static function isArachnidEgg(object : Object)
	{
		return (object.man == 18) && (object.run == 3);
	}
	public static function isPossessed(object : Object)
	{
		return object.man == 19;
	}
	public static function isMantis(object : Object)
	{
		return object.man == 20;
	}	
	public static function isRadar(object : Object)
	{
		return object.man == 27;
	}
	public static function isMechanoid(object : Object)
	{
		return object.man == 24;
	}
	public static function isPsiJammer(object : Object)
	{
		return object.man == 32;
	}
	public static function isEnergyJammer(object : Object)
	{
		return object.man == 33;
	}
	public static function isRocketTurret(object : Object)
	{
		return object.man == 21;
	}
	public static function isLaserTurret(object : Object)
	{
		return object.man == 23;
	}
	public static function isMachinegunTurret(object : Object)
	{
		return object.man == 22;
	}
	public static function isRatDecoy(object : Object)
	{
		return object.man == 30;
	}
	public static function isLaserBall(object : Object)
	{
		return object.man == 31;
	}
};