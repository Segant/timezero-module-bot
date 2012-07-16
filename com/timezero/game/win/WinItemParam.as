class com.timezero.game.win.WinItemParam extends com.timezero.game.win.Window
{
    var _currentMenu, rightMenu, __get__currentMenu, _item, __no_change, __show_owner, __show_needres, __set__currentMenu, realtykey, _hintText, top, createEmptyMovieClip, __set__title, addShelf, trash, item, _parent, split_btn, psy_btn, use_btn, menu, left, included_label, right, __tk, __pets, mc, moveToCenter, _y, bg, bg_lines, hint, box;
    function WinItemParam()
    {
        super();
        trace ("WinItemParam ");
    } // End of the function
    function get currentMenu()
    {
        return (_currentMenu);
    } // End of the function
    function set currentMenu(value)
    {
        if (value == _currentMenu)
        {
            return;
        } // end if
        if (value >= rightMenu.length)
        {
            value = 0;
        }
        else if (value < 0)
        {
            value = rightMenu.length - 1;
        } // end else if
        _currentMenu = value;
        //return (this.currentMenu());
        null;
    } // End of the function
    function init(item, no_change, show_owner, show_needres)
    {
        _item = item;
        __no_change = no_change;
        __show_owner = show_owner;
        __show_needres = show_needres;
        this.__set__currentMenu(0);
        rightMenu = new Array();
        var _loc4 = Math.floor(item.type);
        if (_loc4 == 782 && !__no_change)
        {
            rightMenu.push([_global.LANG.build_in873_0, 11]);
        } // end if
        realtykey._visible = false;
        if (_root.isClothItem(_item))
        {
            rightMenu.push([_global.LANG.iparam_compl, 0]);
            rightMenu.push([_global.LANG.iparam_spec, 1]);
        } // end if
        if (_item.build_in && Math.floor(_item.type) != 919)
        {
            rightMenu.push([_global.LANG.build_in, 2]);
        } // end if
        if (_item.name.charAt(0) == "d" && _item.damage)
        {
            rightMenu.push([_global.LANG.sk6, 3]);
        } // end if
        if (_loc4 == 831)
        {
            rightMenu.push([_global.LANG.lb_lpsy, 4]);
        } // end if
        if (_loc4 == 796)
        {
            rightMenu.push([_global.LANG.iparam_mobs, 5]);
        } // end if
        if (_loc4 == 300)
        {
            rightMenu.push([_global.LANG.iparam_plates, 6]);
        } // end if
        if (_loc4 == 888)
        {
            rightMenu.push([_global.LANG.iparam_crash, 7]);
        } // end if
        if (_loc4 >= 2 && _loc4 <= 5 && _loc4)
        {
            rightMenu.push([_global.LANG.iparam_amm, 8]);
        } // end if
        if (_loc4 >= 811 && _loc4 <= 817 && _loc4)
        {
            rightMenu.push([_global.LANG.build_in811, 9]);
        } // end if
        if (_item.nskill == 4)
        {
            rightMenu.push([_global.LANG.sk4, 10]);
        } // end if
        if (_item.nskill == 7)
        {
            rightMenu.push([_global.LANG.lab_cbr, 12]);
        } // end if
        if (Math.floor(_item.type) == 919)
        {
            rightMenu.push([_global.LANG.iparam_compl, 0]);
            rightMenu.push([_global.LANG.iparam_spec, 1]);
        } // end if
        if (Math.floor(_item.type) == 310)
        {
            rightMenu.push([_global.LANG.iparam_scopes, 14]);
        } // end if
        if (Math.floor(_item.type) == 311)
        {
            rightMenu.push([_global.LANG.iparam_lassc, 15]);
        } // end if
        if (Math.floor(_item.type) == 312)
        {
            rightMenu.push([_global.LANG.iparam_compens, 16]);
        } // end if
    } // End of the function
    function Close()
    {
        this.close();
    } // End of the function
    function close()
    {
        _hintText.Close();
        this.quietClose();
    } // End of the function
    function quietClose()
    {
        com.timezero.game.win.Window.closeWindow(this);
    } // End of the function
    function updateTop()
    {
        top.removeMovieClip();
        this.createEmptyMovieClip("top", 1);
        this.__set__title(_item.txt + (_item.made.length > 0 && _item.made.indexOf("$") < 0 ? ("\n(" + _global.LANG.made + " " + _item.made + ")") : ("")));
        this.addShelf(top, new flash.geom.Point(1, 25), new flash.geom.Point(378, 30), 0);
        this.addShelf(top, new flash.geom.Point(379, 25), new flash.geom.Point(264, 30), 0);
        var _loc4 = _root.isPerk(_item);
        var item = _item;
        trash._visible = !__no_change && (_loc4 && !_root.baseroot.UserBox.AskTrashPerk(item, true) && !_root.inBattle() || !_loc4 && (_root.iamMan() || _root.iamRbt()) && !item.slot && _root.DropItem(item, undefined, undefined, true));
        if (trash._visible)
        {
            trash.swapDepths(100);
            trash.item = _item;
            _root.setHint(trash, _global.LANG["trash" + (_loc4 ? ("_perk_hint") : (""))]);
            if (_loc4)
            {
                trash.onRelease = function ()
                {
                    _root.baseroot.UserBox.AskTrashPerk(item);
                    _parent.Close();
                };
            }
            else
            {
                trash.onRelease = function ()
                {
                    if (_root.USER.vault == "1")
                    {
                        if (_root.inBattle())
                        {
                            if (!_root.isRes(item))
                            {
                                _root.Alert(_global.LANG.error_vault);
                                return;
                            } // end if
                        }
                        else
                        {
                            _root.onDropYesNoAnsverWin = this;
                            _root.onDropYesNoAnsver = function (item)
                            {
                                var _loc3 = _root.UpPadding("WinDrop", "WinDrop");
                                _loc3.Init(_root.SearchReplace(_global.LANG.trash_ask, item.txt), _global.LANG.trash, _root.onDropYesNoAnsverWin._parent, "doTrash", 1, Number(item.count) || 0);
                                _loc3.__red = !Boolean(item.made.indexOf("AR$") == 0);
                                delete _root.onDropYesNoAnsverWin;
                                delete _root.onDropYesNoAnsver;
                            };
                            _root.WinAscYesNo(_global.LANG.vault_dropitem_lose, _root, "onDropYesNoAnsver", item);
                            return;
                        } // end if
                    } // end else if
                    var _loc4 = _root.UpPadding("WinDrop", "WinDrop");
                    _loc4.Init(_root.SearchReplace(_global.LANG.trash_ask, item.txt), _global.LANG.trash, _parent, "doTrash", 1, Number(item.count) || 0);
                    _loc4.__red = !Boolean(item.made.indexOf("AR$") == 0);
                };
            } // end if
        } // end else if
        split_btn._visible = !__no_change && (item.count > 1 || Math.floor(item.type) == 848 || item.type == "782.0") && !_loc4;
        if (split_btn._visible)
        {
            split_btn.swapDepths(102);
            if (Math.floor(item.type) == 782)
            {
                _root.setHint(split_btn, _global.LANG.newkey);
                split_btn.onRelease = function ()
                {
                    _root.WinAscYesNo(_global.LANG.newkey_ask, _parent, "xml_KeyDublicate", _parent._item.id);
                };
            }
            else
            {
                _root.setHint(split_btn, _root.SearchReplace(_global.LANG.split_ask, item.txt));
                split_btn.onRelease = function ()
                {
                    if (Math.floor(_parent._item.type) == 848)
                    {
                        _root.UpPadding("WinSplitRes").Init(_parent._item);
                    }
                    else
                    {
                        _root.UpPadding("WinDrop", "WinDrop").Init(_root.SearchReplace(_global.LANG.split_ask, _parent._item.txt), _global.LANG.DOIT, _parent, "doSplit", 1, Number(_parent._item.count) - 1);
                    } // end else if
                };
            } // end if
        } // end else if
        psy_btn._visible = Math.floor(item.type) == ItemType.PSY_HELM && !__no_change && _root.CheckVip();
        if (psy_btn._visible)
        {
            psy_btn.swapDepths(103);
            can_use = false;
            this.RecreateMenu();
            psy_btn.onRelease = function ()
            {
                if (_parent.menu._visible)
                {
                    _parent.menu.Close();
                }
                else
                {
                    _parent.menu.Open();
                } // end else if
            };
            _root.setHint(psy_btn, _global.LANG.psy_combination);
        } // end if
        var can_use = can_use = !_root.inBattle() && _root.CheckItemMinRequirement(item) && _root.iamMan() && _root.CanUseItem(item);
        if (can_use && _loc4)
        {
            can_use = _root.CanUsePerk(item);
        } // end if
        use_btn._visible = !__no_change && can_use;
        if (use_btn._visible)
        {
            use_btn.swapDepths(101);
            use_btn.item = item;
            _root.setHint(use_btn, _global.LANG["use_" + (!_loc4 ? ("me") : ("perk_hint"))]);
            if (_loc4)
            {
                use_btn.onRelease = function ()
                {
                    _root.UsePerk(item);
                    _parent.Close();
                };
            }
            else
            {
                use_btn.onRelease = function ()
                {
                    _root.WinAscYesNo(_global.LANG.use_me + " ?", _parent, "doUse");
                };
            } // end if
        } // end else if
        if (_item.type == "808.3" && trash._visible)
        {
            use_btn._visible = true;
            _root.setHint(use_btn, _global.LANG.gift5.substr(0, _global.LANG.gift5.length - 1));
            use_btn.swapDepths(101);
            use_btn.onRelease = function ()
            {
                _parent.close();
                _root.WinAscYesNo(_global.LANG.gift5, _root, "doGift", item);
            };
        } // end if
    } // End of the function
    function DrawItem(target, item, slot)
    {
        var _loc3 = _root.DrawBigWeapon_mc(target, item, slot._width, slot._height);
        var _loc2 = slot.getBounds(target);
        _loc3._x = (_loc2.xMin + _loc2.xMax) / 2;
        _loc3._y = (_loc2.yMin + _loc2.yMax) / 2;
        return (_loc3);
    } // End of the function
    function updateLeft()
    {
        if (!_item || !_item.name)
        {
            this.close();
            return;
        } // end if
        if (menu)
        {
            this.RecreateMenu();
        } // end if
        left.removeMovieClip();
        this.createEmptyMovieClip("left", 2);
        left.createEmptyMovieClip("bg", 0);
        left.bg.rectangle(0, 55, 377, 355, 16711680, 0);
        this.addShelf(left.bg, new flash.geom.Point(3, 57), com.timezero.game.win.WinItemParam.IMG_SIZE, 0, 0);
        var _loc4 = new com.timezero.game.view.ItemView(this, "onBigImageLoad");
        _loc4.load(_item, left, null, 1);
        _loc4.setSize(com.timezero.game.win.WinItemParam.IMG_SIZE.x - 4, com.timezero.game.win.WinItemParam.IMG_SIZE.y - 4, true, true);
        _loc4.setPos(5, 59);
        var _loc7 = left.createEmptyMovieClip("scrolled", 2);
        _loc7._x = 176;
        _loc7._y = 56;
        this.updateItemText();
        left.createEmptyMovieClip("scrollmask", 3);
        left.scrollmask.rectangle(0, 0, 173, 298, 16711680, 0);
        left.scrollmask._x = _loc7._x;
        left.scrollmask._y = _loc7._y;
        var _loc11 = (com.timezero.game.ui.Scroller)(left.attachMovie("scroller", "scroller", 4));
        _loc11._x = 349;
        _loc11._y = _loc7._y;
        _loc11.setScrollTarget(_loc7, left.scrollmask, true);
        var _loc12 = Math.floor(_item.type);
        var _loc10 = (_loc12 == 777 ? (_item.included.length) : (_item.build_in.split(",").length || 0)) || (_loc12 == ItemType.PSY_HELM ? (9) : (_item.max_count));
        if (_item.type == "808.3")
        {
            _loc10 = _item.included.length;
        } // end if
        if (_item.calibre && _item.shot)
        {
            ++_loc10;
        } // end if
        for (i in _item.included)
        {
            if (_item.included[i].calibre && _item.included[i].shot)
            {
                ++_loc10;
            } // end if
        } // end of for...in
        var _loc9 = _loc10;
        if (_loc12 == 873)
        {
            _loc9 = _item.included.length;
        } // end if
        if (_loc9)
        {
            var _loc13 = _root.isPerk(_item);
            included_label.ftext(_global.LANG[(_loc13 ? ("perk_") : (int(_item.type) == 777 ? ("draft_") : (""))) + "included"]);
            left.createEmptyMovieClip("included", 5);
            left.included.createEmptyMovieClip("bg", 0);
            var _loc6;
            var _loc5;
            var _loc8 = 10;
            var i = 0;
            while (i < _loc9)
            {
                _loc6 = 3 + (com.timezero.game.win.WinItemParam.INCLUDED_SIZE.x + 1) * (i % 3);
                _loc5 = 227 + Math.floor(i / 3) * (com.timezero.game.win.WinItemParam.INCLUDED_SIZE.y + 2);
                this.addShelf(left.included.bg, new flash.geom.Point(_loc6, _loc5), com.timezero.game.win.WinItemParam.INCLUDED_SIZE, 0, _loc8);
                if (_item.included[i])
                {
                    _loc4 = new com.timezero.game.view.ItemView(this, "handler_IncludedImageLoad");
                    _loc7 = _loc4.load(_item.included[i], left.included, null, _loc8++);
                    _loc4.setSize(com.timezero.game.win.WinItemParam.INCLUDED_SIZE.x - 8, com.timezero.game.win.WinItemParam.INCLUDED_SIZE.y - 8, true, true);
                    _loc4.setPos(_loc6 + 4, _loc5 + 4);
                } // end if
                ++i;
            } // end while
            if (_loc9 > 9)
            {
                left.createEmptyMovieClip("include_scrollmask", 6);
                left.include_scrollmask.rectangle(3, 227, 5 + com.timezero.game.win.WinItemParam.INCLUDED_SIZE.x * 3, 231 + 3 * com.timezero.game.win.WinItemParam.INCLUDED_SIZE.y, 65280, 20);
                _loc11 = (com.timezero.game.ui.Scroller)(left.attachMovie("scroller", "scroller", 7));
                _loc11._x = left.include_scrollmask._x + left.include_scrollmask._width + 1;
                _loc11._y = 227;
                _loc11.setScrollTarget(left.included, left.include_scrollmask, true);
            } // end if
        }
        else
        {
            included_label.ftext("");
        } // end else if
    } // End of the function
    function updateRight()
    {
        if (rightMenu.length == 0)
        {
            return;
        } // end if
        right.removeMovieClip();
        this.createEmptyMovieClip("right", 3);
        right.createEmptyMovieClip("bg", 0);
        right.bg.rectangle(380, 55, 644, 355, 65280, 0);
        var _loc5;
        var _loc4;
        right.attachMovie("btn_mini_left", "moveleft", 1);
        right.moveleft._x = 400;
        right.moveleft._y = 40;
        right.attachMovie("btn_mini_left", "moveright", 2);
        right.moveright._x = 620;
        right.moveright._y = 40;
        right.moveright._rotation = 180;
        if (rightMenu.length == 1)
        {
            right.moveright.enabled = false;
            right.moveleft.enabled = false;
            right.moveright.gotoAndStop(4);
            right.moveleft.gotoAndStop(4);
        }
        else
        {
            right.moveright.enabled = true;
            right.moveleft.enabled = true;
            right.moveright.gotoAndStop(1);
            right.moveleft.gotoAndStop(1);
        } // end else if
        var _loc3 = right.createTextField("mini_btn_txt", 3, 400, 30, 220, 25);
        _loc3.textColor = com.timezero.game.win.WinItemParam.TF_COLOR_BLUE;
        _loc3.selectable = false;
        _loc3.autoSize = "center";
        _loc3.ftext(rightMenu[this.__get__currentMenu()][0]);
        var app = this;
        right.moveleft.onRelease = function ()
        {
            app.__set__currentMenu(--app.__get__currentMenu());
            app.updateRight();
        };
        right.moveright.onRelease = function ()
        {
            app.__set__currentMenu(++app.__get__currentMenu());
            app.updateRight();
        };
        this.updateRightContent();
        _root.addMouseWheel(this);
    } // End of the function
    function updateRightContent()
    {
        switch (rightMenu[this.__get__currentMenu()][1])
        {
            case 0:
            {
                this.drawSets();
                break;
            } 
            case 1:
            {
                this.drawSpecs();
                break;
            } 
            case 2:
            {
                this.drawCanInclude();
                break;
            } 
            case 3:
            {
                this.drawMed();
                break;
            } 
            case 4:
            {
                this.drawPsy();
                break;
            } 
            case 5:
            {
                this.drawMobParts();
                break;
            } 
            case 6:
            {
                this.drawPlates();
                break;
            } 
            case 7:
            {
                this.drawPetFood();
                break;
            } 
            case 8:
            {
                this.drawAmmo();
                break;
            } 
            case 9:
            {
                this.drawPsyCrystall();
                break;
            } 
            case 10:
            {
                this.drawThrowings();
                break;
            } 
            case 11:
            {
                this.drawRealtyKeyConfig();
                break;
            } 
            case 12:
            {
                this.drawBattleMachines();
                break;
            } 
            case 13:
            {
                this.drawSetFromChip();
                break;
            } 
            case 14:
            {
                this.drawScopes();
                break;
            } 
            case 15:
            {
                this.drawLaserDesignators();
                break;
            } 
            case 16:
            {
                this.drawCompensators();
                break;
            } 
        } // End of switch
    } // End of the function
    function drawSets()
    {
        this.clearRight();
        if (!_root.itemDesigns)
        {
            _root.loadItemDesigns(this, "drawSets");
            return;
        } // end if
        var _loc9 = _item.txt.split(" ")[0];
        var _loc3;
        var _loc6 = new Array();
        var _loc5;
        var _loc4;
        for (var _loc5 in _root.onlyOneManSets)
        {
            _loc3 = _root.onlyOneManSets[_loc5];
            if (_loc3.txt == _loc9)
            {
                for (var _loc4 in _loc3.box)
                {
                    _loc6.push(_loc3.box[_loc4].category + "-" + _loc3.box[_loc4].name);
                } // end of for...in
                break;
            } // end if
        } // end of for...in
        for (var _loc5 in _root.complete_modification)
        {
            _loc3 = _root.complete_modification[_loc5];
            if (_loc3.txt == _loc9)
            {
                for (var _loc4 in _loc3.box1)
                {
                    _loc6.push(_loc3.box1[_loc4].category + "-" + _loc3.box1[_loc4].name);
                } // end of for...in
                break;
            } // end if
        } // end of for...in
        var _loc7 = new Array();
        var _loc8 = _root.itemDesigns;
        for (var _loc5 in _loc8)
        {
            for (var _loc4 in _loc6)
            {
                if (_loc5 == _loc6[_loc4])
                {
                    _loc7.push(_loc8[_loc5]);
                } // end if
            } // end of for...in
        } // end of for...in
        if (!_root.USER.man)
        {
            for (var _loc5 in _loc7)
            {
                for (var _loc4 in _loc3.box0)
                {
                    if (_loc3.box1[_loc4].category + "-" + _loc3.box1[_loc4].name == _loc7[_loc5].attributes.name)
                    {
                        _loc7[_loc5].attributes.name = _loc3.box0[_loc4].category + "-" + _loc3.box0[_loc4].name;
                    } // end if
                } // end of for...in
            } // end of for...in
        } // end if
        this.drawXMLItems(_loc7);
    } // End of the function
    function drawSpecs()
    {
        this.clearRight();
        if (!_root.itemSpecials)
        {
            _root.loadItemSpecials(this, "drawSpecs");
            return;
        } // end if
        var _loc4;
        var _loc5 = new Array();
        var _loc6 = _item.txt.split(" ")[0];
        for (var _loc4 in _root.itemSpecials)
        {
            if (_root.itemSpecials[_loc4].attributes.txt.split(" ")[0] == _loc6)
            {
                _loc5.push(this.convertToSpecial(_root.itemSpecials[_loc4]));
            } // end if
        } // end of for...in
        _loc5.reverse();
        var _loc8 = SpecBox.create(right, "specbox", 4, {_x: 374, _y: 53}, _loc5, true);
        _loc8._xscale = _loc8._yscale = 130;
        var _loc7 = right.createTextField("spec_hint", 5, 390, 280, 234, 80);
        _loc7.textColor = com.timezero.game.win.WinItemParam.TF_COLOR_ROAN;
        _loc7.multiline = true;
        _loc7.selectable = false;
        _loc7.wordWrap = true;
        _loc7.ftext(_global.LANG.iparam_spec_hint);
    } // End of the function
    function drawCanInclude()
    {
        this.clearRight();
        if (!_root.itemDesigns)
        {
            _root.loadItemDesigns(this, "drawCanInclude");
            return;
        } // end if
        var _loc5 = _item.build_in.split(",");
        var _loc4;
        var _loc6;
        var _loc7 = new Array();
        var _loc3 = _root.itemDesigns;
        for (var _loc4 in _loc3)
        {
            for (var _loc6 in _loc5)
            {
                if (Math.floor(_loc3[_loc4].attributes.type) == Math.floor(_loc5[_loc6]) && Number(_loc5[_loc6]) >= Number(_loc3[_loc4].attributes.type))
                {
                    _loc7.push(_loc3[_loc4]);
                } // end if
            } // end of for...in
        } // end of for...in
        this.drawXMLItems(_loc7);
    } // End of the function
    function drawMed()
    {
        this.clearRight();
        if (!_root.itemDesigns)
        {
            _root.loadItemDesigns(this, "drawMed");
            return;
        } // end if
        var _loc4;
        var _loc6;
        var _loc5 = new Array();
        var _loc3 = _root.itemDesigns;
        for (var _loc4 in _loc3)
        {
            if (String(_loc3[_loc4].attributes.name).charAt(3) == "d" && _loc3[_loc4].attributes.damage)
            {
                _loc5.push(_loc3[_loc4]);
            } // end if
        } // end of for...in
        this.drawXMLItems(_loc5);
    } // End of the function
    function drawPsy()
    {
        this.clearRight();
        if (!_root.itemDesigns)
        {
            _root.loadItemDesigns(this, "drawPsy");
            return;
        } // end if
        var _loc4;
        var _loc6;
        var _loc5 = new Array();
        var _loc3 = _root.itemDesigns;
        for (var _loc4 in _loc3)
        {
            if (Math.floor(_loc3[_loc4].attributes.type) == 831)
            {
                _loc5.push(_loc3[_loc4]);
            } // end if
        } // end of for...in
        this.drawXMLItems(_loc5);
    } // End of the function
    function drawMobParts()
    {
        this.clearRight();
        if (!_root.itemDesigns)
        {
            _root.loadItemDesigns(this, "drawMobParts");
            return;
        } // end if
        var _loc4;
        var _loc6;
        var _loc5 = new Array();
        var _loc3 = _root.itemDesigns;
        for (var _loc4 in _loc3)
        {
            if (Math.floor(_loc3[_loc4].attributes.type) == 796)
            {
                _loc5.push(_loc3[_loc4]);
            } // end if
        } // end of for...in
        this.drawXMLItems(_loc5);
    } // End of the function
    function drawPlates()
    {
        this.clearRight();
        if (!_root.itemDesigns)
        {
            _root.loadItemDesigns(this, "drawPlates");
            return;
        } // end if
        var _loc4;
        var _loc6;
        var _loc5 = new Array();
        var _loc3 = _root.itemDesigns;
        for (var _loc4 in _loc3)
        {
            if (Math.floor(_loc3[_loc4].attributes.type) == 300)
            {
                _loc5.push(_loc3[_loc4]);
            } // end if
        } // end of for...in
        this.drawXMLItems(_loc5);
    } // End of the function
    function drawPetFood()
    {
        this.clearRight();
        if (!_root.itemDesigns)
        {
            _root.loadItemDesigns(this, "drawPetFood");
            return;
        } // end if
        var _loc4;
        var _loc6;
        var _loc5 = new Array();
        var _loc3 = _root.itemDesigns;
        for (var _loc4 in _loc3)
        {
            if (Math.floor(_loc3[_loc4].attributes.type) == 891)
            {
                _loc5.push(_loc3[_loc4]);
            } // end if
        } // end of for...in
        this.drawXMLItems(_loc5);
    } // End of the function
    function drawAmmo()
    {
        this.clearRight();
        if (!_root.itemDesigns)
        {
            _root.loadItemDesigns(this, "drawAmmo");
            return;
        } // end if
        var _loc4;
        var _loc6;
        var _loc5 = new Array();
        var _loc3 = _root.itemDesigns;
        for (var _loc4 in _loc3)
        {
            if ((Math.floor(_loc3[_loc4].attributes.type) > 6 || _loc3[_loc4].attributes.type == "0.62") && _loc3[_loc4].attributes.calibre == _item.calibre && _item.calibre && _loc3[_loc4].attributes.damage)
            {
                if (Math.floor(_loc3[_loc4].attributes.type) == 844)
                {
                    continue;
                } // end if
                _loc5.push(_loc3[_loc4]);
            } // end if
        } // end of for...in
        this.drawXMLItems(_loc5);
    } // End of the function
    function drawPsyCrystall()
    {
        this.clearRight();
        if (!_root.itemDesigns)
        {
            _root.loadItemDesigns(this, "drawPsyCrystall");
            return;
        } // end if
        var _loc4;
        var _loc6;
        var _loc5 = new Array();
        var _loc3 = _root.itemDesigns;
        for (var _loc4 in _loc3)
        {
            if (Math.floor(_loc3[_loc4].attributes.type) >= 811 && Math.floor(_loc3[_loc4].attributes.type) <= 817)
            {
                _loc5.push(_loc3[_loc4]);
            } // end if
        } // end of for...in
        this.drawXMLItems(_loc5);
    } // End of the function
    function drawThrowings()
    {
        this.clearRight();
        if (!_root.itemDesigns)
        {
            _root.loadItemDesigns(this, "drawThrowings");
            return;
        } // end if
        var _loc4;
        var _loc6;
        var _loc5 = new Array();
        var _loc3 = _root.itemDesigns;
        for (var _loc4 in _loc3)
        {
            if (_loc3[_loc4].attributes.nskill == 4)
            {
                _loc5.push(_loc3[_loc4]);
            } // end if
        } // end of for...in
        this.drawXMLItems(_loc5);
    } // End of the function
    function drawBattleMachines()
    {
        this.clearRight();
        if (!_root.itemDesigns)
        {
            _root.loadItemDesigns(this, "drawBattleMachines");
            return;
        } // end if
        var _loc4;
        var _loc6;
        var _loc5 = new Array();
        var _loc3 = _root.itemDesigns;
        for (var _loc4 in _loc3)
        {
            if (_loc3[_loc4].attributes.nskill == 7)
            {
                _loc5.push(_loc3[_loc4]);
            } // end if
        } // end of for...in
        this.drawXMLItems(_loc5);
    } // End of the function
    function drawSetFromChip()
    {
        this.clearRight();
        if (!_root.itemDesigns)
        {
            _root.loadItemDesigns(this, "drawSetFromChip");
            return;
        } // end if
        var _loc9 = _item.txt.split(" ")[0];
        var _loc4;
        var _loc7 = new Array();
        var _loc5;
        var _loc3;
        for (var _loc5 in _root.complete_modification)
        {
            _loc4 = _root.complete_modification[_loc5];
            if (_loc4.txt == _loc9)
            {
                for (var _loc3 in _loc4.box1)
                {
                    _loc7.push(_loc4.box1[_loc3].category + "-" + _loc4.box1[_loc3].name);
                } // end of for...in
                break;
            } // end if
        } // end of for...in
        var _loc6 = new Array();
        var _loc8 = _root.itemDesigns;
        for (var _loc5 in _loc8)
        {
            for (var _loc3 in _loc7)
            {
                if (_loc5 == _loc7[_loc3])
                {
                    _loc6.push(_loc8[_loc5]);
                } // end if
            } // end of for...in
        } // end of for...in
        if (!_root.USER.man)
        {
            for (var _loc5 in _loc6)
            {
                for (var _loc3 in _loc4.box0)
                {
                    if (_loc4.box1[_loc3].category + "-" + _loc4.box1[_loc3].name == _loc6[_loc5].attributes.name)
                    {
                        _loc6[_loc5].attributes.name = _loc4.box0[_loc3].category + "-" + _loc4.box0[_loc3].name;
                    } // end if
                } // end of for...in
            } // end of for...in
        } // end if
        this.drawXMLItems(_loc6);
    } // End of the function
    function drawScopes()
    {
        this.clearRight();
        if (!_root.itemDesigns)
        {
            _root.loadItemDesigns(this, "drawScopes");
            return;
        } // end if
        var _loc4;
        var _loc6;
        var _loc5 = new Array();
        var _loc3 = _root.itemDesigns;
        for (var _loc4 in _loc3)
        {
            if (Math.floor(_loc3[_loc4].attributes.type) == 310)
            {
                _loc5.push(_loc3[_loc4]);
            } // end if
        } // end of for...in
        this.drawXMLItems(_loc5);
    } // End of the function
    function drawLaserDesignators()
    {
        this.clearRight();
        if (!_root.itemDesigns)
        {
            _root.loadItemDesigns(this, "drawLaserDesignators");
            return;
        } // end if
        var _loc4;
        var _loc6;
        var _loc5 = new Array();
        var _loc3 = _root.itemDesigns;
        for (var _loc4 in _loc3)
        {
            if (Math.floor(_loc3[_loc4].attributes.type) == 311)
            {
                _loc5.push(_loc3[_loc4]);
            } // end if
        } // end of for...in
        this.drawXMLItems(_loc5);
    } // End of the function
    function drawCompensators()
    {
        this.clearRight();
        if (!_root.itemDesigns)
        {
            _root.loadItemDesigns(this, "drawCompensators");
            return;
        } // end if
        var _loc4;
        var _loc6;
        var _loc5 = new Array();
        var _loc3 = _root.itemDesigns;
        for (var _loc4 in _loc3)
        {
            if (Math.floor(_loc3[_loc4].attributes.type) == 312)
            {
                _loc5.push(_loc3[_loc4]);
            } // end if
        } // end of for...in
        this.drawXMLItems(_loc5);
    } // End of the function
    function drawRealtyKeyConfig()
    {
        if (!__no_change)
        {
            realtykey._visible = true;
            var app = this;
            realtykey.name1.ftext(_item.s2 || "");
            realtykey.name1.password = true;
            realtykey.btn_ok.label.ftext(_global.LANG.save_btn);
            realtykey.btn_ok.onRelease = function ()
            {
                _root.ShowBattleLoading();
                if (Math.floor(app._item.type) == 782)
                {
                    app.savePassword();
                } // end if
            };
        } // end if
    } // End of the function
    function convertToSpecial(node)
    {
        var _loc2;
        var _loc3 = new Object();
        _loc3.item = _root.GetXmlParams(node);
        _loc3.perks = new Array();
        _loc3.enabled = true;
        for (var _loc2 = node.firstChild; _loc2; _loc2 = _loc2.nextSibling)
        {
            _loc3.perks.push(_root.GetXmlParams(_loc2));
        } // end of for
        return (_loc3);
    } // End of the function
    function drawXMLItems(elementList)
    {
        var _loc10 = right.createEmptyMovieClip("scrolled", 4);
        _loc10._x = 380;
        _loc10._y = 56;
        right.scrolled.createEmptyMovieClip("bg", 0);
        var _loc7;
        var _loc6;
        var _loc8 = 10;
        var _loc9 = elementList.length;
        var _loc4;
        var _loc5;
        var _loc11;
        for (var _loc3 = 0; _loc3 < _loc9; ++_loc3)
        {
            _loc4 = _root.GetXmlParams(elementList[_loc3]);
            _loc7 = (com.timezero.game.win.WinItemParam.RIGHT_ITEM_SIZE.x + 1) * (_loc3 % 3);
            _loc6 = Math.floor(_loc3 / 3) * (com.timezero.game.win.WinItemParam.RIGHT_ITEM_SIZE.y + 2);
            this.addShelf(right.scrolled.bg, new flash.geom.Point(_loc7, _loc6), com.timezero.game.win.WinItemParam.RIGHT_ITEM_SIZE, 0, _loc8);
            _loc5 = new com.timezero.game.view.ItemView(this, "handler_RightImageLoad");
            _loc11 = _loc5.load(_loc4, right.scrolled, _loc4.category + "_" + _loc4.name + "_" + _loc4.i, _loc8++);
            _loc5.setSize(com.timezero.game.win.WinItemParam.RIGHT_ITEM_SIZE.x - 8, com.timezero.game.win.WinItemParam.RIGHT_ITEM_SIZE.y - 8, true, true);
            _loc5.setPos(_loc7 + 4, _loc6 + 4);
        } // end of for
        right.createEmptyMovieClip("scrollmask", 5);
        right.scrollmask.rectangle(0, 0, 233, 298, 16711680, 0);
        right.scrollmask._x = _loc10._x;
        right.scrollmask._y = _loc10._y;
        var _loc13 = (com.timezero.game.ui.Scroller)(right.attachMovie("scroller", "scroller", 6));
        _loc13._x = right.scrollmask._x + right.scrollmask._width + 1;
        _loc13._y = _loc10._y;
        _loc13.setScrollTarget(_loc10, right.scrollmask, true);
    } // End of the function
    function scrollLeft(delta)
    {
        left.scroller.moveTo(delta);
    } // End of the function
    function scrollRight(delta)
    {
        right.scroller.moveTo(delta);
    } // End of the function
    function clearRight()
    {
        right.specbox.removeMovieClip();
        right.scrolled.removeMovieClip();
        right.scrollmask.removeMovieClip();
    } // End of the function
    function updateItemText()
    {
        var _loc5;
        if (!_item || !_item.name)
        {
            this.close();
            return;
        } // end if
        var _loc11 = int(_item.type);
        var _loc10 = left.scrolled;
        var _loc4;
        if (_root.isPerk(_item))
        {
            _loc4 = display.hint.PerkHint.create(_loc10, "box_newHint", _loc10.getNextHighestDepth(), _item, {tColorA: 16777215, noBorder: true, tSize: 11, uniqueInstance: true});
            _loc4.delLineAt(0, true, false);
            _loc4.addLine(_loc4.addTextLine("&nbsp;"));
            _loc4.addLine(_loc4.addTextLine(_global.LANG["perk_tree" + (_root.isPsyPerk(_item) ? ("_psy") : (""))], _loc4.tColorA, true, true, true, _root.getPerkDscLink(_item) + "\" target=\"_blank "));
            _loc4.addLine(_loc4.addTextLine("&nbsp;"));
            _loc4.addLine(_loc4.addTextLine(_global.LANG.perks_types, _loc4.tColorA, true, true, true, _global.HtmlManual + "perk_type." + _root.language + ".html\" target=\"_blank"));
            _loc4.addLine(_loc4.addTextLine("&nbsp;"));
            _loc4.addLine(_loc4.addTextLine(_global.PLANG["p" + _item.name], _loc4.tColorB, false, true, false));
        }
        else
        {
            _loc4 = display.hint.ItemHint.create(_loc10, "box_newHint", _loc10.getNextHighestDepth(), _item, {tColorA: 16777215, noBorder: true, tSize: 11, uniqueInstance: true});
            _loc4.delLineAt(0, true, false);
            _loc4.addLine(_loc4.addTextLine("&nbsp;"));
            if (_root.isPsyCrystal(_item))
            {
                _loc4.addLine(_loc4.addTextLine(_global.LANG.psy_crystals + ":", _loc4.tColorB, false, true, false));
                var _loc6 = _global.psy_crystals[_loc11 - ItemType.PSY_CRYSTAL_1];
                for (var _loc5 in _loc6)
                {
                    _loc4.addLine(_loc4.addTextLine("&nbsp;&nbsp;" + _global.LANG["psy_crystal" + _loc6[_loc5]], _loc4.tColorA, false, false, false));
                } // end of for...in
            }
            else
            {
                var _loc9 = "";
                var _loc8 = "";
                if (_root.isKPK(_item))
                {
                    _loc9 = _global.HtmlManual + ("pda/" + (_loc11 != 804 ? ("pda") : ("pvp")) + _root.GetSubTypeItem(_item.type)) + "." + _root.language + ".html\" target=\"_blank";
                    _loc8 = _global.LANG.lb;
                }
                else if (_item.lb)
                {
                    _loc9 = _global.HtmlManual + _item.lb + "." + _root.language + ".html\" target=\"_blank";
                    _loc8 = _item.lb.substr(0, 3) == "qst" ? (_global.LANG.lb_qst) : (_global.LANG["lb" + _item.lb] || _global.LANG.lb);
                } // end else if
                var _loc7 = _item.name.charAt(0);
                if (_loc7 == "e" || _loc7 == "k" || _loc7 == "p" || _loc7 == "v" || _loc7 == "w" || int(_item.type) == 6)
                {
                    _loc9 = _global.HtmlManual + "guns" + _loc7 + "." + _root.language + ".html#" + _item.category + "-" + _item.name + "\" target=\"_blank";
                    _loc8 = _global.LANG.lb_guns;
                } // end if
                if (_loc7 == "c")
                {
                    _loc9 = _global.HtmlManual + "armour." + _root.language + ".html#" + _item.category + "-" + _item.name + "\" target=\"_blank";
                    _loc8 = _global.LANG.lb_armour;
                } // end if
                if (_loc11 == 800)
                {
                    _loc9 = _global.HtmlManual + "lb/" + _item.s1 + "." + _root.language + ".html\" target=\"_blank";
                    _loc8 = _global.LANG.lb_menu1;
                } // end if
                _loc4.addLine(_loc4.addTextLine(_loc8, _loc4.tColorA, true, true, true, _loc9));
            } // end else if
            if (__show_needres && _item.res)
            {
                _loc4.addLine(_loc4.addTextLine("&nbsp;"));
                _loc4.addLine(_loc4.addTextLine(_global.LANG.res_draft + ":", _loc4.tColorB, false, true, false));
                _loc6 = _item.res.split(",");
                for (var _loc5 = 0; _loc5 < _loc6.length; ++_loc5)
                {
                    if (_loc6[_loc5] > 0)
                    {
                        _loc4.addLine(_loc4.addTextLine("&nbsp;&nbsp;" + _global.LANG["res" + (_loc5 + 1) + "_s"] + ": " + _loc6[_loc5] + " " + _global.LANG.count_f, _loc4.tColorA, false, false, false));
                    } // end if
                } // end of for
                _loc4.addLine(_loc4.addTextLine("&nbsp;"));
            } // end if
            if (_item.tm > 0)
            {
                _loc4.addLine(_loc4.addTextLine("&nbsp;"));
                _loc4.addLine(_loc4.addTextLine(_global.LANG.ptime + ": " + _root.TimeToString(_item.tm, true), _loc4.tColorA, false, false, false));
            } // end if
            if (_item.st && _item.protect && _item.s1)
            {
                _loc4.addLine(_loc4.addTextLine("&nbsp;"));
                _loc4.addLine(_loc4.addTextLine(_global.LANG.paint, _loc4.tColorA, false, false, false));
            } // end if
            if (__show_owner && _item.owner)
            {
                _loc4.addLine(_loc4.addTextLine("&nbsp;"));
                _loc4.addLine(_loc4.addTextLine(_global.LANG.owner + ":&nbsp;", _loc4.tColorA, false, false, false), _loc4.addTextLine(_item.owner, _loc4.tColorA, true, true, true, "asfunction:_root.xml_GetInfo," + _item.owner + " "));
            } // end if
        } // end else if
        _loc4._max_width = com.timezero.game.win.WinItemParam._HINT_WIDTH;
        _loc4.updateList();
        _hintText = _loc4;
    } // End of the function
    function doTrash(count)
    {
        _global.ErrorTxt = "";
        if (_root.DropItem(_item, count))
        {
            this.close();
        }
        else
        {
            _root.Hint(_global.ErrorTxt || _global.LANG.error_lock, 0);
        } // end else if
    } // End of the function
    function doSplit(count)
    {
        if (count > 0)
        {
            _root.SplitItem(_item, count);
        } // end if
        this.close();
    } // End of the function
    function doUse()
    {
        if (!_item.slot)
        {
            if (!_root.TryPutOn(_item))
            {
                _root.Hint(_global.ErrorTxt, 0);
                return (false);
            } // end if
        } // end if
        this.xml_use(_item.id, _global.mylogin);
        this.close();
    } // End of the function
    function savePassword()
    {
        if (realtykey.name1.text == (_item.s2 || ""))
        {
            _root.DelBattleLoading();
            return;
        } // end if
        this.xml_KeyPass(_item.id, realtykey.name1.text);
    } // End of the function
    function saveNames()
    {
        ++__tk;
        if (__tk >= __pets.length)
        {
            _root.DelBattleLoading();
            return;
        } // end if
        var _loc3 = __pets[__tk];
        var _loc4 = _root.CheckLogin(_loc3.new_name.text);
        if (_loc4)
        {
            _root.DelBattleLoading();
            _root.Hint(_loc4, 0);
        }
        else if (!_loc3 || _loc3.new_name.text == _loc3.name)
        {
            this.saveNames();
        }
        else
        {
            this.xml_saveName(_loc3.id, _loc3.new_name.text);
        } // end else if
    } // End of the function
    function RecreateMenu()
    {
        var _loc7 = [s, "", "", "", "", "", "", ""];
        var _loc5;
        var _loc4;
        var _loc8;
        var _loc6;
        for (var _loc5 in _item.included)
        {
            _loc4 = int(_item.included[_loc5].type) - ItemType.PSY_CRYSTAL_1 + 1;
            _loc7[_loc4] = (_loc7[_loc4] || 0) + 1;
        } // end of for...in
        var _loc10 = new Array();
        var _loc11 = new Array();
        var _loc12 = new Array();
        _loc12.push({txt: _global.LANG.psy_add, n: 999});
        _loc10.push({txt: _global.LANG.psy_menu, sub: _loc12});
        for (var _loc5 = 0; _loc5 < _global.psyCombinations.length; ++_loc5)
        {
            _loc6 = _global.psyCombinations[_loc5].split("\t");
            _loc8 = true;
            for (var _loc4 = 1; _loc4 <= 7; ++_loc4)
            {
                if ((Number(_loc6[_loc4]) || 0) != (Number(_loc7[_loc4]) || 0))
                {
                    _loc8 = false;
                    break;
                } // end if
            } // end of for
            _loc10.push({txt: _loc6[0], n: _loc5 + 1, icon: _loc8 ? ("tick") : (undefined)});
            _loc11.push({txt: _loc6[0], n: 1000 + _loc5 + 1});
        } // end of for
        if (_loc11.length)
        {
            _loc12.push({txt: _global.LANG.psy_del, sub: _loc11});
        } // end if
        _loc12.push({txt: _global.LANG.psy_text, n: 998});
        menu = _root.CreateMenu(this, _loc10, psy_btn._x, psy_btn._y + psy_btn._height, this, "doMenu");
    } // End of the function
    function doMenu(n)
    {
        if (n == 998)
        {
            var _loc10 = "";
            var _loc13;
            var _loc4;
            for (var _loc6 = 0; _loc6 < _global.psyCombinations.length; ++_loc6)
            {
                _loc13 = _global.psyCombinations[_loc6].split("\t");
                _loc10 = _loc10 + ("<cast name=\"" + _root.NormalizeText(_loc13[0]) + "\" ");
                for (var _loc4 = 1; _loc4 <= 7; ++_loc4)
                {
                    _loc10 = _loc10 + (names[_loc4 - 1] + "=\"" + (Number(_loc13[_loc4]) || 0) + "\" ");
                } // end of for
                _loc10 = _loc10 + "/>\n";
            } // end of for
            var mc = _root.UpPadding("ShowText");
            mc.Update(_loc10);
            mc.txt.type = "input";
            mc.btn2.label.ftext(_global.LANG.CHANGE);
            mc.btn2._visible = true;
            mc.btn2.mc = this;
            mc.btn2.names = names;
            mc.btn2.onRelease = function ()
            {
                _global.psyCombinations = new Array();
                var _loc11 = new XML(_parent.txt.text);
                var _loc7 = _loc11.firstChild;
                var _loc10;
                var _loc5;
                var _loc9;
                var _loc6;
                var _loc4;
                var _loc8;
                while (_loc7 != null)
                {
                    _loc10 = _loc7.nodeName;
                    _loc5 = _loc7.attributes;
                    if (_loc10 && _loc10.toLowerCase() == "cast" && _loc5.name)
                    {
                        _loc9 = [_loc5.name.split("\t").join(" ").split("\n").join(" ").split("\r").join(" "), "", "", "", "", "", "", ""];
                        for (var _loc6 in _loc5)
                        {
                            _loc8 = _loc6.toLowerCase();
                            for (var _loc4 = 1; _loc4 <= 7; ++_loc4)
                            {
                                if (names[_loc4 - 1].toLowerCase() == _loc8)
                                {
                                    _loc9[_loc4] = Number(_loc5[_loc6]) || 0;
                                } // end if
                            } // end of for
                        } // end of for...in
                        _global.psyCombinations.push(_loc9.join("\t"));
                    } // end if
                    _loc7 = _loc7.nextSibling;
                } // end while
                _root.SavePsyCombination();
                mc.RecreateMenu();
                _parent.Close();
            };
        }
        else if (n == 999)
        {
            _root.WinEnterText(_global.LANG.psy_add_asc, this, "SavePsy");
        }
        else if (n > 1000)
        {
            _loc13 = _global.psyCombinations[n - 1001].split("\t");
            _root.WinAscYesNo(_root.SearchReplace(_global.LANG.psy_del_asc, _loc13[0]), this, "DelPsy", n - 1001);
        }
        else
        {
            this.AssemblePsy(n - 1);
        } // end else if
    } // End of the function
    function SavePsy(s)
    {
        var _loc5;
        var _loc4;
        var _loc7 = true;
        if (!s)
        {
            return;
        } // end if
        s = s.split("\t").join(" ").split("\n").join(" ").split("\r").join(" ");
        if (s.length > 100)
        {
            s = s.substring(0, 100);
        } // end if
        _loc5 = s.length;
        while (_loc5--)
        {
            if (s.charCodeAt(_loc5) > 32)
            {
                s = s.substring(0, _loc5 + 1);
                _loc7 = false;
                break;
            } // end if
        } // end while
        _loc5 = -1;
        _loc4 = s.length;
        while (_loc5++ < _loc4)
        {
            if (s.charCodeAt(_loc5) > 32)
            {
                s = s.substring(_loc5);
                _loc7 = false;
                break;
            } // end if
        } // end while
        if (!s || _loc7)
        {
            return;
        } // end if
        var _loc8 = [s, "", "", "", "", "", "", ""];
        for (var _loc5 in _item.included)
        {
            _loc4 = int(_item.included[_loc5].type) - ItemType.PSY_CRYSTAL_1 + 1;
            _loc8[_loc4] = (_loc8[_loc4] || 0) + 1;
        } // end of for...in
        for (var _loc5 = 0; _loc5 < _global.psyCombinations.length; ++_loc5)
        {
            var _loc9 = _global.psyCombinations[_loc5].split("\t");
            _loc7 = true;
            for (var _loc4 = 1; _loc4 <= 7; ++_loc4)
            {
                if ((Number(_loc9[_loc4]) || 0) != (Number(_loc8[_loc4]) || 0))
                {
                    _loc7 = false;
                    break;
                } // end if
            } // end of for
            if (_loc7 || _loc9[0].toLowerCase() == s.toLowerCase())
            {
                _global.psyCombinations[_loc5] = _loc8.join("\t");
                _root.SavePsyCombination();
                this.RecreateMenu();
                return;
            } // end if
        } // end of for
        _global.psyCombinations.push(_loc8.join("\t"));
        _root.SavePsyCombination();
        this.RecreateMenu();
    } // End of the function
    function DelPsy(n)
    {
        _global.psyCombinations.splice(n, 1);
        _root.SavePsyCombination();
        this.RecreateMenu();
    } // End of the function
    function AssemblePsy(n)
    {
        var _loc8 = _global.psyCombinations[n].split("\t");
        var _loc5;
        var _loc4;
        _loc5 = 0;
        for (var _loc4 = 1; _loc4 <= 7; ++_loc4)
        {
            _loc5 = _loc5 + (Number(_loc8[_loc4]) || 0);
        } // end of for
        if (_loc5 > _item.max_count)
        {
            _root.Alert(_global.LANG.psy_err1);
            return;
        } // end if
        var _loc9 = new Array();
        var _loc7 = new Array();
        for (var _loc5 in _item.included)
        {
            _loc4 = int(_item.included[_loc5].type) - ItemType.PSY_CRYSTAL_1 + 1;
            _loc9[_loc4] = (_loc9[_loc4] || 0) + 1;
            _loc7[_loc4] = (_loc7[_loc4] || 0) + 1;
        } // end of for...in
        for (var _loc5 in _root.BoxList)
        {
            _loc4 = Math.floor(_root.BoxList[_loc5].type) - ItemType.PSY_CRYSTAL_1 + 1;
            if (_loc4 >= 1 && _loc4 <= 7)
            {
                _loc9[_loc4] = (_loc9[_loc4] || 0) + 1;
            } // end if
        } // end of for...in
        var _loc6 = true;
        var _loc11 = true;
        var _loc12 = new Array();
        for (var _loc4 = 1; _loc4 <= 7; ++_loc4)
        {
            if ((Number(_loc8[_loc4]) || 0) > (Number(_loc9[_loc4]) || 0))
            {
                _loc6 = false;
                _loc12.push(names[_loc4 - 1] + "[" + (Number(_loc8[_loc4]) - (Number(_loc9[_loc4]) || 0)) + "]");
            } // end if
            if ((Number(_loc8[_loc4]) || 0) != (Number(_loc7[_loc4]) || 0))
            {
                _loc11 = false;
            } // end if
        } // end of for
        if (!_loc6)
        {
            _root.Alert(_root.SearchReplace(_global.LANG.psy_err2, _loc12.join(", ")));
            return;
        } // end if
        if (_loc11)
        {
            return;
        } // end if
        var _loc10;
        for (var _loc5 = 0; _loc5 < _item.included.length; ++_loc5)
        {
            _loc4 = int(_item.included[_loc5].type) - ItemType.PSY_CRYSTAL_1 + 1;
            _loc6 = false;
            if (!_loc8[_loc4] || Number(_loc7[_loc4]) > Number(_loc8[_loc4]))
            {
                if (_root.UnloadItemFromItem(_item, _item.included[_loc5].id))
                {
                    --_loc7[_loc4];
                }
                else
                {
                    if (_global.ErrorTxt)
                    {
                        _root.Alert(_global.ErrorTxt);
                    } // end if
                    this.updateLeft();
                    return;
                } // end else if
                continue;
            } // end if
        } // end of for
        for (var _loc4 = 1; _loc4 <= 7; ++_loc4)
        {
            if (_loc8[_loc4])
            {
                while (Number(_loc8[_loc4]) > (Number(_loc7[_loc4]) || 0))
                {
                    _loc6 = undefined;
                    _loc5 = _root.BoxList.length;
                    while (_loc5--)
                    {
                        if (Math.floor(_root.BoxList[_loc5].type) == ItemType.PSY_CRYSTAL_1 - 1 + _loc4)
                        {
                            _loc6 = _root.BoxList[_loc5];
                            break;
                        } // end if
                    } // end while
                    if (_loc6)
                    {
                        if (_item.slot)
                        {
                            _loc10 = _item.slot;
                            if (!_root.ChangeItemSlot(_item))
                            {
                                if (_global.ErrorTxt)
                                {
                                    _root.Alert(_global.ErrorTxt);
                                } // end if
                                this.updateLeft();
                                return;
                            } // end if
                        } // end if
                        if (_root.InsertItemToItem(_item, _loc6, true))
                        {
                            _loc7[_loc4] = (Number(_loc7[_loc4]) || 0) + 1;
                        }
                        else
                        {
                            if (_global.ErrorTxt)
                            {
                                _root.Alert(_global.ErrorTxt);
                            } // end if
                            this.updateLeft();
                            return;
                        } // end else if
                        continue;
                    } // end if
                    _root.Alert(_global.LANG.psy_err2);
                    this.updateLeft();
                    return;
                } // end while
            } // end if
        } // end of for
        if (_loc10)
        {
            if (!_root.ChangeItemSlot(_item, _loc10))
            {
                if (_global.ErrorTxt)
                {
                    _root.Alert(_global.ErrorTxt);
                } // end if
                this.updateLeft();
                return;
            } // end if
            _root.UpdateBOX();
        } // end if
        this.updateLeft();
        _root.PlaySnd("inpsy");
    } // End of the function
    function onLoad()
    {
        this.moveToCenter();
        _y = _y - 20;
        com.timezero.game.win.Window.createBorder(bg, null, {drag: bg, close: true});
        com.timezero.game.win.Window.setDragged(this, bg_lines, null, false);
        this.updateTop();
        this.updateLeft();
        this.updateRight();
    } // End of the function
    function onResize()
    {
        this.moveToCenter();
        _y = _y - 20;
    } // End of the function
    function onBigImageLoad(iv)
    {
        var _loc3 = iv.__get__item();
        var _loc2 = iv.mc;
        _root.CreateFlowers(_loc2, _loc3);
        _loc2.item = _loc3;
        _root.ShowIncludedItems(_loc2);
    } // End of the function
    function handler_IncludedImageLoad(iv)
    {
        var item = iv.__get__item();
        var _loc4 = iv.mc;
        _root.CreateFlowers(_loc4, item);
        _loc4.item = item;
        _root.ShowIncludedItems(_loc4);
        var _loc5 = {x: 170, y: 0, align: "right", to_mc: this};
        _loc4.box = this;
        _loc4.position = _loc5;
        _loc4.item = item;
        _loc4.show_real_quality = _root.USER.god || _root.GetProf("sp") > 5.000000E-001 || _root.CheckVip();
        _loc4.onRollOver = function ()
        {
            _root.ShowItemHint(this);
            if (hint)
            {
                _root.Hint(hint);
            } // end if
        };
        _loc4.onRollOut = _loc4.onReleaseOutside = function ()
        {
            _root.RemoveItemHint();
            _root.removeHint();
        };
        if (!__no_change && Math.floor(_item.type) != 777)
        {
            _loc4.hint = _global.LANG.itemparam_unload;
            _loc4.onRelease = function ()
            {
                _root.RemoveItemHint();
                _root.removeHint();
                if (!box._item || !item)
                {
                    return;
                } // end if
                if (item.count > 0 || _root.ShiftPressed())
                {
                    box.doUnload(this);
                }
                else
                {
                    _root.WinAscYesNo(_root.SearchReplace(_global.LANG.unload_ask, item.txt, box._item.txt), box, "doUnload", this);
                } // end else if
            };
            if (_item.type == "808.3")
            {
                delete _loc4.onRelease;
            } // end if
        }
        else
        {
            _loc4.useHandCursor = false;
        } // end else if
    } // End of the function
    function handler_RightImageLoad(iv)
    {
        var _loc4 = iv.__get__item();
        var _loc3 = iv.mc;
        _root.CreateFlowers(_loc3, _loc4);
        _loc3.item = _loc4;
        var _loc5 = {x: 170, y: 0, align: "right", to_mc: this};
        _loc3.box = this;
        _loc3.position = _loc5;
        _loc3.item = _loc4;
        _loc3.show_real_quality = _root.USER.god || _root.GetProf("sp") > 5.000000E-001 || _root.CheckVip();
        _loc3.onRollOver = function ()
        {
            _root.ShowItemHint(this);
        };
        _loc3.onRollOut = _loc3.onReleaseOutside = function ()
        {
            _root.RemoveItemHint();
            _root.removeHint();
        };
    } // End of the function
    function doUnload(mc)
    {
        if (!mc.item || !mc.box)
        {
            return;
        } // end if
        if (_root.UnloadItemFromItem(mc.box._item, mc.item.id, mc.item.calibre))
        {
            this.updateLeft();
        }
        else
        {
            _root.Hint(_global.ErrorTxt || _global.LANG.error_unload, 0);
        } // end else if
    } // End of the function
    function onMouseWheel(delta, scrollTarget)
    {
        if (String(scrollTarget).indexOf(String(this)) != 0)
        {
            return;
        } // end if
        if (String(scrollTarget).indexOf("right") > -1)
        {
            this.scrollRight(delta);
        }
        else if (String(scrollTarget).indexOf("left") > -1)
        {
            this.scrollLeft(delta);
        } // end else if
    } // End of the function
    function xml_saveName(id, name)
    {
        _root.SendCmd("<USE perk=\"" + id + "\" set_name=\"" + name + "\" />");
    } // End of the function
    function xml_in(e)
    {
        var _loc4 = e.attributes;
        switch (e.nodeName)
        {
            case "BLDKEY":
            {
                if (_loc4.dup)
                {
                    _root.Alert(_global.LANG[Number(_loc4.code) ? ("error_system") : ("newkey_done")]);
                }
                else if (_loc4.pass)
                {
                    _root.Alert(_global.LANG[Number(_loc4.code) ? ("error_system") : ("passkey_done")]);
                    if (!Number(_loc4.code))
                    {
                        _item.s2 = realtykey.name1.text;
                    } // end if
                } // end else if
                _root.DelBattleLoading();
                break;
            } 
            case "USE":
            {
                var _loc5 = __pets[__tk];
                switch (Number(_loc4.code))
                {
                    case 0:
                    {
                        _loc5.obj.build_in = "$" + _loc5.new_name.text;
                        this.saveNames();
                        break;
                    } 
                    case 1:
                    {
                        _root.DelBattleLoading();
                        _root.showHint(_root.SearchReplace(_global.LANG.use_err11, _loc5.new_name.text));
                        break;
                    } 
                } // End of switch
                break;
            } 
        } // End of switch
    } // End of the function
    function xml_KeyDublicate(id)
    {
        _root.SendCmd("<BLDKEY id=\"" + id + "\" dup=\"1\" />");
    } // End of the function
    function xml_KeyPass(id, pass)
    {
        _root.SendCmd("<BLDKEY id=\"" + id + "\" pass=\"" + pass + "\" />");
    } // End of the function
    function xml_use(id, login)
    {
        _root.SendCmd("<USE id=\"" + id + "\" login=\"" + login + "\" />");
    } // End of the function
    static var IMG_SIZE = new flash.geom.Point(164, 156);
    static var INCLUDED_SIZE = new flash.geom.Point(54, 40);
    static var RIGHT_ITEM_SIZE = new flash.geom.Point(77, 77);
    static var _HINT_HEIGHT = 280;
    static var _HINT_WIDTH = 170;
    static var TF_COLOR_BLUE = 13237212;
    static var TF_COLOR_ROAN = 16510153;
    static var TF_COLOR_ORANGE = 16214584;
    static var TF_COLOR_GREEN = 3593330;
    var s = "";
    var names = new Array("Fire", "Water", "Life", "Sun", "Mind", "Blood", "Air");
} // End of Class
