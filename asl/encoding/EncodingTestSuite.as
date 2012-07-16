import asunit.framework.TestSuite;

import asl.encoding.Base64TestCase;
import asl.encoding.Base8TestCase;

class asl.encoding.EncodingTestSuite extends TestSuite {
	public function EncodingTestSuite() {
		super();
		
		addTest(new Base64TestCase());
		addTest(new Base8TestCase());
	}
};