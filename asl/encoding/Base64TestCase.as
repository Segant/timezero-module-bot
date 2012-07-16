import asunit.framework.TestCase;
import asl.encoding.Base64;

class asl.encoding.Base64TestCase extends TestCase {
	private var className:String = "asl.encoding.Base64TestCase";
	
	public function Base64TestCase(methodName : String) {
		super(methodName);
	}
	
	public function testEncodeBytes() {
		var s : Array = [
			"f",
			"fo",
			"foo",
			"foos",
			"all your base64 are belong to foo",
			"Hello, how are you today?"
		];
		var a : Array = [
			"Zg==",
			"Zm8=",
			"Zm9v",
			"Zm9vcw==",
			"YWxsIHlvdXIgYmFzZTY0IGFyZSBiZWxvbmcgdG8gZm9v",
			"SGVsbG8sIGhvdyBhcmUgeW91IHRvZGF5Pw=="
		];
		
		for (var i : Number = 0; i < s.length; i++) {
			assertEquals(Base64.encodeBytes(asl.utils.StringUtilites.getUTF8Bytes(s[i])), a[i]);
		}
	}
	public function testDecodeBytes() {
		var s : Array = [
			"f",
			"fo",
			"foo",
			"foos",
			"all your base64 are belong to foo",
			"Hello, how are you today?"
		];
		var a : Array = [
			"Zg==",
			"Zm8=",
			"Zm9v",
			"Zm9vcw==",
			"YWxsIHlvdXIgYmFzZTY0IGFyZSBiZWxvbmcgdG8gZm9v",
			"SGVsbG8sIGhvdyBhcmUgeW91IHRvZGF5Pw=="
		];
		
		for (var i : Number = 0; i < s.length; i++) {
			var r : Array = Base64.decodeBytes(a[i]);
			var o : Array = asl.utils.StringUtilites.getUTF8Bytes(s[i]);
			
			assertEquals(r.length, o.length);
			for (var k : Number = 0; k < r.length; k++) {
				assertEquals(r[i], o[i]);
			}
		}
	}
	
	public function testEncode() {
		var s : Array = [
			"f",
			"fo",
			"foo",
			"foos",
			"all your base64 are belong to foo",
			"Hello, how are you today?"
		];
		var a : Array = [
			"Zg==",
			"Zm8=",
			"Zm9v",
			"Zm9vcw==",
			"YWxsIHlvdXIgYmFzZTY0IGFyZSBiZWxvbmcgdG8gZm9v",
			"SGVsbG8sIGhvdyBhcmUgeW91IHRvZGF5Pw=="
		];
		
		for (var i : Number = 0; i < s.length; i++) {
			assertEquals(Base64.encode(s[i]), a[i]);
		}
	}
	
	public function testDecode() {
		var s : Array = [
			"f",
			"fo",
			"foo",
			"foos",
			"all your base64 are belong to foo",
			"Hello, how are you today?"
		];
		var a : Array = [
			"Zg==",
			"Zm8=",
			"Zm9v",
			"Zm9vcw==",
			"YWxsIHlvdXIgYmFzZTY0IGFyZSBiZWxvbmcgdG8gZm9v",
			"SGVsbG8sIGhvdyBhcmUgeW91IHRvZGF5Pw=="
		];
		
		for (var i : Number = 0; i < s.length; i++) {
			assertEquals(Base64.decode(a[i]), s[i]);
		}
	}
};