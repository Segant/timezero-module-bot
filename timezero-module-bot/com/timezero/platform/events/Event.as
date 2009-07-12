class com.timezero.platform.events.Event
{
    var type, bubbles, cancelable, __get__target, __set__target, currentTarget, $target;
    function Event(type, bubbles, cancelable)
    {
        this.type = type;
        this.bubbles = Boolean(bubbles);
        this.cancelable = Boolean(cancelable);
        __do_cancel = false;
        if (!this.__get__target())
        {
            this.__set__target(null);
        } // end if
        currentTarget = null;
        _global.ASSetPropFlags(this, new Array("type", "target", "currentTarget", "bubbles", "cancelable", "__do_cancel", "clone", "stopPropagation", "toString"), 3, 4);
    } // End of the function
    static function IEvent(object)
    {
        if (!object || !object.type)
        {
            return (null);
        } // end if
        var _loc2 = com.timezero.platform.events.Event;
        object.clone = _loc2.prototype.clone;
        object.stopPropagation = _loc2.prototype.stopPropagation;
        object.toString = _loc2.prototype.toString;
        _loc2.call(object, object.type, object.bubbles, object.cancelable);
        return (object);
    } // End of the function
    function get target()
    {
        return ($target);
    } // End of the function
    function set target(value)
    {
        if (!value || value == $target)
        {
            return;
        } // end if
        $target = value;
        //return (this.target());
        null;
    } // End of the function
    function clone()
    {
        var _loc2 = new com.timezero.platform.events.Event(type, bubbles, cancelable);
        _loc2.__set__target(target);
        for (var _loc3 in this)
        {
            _loc2[_loc3] = this[_loc3];
        } // end of for...in
        return (_loc2);
    } // End of the function
    function stopPropagation()
    {
        __do_stop = 1;
    } // End of the function
    function stopImmediatePropagation()
    {
        __do_stop = 2;
    } // End of the function
    function preventDefault()
    {
        if (cancelable)
        {
            __do_cancel = true;
        } // end if
    } // End of the function
    function isDefaultPrevented()
    {
        return (__do_cancel);
    } // End of the function
    function toString()
    {
        var _loc2 = new Array("type", "bubbles", "cancelable");
        for (var _loc3 in this)
        {
            _loc2.push(_loc3);
        } // end of for...in
        for (var _loc3 in _loc2)
        {
            _loc2[_loc3] = _loc2[_loc3] + ("=" + (typeof(this[_loc2[_loc3]]) == "string" ? ("\"") : ("")) + this[_loc2[_loc3]] + (typeof(this[_loc2[_loc3]]) == "string" ? ("\"") : ("")));
        } // end of for...in
        return ("[Event " + _loc2.join(" ") + "]");
    } // End of the function
    var __do_cancel = false;
    var __do_stop = 0;
} // End of Class
