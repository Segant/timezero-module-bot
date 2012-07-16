class com.timezero.platform.events.EventDispatcher implements com.timezero.platform.events.IEventDispatcher
{
    var __listeners, __event_target;
    function EventDispatcher(target)
    {
        __listeners = new Object();
        __event_target = target || this;
        _global.ASSetPropFlags(this, new Array("__listeners", "__event_target", "addEventListener", "removeEventListener", "hasEventListener", "dispatchEvent"), 7);
    } // End of the function
    static function IEventDispatcher(object)
    {
        if (!object)
        {
            return (null);
        } // end if
        var _loc1 = com.timezero.platform.events.EventDispatcher;
        object.addEventListener = _loc1.prototype.addEventListener;
        object.removeEventListener = _loc1.prototype.removeEventListener;
        object.dispatchEvent = _loc1.prototype.dispatchEvent;
        object.hasEventListener = _loc1.prototype.hasEventListener;
        _loc1.call(object);
        return (object);
    } // End of the function
    function addEventListener(type, scope, handler, priority)
    {
        if (!type || (typeof(handler) != "string" || !scope) && typeof(handler) != "function")
        {
            return;
        } // end if
        priority = isNaN(priority) ? (0) : (priority);
        var _loc4 = __listeners[type];
        if (_loc4)
        {
            var _loc2 = 0;
            var _loc5 = _loc4.length;
            var _loc3;
            var _loc6;
            var _loc7 = _loc5;
            while (_loc2 < _loc5)
            {
                _loc3 = _loc4[_loc2];
                if (_loc3.scope == scope && _loc3.handler == handler)
                {
                    _loc6 = _loc3;
                    _loc4.splice(_loc2, 1);
                    --_loc5;
                    --_loc2;
                    break;
                } // end if
                if (_loc3.priority < priority)
                {
                    _loc7 = _loc2;
                    break;
                } // end if
                ++_loc2;
            } // end while
            if (!_loc6)
            {
                while (_loc2 < _loc5)
                {
                    _loc3 = _loc4[_loc2];
                    if (_loc3.scope == scope && _loc3.handler == handler)
                    {
                        _loc6 = _loc3;
                        _loc4.splice(_loc2, 1);
                        break;
                    } // end if
                    ++_loc2;
                } // end while
                if (!_loc6)
                {
                    _loc6 = {scope: scope || null, handler: handler};
                } // end if
            }
            else if (_loc7 == _loc5)
            {
                while (_loc2 < _loc5)
                {
                    if (_loc3.priority < priority)
                    {
                        _loc7 = _loc2;
                        break;
                    } // end if
                    ++_loc2;
                } // end while
            } // end else if
            _loc6.priority = priority;
            _loc4.splice(_loc7, 0, _loc6);
        }
        else
        {
            __listeners[type] = new Array({priority: priority, scope: scope || null, handler: handler});
        } // end else if
    } // End of the function
    function removeEventListener(type, scope, handler)
    {
        if (!this.hasEventListener(type))
        {
            return;
        } // end if
        var _loc2 = __listeners[type];
        if (scope)
        {
            if (handler)
            {
                for (var _loc5 in _loc2)
                {
                    if (_loc2[_loc5].scope == scope && _loc2[_loc5].handler == handler)
                    {
                        _loc2.splice(Number(_loc5), 1);
                        break;
                    } // end if
                } // end of for...in
            }
            else
            {
                for (var _loc5 in _loc2)
                {
                    if (_loc2[_loc5].scope == scope)
                    {
                        _loc2.splice(Number(_loc5), 1);
                    } // end if
                } // end of for...in
            } // end else if
        }
        else if (typeof(handler) == "function")
        {
            for (var _loc5 in _loc2)
            {
                if (!_loc2[_loc5].scope && _loc2[_loc5].handler == handler)
                {
                    _loc2.splice(Number(_loc5), 1);
                } // end if
            } // end of for...in
        } // end else if
        if (_loc2.length <= 0)
        {
            delete __listeners[type];
        } // end if
    } // End of the function
    function dispatchEvent(event)
    {
        if (!(event instanceof com.timezero.platform.events.Event))
        {
            com.timezero.platform.events.Event.IEvent(event);
        } // end if
        event.currentTarget = __event_target;
        if (!event.bubbles || !event.target)
        {
            event.target = __event_target;
        } // end if
        if (this.hasEventListener(event.type))
        {
            var _loc7 = __listeners[event.type].slice();
            var _loc2;
            var _loc6;
            for (var _loc5 = 0; _loc5 < _loc7.length; ++_loc5)
            {
                _loc2 = _loc7[_loc5];
                if (!_loc2.handler || !_loc2.scope && _loc2.scope !== null)
                {
                    continue;
                } // end if
                _loc6 = event.clone();
                if (typeof(_loc2.handler) == "function")
                {
                    _loc2.handler.call(_loc2.scope, _loc6);
                }
                else
                {
                    _loc2.scope[_loc2.handler](_loc6);
                } // end else if
                if (event.cancelable && _loc6.isDefaultPrevented())
                {
                    return (false);
                } // end if
                if (event.__do_stop > 0)
                {
                    if (event.__do_stop == 1)
                    {
                        break;
                        continue;
                    } // end if
                    if (event.__do_stop == 2)
                    {
                        return (true);
                    } // end if
                } // end if
            } // end of for
            if (_loc7.length <= 0)
            {
                delete __listeners[event.type];
            } // end if
        } // end if
        if (event.bubbles)
        {
            for (var _loc4 = __event_target.__parent || __event_target._parent; _loc4; _loc4 = _loc4.__parent || _loc4._parent)
            {
                if (_loc4.dispatchEvent && _loc4.hasEventListener(event.type))
                {
                    return (_loc4.dispatchEvent(event));
                    break;
                } // end if
            } // end of for
        } // end if
        return (true);
    } // End of the function
    function hasEventListener(type)
    {
        return (Boolean(__listeners[type]));
    } // End of the function
    function removeAllListeners()
    {
        var _loc4 = __listeners;
        var _loc2;
        var _loc3;
        for (var _loc5 in _loc4)
        {
            _loc3 = _loc4[_loc5];
            for (var _loc2 = 0; _loc2 < _loc3.length; ++_loc2)
            {
                _loc3.splice(_loc2, 1);
            } // end of for
        } // end of for...in
    } // End of the function
    function toString()
    {
        return ("[EventDispatcher ]");
    } // End of the function
} // End of Class
