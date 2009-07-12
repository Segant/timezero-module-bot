class com.timezero.game.ui.RadioButtonGroup
{
    var buttons, checkedButton, __get__value, locked, onChange, __set__value;
    function RadioButtonGroup()
    {
        buttons = new Array();
    } // End of the function
    function get value()
    {
        if (checkedButton == undefined)
        {
            return;
        }
        else
        {
            //return (checkedButton.value());
        } // end else if
    } // End of the function
    function set value(value)
    {
        for (var _loc2 = 0; _loc2 < buttons.length; ++_loc2)
        {
            if (buttons[_loc2].value == value)
            {
                buttons[_loc2].checked = true;
                break;
            } // end if
        } // end of for
        //return (this.value());
        null;
    } // End of the function
    function addButton(button)
    {
        buttons.push(button);
        button.onAddedToGroup(this);
    } // End of the function
    function onButtonChanged(btn)
    {
        if (locked)
        {
            return;
        } // end if
        checkedButton = undefined;
        if (btn.__get__checked())
        {
            checkedButton = btn;
            for (var _loc3 = 0; _loc3 < buttons.length; ++_loc3)
            {
                var _loc2 = buttons[_loc3];
                if (_loc2 !== btn && _loc2.__get__checked())
                {
                    locked = true;
                    _loc2.__set__checked(false);
                    locked = false;
                } // end if
            } // end of for
        } // end if
        this.onChange(prevValue);
        prevValue = value;
    } // End of the function
    var prevValue = undefined;
} // End of Class
