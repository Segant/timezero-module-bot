/**
 * Event Dispatching interface based on the Flash Player 9 api and IBroadcastable by Danny Patterson
 * @see asl.events.EventDispatcher
 * @author Mims Wright
 * 
 * Modified by Konovalov Alexander. 
 * Part of Action Script Library.
 */
 
import asl.events.*;

interface asl.events.IEventDispatcher {
	/**
	 * Dispatches the event object supplied.
	 * @param event - The event to dispatch.
	 */
	public function dispatchEvent(event : Event) : Void;
	
	/**
	 * Adds a listener for a specific event type.
	 * @param type - The string identifier type of event to listen for. 
	 * @param scope - The object containing the method to call.
	 * @param handler - The method to call when the event is dispatched.
	 */
	public function addEventListener(type : String, scope : Object, handler : Function) : Void;
	
	/**
	 * Removes a listener for a specific event type. 
	 * The exact same parameters must have been used for the addEventListener in order for this to apply.
	 *
	 * @param type - The string identifier type of event that was being listened for. 
	 * @param scope - The object containing the method to remove.
	 * @param handler - The method to remove.
	 */
	public function removeEventListener(type : String, scope : Object, handler : Function) : Void;
	
	/**
	 * Check to see if a given eventType has any listeners added.
	 * @return Boolean true if there is a listener for the type or false if not. 
	 */
	public function hasEventListener(type : String) : Boolean;
};