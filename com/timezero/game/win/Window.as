class com.timezero.game.win.Window extends com.timezero.platform.display.EventDispatcherMovieClip
{
    var title_TF, _parent, __get__isModal, __get__title, iconBase, getNextHighestDepth, attachMovie, __get__icon, __set__icon, __set__isModal, __set__title;
    function Window()
    {
        super();
        title_TF.autoSize = "center";
    } // End of the function
    static function assign(mc)
    {
        if (!mc)
        {
            return (null);
        } // end if
        var _loc2 = com.timezero.game.win.Window;
        mc.__proto__ = _loc2.prototype;
        _loc2.call(mc);
        return ((com.timezero.game.win.Window)(mc));
    } // End of the function
    static function createWindow(target, linkageID, newName, isModal, initObject)
    {
        if (!target)
        {
            return (null);
        } // end if
        var _loc8 = target.getNextHighestDepth();
        if (newName && target[newName])
        {
            com.timezero.game.win.Window.closeWindow(target[newName]);
        } // end if
        Selection.setFocus(undefined);
        if (isModal)
        {
            if (target.__pad__)
            {
                target.__pad__.swapDepths(_loc8);
            }
            else
            {
                var _loc9 = target.createEmptyMovieClip("__pad__", _loc8);
                var _loc12 = _loc9.attachMovie("pad_btn", "pad_btn", 0);
                _loc12.useHandCursor = false;
                _loc9._alpha = 10;
                _loc9._width = Stage.width;
                _loc9._height = Stage.height;
            } // end if
        } // end else if
        if (!newName)
        {
            newName = linkageID + _loc8;
        } // end if
        var _loc3 = target[newName];
        if (_loc3)
        {
            _loc3.swapDepths(_loc8 + 1);
            _loc3._visible = true;
            _loc3.update();
        }
        else
        {
            _loc3 = target.attachMovie(linkageID, newName, _loc8 + 1, initObject);
            Stage.addListener(_loc3);
            var _loc11 = (com.timezero.game.win.Window)(_loc3);
            _loc11.__set__isModal(Boolean(isModal));
            com.timezero.game.win.Window.WIN_STACK.push(_loc11);
            _loc3.bg.onPress = function ()
            {
                var _loc4 = com.timezero.game.win.Window.WIN_STACK[com.timezero.game.win.Window.WIN_STACK.length - 1];
                var _loc3 = _parent;
                if (_loc4 == _loc3)
                {
                    return;
                } // end if
                for (var _loc5 in com.timezero.game.win.Window.WIN_STACK)
                {
                    if (com.timezero.game.win.Window.WIN_STACK[_loc5] == _parent)
                    {
                        com.timezero.game.win.Window.WIN_STACK[com.timezero.game.win.Window.WIN_STACK.length - 1] = _loc3;
                        com.timezero.game.win.Window.WIN_STACK[_loc5] = _loc4;
                        var _loc2 = _parent._parent.getNextHighestDepth();
                        _parent.swapDepths(_loc2);
                        break;
                    } // end if
                } // end of for...in
            };
            _loc3.bg.useHandCursor = false;
        } // end else if
        return (_loc3);
    } // End of the function
    static function closeWindow(mc, not_remove)
    {
        if (!mc)
        {
            mc = (com.timezero.game.win.Window)(com.timezero.game.win.Window.WIN_STACK.pop());
            if (!mc)
            {
                return;
            } // end if
        } // end if
        if (mc._parent.__pad__)
        {
            mc._parent.__pad__.removeMovieClip();
        } // end if
        if (!not_remove)
        {
            Stage.removeListener(mc);
            for (var _loc4 in com.timezero.game.win.Window.WIN_STACK)
            {
                if (com.timezero.game.win.Window.WIN_STACK[_loc4] == mc)
                {
                    com.timezero.game.win.Window.WIN_STACK.splice(Number(_loc4), 1);
                } // end if
            } // end of for...in
            mc.swapDepths(mc._parent.getNextHighestDepth());
            mc.removeMovieClip();
        }
        else
        {
            mc._visible = false;
        } // end else if
        var _loc2 = null;
        if (com.timezero.game.win.Window.WIN_STACK.length)
        {
            for (var _loc4 in com.timezero.game.win.Window.WIN_STACK)
            {
                if (com.timezero.game.win.Window.WIN_STACK[_loc4].isModal)
                {
                    _loc2 = com.timezero.game.win.Window.WIN_STACK[_loc4];
                    break;
                } // end if
            } // end of for...in
            if (_loc2)
            {
                mc = (com.timezero.game.win.Window)(_loc2);
                var _loc3 = mc._parent.createEmptyMovieClip("__pad__", mc.getDepth() - 1);
                var _loc5 = _loc3.attachMovie("pad_btn", "pad_btn", 0);
                _loc5.useHandCursor = false;
                _loc3._alpha = 10;
                _loc3._width = Stage.width;
                _loc3._height = Stage.height;
            } // end if
        } // end if
    } // End of the function
    static function setDragged(draggedMC, dragSpot, dragBounds, invertBounds)
    {
        if (!dragBounds)
        {
            var _loc2 = draggedMC.getBounds();
            dragBounds = new Object();
            dragBounds.xMax = Stage.width - _loc2.xMax - _loc2.xMin;
            dragBounds.yMax = Stage.height - _loc2.yMax - _loc2.yMin;
            dragBounds.xMin = 0;
            dragBounds.yMin = 0;
        } // end if
        dragSpot.onPress = function ()
        {
            if (invertBounds)
            {
                draggedMC.startDrag(false, dragBounds.xMax, dragBounds.yMax, dragBounds.xMin, dragBounds.yMin);
            }
            else
            {
                draggedMC.startDrag(false, dragBounds.xMin, dragBounds.yMin, dragBounds.xMax, dragBounds.yMax);
            } // end else if
            function onMouseMove()
            {
                updateAfterEvent();
            } // End of the function
        };
        dragSpot.onRelease = dragSpot.onReleaseOutside = function ()
        {
            draggedMC.stopDrag();
            delete this.onMouseMove;
        };
        dragSpot.useHandCursor = false;
    } // End of the function
    static function createBorder(target, depth, initObj)
    {
        var _loc6 = target.getBounds(target._parent);
        var _loc4 = _loc6.xMax - _loc6.xMin;
        var _loc5 = _loc6.yMax - _loc6.yMin;
        if (!initObj)
        {
            initObj = new Object();
        } // end if
        initObj._x = _loc6.xMin;
        initObj._y = _loc6.yMin;
        if (isNaN(depth))
        {
            depth = target.getDepth() + 1;
        } // end if
        var _loc2 = target._parent.createEmptyMovieClip(target._name + "_border", depth);
        for (var _loc7 in initObj)
        {
            _loc2[_loc7] = initObj[_loc7];
        } // end of for...in
        if (_loc4 - 8 > 0 && _loc5 - 8 > 0)
        {
            _loc2.attachMovie("border_t", "b_t", 0, {_x: 4, _width: _loc4 - 8});
            _loc2.attachMovie("border_t", "b_b", 1, {_x: _loc4 - 4, _y: _loc5, _rotation: 180, _width: _loc4 - 8});
            _loc2.attachMovie("border_t", "b_r", 2, {_x: _loc4, _y: 4, _rotation: 90, _width: _loc5 - 8});
            _loc2.attachMovie("border_t", "b_l", 3, {_y: _loc5 - 4, _rotation: 270, _width: _loc5 - 8});
            _loc2.attachMovie("border_c", "b_tl", 4);
            _loc2.attachMovie("border_c", "b_tr", 5, {_x: _loc4, _rotation: 90});
            _loc2.attachMovie("border_c", "b_br", 6, {_x: _loc4, _y: _loc5, _rotation: 180});
            _loc2.attachMovie("border_c", "b_br", 7, {_y: _loc5, _rotation: 270});
        } // end if
        if (initObj.close)
        {
            var _loc9 = _loc2.attachMovie("btn_close", "btn_close", 8, {_x: _loc4 - 12, _y: 12});
            _loc9.onRelease = function ()
            {
                _parent._parent.close();
            };
        } // end if
        return (_loc2);
    } // End of the function
    static function getBitmapData(id)
    {
        return (_root.baseroot.win_lib.getBitmapData(id));
    } // End of the function
    function set isModal(value)
    {
        value = Boolean(value);
        if (_isModal == value)
        {
            return;
        } // end if
        _isModal = value;
        //return (this.isModal());
        null;
    } // End of the function
    function get isModal()
    {
        return (_isModal);
    } // End of the function
    function set title(value)
    {
        title_TF.text = value;
        //return (this.title());
        null;
    } // End of the function
    function get title()
    {
        return (title_TF.text);
    } // End of the function
    function get icon()
    {
        return (_icon);
    } // End of the function
    function set icon(value)
    {
        value = value.toString();
        if (_icon == value)
        {
            return;
        } // end if
        this[_icon].removeMovieClip();
        var _loc2 = iconBase.getBounds(this);
        var _loc3 = this.attachMovie(value, value, this.getNextHighestDepth());
        var _loc6 = Math.min((_loc2.xMax - _loc2.xMin - 6) / _loc3._width, (_loc2.yMax - _loc2.yMin - 6) / _loc3._height);
        _loc3._xscale = _loc3._yscale = Math.floor(_loc6 * 100);
        var _loc5 = _loc3.getBounds(this);
        _loc3._x = (_loc2.xMax + _loc2.xMin) / 2 - (_loc5.xMax + _loc5.xMin) / 2;
        _loc3._y = (_loc2.yMax + _loc2.yMin) / 2 - (_loc5.yMax + _loc5.yMin) / 2;
        _icon = value;
        //return (this.icon());
        null;
    } // End of the function
    function moveToCenter(target, mc)
    {
        var _loc6 = 1004;
        var _loc5 = 440;
        if (!mc)
        {
            mc = this;
        } // end if
        var _loc3 = mc.getBounds(mc);
        var _loc4 = target ? (target.getBounds()) : ({xMin: 0, xMax: _loc6, yMin: 0, yMax: _loc5});
        if (mc._parent.__pad__)
        {
            mc._parent.__pad__._width = _loc6;
            mc._parent.__pad__._height = _loc5;
        } // end if
        mc._x = Math.floor((_loc4.xMin + _loc4.xMax) / 2 - (_loc3.xMin + _loc3.xMax) / 2);
        mc._y = Math.floor((_loc4.yMin + _loc4.yMax) / 2 - (_loc3.yMin + _loc3.yMax) / 2);
        if (mc._y < 0)
        {
            mc._y = 0;
        } // end if
        if (mc._x < 0)
        {
            mc._x = 0;
        } // end if
    } // End of the function
    function close()
    {
        com.timezero.game.win.Window.closeWindow(this, false);
    } // End of the function
    function addShelf(parent, offset, size, colorIndex, depth)
    {
        if (!depth)
        {
            depth = parent.getNextHighestDepth();
        } // end if
        if (colorIndex == undefined)
        {
            colorIndex = 0;
        } // end if
        var _loc1 = parent.createEmptyMovieClip("shelf_" + depth, depth);
        _loc1._x = offset.x || 0;
        _loc1._y = offset.y || 0;
        var _loc9 = com.timezero.game.win.Window.SHELF_COLORS[colorIndex];
        var _loc4;
        var _loc8 = new flash.geom.Matrix();
        var _loc6;
        var _loc5;
        var _loc2;
        var _loc3;
        _loc4 = com.timezero.game.win.Window.getBitmapData(_loc9 + "_fill");
        _loc2 = 0;
        _loc3 = 0;
        _loc6 = size.x;
        _loc5 = size.y;
        _loc1.beginBitmapFill(_loc4, _loc8, true, false);
        _loc1.moveTo(_loc2, _loc3);
        _loc1.lineTo(_loc6, _loc3);
        _loc1.lineTo(_loc6, _loc5);
        _loc1.lineTo(_loc2, _loc5);
        _loc1.lineTo(_loc2, _loc3);
        _loc1.endFill();
        _loc4 = com.timezero.game.win.Window.getBitmapData(_loc9 + "_top_left");
        _loc1.beginBitmapFill(_loc4, _loc8, true, false);
        _loc1.moveTo(0, 0);
        _loc6 = _loc4.width;
        _loc5 = _loc4.height;
        _loc1.lineTo(_loc6, 0);
        _loc1.lineTo(_loc6, _loc5);
        _loc1.lineTo(0, _loc5);
        _loc1.lineTo(0, 0);
        _loc1.endFill();
        _loc4 = com.timezero.game.win.Window.getBitmapData(_loc9 + "_top");
        _loc1.beginBitmapFill(_loc4, _loc8, true, false);
        _loc2 = _loc6;
        _loc3 = 0;
        _loc1.moveTo(_loc2, _loc3);
        _loc6 = size.x - _loc2;
        _loc5 = _loc4.height;
        _loc1.lineTo(_loc6, _loc3);
        _loc1.lineTo(_loc6, _loc5);
        _loc1.lineTo(_loc2, _loc5);
        _loc1.lineTo(_loc2, _loc3);
        _loc1.endFill();
        _loc4 = com.timezero.game.win.Window.getBitmapData(_loc9 + "_left");
        _loc2 = 0;
        _loc3 = _loc5;
        _loc6 = _loc4.width;
        _loc5 = size.y;
        _loc1.beginBitmapFill(_loc4, _loc8, true, false);
        _loc1.moveTo(_loc2, _loc3);
        _loc1.lineTo(_loc6, _loc3);
        _loc1.lineTo(_loc6, _loc5);
        _loc1.lineTo(_loc2, _loc5);
        _loc1.lineTo(_loc2, _loc3);
        _loc1.endFill();
        _loc4 = com.timezero.game.win.Window.getBitmapData(_loc9 + "_bottom_left");
        _loc2 = 0;
        _loc3 = size.y - _loc4.height;
        _loc6 = _loc4.width;
        _loc5 = size.y;
        _loc8 = new flash.geom.Matrix(1, 0, 0, 1, _loc2, _loc3);
        _loc1.beginBitmapFill(_loc4, _loc8, true, false);
        _loc1.moveTo(_loc2, _loc3);
        _loc1.lineTo(_loc6, _loc3);
        _loc1.lineTo(_loc6, _loc5);
        _loc1.lineTo(_loc2, _loc5);
        _loc1.lineTo(_loc2, _loc3);
        _loc1.endFill();
        _loc4 = com.timezero.game.win.Window.getBitmapData(_loc9 + "_bottom");
        _loc2 = _loc6;
        _loc3 = size.y - _loc4.height;
        _loc6 = size.x - _loc2;
        _loc5 = size.y;
        _loc8 = new flash.geom.Matrix(1, 0, 0, 1, _loc2, _loc3);
        _loc1.beginBitmapFill(_loc4, _loc8, true, false);
        _loc1.moveTo(_loc2, _loc3);
        _loc1.lineTo(_loc6, _loc3);
        _loc1.lineTo(_loc6, _loc5);
        _loc1.lineTo(_loc2, _loc5);
        _loc1.lineTo(_loc2, _loc3);
        _loc1.endFill();
        _loc4 = com.timezero.game.win.Window.getBitmapData(_loc9 + "_top_left");
        _loc2 = size.x - _loc4.width;
        _loc3 = 0;
        _loc6 = size.x;
        _loc5 = _loc4.height;
        _loc8 = new flash.geom.Matrix(-1, 0, 0, 1, _loc2, _loc3);
        _loc1.beginBitmapFill(_loc4, _loc8, true, false);
        _loc1.moveTo(_loc2, _loc3);
        _loc1.lineTo(_loc6, _loc3);
        _loc1.lineTo(_loc6, _loc5);
        _loc1.lineTo(_loc2, _loc5);
        _loc1.lineTo(_loc2, _loc3);
        _loc1.endFill();
        _loc4 = com.timezero.game.win.Window.getBitmapData(_loc9 + "_left");
        _loc2 = size.x - _loc4.width;
        _loc3 = _loc5;
        _loc6 = size.x;
        _loc5 = size.y;
        _loc8 = new flash.geom.Matrix(-1, 0, 0, 1, _loc2, _loc3);
        _loc1.beginBitmapFill(_loc4, _loc8, true, false);
        _loc1.moveTo(_loc2, _loc3);
        _loc1.lineTo(_loc6, _loc3);
        _loc1.lineTo(_loc6, _loc5);
        _loc1.lineTo(_loc2, _loc5);
        _loc1.lineTo(_loc2, _loc3);
        _loc1.endFill();
        _loc4 = com.timezero.game.win.Window.getBitmapData(_loc9 + "_bottom_left");
        _loc2 = size.x - _loc4.width;
        _loc3 = size.y - _loc4.height;
        _loc6 = size.x;
        _loc5 = size.y;
        _loc8 = new flash.geom.Matrix(-1, 0, 0, 1, _loc2, _loc3);
        _loc1.beginBitmapFill(_loc4, _loc8, true, false);
        _loc1.moveTo(_loc2, _loc3);
        _loc1.lineTo(_loc6, _loc3);
        _loc1.lineTo(_loc6, _loc5);
        _loc1.lineTo(_loc2, _loc5);
        _loc1.lineTo(_loc2, _loc3);
        _loc1.endFill();
        return (_loc1);
    } // End of the function
    static var ICON_SETTINGS = "icon_settings";
    static var ICON_HISTORY = "icon_history";
    static var ICON_ARENA = "icon_arena";
    static var ICON_MESSAGE = "icon_mail";
    static var ICON_ERROR = "icon_error";
    static var SHELF_COLORS = new Array("black", "green", "blue", "yellow", "red");
    static var WIN_STACK = new Array();
    var _isModal = false;
    var _icon = "";
} // End of Class
