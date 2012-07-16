class com.timezero.platform.net.Loader extends com.timezero.platform.events.EventDispatcher
{
    var __url, __target, __get__target, dispatchEvent, __complete_listeners, __progress_listeners, __get__bytesLoaded, __get__bytesTotal, onEnterFrame, __get__loaded, __get__url;
    function Loader(url, target)
    {
        super();
        __url = com.timezero.platform.net.Loader.createNormalizedLink(url);
        __target = target;
        if (com.timezero.platform.net.Loader.isLocalLink(url))
        {
            url = __url;
        } // end if
        com.timezero.platform.net.Loader.__mcl.addListener(this);
        com.timezero.platform.net.Loader.__mcl.loadClip(url, target);
    } // End of the function
    static function loadAndCreate(url, targetParent, name, depth)
    {
        if (!url || !targetParent)
        {
            return (null);
        } // end if
        if (!name)
        {
            name = url.substring(url.lastIndexOf("/") + 1, url.lastIndexOf("."));
        } // end if
        var _loc1 = targetParent[name];
        if (!_loc1)
        {
            if (isNaN(depth))
            {
                depth = targetParent.getNextHighestDepth();
            } // end if
            _loc1 = targetParent.createEmptyMovieClip(name, depth);
            if (com.timezero.platform.net.Loader.__loaders[_loc1])
            {
                delete com.timezero.platform.net.Loader.__loaders[_loc1];
            } // end if
            
        } // end if
        return (com.timezero.platform.net.Loader.load(url, _loc1));
    } // End of the function
    static function load(url, target)
    {
        if (!url || !target)
        {
            return (null);
        } // end if
        var _loc2 = com.timezero.platform.net.Loader.__loaders[target];
        if (_loc2 && _loc2.__get__url() == url)
        {
            var _loc4 = target._url.split("\\").join("/");
            for (var _loc1 = url; _loc1.indexOf(".") == 0 && _loc1.indexOf("./") <= 1; _loc1 = _loc1.substring(_loc1.indexOf("./") + 2))
            {
            } // end of for
            if (!_loc2.__get__loaded() || _loc4.lastIndexOf(_loc1) == _loc4.length - _loc1.length)
            {
                return (_loc2);
            } // end if
        } // end if
        _loc2 = com.timezero.platform.net.Loader.__loaders[target] = new com.timezero.platform.net.Loader(url, target);
        return (_loc2);
    } // End of the function
    static function isRelativeLink(value)
    {
        value = value.toLowerCase();
        if (value.indexOf("file://") == 0 || value.indexOf("http://") == 0 || value.indexOf("https://") == 0)
        {
            return (false);
        } // end if
        return (true);
    } // End of the function
    static function isLocalLink(value)
    {
        if (value.toLowerCase().indexOf("file://") == 0)
        {
            return (true);
        } // end if
        if (_root._url.indexOf("file://") == 0)
        {
            return (true);
        } // end if
        return (false);
    } // End of the function
    static function createAbsoluteLink(value)
    {
        var _loc3 = _root._url.substring(0, _root._url.lastIndexOf("/"));
        _loc3 = _loc3.split("\\").join("/");
        value = value.split("\\").join("/");
        while (value.indexOf("../") == 0 || value.indexOf("./") == 0)
        {
            value = value.substring(value.indexOf("/") + 1, value.length);
            _loc3 = _loc3.substring(0, _loc3.lastIndexOf("/"));
        } // end while
        return (_loc3 + "/" + value);
    } // End of the function
    static function createNormalizedLink(value)
    {
        if (value.indexOf("?") > -1)
        {
            value = value.substring(0, value.indexOf("?"));
        } // end if
        return (value);
    } // End of the function
    static function destroyLoader(target)
    {
        delete com.timezero.platform.net.Loader.__loaders[target];
    } // End of the function
    function get target()
    {
        return (typeof(__target) == "movieclip" && __target._parent ? (__target) : (null));
    } // End of the function
    function get url()
    {
        return (__url);
    } // End of the function
    function get bytesLoaded()
    {
        return (com.timezero.platform.net.Loader.__mcl.getProgress(__target).bytesLoaded);
    } // End of the function
    function get bytesTotal()
    {
        return (com.timezero.platform.net.Loader.__mcl.getProgress(__target).bytesTotal);
    } // End of the function
    function get loaded()
    {
        return (__loaded && __inited);
    } // End of the function
    function unload()
    {
        com.timezero.platform.net.Loader.__mcl.unloadClip(__target);
        delete com.timezero.platform.net.Loader.__loaders[this.__get__target()];
        this.dispatchEvent({type: "unload"});
    } // End of the function
    function addCompleteEventListener(scope, listener, args)
    {
        if (typeof(listener) != "function" && (!scope || typeof(listener) != "string"))
        {
            return;
        } // end if
        if (this.hasCompleteEventListener(scope, listener, args))
        {
            return;
        } // end if
        if (!__complete_listeners)
        {
            __complete_listeners = new Array();
        } // end if
        __complete_listeners.push(new com.timezero.platform.utils.Caller(scope, listener, args));
    } // End of the function
    function removeCompleteEventListener(scope, listener, args)
    {
        var _loc2;
        for (var _loc5 in __complete_listeners)
        {
            _loc2 = __complete_listeners[_loc5];
            if (_loc2.scope == scope && _loc2.listener == listener && _loc2.args == args)
            {
                __complete_listeners.splice(Number(_loc5), 1);
            } // end if
        } // end of for...in
    } // End of the function
    function hasCompleteEventListener(scope, listener, args)
    {
        var _loc2;
        for (var _loc5 in __complete_listeners)
        {
            _loc2 = __complete_listeners[_loc5];
            if (_loc2.scope == scope && _loc2.listener == listener && _loc2.args == args)
            {
                return (true);
            } // end if
        } // end of for...in
        return (false);
    } // End of the function
    function addProgressEventListener(listener)
    {
        if (!listener)
        {
            return;
        } // end if
        if (this.hasProgressEventListener(listener))
        {
            return;
        } // end if
        if (!__progress_listeners)
        {
            __progress_listeners = new Array();
        } // end if
        listener.setProgress(0);
        __progress_listeners.push(listener);
    } // End of the function
    function removeProgressEventListener(listener)
    {
        if (!listener)
        {
            return;
        } // end if
        for (var _loc3 in __progress_listeners)
        {
            if (__progress_listeners[_loc3] == listener)
            {
                __progress_listeners.splice(Number(_loc3), 1);
            } // end if
        } // end of for...in
    } // End of the function
    function hasProgressEventListener(listener)
    {
        if (!listener)
        {
            return (false);
        } // end if
        for (var _loc3 in __progress_listeners)
        {
            if (__progress_listeners[_loc3] == listener)
            {
                return (true);
            } // end if
        } // end of for...in
        return (false);
    } // End of the function
    function valueOf()
    {
        return (__target);
    } // End of the function
    function toString()
    {
        return ("[Loader (url=\"" + __url + "\", target=" + __target + ")]");
    } // End of the function
    function dispatchCompleteEvent()
    {
        while (__complete_listeners.length)
        {
            __complete_listeners.shift().call();
        } // end while
        __progress_listeners = null;
        var _loc3 = this.dispatchEvent({type: com.timezero.platform.net.Loader.COMPLETE});
        com.timezero.platform.net.Loader.__mcl.removeListener(this);
        super.removeAllListeners();
        return (_loc3);
    } // End of the function
    function dispatchProgressEvent()
    {
        for (var _loc2 in __progress_listeners)
        {
            __progress_listeners[_loc2].setProgress(this.__get__bytesLoaded() / this.__get__bytesTotal());
        } // end of for...in
        //return (this.dispatchEvent({type: com.timezero.platform.net.Loader.PROGRESS, bytesLoaded: this.bytesLoaded(), bytesTotal: this.__get__bytesTotal()}));
    } // End of the function
    function onLoadComplete(target, httpStatus)
    {
        if (__target !== target)
        {
            return;
        } // end if
        this.dispatchEvent({type: com.timezero.platform.net.Loader.HTTP_STATUS, status: httpStatus});
        __loaded = true;
        if (__inited)
        {
            this.dispatchCompleteEvent();
        } // end if
    } // End of the function
    function onLoadInit(target)
    {
        if (__target !== target)
        {
            return;
        } // end if
        __inited = true;
        if (target._currentframe <= 0)
        {
            var app = this;
            target.onEnterFrame = function ()
            {
                if (target._currentframe > 0)
                {
                    delete this.onEnterFrame;
                    app.onLoadInit(this);
                } // end if
            };
        }
        else
        {
            this.dispatchEvent({type: com.timezero.platform.net.Loader.INIT});
            if (__loaded)
            {
                this.dispatchCompleteEvent();
            } // end if
        } // end else if
    } // End of the function
    function onLoadError(target, errorCode, httpStatus)
    {
        if (__target !== target)
        {
            return;
        } // end if
        this.dispatchEvent({type: com.timezero.platform.net.Loader.HTTP_STATUS, status: httpStatus});
        this.dispatchEvent({type: com.timezero.platform.net.Loader.ERROR, code: errorCode, status: httpStatus});
        com.timezero.platform.net.Loader.__mcl.removeListener(this);
        __complete_listeners = null;
        __progress_listeners = null;
        super.removeAllListeners();
        delete com.timezero.platform.net.Loader.__loaders[target];
    } // End of the function
    function onLoadProgress(target, bytesLoaded, bytesTotal)
    {
        if (__target !== target)
        {
            return;
        } // end if
        this.dispatchProgressEvent();
    } // End of the function
    function onLoadStart(target)
    {
        if (__target !== target)
        {
            return;
        } // end if
        this.dispatchEvent({type: com.timezero.platform.net.Loader.OPEN});
    } // End of the function
    static var OPEN = "open";
    static var PROGRESS = "progress";
    static var ERROR = "error";
    static var HTTP_STATUS = "httpStatus";
    static var INIT = "init";
    static var COMPLETE = "complete";
    static var UNLOAD = "unload";
    static var __loaders = new Object();
    static var __mcl = new MovieClipLoader();
    var __loaded = false;
    var __inited = false;
} // End of Class
