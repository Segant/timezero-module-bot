import asl.utils.Endian;

class asl.utils.ByteArrayStream {
	private var _data : Array;
	private var _position : Number;
	private var _endian : Number;
	
	public function ByteArrayStream() {
		_data = new Array();
		_position = 0;
		_endian = Endian.LITTLE_ENDIAN;
	}
	
	public function set data(value : Array) : Void {
		if (value == null) {
			_data = new Array();
		} else {
			_data = value;
		}
	}
	public function get data() : Array {
		return _data;
	}
	
	public function get length() : Number {
		return _data.length;
	}
	public function set position(value : Number) : Void {
		_position = value;
	}
	public function get position() : Number {
		return _position;
	}
	
	public function set endian(value : Number) : Void {
		if (value == Endian.LITTLE_ENDIAN || 
				value == Endian.BIG_ENDIAN ||
				value == Endian.MIDDLE_ENDIAN) {
			_endian = value;
		} else {
			_endian = Endian.LITTLE_ENDIAN;
		}
	}
	public function get endian() : Number {
		return _endian;
	}
	
	private function _write(x : Number) {		
		if (_position == _data.length) {
			_data.push(x);
			_position = _data.length;
		} else {
			_data[_position++] = x;
		}
	}
	
	public function writeUnsigned8(x : Number) : Void {
		x &= 0xFF;
		_data.push(x);
	}
	public function writeUnsigned16(x : Number) : Void {
		x &= 0xFFFF;
		
		switch (_endian) {
			case Endian.LITTLE_ENDIAN : {
				_write(x & 0xFF);
				_write((x >> 8) & 0xFF);
				break;
			}
			case Endian.BIG_ENDIAN : {
				_write((x >> 8) & 0xFF);
				_write(x & 0xFF);
				break;
			}
			case Endian.MIDDLE_ENDIAN : {
				_write(x & 0xFF);
				_write((x >> 8) & 0xFF);
				break;
			}
		}
	}
	public function writeUnsigned32(x : Number) : Void {
		x &= 0xFFFFFFFF;
		
		switch (_endian) {
			case Endian.LITTLE_ENDIAN : {
				_write(x & 0xFF);
				_write((x >> 8) & 0xFF);
				_write((x >> 16) & 0xFF);
				_write((x >> 24) & 0xFF);
				break;
			}
			case Endian.BIG_ENDIAN : {
				_write((x >> 24) & 0xFF);
				_write((x >> 16) & 0xFF);
				_write((x >> 8) & 0xFF);
				_write(x & 0xFF);
				break;
			}
			case Endian.MIDDLE_ENDIAN : {
				_write((x >> 16) & 0xFF);
				_write((x >> 24) & 0xFF);
				_write(x & 0xFF);
				_write((x >> 8) & 0xFF);
				break;
			}
		}
	}
	
	public function writeInteger8(x : Number) : Void {
		writeUnsigned8(x);
	}
	public function writeInteger16(x : Number) : Void {
		writeUnsigned16(x);
	}
	public function writeInteger32(x : Number) : Void {
		writeUnsigned32(x);
	}
};