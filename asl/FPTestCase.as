import asunit.framework.TestCase;

import asl.fp;

class asl.FPTestCase extends TestCase {
	private var className:String = "asl.FPTestCase";
	
	public function FPTestCase(methodName : String) {
		super(methodName);
	}
	
	public function testDelegate() {
		var f : Function = fp.delegate({a : 1}, function() {
			return this.a;
		});
		
		assertEquals(1, f());
		assertEquals(1, f.apply({a : 0}));
	}
	
	public function testCurry() {
		assertEquals(100, fp.curry(asl.math.max, [99])(100));
		assertEquals(99, fp.curry(asl.math.max, [99])(12));
		assertEquals(10, fp.curry(asl.math.max, [10, 0])());
		
		var f : Function = fp.curry(function(x : Number) {
			return x + this.a;
		}, [2], {a : 1});
		assertEquals(3, f());
		
		assertEquals(3, fp.curry(asl.math.max, [])(3,2));
	}
	
	public function testCurried() {
		var f : Function = fp.curried(asl.math.max, 2);
		assertEquals(5, f(4)(5));
		
		var f1 : Function = f(1);
		assertEquals(2, f1(2));
		assertEquals(1, f1(0));
		
		assertEquals(3, fp.curried(asl.math.max, 0)(3,2));
	}
	
	public function testFlip() {
		var f : Function = function(a, b) { return a - b; }
		var ff : Function = fp.flip(f)
		assertEquals(-1, f(1, 2));
		assertEquals(1, ff(1, 2));
		 
		f = function(a, b, c) { return a * b * b * c * c * c; }
		ff = fp.flip(f)
		assertEquals(1 * 2 * 2 * 3 * 3 * 3, f(1, 2, 3));
		assertEquals(3 * 2 * 2 * 1 * 1 * 1, ff(1, 2, 3));
	}
	
	public function testMap() {
		assertEquals([[1],[2],[3]], fp.map(function(a){return [a];}, [1, 2, 3]));
		assertEquals([2, 4, 6], fp.map(function(a){return 2*a;}, [1, 2, 3]));
	}
	
	public function testFoldl() {
		assertEquals(false, 
					 fp.foldl(function(acc, next) {return acc[next];}, 
		                      {a : [1, [false]]},
							  ["a", 1, 0]));
		assertEquals(4, fp.foldl(asl.math.max, 0, [1, 4, 2]));
		assertEquals((2 - (4 - (1 - 0))), fp.foldl(function(acc, next) {return next - acc; },
		             0, [1, 4, 2]));
	}
	
	public function testFoldr() {
		assertEquals([3, 2, 1], 
					 fp.foldr(function(next, acc) {return acc.concat(next);},
		                      [1, 2, 3], []));
	}
	
	public function testFilter() {
		assertEquals([1,2,3], fp.filter(fp.id, [1,0,2,0,0,3]));
		assertEquals([1, 2], fp.filter(function(a){return a > 0}, [1, 2, 0, -1]));
	}
	
	public function testCount() {
		assertEquals(3, fp.count(fp.id, [1, 2, 3, 0, 0]));
		assertEquals(2, fp.count(function(a){return a > 0}, [1, 2, 0, -1]));
	}
	
	public function testZip() {
		assertEquals([[1,true], [2,false]], fp.zip([1, 2], [true, false]));
		assertEquals([[1,true]], fp.zip([1], [true, false]));
	}
	
	public function testTypeMatch() {
		assertEquals(true, fp.typeMatch("test", String));
		assertEquals(false, fp.typeMatch("test", Number));
		assertEquals(true, fp.typeMatch({}, Object));
		assertEquals(false, fp.typeMatch({}, Array));
		assertEquals(true, fp.typeMatch(new asl.core.Error(), asl.core.Error));
		assertEquals(true, fp.typeMatch([123, false, "re"], [Number, Boolean, String]));
		assertEquals(true, fp.typeMatch(function() { }, Function));
		assertEquals(true, fp.typeMatch({a:function(){}, b:123}, {a:Function, b:Number}));
		assertEquals(true, fp.typeMatch([123, false, "rer"], Array));
		assertEquals(true, fp.typeMatch([1, undefined, null, true], [Number, fp.ANY, fp.ANY, fp.ANY]));  
	}
	
	public function testMatch() {
		assertEquals(true, fp.match([1, 2, 3], [1, 2, Number]));
		assertEquals(true, fp.match( { a:2, b:[], c:new XMLSocket() }, { a:2, b:[], c:XMLSocket } ));
		assertEquals(true, fp.match([1, undefined, null, true], [1, fp.ANY, fp.ANY, true]));
		assertEquals(true, fp.match([1, undefined, null, true], [1, fp.UNDEFINED, fp.NULL, true]));
		assertEquals(false, fp.match([1, undefined, null, true], [1, Object, Object, true]));
	}
}