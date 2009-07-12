class com.timezero.platform.utils.Caller
{
    var scope, listener, args;
    function Caller(scope, listener, args)
    {
        super();
        this.scope = scope || null;
        this.listener = listener || null;
        this.args = args || new Array();
    } // End of the function
    static function deferredCall(scope, callback, args, target, eventType, priority)
    {
        if (target.hasEventListener(eventType))
        {
            return;
        } // end if
        var caller = new com.timezero.platform.utils.Caller(scope, callback, arguments);
        var _loc3 = function (event)
        {
            event.__get__target().removeEventListener(event.type, this, arguments.callee);
            caller.call();
        };
        target.addEventListener(eventType, null, _loc3, priority);
    } // End of the function
    function call()
    {
        if (!(args instanceof Array))
        {
            args = new Array();
        } // end if
        if (listener)
        {
            if (typeof(listener) == "function")
            {
                return (listener.apply(scope, args));
            }
            else if (scope)
            {
                return (scope[listener].apply(scope, args));
            } // end if
        } // end else if
        return (null);
    } // End of the function
} // End of Class
