class asl.ui.Label extends asl.ui.Widget {
	private var _textField : TextField;
	
	public function Label() {
		super();
		
		createTextField("_textField", 0, 0, 0, 100, 22);
		_textField.selectable = false;
		
		updateView();
	}
	
	[Inspectable(defaultValue="Label")]
	public function set text(value) {
		_textField.text = value;
	}
	public function get text() : String {
		return _textField.text;
	}
	
	public function updateSize() {
		_textField._width = _width;
        _textField._height = _textField.textHeight + 4;
        _textField._y = Math.round(_height / 2 - _textField._height / 2);
	}
	public function updateView() {
		var format : TextFormat = new TextFormat("_sans", 12, 0);
        format.align = "center";
        
        _textField.setTextFormat(format);
        _textField.setNewTextFormat(format);
		
		updateSize();
	}
}