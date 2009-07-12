import asunit.textui.TestRunner;
import asl.ASLTestSuite;

class asl.ASLTestRunner extends TestRunner {
	public function ASLTestRunner() {
		start(ASLTestSuite, null, TestRunner.SHOW_TRACE);
	}
	public static function main():Void {
		var runner = new ASLTestRunner();
	}
}