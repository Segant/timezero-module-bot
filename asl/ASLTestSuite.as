import asunit.framework.TestSuite;

import asl.encoding.EncodingTestSuite;

class asl.ASLTestSuite extends TestSuite {
	public function ASLTestSuite() {
		super();
		addTest(new EncodingTestSuite());
	}
};