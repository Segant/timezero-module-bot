import asl.collections.IndexOutOfBoundsException;

class asl.collections.Matrix {
	private var _data : Array;
	private var _width : Number;
	private var _height : Number;
	
	public function Matrix(width : Number, height : Number) {
		_width = width;
		_height = height;
		_data = new Array(width * height);
		/* Which way is faster?
		_data = new Array(height);
		for (var i : Number = 0; i < _height; i++) {
			_data[i] = new Array(_width);
		}
		*/
	}
	
	private function _rangeCheck(x : Number, y : Number) {
		if (x < 0 || x >= _width) {
			throw new IndexOutOfBoundsException(x);
		}
		if (y < 0 || y >= _height) {
			throw new IndexOutOfBoundsException(y);
		}
	}
	
	public function get width() : Number {
		return _width;
	}
	public function get height() : Number {
		return _height;
	}
	
	public function get(x : Number, y : Number) : Object {
		_rangeCheck(x, y);
		return _data[y * _width + x];
		/*
		return _data[y][x];
		*/
	}
	public function set(x : Number, y : Number, o : Object) : Void {
		_rangeCheck(x, y);
		_data[y * _width + x] = o;
		/*
		_data[y][x] = o;
		*/
	}
};