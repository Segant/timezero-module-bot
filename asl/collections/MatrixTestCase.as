import asunit.framework.TestCase;
import asl.collections.Matrix;

class asl.collections.MatrixTestCase extends TestCase {
	public function MatrixTestCase(methodName : String) {
		super(methodName);
	}
	
	public function testCreate() {
		var m : Matrix = new Matrix(10, 5);
		
		assertNotNull(m);
		assertNotUndefined(m);
		
		assertEquals(m.width, 10);
		assertEquals(m.height, 5);
	}
	
	public function testModify() {
		var m : Matrix = new Matrix(10, 5);
		
		m.set(0, 0, 1);
		m.set(9, 4, "test");
		m.set(0, 1, true);
		
		assertEquals(m.get(0, 0), 1);
		assertEquals(m.get(9, 4), "test");
		assertEquals(m.get(0, 1), true);
		
		var exceptionThrown:Boolean = false;
		try {
			m.set(100, 100, 1);
		} catch (e : Error) {
			exceptionThrown = true;
		}
		assertTrue(exceptionThrown);
		
		exceptionThrown = false;
		try {
			m.get(100, 100);
		} catch (e : Error) {
			exceptionThrown = true;
		}
		assertTrue(exceptionThrown);
	}
};