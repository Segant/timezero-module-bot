class walle.Statistics {
	private var data : Object; //XXX : Hashtable
	
	public function Statistics() {
		data = new Object();
	}
	
	public function add(name : String, value : Number) {
		var o : Object = data[name] || (data[name] = new Object());
		if (isNaN(o.value)) o.value = 0;
		if (isNaN(o.count)) o.count = 0;
		
		o.value += value;
		o.count += 1;
	}
	public function getAverage(name : String) {
		return data[name].value / data[name].count;
	}
	public function remove(name : String) {
		
	}
};