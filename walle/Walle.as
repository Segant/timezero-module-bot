/** Rich(but old) wrapped Timezero api */
import timezero.Chat;
import timezero.Client;
//import timezero.Dialog;
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

/** Walle api */
import walle.XOMLoader;
import walle.Objective;
import walle.ObjectiveManager;
import walle.LicensionChecker;
import walle.Logger;

import walle.objectives.AutoDigger;

class walle.Walle {
	private var _sendHook : Hook;
	private var _recvHook : Hook;
	private var _timer : Timer;
	private var _ui : MovieClip;
	private var _objectiveManager : ObjectiveManager;
	private var _settings : Object;
	private var _started : Boolean;
	private var _log : Logger;
	
	public function Walle(ui : MovieClip) {					
		_timer = new Timer(1000);
		_ui = ui;
		_objectiveManager = new ObjectiveManager();
		_started = false;
		_log = new Logger();
		_log.connect("localhost", 5191);
		
		Chat.sendToClient("Walle.Walle(" + arguments.toString() + ");");
	}
	
	private function _main() {
		Chat.addEventListener(Chat.ON_CHAT_MESSAGE, this, onChatMessage);
		_timer.addEventListener(Timer.TIMER, this, onTimerEvent);
		
		Chat.sendToClient("WALL-E - TimeZero autodigger", Math.randomIntegerInRange(0, 15));
		Chat.sendToClient("(C) Konovalov Alexander aka Linos, xenn, Edwin Irving, Revival, Konrad Roar", Math.randomIntegerInRange(0, 15));
		Chat.sendToClient("(!!!) Экспериментальная версия. (!!!)", Math.randomIntegerInRange(0, 15));
		
		_timer.delay = Number(_settings.walle.thinkDelay);
	}
	
	public function start() {
		_started = true;
		_objectiveManager.add("AutoDigger", [_settings]);
		_timer.start();
	}
	public function stop() {
		_timer.stop();
		_objectiveManager.clear();
		_started = false;
	}
	
	public function onChatMessage(e : Event) {
		var args : Array = e.message.split(";");
	}
	public function onTimerEvent(e : Event) {
		_objectiveManager.current.onTimer();
	}
	
	private function _checkLicension() : Boolean {
		var login : String = _settings.walle.licension.login;
		var maxLevel : Number = _settings.walle.licension.maxLevel;
		var expDate : Date = _settings.walle.licension.expDate;
		var rkey : Number = _settings.walle.licension.rkey;
		var key : String = _settings.walle.licension.key;
		
		return LicensionChecker.check(login, maxLevel, expDate, rkey, key);
	}
	
	private function _loadSettings() {
		Chat.sendToClient("Walle.loadSettings(" + arguments.toString() + ");");
		var loader : XOMLoader = new XOMLoader();
		
		loader.addEventListener(XOMLoader.ON_LOAD, this, function(e : Event) {
			if (e.success) {
				_settings = e.result;
				
				Chat.sendToClient("Настройки загружены.");
				
				Chat.sendToClient(_settings.walle.autoOff);
				//if (!_checkLicension()) {
					//Chat.sendToClient("Лицензия устарела или не валидна.");
					//return;
				//}
			} else {
				Chat.sendToClient("Не могу загрузить \"" + e.url + "\".");
				//Chat.sendToClient("Лицензия устарела или не валидна.");
				return;
			}
			
			_initializeUI();
			
			_main();
		});
		
		loader.loadURL(User.login + ".xml");
	}
	
	private function _initializeUI() {
		function onClick(e : Event) {
			var checkBox : CheckBox = CheckBox(e.target);
			Chat.sendToClient("checkBox pressed : " + checkBox.name);
			switch(checkBox.name) {
				case "autoHealCheckBox":
					checkBox.checked = !checkBox.checked;
					_settings.walle.autoHeal = checkBox.checked;
					break;
				case "autoOffCheckBox":
					checkBox.checked = !checkBox.checked;
					_settings.walle.autoOff = checkBox.checked;
					break;
				case "autoBattleCheckBox":
					checkBox.checked = !checkBox.checked;
					_settings.walle.autoBattle = checkBox.checked;
					break;
				case "debugCheckBox":
					checkBox.checked = !checkBox.checked;
					_settings.walle.debug = checkBox.checked;
					break;
				case "onOffCheckBox":
					checkBox.checked = !checkBox.checked;
					if (checkBox.checked) {
						this.start();
					} else {
						this.stop();
					}
					break;
				default:
					if (checkBox.name.substr(0, 6) == "PickUp") {
						checkBox.checked = !checkBox.checked;
						var k : String = checkBox.name.substr(6).split('_').join(' ');
						_settings.walle.pickup[k] = checkBox.checked;
					}
					break;
			};
		}
		
		_ui.autoHealCheckBox.checked = _settings.walle.autoHeal;
		_ui.autoOffCheckBox.checked = _settings.walle.autoOff;
		_ui.autoBattleCheckBox.checked = _settings.walle.autoBattle;
		_ui.onOffCheckBox.checked = _started;
		_ui.debugCheckBox.checked = _settings.walle.debug;
		
		_ui.autoHealCheckBox.addEventListener(CheckBox.ON_CLICK, this, onClick);
		_ui.autoOffCheckBox.addEventListener(CheckBox.ON_CLICK, this, onClick);
		_ui.autoBattleCheckBox.addEventListener(CheckBox.ON_CLICK, this, onClick);
		_ui.onOffCheckBox.addEventListener(CheckBox.ON_CLICK, this, onClick);
		_ui.debugCheckBox.addEventListener(CheckBox.ON_CLICK, this, onClick);
		
		var resources : Array = [
			"Metals", 
			"Gems", 
			"Precious metals", 
			"Radioactive materials", 
			"Venom", 
			"Silicon", 
			"Organic", 
			"Polymers"
		];
		for (var k : String in resources) {
			var i : String = resources[k];
			_ui["PickUp" + i.split(' ').join('_')].checked = _settings.walle.pickup[i];
			_ui["PickUp" + i.split(' ').join('_')].addEventListener(CheckBox.ON_CLICK, this, onClick);
		}
	}
	
	public function printDebug(message : Object) {
		if (_settings.gwalle.debug) {
			Chat.sendToClient("DEBUG : " + message, 5, true, false);
		}
	}
	
	public function onLoad() {
		//Dialog.initialize();
		_log.log(Logger.MESSAGE, "Loaded");
		
		var walle : Walle = this;
		_sendHook = asl.utils.Hooker.setOnCall(_global.net.TzConnection.prototype, 
				"send", function (args : Array, hook : Hook) {
			if (args[0]) {
				walle.printDebug(args[0].toString());
				
				var packetName : String = args[0].value.firstChild.nodeName;
				if (packetName.indexOf("DLS") == 0) {
					timezero.Chat.sendToClient("DETECTED Anti-cheat NetCommand : ", 5, true);
					timezero.Chat.sendToClient(args[0].toString());
					return;
				} else {
					return hook.invoke(args);
				}
			}
			return;
		});
		
		_recvHook = asl.utils.Hooker.setOnCall(Client.gameConnection._proxy._sock, 
				"onData", function (args : Array, hook : Hook) {
			if (args[0]) {
				walle.printDebug(args[0].toString());
				
				/*var packetName : String = args[0].value.firstChild.nodeName;
				if (packetName.indexOf("DLS") == 0) {
					timezero.Chat.sendToClient("DETECTED Anti-cheat NetCommand : ", 5, true);
					timezero.Chat.sendToClient(args[0].toString());
					return;
				} else {
					return hook.invoke(args);
				}*/
			}
			return hook.invoke(args);
		});
		Chat.sendToClient("Walle.onLoad(" + arguments.toString() + ");");
		_loadSettings();
	}
	public function onClose() {
		Chat.removeEventListener(Chat.ON_CHAT_MESSAGE, this, onChatMessage);
		
		//Dialog.shutdown();
		
		_timer.removeEventListener(Timer.TIMER, this, onTimerEvent);
		_timer.stop();
	}
};