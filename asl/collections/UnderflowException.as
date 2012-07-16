import asl.core.Exception;
import asl.utils.ObjectUtilites;

class asl.collections.UnderflowException extends Exception {
	public function UnderflowException() {
		ObjectUtilites.getSuperClass(this).apply(this, arguments);
	}
}