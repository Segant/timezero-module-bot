import asunit.framework.TestSuite;

import asl.encoding.EncodingTestSuite;
import asl.FPTestCase;
import asl.TraitsTestCase;

class asl.ASLTestSuite extends TestSuite {
	public function ASLTestSuite() {
		super();
		addTest(new EncodingTestSuite());
		addTest(new FPTestCase());
		addTest(new TraitsTestCase());
	}
};