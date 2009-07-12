class com.timezero.game.display.BrownRamka extends MovieClip
{
    var __size, _parent, savedSize, __get__size, createEmptyMovieClip, top_leftL, top_leftR, bottom_leftL, bottom_leftR, fillL, topL, bottomL, leftL, leftR, flags, __set__size;
    static var bmpSource;
    function BrownRamka()
    {
        super();
        __size = new flash.geom.Point(-1000, -1000);
    } // End of the function
    static function assign(mc)
    {
        if (!mc)
        {
            return (null);
        } // end if
        var _loc2 = com.timezero.game.display.BrownRamka;
        mc.__proto__ = _loc2.prototype;
        _loc2.call(mc);
        return ((com.timezero.game.display.BrownRamka)(mc));
    } // End of the function
    static function setImgSourceLib(mc)
    {
        bmpSource = mc;
    } // End of the function
    static function getBitmapData(id)
    {
        if (!com.timezero.game.display.BrownRamka.bmpSource)
        {
            trace ("ERROR: No bitmap lib source, call \'setImgSourceLib\' first.");
            return;
        } // end if
        return (com.timezero.game.display.BrownRamka.bmpSource.getBitmapData(id));
    } // End of the function
    static function createSimpleRamka(parent, size, name, depth, initObj)
    {
        if (!depth)
        {
            depth = parent.getNextHighestDepth();
        } // end if
        var _loc1 = parent.createEmptyMovieClip(name || "ramka_" + depth, depth);
        com.timezero.game.display.BrownRamka.assign(_loc1);
        _loc1.size = size;
        _loc1.flags = initObj;
        return (_loc1);
    } // End of the function
    static function createRamka(parent, offset, size, name, depth, initObj)
    {
        var _loc5;
        var _loc8 = new flash.geom.Matrix();
        var _loc7;
        var _loc6;
        var _loc3;
        var _loc4;
        var _loc2 = com.timezero.game.display.BrownRamka.createSimpleRamka(parent, size, name, depth);
        _loc2._x = offset.x;
        _loc2._y = offset.y;
        if (!initObj.no_header)
        {
            _loc2.createEmptyMovieClip("header", _loc2.getNextHighestDepth());
            _loc5 = com.timezero.game.display.BrownRamka.getBitmapData(com.timezero.game.display.BrownRamka.ramkalink + "_header");
            _loc3 = (size.x - _loc5.width) / 2;
            _loc4 = -_loc5.height;
            _loc7 = _loc3 + _loc5.width;
            _loc6 = 0;
            _loc8 = new flash.geom.Matrix(1, 0, 0, 1, _loc3, _loc4);
            _loc2.header.beginBitmapFill(_loc5, _loc8, true, false);
            _loc2.header.moveTo(_loc3, _loc4);
            _loc2.header.lineTo(_loc7, _loc4);
            _loc2.header.lineTo(_loc7, _loc6);
            _loc2.header.lineTo(_loc3, _loc6);
            _loc2.header.lineTo(_loc3, _loc4);
            _loc2.header.endFill();
        } // end if
        if (!initObj.no_leftright_btn)
        {
            _loc2.createEmptyMovieClip("left_btn", _loc2.getNextHighestDepth());
            _loc2.left_btn.createEmptyMovieClip("up", 0);
            _loc2.left_btn.createEmptyMovieClip("over", 1);
            _loc5 = com.timezero.game.display.BrownRamka.getBitmapData(com.timezero.game.display.BrownRamka.ramkalink + "_left_btn");
            _loc3 = -2 - _loc5.width + 4;
            _loc4 = size.y / 2 - _loc5.height / 2;
            _loc7 = 2;
            _loc6 = _loc4 + _loc5.height;
            _loc8 = new flash.geom.Matrix(1, 0, 0, 1, _loc3, _loc4);
            _loc2.left_btn.up.beginBitmapFill(_loc5, _loc8, true, false);
            _loc2.left_btn.up.moveTo(_loc3, _loc4);
            _loc2.left_btn.up.lineTo(_loc7, _loc4);
            _loc2.left_btn.up.lineTo(_loc7, _loc6);
            _loc2.left_btn.up.lineTo(_loc3, _loc6);
            _loc2.left_btn.up.lineTo(_loc3, _loc4);
            _loc2.left_btn.up.endFill();
            _loc5 = com.timezero.game.display.BrownRamka.getBitmapData(com.timezero.game.display.BrownRamka.ramkalink + "_left_btn_over");
            _loc3 = -_loc5.width - 1;
            _loc4 = size.y / 2 - _loc5.height / 2 - 4;
            _loc7 = -1;
            _loc6 = _loc4 + _loc5.height - 4;
            _loc8 = new flash.geom.Matrix(1, 0, 0, 1, _loc3, _loc4);
            _loc2.left_btn.over.beginBitmapFill(_loc5, _loc8, true, false);
            _loc2.left_btn.over.moveTo(_loc3, _loc4);
            _loc2.left_btn.over.lineTo(_loc7, _loc4);
            _loc2.left_btn.over.lineTo(_loc7, _loc6);
            _loc2.left_btn.over.lineTo(_loc3, _loc6);
            _loc2.left_btn.over.lineTo(_loc3, _loc4);
            _loc2.left_btn.over.endFill();
            _loc2.left_btn.over._visible = false;
            _loc2.left_btn.up.onRollOver = function ()
            {
                _parent.over._visible = true;
            };
            _loc2.left_btn.up.onRollOut = function ()
            {
                _parent.over._visible = false;
            };
            _loc2.left_btn.up.onRelease = function ()
            {
                if (!_parent._parent.leftReleaseFunction)
                {
                    trace ("ERR: \'leftReleaseFunction\' is not set");
                } // end if
                _parent._parent.leftReleaseFunction.call(null);
            };
            _loc2.createEmptyMovieClip("right_btn", _loc2.getNextHighestDepth());
            _loc2.right_btn.createEmptyMovieClip("up", 0);
            _loc2.right_btn.createEmptyMovieClip("over", 1);
            _loc5 = com.timezero.game.display.BrownRamka.getBitmapData(com.timezero.game.display.BrownRamka.ramkalink + "_left_btn");
            _loc3 = size.x - 4;
            _loc4 = size.y / 2 - _loc5.height / 2;
            _loc7 = size.x - 4 + _loc5.width;
            _loc6 = _loc4 + _loc5.height;
            _loc8 = new flash.geom.Matrix(-1, 0, 0, 1, _loc3, _loc4);
            _loc2.right_btn.up.beginBitmapFill(_loc5, _loc8, true, false);
            _loc2.right_btn.up.moveTo(_loc3, _loc4);
            _loc2.right_btn.up.lineTo(_loc7, _loc4);
            _loc2.right_btn.up.lineTo(_loc7, _loc6);
            _loc2.right_btn.up.lineTo(_loc3, _loc6);
            _loc2.right_btn.up.lineTo(_loc3, _loc4);
            _loc2.right_btn.up.endFill();
            _loc5 = com.timezero.game.display.BrownRamka.getBitmapData(com.timezero.game.display.BrownRamka.ramkalink + "_left_btn_over");
            _loc3 = size.x - 2;
            _loc4 = size.y / 2 - _loc5.height / 2 - 4;
            _loc7 = size.x - 2 + _loc5.width;
            _loc6 = _loc4 + _loc5.height - 4;
            _loc8 = new flash.geom.Matrix(-1, 0, 0, 1, _loc3, _loc4);
            _loc2.right_btn.over.beginBitmapFill(_loc5, _loc8, true, false);
            _loc2.right_btn.over.moveTo(_loc3, _loc4);
            _loc2.right_btn.over.lineTo(_loc7, _loc4);
            _loc2.right_btn.over.lineTo(_loc7, _loc6);
            _loc2.right_btn.over.lineTo(_loc3, _loc6);
            _loc2.right_btn.over.lineTo(_loc3, _loc4);
            _loc2.right_btn.over.endFill();
            _loc2.right_btn.over._visible = false;
            _loc2.right_btn.up.onRollOver = function ()
            {
                _parent.over._visible = true;
            };
            _loc2.right_btn.up.onRollOut = function ()
            {
                _parent.over._visible = false;
            };
            _loc2.right_btn.up.onRelease = function ()
            {
                if (!_parent._parent.rightReleaseFunction)
                {
                    trace ("ERR: \'rightReleaseFunction\' is not set");
                } // end if
                _parent._parent.rightReleaseFunction.call(null);
            };
        } // end if
        if (!initObj.no_close)
        {
            _loc2.createEmptyMovieClip("close", _loc2.getNextHighestDepth());
            _loc2.close.createEmptyMovieClip("bg", 0);
            _loc2.close.createEmptyMovieClip("up", 1);
            _loc2.close.createEmptyMovieClip("over", 2);
            _loc5 = com.timezero.game.display.BrownRamka.getBitmapData(com.timezero.game.display.BrownRamka.ramkalink + "_close_up");
            _loc3 = size.x - 58;
            _loc4 = -_loc5.height;
            _loc7 = _loc3 + _loc5.width;
            _loc6 = 0;
            _loc8 = new flash.geom.Matrix(1, 0, 0, 1, _loc3, _loc4);
            _loc2.close.up.beginBitmapFill(_loc5, _loc8, true, false);
            _loc2.close.up.moveTo(_loc3, _loc4);
            _loc2.close.up.lineTo(_loc7, _loc4);
            _loc2.close.up.lineTo(_loc7, _loc6);
            _loc2.close.up.lineTo(_loc3, _loc6);
            _loc2.close.up.lineTo(_loc3, _loc4);
            _loc2.close.up.endFill();
            _loc5 = com.timezero.game.display.BrownRamka.getBitmapData(com.timezero.game.display.BrownRamka.ramkalink + "_close_over");
            _loc3 = size.x - 54;
            _loc4 = -_loc5.height - 2;
            _loc7 = _loc3 + _loc5.width;
            _loc6 = -2;
            _loc8 = new flash.geom.Matrix(1, 0, 0, 1, _loc3, _loc4);
            _loc2.close.over.beginBitmapFill(_loc5, _loc8, true, false);
            _loc2.close.over.moveTo(_loc3, _loc4);
            _loc2.close.over.lineTo(_loc7, _loc4);
            _loc2.close.over.lineTo(_loc7, _loc6);
            _loc2.close.over.lineTo(_loc3, _loc6);
            _loc2.close.over.lineTo(_loc3, _loc4);
            _loc2.close.over.endFill();
            _loc2.close.over._visible = false;
            _loc2.close.up.onRollOver = function ()
            {
                _parent.over._visible = true;
            };
            _loc2.close.up.onRollOut = function ()
            {
                _parent.over._visible = false;
            };
            _loc2.close.up.onRelease = function ()
            {
                if (!_parent._parent.closeFunction)
                {
                    trace ("ERR: \'closeFunction\' is not set");
                } // end if
                _parent._parent.closeFunction.call(null);
            };
            _loc5 = com.timezero.game.display.BrownRamka.getBitmapData(com.timezero.game.display.BrownRamka.ramkalink + "_closebg");
            _loc3 = size.x - _loc5.width - 10;
            _loc4 = -_loc5.height + 2;
            _loc7 = _loc3 + _loc5.width;
            _loc6 = 2;
            _loc8 = new flash.geom.Matrix(1, 0, 0, 1, _loc3, _loc4);
            _loc2.close.bg.beginBitmapFill(_loc5, _loc8, true, false);
            _loc2.close.bg.moveTo(_loc3, _loc4);
            _loc2.close.bg.lineTo(_loc7, _loc4);
            _loc2.close.bg.lineTo(_loc7, _loc6);
            _loc2.close.bg.lineTo(_loc3, _loc6);
            _loc2.close.bg.lineTo(_loc3, _loc4);
            _loc2.close.bg.endFill();
        } // end if
        return (_loc2);
    } // End of the function
    function get size()
    {
        return (__size);
    } // End of the function
    function set size(value)
    {
        if (value.x == __size.x && value.y == __size.y)
        {
            return;
        } // end if
        savedSize = __size;
        __size = value;
        this.onSizeChanged();
        //return (this.size());
        null;
    } // End of the function
    function createPieceIfNotExist(name, side, width, height)
    {
        if (this[name + side])
        {
            return;
        } // end if
        this.createEmptyMovieClip(name + side, com.timezero.game.display.BrownRamka.PART_DEPTHS[name + side]);
        var _loc2 = this[name + side];
        var _loc4 = com.timezero.game.display.BrownRamka.getBitmapData(com.timezero.game.display.BrownRamka.ramkalink + "_" + name);
        var _loc8 = new flash.geom.Matrix(side == "L" ? (1) : (-1), 0, 0, 1, 0, 0);
        if (width === null)
        {
            width = _loc4.width;
        } // end if
        if (height === null)
        {
            height = _loc4.height;
        } // end if
        _loc2.beginBitmapFill(_loc4, _loc8, true, false);
        _loc2.moveTo(0, 0);
        _loc2.lineTo(width, 0);
        _loc2.lineTo(width, height);
        _loc2.lineTo(0, height);
        _loc2.lineTo(0, 0);
        _loc2.endFill();
    } // End of the function
    function adjustCorners()
    {
        var _loc2 = com.timezero.game.display.BrownRamka.ADJUSTMENTS[com.timezero.game.display.BrownRamka.ramkalink];
        top_leftL._x = top_leftL._x + _loc2.top_leftL.x;
        top_leftL._y = top_leftL._y + _loc2.top_leftL.y;
        top_leftR._x = top_leftR._x + _loc2.top_leftR.x;
        top_leftR._y = top_leftR._y + _loc2.top_leftR.y;
        bottom_leftL._x = bottom_leftL._x + _loc2.bottom_leftL.x;
        bottom_leftL._y = bottom_leftL._y + _loc2.bottom_leftL.y;
        bottom_leftR._x = bottom_leftR._x + _loc2.bottom_leftR.x;
        bottom_leftR._y = bottom_leftR._y + _loc2.bottom_leftR.y;
    } // End of the function
    function onSizeChanged()
    {
        var _loc2 = com.timezero.game.display.BrownRamka.ADJUSTMENTS[com.timezero.game.display.BrownRamka.ramkalink].size;
        fillL.removeMovieClip();
        if (this.__get__size().x != savedSize.x)
        {
            topL.removeMovieClip();
            bottomL.removeMovieClip();
        } // end if
        if (this.__get__size().y != savedSize.y)
        {
            leftL.removeMovieClip();
            leftR.removeMovieClip();
        } // end if
        if (!flags.no_fill)
        {
            this.createPieceIfNotExist("fill", "L", this.__get__size().x, this.__get__size().y);
        } // end if
        this.createPieceIfNotExist("top_left", "L", null, null);
        this.createPieceIfNotExist("bottom_left", "L", null, null);
        this.createPieceIfNotExist("top_left", "R", null, null);
        this.createPieceIfNotExist("bottom_left", "R", null, null);
        top_leftL._x = -_loc2;
        top_leftL._y = -_loc2;
        bottom_leftL._x = -_loc2;
        bottom_leftL._y = this.__get__size().y - bottom_leftL._height + _loc2;
        top_leftR._x = this.__get__size().x - top_leftR._width + _loc2;
        top_leftR._y = -_loc2;
        bottom_leftR._x = this.__get__size().x - bottom_leftR._width + _loc2;
        bottom_leftR._y = this.__get__size().y - bottom_leftR._height + _loc2;
        this.adjustCorners();
        this.createPieceIfNotExist("top", "L", top_leftR._x - (top_leftL._x + top_leftL._width), null);
        this.createPieceIfNotExist("bottom", "L", bottom_leftR._x - (bottom_leftL._x + bottom_leftL._width), null);
        this.createPieceIfNotExist("left", "L", null, bottom_leftL._y - (top_leftL._y + top_leftL._height));
        this.createPieceIfNotExist("left", "R", null, bottom_leftR._y - (top_leftR._y + top_leftR._height));
        topL._x = top_leftL._x + top_leftL._width;
        topL._y = -_loc2;
        bottomL._x = bottom_leftL._x + bottom_leftL._width;
        bottomL._y = this.__get__size().y;
        leftL._x = -_loc2;
        leftL._y = top_leftL._y + top_leftL._height;
        leftR._x = this.__get__size().x - leftR._width + _loc2;
        leftR._y = top_leftR._y + top_leftR._height;
    } // End of the function
    static var ramkalink = "brownramka";
    static var PART_DEPTHS = {fillL: 1, topL: 2, bottomL: 3, leftL: 4, leftR: 5, top_leftL: 6, bottom_leftL: 7, top_leftR: 8, bottom_leftR: 9};
    static var ADJUSTMENTS = {brownramka: {size: 5, top_leftL: {x: 0, y: -2}, top_leftR: {x: 0, y: -2}, bottom_leftL: {x: -17, y: 6}, bottom_leftR: {x: 17, y: 6}}};
} // End of Class
