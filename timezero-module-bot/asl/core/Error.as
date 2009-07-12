import asl.utils.ObjectUtilites;

class asl.core.Error extends asl.core.Throwable {
	public function Error() {
		ObjectUtilites.getSuperClass(this).apply(this, arguments);
	}
};