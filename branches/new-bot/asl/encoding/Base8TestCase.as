import asunit.framework.TestCase;
import asl.encoding.Base8;

class asl.encoding.Base8TestCase extends TestCase {
	private var className:String = "asl.encoding.Base8TestCase";
	
	public function Base8TestCase(methodName : String) {
		super(methodName);
	}
	
	public function testEncode() {
		var s : Array = [
			"hello world with a base 8 algorithm"
		];
		var a : Array = [
			"68656c6c6f20776f726c64207769746820612062617365203820616c676f726974686d"
		];
		
		for (var i : Number = 0; i < s.length; i++) {
			var bytes : Array = asl.utils.StringUtilites.getUTF8Bytes(s[i]);
			assertEquals(Base8.encode(bytes), a[i]);
		}
	}
	
	public function testDecode() {
		var s : Array = [
			"hello world with a base 8 algorithm"
		];
		var a : Array = [
			"68656c6c6f20776f726c64207769746820612062617365203820616c676f726974686d"
		];
		
		for (var i : Number = 0; i < s.length; i++) {
			assertEquals(Base8.decode(a[i]), asl.utils.StringUtilites.getUTF8Bytes(s[i]));
		}
	}
};