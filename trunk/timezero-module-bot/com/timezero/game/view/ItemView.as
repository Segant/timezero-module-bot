class com.timezero.game.view.ItemView
{
    var _scope, _callback, _item, mc, _toupdateSize, _basew, _baseh, _basex, _basey, _tomoveX, _tomoveY, __get__item;
    function ItemView(scope, callback)
    {
        super();
        _scope = scope;
        _callback = callback;
    } // End of the function
    function load(item, target, newname, depth)
    {
        _item = item;
        var _loc5 = _global.LocalStart + "lib/" + item.category + ".swf";
        var _loc4 = com.timezero.platform.net.Loader.loadAndCreate(_loc5, target, newname, depth);
        var _loc3 = target[newname] || target[item.category];
        if (!_loc4.__get__loaded())
        {
            _loc4.addCompleteEventListener(this, "onLoadComplete", [_loc3]);
        }
        else
        {
            this.onLoadComplete(_loc3);
        } // end else if
        return (_loc3);
    } // End of the function
    function get item()
    {
        return (_item);
    } // End of the function
    function setSize(w, h, keepAspectRatio, alignCenter)
    {
        if (!mc)
        {
            _toupdateSize = {w: w, h: h, keepAspectRatio: keepAspectRatio, alignCenter: alignCenter};
        } // end if
        if (keepAspectRatio)
        {
            var _loc7 = w / _basew;
            var _loc8 = h / _baseh;
            var _loc2 = Math.min(_loc7, _loc8);
            if (_loc2 > 1)
            {
                _loc2 = 1;
            } // end if
            mc._width = _basew * _loc2;
            mc._height = _baseh * _loc2;
            if (alignCenter)
            {
                mc._x = _basex * _loc2 + (w - mc._width) / 2;
                mc._y = _basey * _loc2 + (h - mc._height) / 2;
            } // end if
        }
        else
        {
            mc._width = w;
            mc._height = h;
        } // end else if
    } // End of the function
    function setPos(x, y)
    {
        if (!mc)
        {
            _tomoveX = x;
            _tomoveY = y;
        }
        else
        {
            mc._parent._x = x;
            mc._parent._y = y;
        } // end else if
    } // End of the function
    function onLoadComplete(lib)
    {
        var _loc6 = lib.getNextHighestDepth();
        var _loc4 = _root.getItemClipName(_item);
        var _loc7 = lib.createEmptyMovieClip("holder_" + _loc6, _loc6);
        var _loc3 = _loc7.attachMovie(_loc4, _loc4, 0);
        mc = _loc3;
        var _loc5 = _loc3.getBounds(lib);
        mc._x = -_loc5.xMin;
        mc._y = -_loc5.yMin;
        _basex = mc._x;
        _basey = mc._y;
        if (_tomoveX)
        {
            mc._parent._x = _tomoveX;
        } // end if
        if (_tomoveY)
        {
            mc._parent._y = _tomoveY;
        } // end if
        _basew = _loc3._width;
        _baseh = _loc3._height;
        if (_toupdateSize)
        {
            this.setSize(_toupdateSize.w, _toupdateSize.h, _toupdateSize.keepAspectRatio, _toupdateSize.alignCenter);
            _toupdateSize = null;
        } // end if
        _scope[_callback].call(_scope, this);
    } // End of the function
} // End of Class
