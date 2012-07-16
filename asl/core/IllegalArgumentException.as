import asl.utils.ObjectUtilites;
import asl.core.Exception;

class asl.core.IllegalArgumentException extends Exception {
	public function Exception() {
		ObjectUtilites.getSuperClass(this).apply(this, arguments);
	}
};