import asl.collections.Collection;

interface asl.collections.Queue extends Collection {
	public function enqueue(o : Object) : Void;
	public function dequeue() : Object;
};