import asl.utils.ObjectUtilites;
import asl.core.Exception;

class asl.core.IllegalStateException extends Exception {
	public function IllegalStateException() {
		ObjectUtilites.getSuperClass(this).apply(this, arguments);
	}
};