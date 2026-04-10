/*
 *  @Project:		Battle Brothers
 *	@Company:		Overhype Studios
 *
 *	@Copyright:		(c) Overhype Studios | 2013 - 2020
 * 
 *  @Author:		Overhype Studios
 *  @Date:			15.10.2017
 *  @Description:	Tactical Combat Result Screen - Loot Panel JS
 */
"use strict";


var TacticalCombatResultScreenLootPanel = function (_dataSource) {
    this.mDataSource = _dataSource;

    this.mIsVisible = false;

    // container
    this.mContainer = null;
    this.mStashListContainer = null;
    this.mStashListScrollContainer = null;
    this.mFoundLootListContainer = null;
    this.mFoundLootListScrollContainer = null;

    // buttons
    this.mLootAllItemsButton = null;

    // labels
    this.mStashSlotSizeContainer = null;
    this.mStashSlotSizeLabel = null;

    // stash & found loot
    this.mStashSlots = null;
    this.mFoundLootSlots = null;

    this.registerDatasourceListener();
};


TacticalCombatResultScreenLootPanel.prototype.createDIV = function (_parentDiv) {
    var self = this;

    // create: loot panel (init hidden!)
    this.mContainer = $('<div class="loot-panel opacity-none"/>');
    _parentDiv.append(this.mContainer);

    // create stash
    var leftColumn = $('<div class="column is-left"/>');
    this.mContainer.append(leftColumn);
    var headerRow = $('<div class="row is-header title-font-normal font-bold font-color-title">Stash</div>');
    leftColumn.append(headerRow);
    var contentRow = $('<div class="row is-content"/>');
    leftColumn.append(contentRow);
    var footerRow = $('<div class="row is-footer"/>');
    leftColumn.append(footerRow);

    var listContainerLayout = $('<div class="l-list-container is-left"></div>');
    contentRow.append(listContainerLayout);
    this.mStashListContainer = listContainerLayout.createList(1.24/*8.63*/);
    this.mStashListScrollContainer = this.mStashListContainer.findListScrollContainer();

    // create options
    var middleColumn = $('<div class="column is-middle"/>');
    this.mContainer.append(middleColumn);
    contentRow = $('<div class="row is-content"/>');
    middleColumn.append(contentRow);

    this.mStashSlotSizeContainer = $('<div class="slot-count-container"/>');
    middleColumn.append(this.mStashSlotSizeContainer);
    var slotSizeImage = $('<img/>');
    slotSizeImage.attr('src', Path.GFX + Asset.ICON_BAG);
    this.mStashSlotSizeContainer.append(slotSizeImage);
    this.mStashSlotSizeLabel = $('<div class="label text-font-small font-bold font-color-value"/>');
    this.mStashSlotSizeContainer.append(this.mStashSlotSizeLabel);

    // create: buttons
    var buttonLayout = $('<div class="l-loot-all-items-button"/>');
    contentRow.append(buttonLayout);
    this.mLootAllItemsButton = buttonLayout.createCustomButton("", function () {
        self.mDataSource.notifyBackendLootAllItemsButtonPressed();
    }, 'loot-all-button', 7);

    /*
    buttonLayout = $('<div class="l-destroy-item-button"/>');
    contentRow.append(buttonLayout);
    buttonLayout.createImageButton(Path.GFX + Asset.BUTTON_DESTROY_ITEM, function() {
        //self.notifyBackendQuitButtonPressed();
    });
*/

    // create found loot
    var rightColumn = $('<div class="column is-right"/>');
    this.mContainer.append(rightColumn);
    headerRow = $('<div class="row is-header title-font-normal font-bold font-color-title">Found Loot</div>');
    rightColumn.append(headerRow);
    contentRow = $('<div class="row is-content"/>');
    rightColumn.append(contentRow);

    listContainerLayout = $('<div class="l-list-container is-right"></div>');
    contentRow.append(listContainerLayout);
    this.mFoundLootListContainer = listContainerLayout.createList(1.24/*8.63*/);
    this.mFoundLootListScrollContainer = this.mFoundLootListContainer.findListScrollContainer();

    this.setupEventHandler();
};

TacticalCombatResultScreenLootPanel.prototype.destroyDIV = function () {
    this.mStashSlots = null;
    this.mFoundLootSlots = null;

    this.mStashSlotSizeLabel.remove();
    this.mStashSlotSizeLabel = null;
    this.mStashSlotSizeContainer.empty();
    this.mStashSlotSizeContainer.remove();
    this.mStashSlotSizeContainer = null;

    this.mLootAllItemsButton.remove();
    this.mLootAllItemsButton = null;

    this.mStashListContainer.destroyList();
    this.mStashListScrollContainer = null;
    this.mStashListContainer = null;

    this.mFoundLootListContainer.destroyList();
    this.mFoundLootListScrollContainer = null;
    this.mFoundLootListContainer = null;

    this.mContainer.empty();
    this.mContainer.remove();
    this.mContainer = null;
};


TacticalCombatResultScreenLootPanel.prototype.setupEventHandler = function () {
    var self = this;

    /*
    var dropStartHandler = function () {
        $(this).addClass("is-drop-target");
    };
    var dropEndHandler = function () {
        $(this).removeClass("is-drop-target");
    };
    */
    var dropHandler = function (ev, dd) {
        /*
        console.info(dd);
        console.info('dropped');
*/
        var drag = $(dd.drag);
        var drop = $(dd.drop);

        // do the swapping
        var sourceData = drag.data('item') || {};
        var targetData = drop.data('item') || {};

        var sourceOwner = (sourceData !== null && 'owner' in sourceData) ? sourceData.owner : null;
        var targetOwner = (targetData !== null && 'owner' in targetData) ? targetData.owner : null;

        /*
                console.info(sourceData);
                 console.info(targetData);
        */

        if (sourceOwner === null || targetOwner === null) {
            console.error('Failed to drop item. Owner are invalid.');
            return;
        }

        var sourceItemIdx = (sourceData !== null && 'index' in sourceData) ? sourceData.index : null;
        var targetItemIdx = (targetData !== null && 'index' in targetData) ? targetData.index : null;

        if (sourceItemIdx === null) {
            console.error('Failed to drop item. Source idx is invalid.');
            return;
        }
        self.mDataSource.swapItem(sourceItemIdx, sourceOwner, targetItemIdx, targetOwner, false);

        // workaround if the source container was removed before we got here
        if (drag.parent().length === 0) {
            $(dd.proxy).remove();
        }
        else {
            drag.removeClass('is-dragged');
        }
    };

    // create drop handler for the stash & found loot container
    $.drop({ mode: 'middle' });

    this.mStashListContainer.data('item', { owner: TacticalCombatResultScreenIdentifier.ItemOwner.Stash });
    //this.mStashListContainer.drop('start', dropStartHandler);
    this.mStashListContainer.drop(dropHandler);
    //this.mStashListContainer.drop('end', dropEndHandler);

    this.mFoundLootListContainer.data('item', { owner: TacticalCombatResultScreenIdentifier.ItemOwner.FoundLoot });
    //this.mFoundLootListContainer.drop('start', dropStartHandler);
    this.mFoundLootListContainer.drop(dropHandler);
    //this.mFoundLootListContainer.drop('end', dropEndHandler);
};


TacticalCombatResultScreenLootPanel.prototype.bindTooltips = function () {
    this.mStashSlotSizeContainer.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.Stash.FreeSlots });
    this.mLootAllItemsButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.TacticalCombatResultScreen.LootPanel.LootAllItemsButton });
};

TacticalCombatResultScreenLootPanel.prototype.unbindTooltips = function () {
    this.mStashSlotSizeContainer.unbindTooltip();
    this.mLootAllItemsButton.unbindTooltip();
};


TacticalCombatResultScreenLootPanel.prototype.registerDatasourceListener = function () {
    this.mDataSource.addListener(TacticalCombatResultScreenDatasourceIdentifier.Stash.Loaded, jQuery.proxy(this.onStashLoaded, this));
    this.mDataSource.addListener(TacticalCombatResultScreenDatasourceIdentifier.Stash.ItemUpdated, jQuery.proxy(this.onStashItemUpdated, this));
    this.mDataSource.addListener(TacticalCombatResultScreenDatasourceIdentifier.FoundLoot.Loaded, jQuery.proxy(this.onFoundLootLoaded, this));
    this.mDataSource.addListener(TacticalCombatResultScreenDatasourceIdentifier.FoundLoot.ItemUpdated, jQuery.proxy(this.onFoundLootItemUpdated, this));
    this.mDataSource.addListener(ErrorCode.Key, jQuery.proxy(this.onDataSourceError, this));
};


TacticalCombatResultScreenLootPanel.prototype.create = function (_parentDiv) {
    this.createDIV(_parentDiv);
    this.bindTooltips();
};

TacticalCombatResultScreenLootPanel.prototype.destroy = function () {
    this.unbindTooltips();
    this.destroyDIV();
};


TacticalCombatResultScreenLootPanel.prototype.register = function (_parentDiv) {
    console.log('TacticalCombatResultScreenLootPanel::REGISTER');

    if (this.mContainer !== null) {
        console.error('ERROR: Failed to register Loot Panel Module. Reason: Loot Panel Module is already initialized.');
        return;
    }

    if (_parentDiv !== null && typeof (_parentDiv) == 'object') {
        this.create(_parentDiv);
    }
};

TacticalCombatResultScreenLootPanel.prototype.unregister = function () {
    console.log('TacticalCombatResultScreenLootPanel::UNREGISTER');

    if (this.mContainer === null) {
        console.error('ERROR: Failed to unregister Loot Panel Module. Reason: Loot Panel Module is not initialized.');
        return;
    }

    this.destroy();
};

TacticalCombatResultScreenLootPanel.prototype.isRegistered = function () {
    if (this.mContainer !== null) {
        return this.mContainer.parent().length !== 0;
    }

    return false;
};


TacticalCombatResultScreenLootPanel.prototype.isVisible = function () {
    return this.mIsVisible;
};

TacticalCombatResultScreenLootPanel.prototype.show = function () {
    // NOTE: (js) HACK which prevents relayouting..
    this.mContainer.removeClass('opacity-none').addClass('opacity-full is-top');
    this.mIsVisible = true;
};

TacticalCombatResultScreenLootPanel.prototype.hide = function () {
    // NOTE: (js) HACK which prevents relayouting..
    this.mContainer.removeClass('opacity-full is-top').addClass('opacity-none');
    this.mIsVisible = false;
};


TacticalCombatResultScreenLootPanel.prototype.querySlotByIndex = function (_itemArray, _index) {
    if (_itemArray === null || _itemArray.length === 0 || _index < 0 || _index >= _itemArray.length) {
        return null;
    }

    return _itemArray[_index];
};

TacticalCombatResultScreenLootPanel.prototype.createItemSlot = function (_owner, _index, _parentDiv, _screenDiv) {
    var self = this;

    var result = _parentDiv.createListItem();
    result.attr('id', 'slot-index_' + _index);

    // update item data
    var itemData = result.data('item') || {};
    itemData.index = _index;
    itemData.owner = _owner;
    result.data('item', itemData);

    // add event handler
    var dropHandler = function (_source, _target, _proxy, _dd, _event) {
        var sourceData = _source.data('item');
        var targetData = _target.data('item');

        var sourceOwner = (sourceData !== null && 'owner' in sourceData) ? sourceData.owner : null;
        var targetOwner = (targetData !== null && 'owner' in targetData) ? targetData.owner : null;

        /*
         console.info(sourceData);
         console.info(targetData);
         */

        if (sourceOwner === null || targetOwner === null) {
            console.error('Failed to drop item. Owner are invalid.');
            return;
        }

        var sourceItemIdx = (sourceData !== null && 'index' in sourceData) ? sourceData.index : null;
        var targetItemIdx = (targetData !== null && 'index' in targetData) ? targetData.index : null;

        if (sourceItemIdx === null) {
            console.error('Failed to drop item. Source idx is invalid.');
            return;
        }

        if (sourceOwner === TacticalCombatResultScreenIdentifier.ItemOwner.Stash && targetOwner === TacticalCombatResultScreenIdentifier.ItemOwner.Stash) {
            // don't allow swapping with same slot..
            if (sourceItemIdx === targetItemIdx) {
                //console.error('Inventory::dropHandler: Failed to drop item. Source idx is same as target idx.');
                return;
            }

            // allow drop animation
            sourceData.isAllowedToDrop = true;
            _source.data('item', sourceData);

            // console.info('Stash -> Stash (swap)');
            var shiftPressed = (KeyModiferConstants.ShiftKey in _event && _event[KeyModiferConstants.ShiftKey] === true);
            var tryToUpgrade = shiftPressed && ((sourceData.slotType == "body" || sourceData.slotType == "head") && targetData.slotType == sourceData.slotType);
            
            self.mDataSource.swapItem(sourceItemIdx, sourceOwner, targetItemIdx, targetOwner, tryToUpgrade);
            return;
        }

        self.mDataSource.swapItem(sourceItemIdx, sourceOwner, targetItemIdx, targetOwner, false);
    };

    var dragEndHandler = function (_source, _target) {
        if (_source.length === 0 || _target.length === 0) {
            return false;
        }

        var sourceData = _source.data('item');
        var targetData = _target.data('item');

        var sourceOwner = (sourceData !== null && 'owner' in sourceData) ? sourceData.owner : null;
        var targetOwner = (targetData !== null && 'owner' in targetData) ? targetData.owner : null;
        var hasTargetIndex = (targetData !== null && 'index' in targetData && targetData.index !== null) ? true : false;

        if (sourceOwner === null || targetOwner === null) {
            console.error('Failed to drop item. Owner are invalid.');
            return false;
        }

        /*
                // we don't allow swapping within the found loot container
                if (sourceOwner === TacticalCombatResultScreenIdentifier.ItemOwner.FoundLoot && targetOwner === TacticalCombatResultScreenIdentifier.ItemOwner.FoundLoot)
                {
                    console.error('Failed to swap item within found loot container. Not allowed.');
                    return false;
                }
        */

        // we don't allow swapping if there is not enough space left
        if (sourceOwner === TacticalCombatResultScreenIdentifier.ItemOwner.FoundLoot && !hasTargetIndex) {
            return self.mDataSource.isStashSpaceLeft();
        }

        return true;
    };

    // add event handler
    result.assignListItemDragAndDrop(_screenDiv, null, dragEndHandler, dropHandler);

    result.assignListItemRightClick(function (_item, _event) {
        var data = _item.data('item');

        var isEmpty = (data !== null && 'isEmpty' in data) ? data.isEmpty : true;
        var owner = (data !== null && 'owner' in data) ? data.owner : null;
        //var itemId = (data !== null && 'id' in data) ? data.id : null;
        var itemIdx = (data !== null && 'index' in data) ? data.index : null;
        var destroyItem = false;//(KeyModiferConstants.AltKey in _event && _event[KeyModiferConstants.AltKey] === true);
        var removeUpgrades = (KeyModiferConstants.ShiftKey in _event && _event[KeyModiferConstants.ShiftKey] === true && ("isUsable" in data && data.isUsable === false));

        if (isEmpty === false && owner !== null /*&& itemId !== null*/ && itemIdx !== null) {
            // pickup, drop or destroy
            switch (owner) {
                case TacticalCombatResultScreenIdentifier.ItemOwner.Stash:
                    {
                        if (removeUpgrades === true) {
                            self.mDataSource.notifyBackendRemoveInventoryItemUpgrades(itemIdx);
                        }
                        else if (destroyItem === true) {
                            //console.info('destroy');
                            self.mDataSource.destroyItem(itemIdx, owner);
                        }
                        else {
                            //console.info('drop');
                            self.mDataSource.swapItem(itemIdx, owner, null, TacticalCombatResultScreenIdentifier.ItemOwner.FoundLoot, false);
                        }
                    } break;
                case TacticalCombatResultScreenIdentifier.ItemOwner.FoundLoot:
                    {
                        if (destroyItem === true) {
                            //console.info('destroy');
                            self.mDataSource.destroyItem(itemIdx, owner);
                        }
                        else {
                            //console.info('pickup');
                            self.mDataSource.swapItem(itemIdx, owner, null, TacticalCombatResultScreenIdentifier.ItemOwner.Stash, false);
                        }
                    } break;
            }
        }
    });

    return result;
};

TacticalCombatResultScreenLootPanel.prototype.createItemSlots = function (_owner, _size, _itemArray, _itemContainer) {
    var screen = $('.tactical-combat-result-screen');
    for (var i = 0; i < _size; ++i) {
        _itemArray.push(this.createItemSlot(_owner, i, _itemContainer, screen));
    }
};

TacticalCombatResultScreenLootPanel.prototype.assignItems = function (_owner, _items, _itemArray, _itemContainer) {
    this.destroyItemSlots(_itemArray, _itemContainer);

    if (_items.length > 0) {
        this.createItemSlots(_owner, _items.length, _itemArray, _itemContainer);

        for (var i = 0; i < _items.length; ++i) {
            // ignore empty slots
            if (_items[i] !== undefined && _items[i] !== null) {
                this.assignItemToInventorySlot(_owner, _itemArray[i], _items[i]);
            }
        }

        if (_owner === TacticalCombatResultScreenIdentifier.ItemOwner.Stash) {
            this.updateStashFreeSlotsLabel();
        }
    }
};

TacticalCombatResultScreenLootPanel.prototype.assignItemToInventorySlot = function (_owner, _slot, _item) {
    var remove = false;
    if (!(TacticalCombatResultScreenIdentifier.Item.Id in _item) || !(TacticalCombatResultScreenIdentifier.Item.ImagePath in _item)) {
        remove = true;
    }

    if (remove === true) {
        this.removeItemFromSlot(_slot);
    }
    else {
        // update item data
        var itemData = _slot.data('item') || {};
        itemData.id = _item[TacticalCombatResultScreenIdentifier.Item.Id];
        itemData.slotType = _item.slot;
        itemData.isUsable = _item.isUsable;
        _slot.data('item', itemData);

        // assign image
        _slot.assignListItemImage(Path.ITEMS + _item['imagePath']);
        _slot.assignListItemOverlayImage(_item['imageOverlayPath'], _item);

        // show amount
        // show amount
        if (_item['showAmount'] === true && _item[TacticalCombatResultScreenIdentifier.Item.Amount] != '') {
            _slot.assignListItemAmount('' + _item[TacticalCombatResultScreenIdentifier.Item.Amount], _item['amountColor']);
        }

        // bind tooltip
        _slot.assignListItemTooltip(itemData.id, _owner);
    }
};

TacticalCombatResultScreenLootPanel.prototype.updateSlotItem = function (_owner, _itemArray, _item, _index, _flag) {
    var slot = this.querySlotByIndex(_itemArray, _index);
    if (slot === null) {
        console.error('ERROR: Failed to update slot item: Reason: Invalid slot index: ' + _index);
        return;
    }

    switch (_flag) {
        case TacticalCombatResultScreenDatasourceIdentifier.Item.Flag.Inserted:
        case TacticalCombatResultScreenDatasourceIdentifier.Item.Flag.Updated:
            {
                this.removeItemFromSlot(slot);
                this.assignItemToInventorySlot(_owner, slot, _item);
            } break;
        case TacticalCombatResultScreenDatasourceIdentifier.Item.Flag.Removed:
            {
                this.removeItemFromSlot(slot);
            } break;
    }

    if (_owner === TacticalCombatResultScreenIdentifier.ItemOwner.Stash) {
        this.updateStashFreeSlotsLabel();
    }
};

TacticalCombatResultScreenLootPanel.prototype.removeItemFromSlot = function (_slot) {
    // remove item image
    _slot.assignListItemImage();
    _slot.assignListItemOverlayImage();
};

TacticalCombatResultScreenLootPanel.prototype.clearItemSlots = function (_itemArray) {
    if (_itemArray === null || _itemArray.length === 0) {
        return;
    }

    for (var i = 0; i < _itemArray.length; ++i) {
        this.removeItemFromSlot(_itemArray[i]);
    }
};

TacticalCombatResultScreenLootPanel.prototype.destroyItemSlots = function (_itemArray, _itemContainer) {
    this.clearItemSlots(_itemArray);

    _itemContainer.empty();
    _itemArray.length = 0;
};

TacticalCombatResultScreenLootPanel.prototype.updateStashFreeSlotsLabel = function () {
    var statistics = this.mDataSource.getStashStatistics();
    this.mStashSlotSizeLabel.html('' + statistics.used + '/' + statistics.size);
    if (statistics.used >= statistics.size) {
        this.mStashSlotSizeLabel.removeClass('font-color-value').addClass('font-color-negative-value');
    }
    else {
        this.mStashSlotSizeLabel.removeClass('font-color-negative-value').addClass('font-color-value');
    }
};


TacticalCombatResultScreenLootPanel.prototype.onStashLoaded = function (_dataSource, _data) {
    if (_data === undefined || _data === null || !jQuery.isArray(_data)) {
        return;
    }

    if (this.mStashSlots === null) {
        this.mStashSlots = [];
    }

    // call by ref hack
    var arrayRef = { val: this.mStashSlots };
    var containerRef = { val: this.mStashListScrollContainer };

    this.assignItems(TacticalCombatResultScreenIdentifier.ItemOwner.Stash, _data, arrayRef.val, containerRef.val);
};

TacticalCombatResultScreenLootPanel.prototype.onStashItemUpdated = function (_dataSource, _data) {
    if (_data === null || typeof (_data) !== 'object' || !('item' in _data) || !('index' in _data) || !('flag' in _data)) {
        return;
    }

    this.updateSlotItem(TacticalCombatResultScreenIdentifier.ItemOwner.Stash, this.mStashSlots, _data.item, _data.index, _data.flag);
};

TacticalCombatResultScreenLootPanel.prototype.onFoundLootLoaded = function (_dataSource, _data) {
    if (_data === undefined || _data === null || !jQuery.isArray(_data)) {
        return;
    }

    if (this.mFoundLootSlots === null) {
        this.mFoundLootSlots = [];
    }

    // call by ref hack
    var arrayRef = { val: this.mFoundLootSlots };
    var containerRef = { val: this.mFoundLootListScrollContainer };

    this.assignItems(TacticalCombatResultScreenIdentifier.ItemOwner.FoundLoot, _data, arrayRef.val, containerRef.val);
};

TacticalCombatResultScreenLootPanel.prototype.onFoundLootItemUpdated = function (_dataSource, _data) {
    if (_data === null || typeof (_data) !== 'object' || !('item' in _data) || !('index' in _data) || !('flag' in _data)) {
        return;
    }

    this.updateSlotItem(TacticalCombatResultScreenIdentifier.ItemOwner.FoundLoot, this.mFoundLootSlots, _data.item, _data.index, _data.flag);
};

TacticalCombatResultScreenLootPanel.prototype.onDataSourceError = function (_dataSource, _data) {
    if (_data === null || typeof (_data) !== 'number') {
        return;
    }

    switch (_data) {
        case ErrorCode.NotEnoughStashSpace:
            {
                this.mStashSlotSizeContainer.shakeLeftRight();
            } break;
    }
};