import asl.collections.Collection;

interface asl.collections.Stack extends Collection {
	public function push(o : Object) : Void;
	public function pop() : Object;
	public function peek() : Object;
};