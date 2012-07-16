import asunit.framework.TestCase;

import asl.traits;

class asl.TraitsTestCase extends TestCase {
	private var className:String = "asl.TraitsTestCase";
	
	public function TraitsTestCase(methodName : String) {
		super(methodName);
	}
	
	private function testInstanceOf() {
		var objects = [0, true, [], new MovieClip(), "", Object, new asl.core.Error()];
		var classes = [Number, Boolean, Array, MovieClip, String, Function, asl.core.Error];
		
		for (var i : Number = 0; i < objects.length; i++) {
			for (var k : Number = 0; k < objects.length; k++) {
				assertEquals(i == k, traits.instanceOf(objects[i], classes[k]));
			}
		}
		
		assertEquals(true, traits.instanceOf({}, Object));
		for (var i : Number = 0; i < objects.length; i++) {
			assertEquals(true, traits.instanceOf(objects[i], Object));
		}
	}
	
	private function testHasProperty() {
		assertEquals(true, traits.hasProperty({a : 1}, "a"));
		assertEquals(false, traits.hasProperty({a : 1}, "b"));
		assertEquals(false, traits.hasProperty({a : 1}, "12"));
		assertEquals(true, traits.hasProperty([1], "0"));
		assertEquals(false, traits.hasProperty([1], "1"));
		assertEquals(false, traits.hasProperty(this, "testHasProperty"));
		assertEquals(false, traits.hasProperty(testHasProperty, "apply"));
	}
}