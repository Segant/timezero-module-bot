import asl.core.Exception;
import asl.utils.ObjectUtilites;

class asl.collections.IndexOutOfBoundsException extends Exception {
	public function IndexOutOfBoundsException() {
		if (ObjectUtilites.isNumber(arguments[0])) {
			super("Array index out of range: " + arguments[0]);
		} else {
			ObjectUtilites.getSuperClass(this).apply(this, arguments);
		}
	}
}