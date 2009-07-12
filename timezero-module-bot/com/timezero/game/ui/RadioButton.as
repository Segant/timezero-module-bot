class com.timezero.game.ui.RadioButton extends MovieClip
{
    var txtLabel, gotoAndStop, _value, __get__value, onCheck, group, __get__checked, __get__label, __get__hint, __set__hint, useHandCursor, _alpha, __get__enabled, __set__checked, __set__enabled, __set__label, __set__value;
    function RadioButton()
    {
        super();
        txtLabel._visible = false;
    } // End of the function
    static function assign(mc)
    {
        if (!mc)
        {
            return (null);
        } // end if
        var _loc2 = com.timezero.game.ui.RadioButton;
        mc.__proto__ = _loc2.prototype;
        _loc2.call(mc);
        return ((com.timezero.game.ui.RadioButton)(mc));
    } // End of the function
    function onLoad()
    {
        this.gotoAndStop(_checked ? (2) : (1));
        txtLabel.autoSize = "left";
    } // End of the function
    function get value()
    {
        return (_value);
    } // End of the function
    function set value(v)
    {
        if (_value == v)
        {
            return;
        } // end if
        _value = v;
        //return (this.value());
        null;
    } // End of the function
    function get checked()
    {
        return (_checked);
    } // End of the function
    function set checked(value)
    {
        if (_checked == Boolean(value))
        {
            return;
        } // end if
        _checked = value;
        this.gotoAndStop(_checked ? (2) : (1));
        if (onCheck)
        {
            this.onCheck(_checked);
        } // end if
        if (group)
        {
            group.onButtonChanged(this);
        } // end if
        //return (this.checked());
        null;
    } // End of the function
    function get label()
    {
        return (txtLabel.text);
    } // End of the function
    function set label(value)
    {
        if (txtLabel.text == value)
        {
            return;
        } // end if
        txtLabel.text = value;
        txtLabel._visible = true;
        //return (this.label());
        null;
    } // End of the function
    function get hint()
    {
        //return (this.hint());
    } // End of the function
    function set hint(value)
    {
        this.__set__hint(value);
        //return (this.hint());
        null;
    } // End of the function
    function get enabled()
    {
        return (_enabled);
    } // End of the function
    function set enabled(value)
    {
        if (_enabled == Boolean(value))
        {
            return;
        } // end if
        _enabled = Boolean(value);
        useHandCursor = _enabled;
        _alpha = _enabled ? (100) : (30);
        //return (this.enabled());
        null;
    } // End of the function
    function onRelease()
    {
        if (!_enabled)
        {
            return;
        } // end if
        _root.PlaySnd("btn");
        this.__set__checked(!this.__get__checked());
    } // End of the function
    function onAddedToGroup(g)
    {
        group = g;
    } // End of the function
    var _checked = false;
    var _enabled = true;
} // End of Class
