interface asl.hashing.Digest {
	public function reset() : Void;
	public function update(bytes : Array);
	public function digest() : Array;
	public function digestAsString() : String;
	
	public function name() : String;
};