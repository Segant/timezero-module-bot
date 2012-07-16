import asl.collections.Collection;

interface asl.collections.List extends Collection {
	public function get(index : Number) : Object;
	public function set(index : Number, object : Object) : Object;
	public function insert(index : Number, object : Object) : Void;
	public function removeAt(index : Number) : Object;
	
	public function indexOf(object : Object) : Number;
    public function lastIndexOf(object : Object) : Number;
	
    public function subList(fromIndex : Number, toIndex : Number) : List;
	
	public function length() : Number;
};