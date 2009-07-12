class com.timezero.game.ui.Scroller extends MovieClip
{
    var _btnsDisabled, up, _parent, _y, _height, down, bg, tick, _x, startDrag, __get__value, _targetmc, _mask, curAction, __set__value;
    function Scroller()
    {
        super();
        _btnsDisabled = true;
        var app = this;
        up.onPress = function ()
        {
            if (app._btnsDisabled)
            {
                return;
            } // end if
            _parent.tick._y = _parent.tick._y - (app.curAction.val || com.timezero.game.ui.Scroller.DEFAULT_STEP);
            if (_parent.tick._y < _y + _height)
            {
                _parent.tick._y = _y + _height;
            } // end if
            if (!app.curAction || app.curAction.type != "up")
            {
                clearInterval(app.actionInterval);
                app.actionInterval = setInterval(app, "actionExecute", 100);
                app.curAction = {type: "up", val: com.timezero.game.ui.Scroller.DEFAULT_STEP, count: 0};
            }
            else
            {
                ++app.curAction.count;
                if (app.curAction.count >= 3)
                {
                    app.curAction.count = 0;
                    app.curAction.val = app.curAction.val + com.timezero.game.ui.Scroller.DEFAULT_STEP;
                } // end if
            } // end else if
            app.updateTargetPos();
        };
        down.onPress = function ()
        {
            if (app._btnsDisabled)
            {
                return;
            } // end if
            _parent.tick._y = _parent.tick._y + (app.curAction.val || com.timezero.game.ui.Scroller.DEFAULT_STEP);
            if (_parent.tick._y > _y - _height - _parent.tick._height)
            {
                _parent.tick._y = _y - _height - _parent.tick._height;
            } // end if
            if (!app.curAction || app.curAction.type != "down")
            {
                clearInterval(app.actionInterval);
                app.actionInterval = setInterval(app, "actionExecute", 100);
                app.curAction = {type: "down", val: com.timezero.game.ui.Scroller.DEFAULT_STEP, count: 0};
            }
            else
            {
                ++app.curAction.count;
                if (app.curAction.count >= 3)
                {
                    app.curAction.count = 0;
                    app.curAction.val = app.curAction.val + com.timezero.game.ui.Scroller.DEFAULT_STEP;
                } // end if
            } // end else if
            app.updateTargetPos();
        };
        bg.onPress = function ()
        {
            if (app._btnsDisabled)
            {
                return;
            } // end if
            _parent.tick._y = _parent._ymouse - _parent.tick._height / 2;
            if (_parent.tick._y < _parent.up._y + _parent.up._height)
            {
                _parent.tick._y = _parent.up._y + _parent.up._height;
            } // end if
            if (_parent.tick._y > _parent.down._y - _parent.down._height - _parent.tick._height)
            {
                _parent.tick._y = _parent.down._y - _parent.down._height - _parent.tick._height;
            } // end if
            app.updateTargetPos();
        };
        up.onRelease = up.onReleaseOutside = down.onRelease = down.onReleaseOutside = function ()
        {
            if (app._btnsDisabled)
            {
                return;
            } // end if
            clearInterval(app.actionInterval);
            app.curAction = null;
        };
        tick.onPress = function ()
        {
            if (app._btnsDisabled)
            {
                return;
            } // end if
            this.startDrag(false, _x, _parent.up._y + _parent.up._height, _x, _parent.down._y - _height - _parent.down._height);
            app._dragging = true;
        };
        tick.onMouseMove = function ()
        {
            if (app._btnsDisabled)
            {
                return;
            } // end if
            if (app._dragging)
            {
                app.updateTargetPos();
            } // end if
        };
        tick.onRelease = tick.onReleaseOutside = function ()
        {
            if (app._btnsDisabled)
            {
                return;
            } // end if
            app.stopDrag();
        };
    } // End of the function
    function get value()
    {
        return (_value);
    } // End of the function
    function set value(val)
    {
        if (val == _value)
        {
            return;
        } // end if
        _value = val;
        //return (this.value());
        null;
    } // End of the function
    function setScrollTarget(target, mask)
    {
        _targetmc = target;
        _mask = mask;
        target.setMask(mask);
        this.updateSize();
        this.updateBtns();
        this.updateScrollPos();
    } // End of the function
    function update()
    {
        this.updateSize();
        this.updateBtns();
        this.updateScrollPos();
    } // End of the function
    function moveTo(delta)
    {
        tick._y = tick._y - delta * com.timezero.game.ui.Scroller.DEFAULT_STEP;
        if (tick._y < up._y + up._height)
        {
            tick._y = up._y + up._height;
        } // end if
        if (tick._y > down._y - down._height - tick._height)
        {
            tick._y = down._y - down._height - tick._height;
        } // end if
        this.updateTargetPos();
    } // End of the function
    function updateSize()
    {
        var _loc4 = _targetmc;
        var _loc3 = _mask;
        var _loc2 = _loc4._height / _loc3._height;
        if (_loc2 <= 1)
        {
            _loc2 = 1;
            _btnsDisabled = true;
            tick._visible = false;
        }
        else
        {
            _btnsDisabled = false;
            tick._visible = true;
        } // end else if
        bg._height = _loc3._height;
        down._y = _loc3._height;
        tick.body._height = (bg._height - up._height - down._height) / _loc2 - (tick.top._height + tick.bottom._height);
        tick.bottom._y = tick.body._height + tick.top._height;
    } // End of the function
    function updateScrollPos(percent)
    {
        if (!percent)
        {
            var _loc2 = _targetmc;
            var _loc3 = _mask;
            var _loc6 = _loc2._height / _loc3._height;
            var _loc5 = bg._height - up._height - down._height - tick._height;
            percent = (_loc3._y - _loc2._y) / (_loc2._height - _loc3._height);
        } // end if
        _value = percent;
        tick._y = up._height + percent * _loc5;
    } // End of the function
    function updateTargetPos()
    {
        var _loc2 = _targetmc;
        var _loc3 = _mask;
        var _loc6 = _loc2._height / _loc3._height;
        var _loc4 = bg._height - up._height - down._height - tick._height;
        var _loc5 = (tick._y - up._height) / _loc4;
        _loc2._y = _loc3._y - _loc5 * (_loc2._height - _loc3._height);
    } // End of the function
    function updateBtns()
    {
        if (_btnsDisabled)
        {
            bg.enabled = false;
            up.enabled = false;
            down.enabled = false;
            up.gotoAndStop(4);
            down.gotoAndStop(4);
            bg.gotoAndStop(4);
        }
        else
        {
            bg.enabled = true;
            up.enabled = true;
            down.enabled = true;
            up.gotoAndStop(1);
            down.gotoAndStop(1);
            bg.gotoAndStop(1);
        } // end else if
    } // End of the function
    function actionExecute()
    {
        if (curAction.type == "up")
        {
            up.onPress();
        }
        else if (curAction.type == "down")
        {
            down.onPress();
        } // end else if
    } // End of the function
    static var DEFAULT_STEP = 5;
    var _value = 0;
} // End of Class
