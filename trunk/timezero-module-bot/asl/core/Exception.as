import asl.utils.ObjectUtilites;
import asl.core.Throwable;

class asl.core.Exception extends Throwable {
	public function Exception() {
		ObjectUtilites.getSuperClass(this).apply(this, arguments);
	}
};