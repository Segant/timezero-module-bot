import tzmf.*;
import timezero.*;
import asl.math;
import asl.collections.Matrix;
import asl.collections.Queue;
import asl.collections.PriorityQueue;

class timezero.battle.Map
{
	private static function debug(message : String) {
		timezero.Chat.sendToClient("DEBUG : " + message, 5, true, false);
	}
	
	public static function isPassable(gx : Number, gy : Number, boxes : Boolean) : Boolean
	{
		var bg = _root.base.battle.btl.bg.earth[gx + "_" + gy];
		var bg2 : Boolean = !_root.base.battle.btl.bg["di" + gx + "_" + gy];
		if(!boxes) bg2 = true;
		return bg.thisOD < 1000000 && bg.thisOD >= 1 && !(bg.broken) && bg2;
	}
	public static function isVisible(x1 : Number, y1 : Number, x2 : Number, y2 : Number) : Boolean
	{
		var dx : Number = x2 - x1;
		var dy : Number = y2 - y1;
		
		var sx : Number = math.sign(dx);
		var sy : Number = math.sign(dy);
		
		var k : Number = (y2 - y1) / (x2 - x1);
		var b : Number = y1 - k * x1;
		
		if(dx > dy) for(var x : Number = x1; x != x2; x += sx)
		{
			if(!isPassable(math.round(x), math.round(k * x + b))) return false;
		}
		else for(var y : Number = y1; y != y2; y += sy)
		{
			if(!isPassable(math.round((y - b) / k), math.round(y))) return false;
		}
		
		return true;
	}
	public static function getGexDistance(x1 : Number, y1 : Number, x2 : Number, y2 : Number) : Number
	{
		var dx : Number = math.abs(x1 - x2);
		var dy : Number = math.abs(y1 - y2);
		if(dx == 0 || dy == 0) return math.maxl(dx, dy);
		else return dx * dy;
	}
	public static var wayCache : Object = new Object();
	public static function cleanWayCache()
	{
		for(var i in wayCache)
			delete wayCache[i];
		delete wayCache;
		
		wayCache = new Object();
	}
	public static function findWay(o1 : Object, o2 : Object) : Array {
		return findWayByXY(o1.bx, o1.by, o2.bx, o2.by);
	}
	public static function findWayByXY(x1 : Number, y1 : Number, x2 : Number, y2 : Number) : Array {
		//debug("Looking for way from " + xyToString(x1, y1) + " to " + xyToString(x2, y2));
		
		if(!!wayCache[x1 + "_" + y1 + "_" + x2 + "_" + y2]) {
			//debug("Found it in cache");
			return wayCache[x1 + "_" + y1 + "_" + x2 + "_" + y2];
		}
		
		if(!isPassable(x2, y2) || (x1 == x2 && y1 == y2)) {
			return null;
		}
		
		var distance : Number = getGexDistance(x1, y1, x2, y2);
	
		var map : Matrix = new Matrix(_global.MAP.map_max_x + 1, _global.MAP.map_max_y + 1);
		map.set(x1, y1, 1);
		
		function compare(a : Object, b : Object) : Number {
			var as : Number = a.fv + a.gv;
			var bs : Number = b.fv + b.gv;
			if (as > bs) return 1;
			else if (as < bs) return -1;
			else return 0;
		};
		
		//var temp : Array = new Array();
		//temp.push({x: x1, y: y1, s: 1});
		
		var queue : Queue = new PriorityQueue(compare);
		queue.enqueue({x : x1, y : y1, fv : 1, gv : 0});
		
		var success : Boolean = false;
		var counter : Number = 0;
		while (!success && !queue.isEmpty()) {
			var current : Object = queue.dequeue();
			counter++;
			
			for(var g in _global.gex) {
				var gx : Number = current.x + _global.gex[g].x;
				var gy : Number = current.y + _global.gex[g].y;
				
				if(gx == x2 && gy == y2) {
					success = true;
					break;
				}
				
				if (gx > 0 && gx < map.width && gy > 0 && gy < map.height) {
					if(map.get(gx, gy) > 0 && map.get(gx, gy) <= (current.fv + 1) || !isPassable(gx, gy, true)) 
						continue;
					
					map.set(gx, gy, current.fv + 1);
					queue.enqueue({x: gx, y: gy, fv: current.fv + 1, gv : getGexDistance(gx, gy, x2, y2) - distance});
				}
			}
		}
		
		//debug("counter : " + counter);
		
		if(!success) {
			//debug("wtf3");
			return null;
		}
		
		wayCache[x1 + "_" + y1 + "_" + x2 + "_" + y2] = new Array();
		var way : Array = wayCache[x1 + "_" + y1 + "_" + x2 + "_" + y2];
		var x : Number = Number(x2);
		var y : Number = Number(y2);
		success = false;
		
		while(!success) {
			var mv : Number = 10000;
			var mg : Number = 0;
			
			for(var g : Number = 0; g < _global.gex.length; g++) {
				var gx : Number = Number(x) + Number(_global.gex[g].x);
				var gy : Number = Number(y) + Number(_global.gex[g].y);
				
				if(gx == x1 && gy == y1) {
					mg = Number(g);
					mv = Number(map.get(gx, gy));
					success = true;
					break;
				}
				
				if(Number(map.get(gx, gy)) < Number(mv)) {
					mg = Number(g);
					mv = Number(map.get(gx, gy));
				}
			}
			
			x += Number(_global.gex[mg].x);
			y += Number(_global.gex[mg].y);
			
			way.push({direction : mg, x : x, y : y});
		}
		
		way.reverse();
		return way;
	}
	
	public static function get clearGex() : Number
	{
		for(var k = 0, i = math.round(math.rand(-0.5, 5.5)); k < 6; k++, i = (i + 1)%6)
		{
			if(isPassable(_global.MAP.iam.bx + _global.gex[i].x, _global.MAP.iam.by + _global.gex[i].y, true))
			{
				return i;
			}
		}
		return -1;
	}
	
	public static function get myPlayer() : Object {
		return _global.MAP.iam;
	}
	public static function get enemyPlayers() : Array {
		return _global.MAP.objects;
	}
	public static function get dropedItems() : Array {
		return _global.MAP.droped;
	}
	public static function get dropedBoxes() : Array {
		var ret : Array = new Array();
		for(var i in _global.MAP.droped)
		{
			var item : Object = _global.MAP.droped;
			var success : Boolean = false;
			for(var k in ret)
			{
				if(ret[k].bx == item.bx && ret[k].by == item.by)
				{
					ret[k].push(item);
					success = true;
				}
			}
			if(!success)
			{
				var arr : Array = new Array();
				arr.push(item);
				ret.push(arr);
			}
		}
		return ret;
	}
	public static function combineItemsToBoxes(items : Array) : Array
	{
		var result : Array = new Array();
		var tmp : Object = new Object();
		
		for(var i in items)
		{
			if(!tmp[items[i].bx + "_" + items[i].by])
				tmp[items[i].bx + "_" + items[i].by] = new Array();
			tmp[items[i].bx + "_" + items[i].by].push(items[i]);
		}
		
		var k : Number = 0;
		for(var i in tmp) 
			result[k++] = tmp[i];
		
		return result;
	}
	public static function xyToString(x : Number, y : Number) : String {
		var englishAlphabet : String = 
			"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		return englishAlphabet.charAt(y) + " " + (x - 12 + (1 + Math.floor(y / 2)));
	}
}