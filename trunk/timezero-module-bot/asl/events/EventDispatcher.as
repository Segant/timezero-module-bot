/**
* A standard implementation of IEventDispatcher used to dispatch events to listeners.
* Based on dannypatterson's event broadcaster. Updated to model flash player 9 api.
* @author Mims H. Wright
*
* Modified by Konovalov Alexander. 
* Part of Action Script Library.
*/

import asl.events.*;
import asl.core.IllegalArgumentException;

class asl.events.EventDispatcher implements IEventDispatcher {
	/** Stores the event listeners for this object. */
	private var _target : IEventDispatcher; //XXX : IEventTarget?
	private var _listeners : Object; //XXX : Hashtable
	
	/** Constructor */
	public function EventDispatcher(target : IEventDispatcher) {
		_target = target;
		_listeners = new Object();
	}
	
	/**
	* Adds a listener for a specific event type.
	* @param type - The string identifier type of event to listen for. 
	* @param scope - The object containing the method to call.
	* @param handler - The method to call when the event is dispatched.
	* @param [priority] - Priority of the listener.
	*/
	public function addEventListener(type : String, scope : Object, handler : Function) : Void {
		if (type == undefined) {
			throw new IllegalArgumentException("Type must be defined.");
		} else if (scope == undefined) {
			throw new IllegalArgumentException("Scope must be defined.");
		} else if (handler == undefined) {
			throw new IllegalArgumentException("Handler must be defined.");
		}
		
		var priority : Number = arguments[3] || 0;
		
		if (_listeners[type] == undefined) {
			_listeners[type] = new Array();
		}
		
		_listeners[type].push({scope : scope, handler : handler, priority : priority});
		
		_listeners[type].sortOn("priority", Array.NUMERIC);
	}
	
	/**
	* Dispatches the event object supplied.
	* @param event - The event to dispatch.
	*/
	public function dispatchEvent(event : Event) : Void {
		var type : String = event.type;
		var scope : Object = null;
		var handler : Function = null;
		
		event.target = _target;
		event.currentTarget = this;
		
		if (hasEventListener(type)) {
			var listenersForEvent:Array = _listeners[type];
			for (var i : Number = 0; i < listenersForEvent.length; i++) {
				scope = listenersForEvent[i].scope;
				handler = listenersForEvent[i].handler;
				handler.apply(scope, [event]);
			}
		}
	}
	
	/**
	* Removes a listener for a specific event type. 
	* The exact same parameters must have been used for the addEventListener in order for this to apply.
	*
	* @param type - The string identifier type of event that was being listened for. 
	* @param scope - The object containing the method to remove.
	* @param handler - The method to remove.
	*/
	public function removeEventListener(type : String, scope : Object, handler : Function) : Void {
		if (hasEventListener(type)) {
			var listenersForEvent : Array = _listeners[type];
			for (var i : Number = 0; i < listenersForEvent; i++) {
				if(listenersForEvent[i].scope == scope && listenersForEvent[i].handler == handler) {
					listenersForEvent.splice(i, 1);
					
					if (listenersForEvent.length == 0)  {
						_listeners[type] = null;
					}
					
					break;
				}
			}
		}
	}
	
	/**
	* Check to see if a given eventType has any listeners added.
	* @return Boolean true if there is a listener for the type or false if not. 
	*/
	public function hasEventListener(type : String) : Boolean {
		var listenersForEvent : Array = _listeners[type];
		return (listenersForEvent != null && listenersForEvent != undefined);
	}
}