/**
 * Represents an event being dispatched from an IEventDispatcher.
 * Some standard event types are enumerated here as well.
 * Replicates the AS3 Event object in AS2.
 *
 * @author Mims H. Wright
 *
 * Modified by Konovalov Alexander. 
 * Part of Action Script Library.
 */

import asl.events.*;

dynamic class asl.events.Event extends Object {
	/** The type (description) of the event. A string used to identify the event. */
	public var type : String;
	/** XXX : Comment */
	public var target : IEventDispatcher;
	/** XXX : Comment */
	public var currentTarget : IEventDispatcher;
	
	public function Event(data : Object) {
		super();
		
		for (var i in data) {
			this[i] = data[i];
		}
	}
};