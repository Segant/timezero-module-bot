import asunit.framework.TestCase;
import asl.encoding.Base8;

class asl.encoding.Base8TestCase extends TestCase {
	private var className:String = "asl.encoding.Base8TestCase";
	
	public function Base8TestCase(methodName : String) {
		super(methodName);
	}
	
	public function testEncodeBytes() {
		var s : Array = [
			"hello world with a base 8 algorithm"
		];
		var a : Array = [
			"68656c6c6f20776f726c64207769746820612062617365203820616c676f726974686d"
		];
		
		for (var i : Number = 0; i < s.length; i++) {
			assertEquals(Base8.encodeBytes(asl.utils.StringUtilites.getUTF8Bytes(s[i])), a[i]);
		}
	}
	public function testDecodeBytes() {
		var s : Array = [
			"hello world with a base 8 algorithm"
		];
		var a : Array = [
			"68656c6c6f20776f726c64207769746820612062617365203820616c676f726974686d"
		];
		
		for (var i : Number = 0; i < s.length; i++) {
			var r : Array = Base8.decodeBytes(a[i]);
			var o : Array = asl.utils.StringUtilites.getUTF8Bytes(s[i]);
			
			assertEquals(r.length, o.length);
			for (var k : Number = 0; k < r.length; k++) {
				assertEquals(r[i], o[i]);
			}
		}
	}
	
	public function testEncode() {
		var s : Array = [
			"hello world with a base 8 algorithm"
		];
		var a : Array = [
			"68656c6c6f20776f726c64207769746820612062617365203820616c676f726974686d"
		];
		
		for (var i : Number = 0; i < s.length; i++) {
			assertEquals(Base8.encode(s[i]), a[i]);
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
			assertEquals(Base8.decode(a[i]), s[i]);
		}
	}
};