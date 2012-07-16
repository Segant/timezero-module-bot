/** Rich(but old) wrapped Timezero api */
import timezero.Chat;
import timezero.Client;
import timezero.Dialog;
import timezero.User;
import timezero.buildings.Arena;
import timezero.buildings.Mine;
import timezero.battle.Battle;
import timezero.battle.Players;
import timezero.battle.Map;

/** Action Script Library */
import asl.Math;
import asl.utils.ObjectUtilites;
import asl.utils.ArrayUtilites;
import asl.utils.Hook;
import asl.utils.Hooker;
import asl.utils.Timer;
import asl.ui.CheckBox;
import asl.events.*;
import asl.fp;

/** Walle api */
import walle.Objective;
import walle.ObjectiveManager;
import walle.LicensionChecker;

class walle.objectives.AutoDigger implements Objective {
	private var _settings : Object;
	private var _manager : ObjectiveManager;
	
	public function AutoDigger(settings : Object) {
		_settings = settings;
	}
	
	public function onAdd(manager : ObjectiveManager) : Void {
		_manager = manager;
	}
	public function onResult(objective : Objective, result : Object) : Void {
		
	}
	
	public function printDebug(message : Object) {
		if (_settings.walle.debug) {
			Chat.sendToClient("DEBUG : " + message, 5, true, false);
		}
	}
	
	public function getEnemys() {
		var players : Array = ArrayUtilites.clone(Map.enemyPlayers);
		players = fp.filter(function(item : Object) {
			return (Map.myPlayer.group != item.group)/* && timezero.battle.Map.myPlayer.login != item.login*/;
		}, players);
		if(players.length == 0) return null;
		
		players.sort(function(a : Object, b : Object) {			
			var ad : Number = Map.findWay(Map.myPlayer, a).length;
			var bd : Number = Map.findWay(Map.myPlayer, b).length;
			
			if(ad < bd) {
				return -1;
			} else if(ad > bd) {
				return 1;
			} else {
				if(a.level < b.level) {
					return -1;
				} else {
					return 1;
				}
			}
		});
		
		return players;
	}
	
	public function getConcurents() //получаем список всех, кто в одной группе с ботом
	{
		var players2 : Array = ArrayUtilites.clone(Map.enemyPlayers);
		players2 = fp.filter(function(item : Object)
		{
			return ((timezero.battle.Map.myPlayer.group == item.group) && (timezero.battle.Map.myPlayer.login != item.login))
		}, players2);
		if(players2.length == 0) return null;
		players2.sort(function(a : Object, b : Object) {			
			var ad : Number = Map.findWay(Map.myPlayer, a).length;
			var bd : Number = Map.findWay(Map.myPlayer, b).length;
			
			if(ad < bd) return -1;
			else if(ad > bd) return 1;
			else
			{
				if(a.level < b.level) return -1;
				else return 1;
			}
		});
		
		return players2;
	}
	
	private function getBoxes() {
		var droped : Array = Map.dropedItems.concat();
		droped = fp.filter(function(item : Object) {
			printDebug(item.txt);
			var name : String = item.txt.toLowerCase().split(' ').join('_');
			
			if (_settings.walle.pickup[name] == undefined || _settings.walle.pickup[name] == true) {
				printDebug("OK");
				return true;
			} else {
				return false;
			}
		}, droped);
		printDebug(droped.length);
		if(droped.length == 0) return null;
		
		var boxes : Array = Map.combineItemsToBoxes(droped).concat();
		boxes.sort(function(a : Object, b : Object) {
			var ad : Number = Map.findWay(Map.myPlayer, a[0]).length;
			var bd : Number = Map.findWay(Map.myPlayer, b[0]).length;

			if(ad < bd) return -1;
			else return 1;
		});
		printDebug(boxes.length);
		
		return boxes;
	}
	
	public function attackMonster(monster : Object) //атака указанного монстра
	{
		Battle.reload();
		if((User.dazzling + User.hallucination) <= 0) 
			Battle.attack(monster);
		else 
			Battle.attack(monster, false, true);
		Battle.reload();
	}
	
	private function distance(o : Object) {
		var way : Array = timezero.battle.Map.findWay(Map.myPlayer, o);
		if (way == null) {
			return -1;
		} else {
			return way.length;
		}
	}
	
	public function processBattle2() {
		if (Battle.inPlanningMode) {
			Map.cleanWayCache();
			Battle.undoAllActions();
			
			var enemys : Array = getEnemys();
			var boxes : Array = getBoxes();
			
			var enemy : Object = enemys[0] || null;
			var box : Object = boxes[0] || null;
			
			printDebug("enemy " + (enemy ? "1" : "0") + "box " + (box ? "1" : "0"));
			
			if (enemy != null) {
				var minDistance : Number = 5;
				if (Players.isRat(enemy)) {
					minDistance = Number(enemy.level) + 1;
				}
				
				Battle.reload();
				var way : Array = Map.findWay(Map.myPlayer, enemy);
				if (way.length > minDistance) {
					var l : Number = way.length - 1 - minDistance;
					Battle.setFlag(way[l].x, way[l].y);
				}
				attackMonster(enemy);
				Battle.endOfTurn();
			} else if (box != null) {
				var count : Number = fp.count(function (item : Object) : Boolean {
					return Map.myPlayer.group == item.group && User.login != item.login;	
				}, Map.enemyPlayers);
				printDebug("concurrents : " + count);
				if (count == 0 && User.isVIP) {
					printDebug("what the fuck?");
					Battle.getAllVIP();
				} else {
					printDebug(Map.myPlayer.bx + " " + Map.myPlayer.by);
					printDebug(box.length);
					printDebug(box[0]);
					var way : Array = Map.findWay(Map.myPlayer, box[0]);
						printDebug(way);
					if (way.length == 1) {
						for(var i : Number = 0; i < box.length && User.AP != 0; i++) {
							Battle.pickup(box[i], 4);
						}
					} else {
						Battle.setFlag(box[0].bx, box[0].by);
					}
					Battle.endOfTurn();
				}
			} else {
				Battle.endOfBattle();
			}
		}
	}
	
	private function processArena() {
		var arena : Arena = new Arena();
		if(User.HP > (User.maxHP * 0.75)) {
			if(arena.room == 115 || arena.room == 0) { 
				arena.room = 116;
			} else {
				arena.findMonsters();
			}
		} else if(arena.room != 115) {
			arena.room = 115;
		}
	}
	
	private function processMine() {
		var mine : Mine = new Mine();
		if(User.HP > (User.maxHP * 0.75)) {
			mine.findMonsters();
		}
	}
	
	public function onTimer() : Void {
		if(Battle.inBattle) {
			printDebug("processBattle");
			processBattle2();
		} else if (_settings.walle.autobattle) {
			if(User.inBattle) {
				Battle.exit();
			} else if(User.inArena && User.level < 3) {
				processArena();
			} else if(User.inMine) {
				processMine();
			}
		}
	}
	public function onRemove() : Void {
		
	}
};