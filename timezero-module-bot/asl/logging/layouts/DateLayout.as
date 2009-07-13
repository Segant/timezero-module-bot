/**
 * A layout with date information prefixed to each message.
 */
 
import asl.logging.Level;
import asl.logging.Layout;
 
class asl.logging.layouts.DateLayout implements Layout {
	public function format(level : Number, message : String) : String {
		var date : Date = new Date();
		var dateString : String = date.getHours() + ":" + 
			date.getMinutes() + ":" + date.getSeconds() + ":" + date.getMilliseconds();
		var levelString : String = Level.toString(level);
		return dateString + " " + levelString + " " + message;
	}
}