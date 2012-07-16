class com.timezero.platform.display.EventDispatcherMovieClip extends MovieClip implements com.timezero.platform.events.IEventDispatcher
{
    var _dispatcher;
    function EventDispatcherMovieClip()
    {
        super();
        _dispatcher = new com.timezero.platform.events.EventDispatcher(this);
    } // End of the function
    function addEventListener(type, scope, handler, priority)
    {
        _dispatcher.addEventListener(type, scope, handler, priority);
    } // End of the function
    function removeEventListener(type, scope, handler)
    {
        _dispatcher.removeEventListener(type, scope, handler);
    } // End of the function
    function dispatchEvent(event)
    {
        return (_dispatcher.dispatchEvent(event));
    } // End of the function
    function hasEventListener(type)
    {
        return (_dispatcher.hasEventListener(type));
    } // End of the function
    function toString()
    {
        return (_dispatcher.toString());
    } // End of the function
} // End of Class
