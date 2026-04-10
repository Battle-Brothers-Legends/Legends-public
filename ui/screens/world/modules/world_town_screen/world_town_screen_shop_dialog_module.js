/*
 *  @Project:		Battle Brothers
 *	@Company:		Overhype Studios
 *
 *	@Copyright:		(c) Overhype Studios | 2013 - 2020
 * 
 *  @Author:		Overhype Studios
 *  @Date:			11.11.2017
 *  @Description:	Town Shop Dialog Module JS
 */
"use strict";

var WorldTownScreenShop =
{
    ItemOwner:
    {
        Stash: 'world-town-screen-shop-dialog-module.stash',
        Shop: 'world-town-screen-shop-dialog-module.shop'
    },

    ItemFlag:
    {
        Inserted: 0,
        Removed: 1,
        Updated: 2
    }
};

var WorldTownScreenShopDialogModule = function (_parent) {
    this.mSQHandle = null;
    this.mParent = _parent;

    // event listener
    this.mEventListener = null;

    // generic containers
    this.mContainer = null;
    this.mDialogContainer = null;

    // list containers
    this.mStashListContainer = null;
    this.mStashListScrollContainer = null;
    this.mShopListContainer = null;
    this.mShopListScrollContainer = null;

    // assets labels
    this.mAssets = new WorldTownScreenAssets(_parent);

    // buttons
    this.mLeaveButton = null;

    // stash labels
    this.mStashSlotSizeContainer = null;
    this.mStashSlotSizeLabel = null;

    this.mStashSpaceUsed = 0;
    this.mStashSpaceMax = 0;

    // stash & found loot
    this.mStashSlots = null;
    this.mShopSlots = null;

    // lists
    this.mStashList = null;
    this.mShopList = null;

    // sort & filter
    this.mSortInventoryButton = null;
    this.mFilterAllButton = null;
    this.mFilterWeaponsButton = null;
    this.mFilterArmorButton = null;
    this.mFilterMiscButton = null;
    this.mFilterUsableButton = null;

    this.mIsRepairOffered = false;

    // generics
    this.mIsVisible = false;
};


WorldTownScreenShopDialogModule.prototype.isConnected = function () {
    return this.mSQHandle !== null;
};

WorldTownScreenShopDialogModule.prototype.onConnection = function (_handle) {
    this.mSQHandle = _handle;

    // notify listener
    if (this.mEventListener !== null && ('onModuleOnConnectionCalled' in this.mEventListener)) {
        this.mEventListener.onModuleOnConnectionCalled(this);
    }
};

WorldTownScreenShopDialogModule.prototype.onDisconnection = function () {
    this.mSQHandle = null;

    // notify listener
    if (this.mEventListener !== null && ('onModuleOnDisconnectionCalled' in this.mEventListener)) {
        this.mEventListener.onModuleOnDisconnectionCalled(this);
    }
};

WorldTownScreenShopDialogModule.prototype.updateAssets = function (_data) {
    this.mAssets.loadFromData(_data);
    this.updateItemPriceLabels(this.mShopSlots, this.mShopList, false);
}

WorldTownScreenShopDialogModule.prototype.createDIV = function (_parentDiv) {
    var self = this;

    // create: containers (init hidden!)
    this.mContainer = $('<div class="l-shop-dialog-container display-none opacity-none"/>');
    _parentDiv.append(this.mContainer);
    this.mDialogContainer = this.mContainer.createDialog('', '', '', true, 'dialog-1024-768');

    // create tabs
    var tabButtonsContainer = $('<div class="l-tab-container"/>');
    this.mDialogContainer.findDialogTabContainer().append(tabButtonsContainer);

    //create assets
    this.mAssets.createDIV(tabButtonsContainer);

    // create content
    var content = this.mDialogContainer.findDialogContentContainer();

    // create stash
    var leftColumn = $('<div class="column is-left"/>');
    content.append(leftColumn);
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

    // create middle
    var middleColumn = $('<div class="column is-middle"/>');
    content.append(middleColumn);
    contentRow = $('<div class="row is-content"/>');
    middleColumn.append(contentRow);
    var buttonContainer = $('<div class="button-container"/>');
    contentRow.append(buttonContainer);

    // sort/filter
    var layout = $('<div class="l-button is-sort"/>');
    buttonContainer.append(layout);
    this.mSortInventoryButton = layout.createImageButton(Path.GFX + Asset.BUTTON_SORT, function () {
        self.notifyBackendSortButtonClicked();
    }, '', 3);

    var layout = $('<div class="l-button is-all-filter"/>');
    buttonContainer.append(layout);
    this.mFilterAllButton = layout.createImageButton(Path.GFX + Asset.BUTTON_ALL_FILTER, function () {
        self.mFilterAllButton.addClass('is-active');
        self.mFilterWeaponsButton.removeClass('is-active');
        self.mFilterArmorButton.removeClass('is-active');
        self.mFilterMiscButton.removeClass('is-active');
        self.mFilterUsableButton.removeClass('is-active');
        self.notifyBackendFilterAllButtonClicked();
    }, '', 3);
    self.mFilterAllButton.addClass('is-active');

    var layout = $('<div class="l-button is-weapons-filter"/>');
    buttonContainer.append(layout);
    this.mFilterWeaponsButton = layout.createImageButton(Path.GFX + Asset.BUTTON_WEAPONS_FILTER, function () {
        self.mFilterAllButton.removeClass('is-active');
        self.mFilterWeaponsButton.addClass('is-active');
        self.mFilterArmorButton.removeClass('is-active');
        self.mFilterMiscButton.removeClass('is-active');
        self.mFilterUsableButton.removeClass('is-active');
        self.notifyBackendFilterWeaponsButtonClicked();
    }, '', 3);

    var layout = $('<div class="l-button is-armor-filter"/>');
    buttonContainer.append(layout);
    this.mFilterArmorButton = layout.createImageButton(Path.GFX + Asset.BUTTON_ARMOR_FILTER, function () {
        self.mFilterAllButton.removeClass('is-active');
        self.mFilterWeaponsButton.removeClass('is-active');
        self.mFilterArmorButton.addClass('is-active');
        self.mFilterMiscButton.removeClass('is-active');
        self.mFilterUsableButton.removeClass('is-active');
        self.notifyBackendFilterArmorButtonClicked();
    }, '', 3);

    var layout = $('<div class="l-button is-misc-filter"/>');
    buttonContainer.append(layout);
    this.mFilterMiscButton = layout.createImageButton(Path.GFX + Asset.BUTTON_MISC_FILTER, function () {
        self.mFilterAllButton.removeClass('is-active');
        self.mFilterWeaponsButton.removeClass('is-active');
        self.mFilterArmorButton.removeClass('is-active');
        self.mFilterMiscButton.addClass('is-active');
        self.mFilterUsableButton.removeClass('is-active');
        self.notifyBackendFilterMiscButtonClicked();
    }, '', 3);

    var layout = $('<div class="l-button is-usable-filter"/>');
    buttonContainer.append(layout);
    this.mFilterUsableButton = layout.createImageButton(Path.GFX + Asset.BUTTON_USABLE_FILTER, function () {
        self.mFilterAllButton.removeClass('is-active');
        self.mFilterWeaponsButton.removeClass('is-active');
        self.mFilterArmorButton.removeClass('is-active');
        self.mFilterMiscButton.removeClass('is-active');
        self.mFilterUsableButton.addClass('is-active');
        self.notifyBackendFilterUsableButtonClicked();
    }, '', 3);

    this.mStashSlotSizeContainer = $('<div class="slot-count-container"/>');
    buttonContainer.append(this.mStashSlotSizeContainer);
    var slotSizeImage = $('<img/>');
    slotSizeImage.attr('src', Path.GFX + Asset.ICON_BAG);
    this.mStashSlotSizeContainer.append(slotSizeImage);
    this.mStashSlotSizeLabel = $('<div class="label text-font-small font-bold font-color-value"/>');
    this.mStashSlotSizeContainer.append(this.mStashSlotSizeLabel);

    // create shop loot
    var rightColumn = $('<div class="column is-right"/>');
    content.append(rightColumn);
    headerRow = $('<div class="row is-header title-font-normal font-bold font-color-title">Shop</div>');
    rightColumn.append(headerRow);
    contentRow = $('<div class="row is-content"/>');
    rightColumn.append(contentRow);

    listContainerLayout = $('<div class="l-list-container is-right"></div>');
    contentRow.append(listContainerLayout);
    this.mShopListContainer = listContainerLayout.createList(1.24/*8.63*/);
    this.mShopListScrollContainer = this.mShopListContainer.findListScrollContainer();


    // create footer button bar
    var footerButtonBar = $('<div class="l-button-bar"/>');
    this.mDialogContainer.findDialogFooterContainer().append(footerButtonBar);

    // create: buttons
    var layout = $('<div class="l-leave-button"/>');
    footerButtonBar.append(layout);
    this.mLeaveButton = layout.createTextButton("Leave", function () {
        self.notifyBackendLeaveButtonPressed();
    }, '', 1);

    this.mIsVisible = false;

    this.setupEventHandler();
};

WorldTownScreenShopDialogModule.prototype.destroyDIV = function () {
    this.mStashSlots = null;
    this.mShopSlots = null;

    this.mStashSlotSizeLabel.remove();
    this.mStashSlotSizeLabel = null;
    this.mStashSlotSizeContainer.empty();
    this.mStashSlotSizeContainer.remove();
    this.mStashSlotSizeContainer = null;

    this.mStashListContainer.destroyList();
    this.mStashListScrollContainer = null;
    this.mStashListContainer = null;

    this.mShopListContainer.destroyList();
    this.mShopListScrollContainer = null;
    this.mShopListContainer = null;

    this.mAssets.destroyDIV();
    //this.mAssets = null;

    this.mLeaveButton.remove();
    this.mLeaveButton = null;

    this.mDialogContainer.empty();
    this.mDialogContainer.remove();
    this.mDialogContainer = null;

    this.mContainer.empty();
    this.mContainer.remove();
    this.mContainer = null;
};

WorldTownScreenShopDialogModule.prototype.showSwapConfirmationDialog = function (_item, _options, _callbackOnConfirm) {
    var popupDialog = this.mContainer.createPopupDialog(_options.Prompt, null, null, 'swap-confirmation-popup');

    popupDialog.addPopupDialogContent(this.createSwapConfirmationDialogContent(_item, _options.Text));

    popupDialog.addPopupDialogOkButton(jQuery.proxy(function (_dialog) {
        if (_options.Confirmable) { _callbackOnConfirm(); }

        _dialog.destroyPopupDialog();
    }, this));

    if (_options.Confirmable) {
        popupDialog.addPopupDialogCancelButton(function (_dialog) {
            _dialog.destroyPopupDialog();
        });
    }
};

WorldTownScreenShopDialogModule.prototype.createSwapConfirmationDialogContent = function (_item, _confirmationText) {
    var result = $('<div class="swap-confirmation-popup-dialog-content-container"/>');

    var leftColumn = $('<div class="left-column"/>');
    result.append(leftColumn);

    var itemImageContainer = $('<div class="item-image-container"/>');
    leftColumn.append(itemImageContainer);

    var itemImage = $('<img/>');
    itemImage.attr('src', Path.ITEMS + _item.Icon);
    itemImageContainer.append(itemImage);

    if (_item.imageOverlayPath && _item.imageOverlayPath.length > 0) {
        var drawOrder = [];
        if (_item && (_item.slot === "head" || _item.slot === "body") && _item.upgrades[0]) {
            drawOrder = _item.Helper.getLayerUpgradeDrawOrder(_item.upgrades, _item.imageOverlayPath, _item.slot, true);
        } else {
            for (var i = 0; i < _item.imageOverlayPath.length; i++)
                drawOrder.push(i);
        }

        drawOrder.forEach(function (i) {
            var imagePath = _item.imageOverlayPath[i];
            if (imagePath === '') {
                return;
            }
            var overlayImage = $('<img/>');
            overlayImage.attr('src', Path.ITEMS + imagePath);;
            itemImageContainer.append(overlayImage);
        });
    }

    var rightColumn = $('<div class="right-column"/>');
    result.append(rightColumn);

    var parsedName = XBBCODE.process(
        {
            text: _item.Name,
            removeMisalignedTags: false,
            addInLineBreaks: false
        });

    var itemNameLabel = $('<div class="name title-font-big font-bold font-color-title">' + parsedName.html + '</div>');
    rightColumn.append(itemNameLabel);

    var descriptionText = _confirmationText.replace(/#135213/gi, "#1e861e"); // positive values
    descriptionText = descriptionText.replace(/#8f1e1e/gi, "#a22424"); // negative values

    var parsedDescriptionText = XBBCODE.process({
        text: descriptionText,
        removeMisalignedTags: false,
        addInLineBreaks: true
    });

    var itemDescriptionLabel = $('<div class="description description-font-small font-style-italic font-color-description">' + parsedDescriptionText.html + '</div>');
    rightColumn.append(itemDescriptionLabel);

    return result;
};

WorldTownScreenShopDialogModule.prototype.setupEventHandler = function () {
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
        var drag = $(dd.drag);
        var drop = $(dd.drop);

        // do the swapping
        var sourceData = drag.data('item') || {};
        var targetData = drop.data('item') || {};

        var sourceOwner = (sourceData !== null && 'owner' in sourceData) ? sourceData.owner : null;
        var targetOwner = (targetData !== null && 'owner' in targetData) ? targetData.owner : null;

        if (sourceOwner === null || targetOwner === null) {
            console.error('Failed to drop item. Owner are invalid.');
            return;
        }

        // we don't allow swapping within the shop container
        if (sourceOwner === WorldTownScreenShop.ItemOwner.Shop && targetOwner === WorldTownScreenShop.ItemOwner.Shop) {
            //console.error('Failed to swap item within shop container. Not allowed.');
            return;
        }

        var sourceItemIdx = (sourceData !== null && 'index' in sourceData) ? sourceData.index : null;
        var targetItemIdx = (targetData !== null && 'index' in targetData) ? targetData.index : null;

        if (sourceItemIdx === null) {
            console.error('Failed to drop item. Source idx is invalid.');
            return;
        }

        self.triggerSwapFlow(sourceItemIdx, sourceOwner, targetItemIdx, targetOwner, false);

        // workaround if the source container was removed before we got here
        if (drag.parent().length === 0) {
            $(dd.proxy).remove();
        }
        else {
            drag.removeClass('is-dragged');
        }
    };

    // create drop handler for the stash & shop container
    $.drop({ mode: 'middle' });

    this.mStashListContainer.data('item', { owner: WorldTownScreenShop.ItemOwner.Stash });
    //this.mStashListContainer.drop('start', dropStartHandler);
    this.mStashListContainer.drop(dropHandler);
    //this.mStashListContainer.drop('end', dropEndHandler);

    this.mShopListContainer.data('item', { owner: WorldTownScreenShop.ItemOwner.Shop });
    //this.mShopListContainer.drop('start', dropStartHandler);
    this.mShopListContainer.drop(dropHandler);
    //this.mShopListContainer.drop('end', dropEndHandler);
};

WorldTownScreenShopDialogModule.prototype.bindTooltips = function () {
    this.mAssets.bindTooltips();
    this.mStashSlotSizeContainer.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.Stash.FreeSlots });
    this.mLeaveButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.WorldTownScreen.ShopDialogModule.LeaveButton });

    this.mSortInventoryButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterScreen.RightPanelHeaderModule.SortButton });
    this.mFilterAllButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterScreen.RightPanelHeaderModule.FilterAllButton });
    this.mFilterWeaponsButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterScreen.RightPanelHeaderModule.FilterWeaponsButton });
    this.mFilterArmorButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterScreen.RightPanelHeaderModule.FilterArmorButton });
    this.mFilterMiscButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterScreen.RightPanelHeaderModule.FilterMiscButton });
    this.mFilterUsableButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterScreen.RightPanelHeaderModule.FilterUsableButton });
};

WorldTownScreenShopDialogModule.prototype.unbindTooltips = function () {
    this.mAssets.unbindTooltips();
    this.mStashSlotSizeContainer.unbindTooltip();
    this.mLeaveButton.unbindTooltip();

    this.mSortInventoryButton.unbindTooltip();
    this.mFilterAllButton.unbindTooltip();
    this.mFilterWeaponsButton.unbindTooltip();
    this.mFilterArmorButton.unbindTooltip();
    this.mFilterMiscButton.unbindTooltip();
    this.mFilterUsableButton.unbindTooltip();
};

WorldTownScreenShopDialogModule.prototype.create = function (_parentDiv) {
    this.createDIV(_parentDiv);
    this.bindTooltips();
};

WorldTownScreenShopDialogModule.prototype.destroy = function () {
    this.unbindTooltips();
    this.destroyDIV();
};

WorldTownScreenShopDialogModule.prototype.register = function (_parentDiv) {
    console.log('WorldTownScreenShopDialogModule::REGISTER');

    if (this.mContainer !== null) {
        console.error('ERROR: Failed to register World Town Screen Shop Dialog Module. Reason: World Town Screen Shop Dialog Module is already initialized.');
        return;
    }

    if (_parentDiv !== null && typeof (_parentDiv) == 'object') {
        this.create(_parentDiv);
    }
};

WorldTownScreenShopDialogModule.prototype.unregister = function () {
    console.log('WorldTownScreenShopDialogModule::UNREGISTER');

    if (this.mContainer === null) {
        console.error('ERROR: Failed to unregister World Town Screen Shop Dialog Module. Reason: World Town Screen Shop Dialog Module is not initialized.');
        return;
    }

    this.destroy();
};

WorldTownScreenShopDialogModule.prototype.isRegistered = function () {
    if (this.mContainer !== null) {
        return this.mContainer.parent().length !== 0;
    }

    return false;
};


WorldTownScreenShopDialogModule.prototype.registerEventListener = function (_listener) {
    this.mEventListener = _listener;
};


/*WorldTownScreenShopDialogModule.prototype.show = function (_withSlideAnimation)
{
    var self = this;

    var withAnimation = (_withSlideAnimation !== undefined && _withSlideAnimation !== null) ? _withSlideAnimation : true;
    if (withAnimation === true)
    {
        var offset = -this.mContainer.width();
        this.mContainer.css({ 'translateX': offset });
        this.mContainer.velocity("finish", true).velocity({ opacity: 1, translateX: 0 },
        {
            duration: Constants.SCREEN_SLIDE_IN_OUT_DELAY,
            easing: 'swing',
            begin: function ()
            {
                $(this).removeClass('display-none').addClass('display-block');
                self.notifyBackendModuleAnimating();
            },
            complete: function ()
            {
                self.mIsVisible = true;
                self.notifyBackendModuleShown();
            }
        });
    }
    else
    {
        this.mContainer.css({ opacity: 0 });
        this.mContainer.velocity("finish", true).velocity({ opacity: 1 },
        {
            duration: Constants.SCREEN_FADE_IN_OUT_DELAY,
            easing: 'swing',
            begin: function ()
            {
                $(this).removeClass('display-none').addClass('display-block');
                self.notifyBackendModuleAnimating();
            },
            complete: function ()
            {
                self.mIsVisible = true;
                self.notifyBackendModuleShown();
            }
        });
    }
};

WorldTownScreenShopDialogModule.prototype.hide = function ()
{
    var self = this;

    var offset = -this.mContainer.width();
    this.mContainer.velocity("finish", true).velocity({ opacity: 0, translateX: offset },
    {
        duration: Constants.SCREEN_SLIDE_IN_OUT_DELAY,
        easing: 'swing',
        begin: function ()
        {
            $(this).removeClass('is-center');
            self.notifyBackendModuleAnimating();
        },
        complete: function ()
        {
            self.mIsVisible = false;
            $(this).removeClass('display-block').addClass('display-none');
            self.notifyBackendModuleHidden();
        }
    });
};*/

WorldTownScreenShopDialogModule.prototype.show = function (_withSlideAnimation) {
    var self = this;

    var withAnimation = (_withSlideAnimation !== undefined && _withSlideAnimation !== null) ? _withSlideAnimation : true;
    if (withAnimation === true) {
        var offset = -(this.mContainer.parent().width() + this.mContainer.width());
        this.mContainer.css({ 'left': offset });
        this.mContainer.velocity("finish", true).velocity({ opacity: 1, left: '0', right: '0' },
            {
                duration: Constants.SCREEN_SLIDE_IN_OUT_DELAY,
                easing: 'swing',
                begin: function () {
                    $(this).removeClass('display-none').addClass('display-block');
                    self.notifyBackendModuleAnimating();
                },
                complete: function () {
                    self.mIsVisible = true;
                    self.notifyBackendModuleShown();
                }
            });
    }
    else {
        this.mContainer.css({ opacity: 0 });
        this.mContainer.velocity("finish", true).velocity({ opacity: 1 },
            {
                duration: Constants.SCREEN_FADE_IN_OUT_DELAY,
                easing: 'swing',
                begin: function () {
                    $(this).removeClass('display-none').addClass('display-block');
                    self.notifyBackendModuleAnimating();
                },
                complete: function () {
                    self.mIsVisible = true;
                    self.notifyBackendModuleShown();
                }
            });
    }
};

WorldTownScreenShopDialogModule.prototype.hide = function () {
    var self = this;

    var offset = -(this.mContainer.parent().width() + this.mContainer.width());
    this.mContainer.velocity("finish", true).velocity({ opacity: 0, left: offset },
        {
            duration: Constants.SCREEN_SLIDE_IN_OUT_DELAY,
            easing: 'swing',
            begin: function () {
                $(this).removeClass('is-center');
                self.notifyBackendModuleAnimating();
            },
            complete: function () {
                self.mIsVisible = false;
                $(this).removeClass('display-block').addClass('display-none');
                self.notifyBackendModuleHidden();
            }
        });
};

WorldTownScreenShopDialogModule.prototype.isVisible = function () {
    return this.mIsVisible;
};

WorldTownScreenShopDialogModule.prototype.loadFromData = function (_data) {
    if (_data === undefined || _data === null || !(typeof (_data) === 'object')) {
        return;
    }

    if ('Title' in _data && _data.Title !== null) {
        this.mDialogContainer.findDialogTitle().html(_data.Title);
    }

    if ('SubTitle' in _data && _data.SubTitle !== null) {
        this.mDialogContainer.findDialogSubTitle().html(_data.SubTitle);
    }

    if ('HeaderImage' in _data && _data.HeaderImage !== null) {
        this.mDialogContainer.findDialogHeaderImage().attr('src', Path.GFX + _data.HeaderImage);
    }

    if ('IsRepairOffered' in _data && _data.IsRepairOffered !== null) {
        this.mIsRepairOffered = _data.IsRepairOffered;
    }

    if ('StashSpaceUsed' in _data) {
        this.mStashSpaceUsed = _data.StashSpaceUsed;
    }

    if ('StashSpaceMax' in _data) {
        this.mStashSpaceMax = _data.StashSpaceMax;
    }

    if ('Stash' in _data && _data.Stash !== null) {
        this.loadStashData(_data.Stash);
    }

    if ('Shop' in _data && _data.Shop !== null) {
        this.loadShopData(_data.Shop);
    }
};

WorldTownScreenShopDialogModule.prototype.loadStashData = function (_data) {
    if (_data === undefined || _data === null || !jQuery.isArray(_data)) {
        return;
    }

    this.mStashList = _data;

    if (this.mStashSlots === null) {
        this.mStashSlots = [];
    }

    // call by ref hack
    var arrayRef = { val: this.mStashSlots };
    var containerRef = { val: this.mStashListScrollContainer };

    this.assignItems(WorldTownScreenShop.ItemOwner.Stash, _data, arrayRef.val, containerRef.val);
};

WorldTownScreenShopDialogModule.prototype.loadShopData = function (_data) {
    if (_data === undefined || _data === null || !jQuery.isArray(_data)) {
        return;
    }

    this.mShopList = _data;

    if (this.mShopSlots === null) {
        this.mShopSlots = [];
    }

    // call by ref hack
    var arrayRef = { val: this.mShopSlots };
    var containerRef = { val: this.mShopListScrollContainer };

    this.assignItems(WorldTownScreenShop.ItemOwner.Shop, _data, arrayRef.val, containerRef.val);
};

WorldTownScreenShopDialogModule.prototype.assignItems = function (_owner, _items, _itemArray, _itemContainer) {
    this.destroyItemSlots(_itemArray, _itemContainer);

    if (_items.length > 0) {
        this.createItemSlots(_owner, _items.length, _itemArray, _itemContainer);

        for (var i = 0; i < _items.length; ++i) {
            // ignore empty slots
            if (_items[i] !== undefined && _items[i] !== null) {
                this.assignItemToInventorySlot(_owner, _itemArray[i], _items[i]);
            }
        }

        this.updateItemPriceLabels(_itemArray, _items, _owner === WorldTownScreenShop.ItemOwner.Stash);

        if (_owner === WorldTownScreenShop.ItemOwner.Stash) {
            this.updateStashFreeSlotsLabel();
        }
    }
};

WorldTownScreenShopDialogModule.prototype.destroyItemSlots = function (_itemArray, _itemContainer) {
    this.clearItemSlots(_itemArray);

    _itemContainer.empty();
    _itemArray.length = 0;
};

WorldTownScreenShopDialogModule.prototype.removeItemFromSlot = function (_slot) {
    // remove item image
    _slot.assignListItemImage();
    _slot.assignListItemOverlayImage();
    _slot.assignListItemTooltip();
};

WorldTownScreenShopDialogModule.prototype.assignItemToInventorySlot = function (_owner, _slot, _item) {
    var remove = false;

    if (!('id' in _item) || !('imagePath' in _item)) {
        remove = true;
    }

    if (remove === true) {
        this.removeItemFromSlot(_slot);
    }
    else {
        // update item data
        var itemData = _slot.data('item') || {};
        itemData.id = _item.id;
        itemData.slotType = _item.slot;
        itemData.isUsable = _item.isUsable;
        _slot.data('item', itemData);

        // assign image
        _slot.assignListItemImage(Path.ITEMS + _item['imagePath']);
        _slot.assignListItemOverlayImage(_item['imageOverlayPath'], _item);

        // show amount
        if (_item.showAmount === true && _item.amount != '') {
            _slot.assignListItemAmount('' + _item.amount, _item['amountColor']);
        }

        // show price
        if ('price' in _item && _item.price !== null) {
            _slot.assignListItemPrice(_item.price);
        }

        // bind tooltip
        _slot.assignListItemTooltip(itemData.id, _owner);
    }
};

WorldTownScreenShopDialogModule.prototype.querySlotByIndex = function (_itemArray, _index) {
    if (_itemArray === null || _itemArray.length === 0 || _index < 0 || _index >= _itemArray.length) {
        return null;
    }

    return _itemArray[_index];
};

WorldTownScreenShopDialogModule.prototype.createItemSlots = function (_owner, _size, _itemArray, _itemContainer) {
    var screen = $('.world-town-screen');
    for (var i = 0; i < _size; ++i) {
        _itemArray.push(this.createItemSlot(_owner, _itemArray.length, _itemContainer, screen));
    }
};

WorldTownScreenShopDialogModule.prototype.clearItemSlots = function (_itemArray) {
    if (_itemArray === null || _itemArray.length === 0) {
        return;
    }

    for (var i = 0; i < _itemArray.length; ++i) {
        // remove item image
        this.removeItemFromSlot(_itemArray[i]);
    }
};

WorldTownScreenShopDialogModule.prototype.createItemSlot = function (_owner, _index, _parentDiv, _screenDiv) {
    var self = this;

    var result = _parentDiv.createListItem(true);
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

        if (sourceOwner === WorldTownScreenShop.ItemOwner.Stash && targetOwner === WorldTownScreenShop.ItemOwner.Stash) {
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

            self.triggerSwapFlow(sourceItemIdx, sourceOwner, targetItemIdx, targetOwner, tryToUpgrade);
            return;
        }

        self.triggerSwapFlow(sourceItemIdx, sourceOwner, targetItemIdx, targetOwner, false);
    };

    var dragEndHandler = function (_source, _target) {
        if (_source.length === 0 || _target.length === 0) {
            return false;
        }

        var sourceData = _source.data('item');
        var targetData = _target.data('item');

        var sourceOwner = (sourceData !== null && 'owner' in sourceData) ? sourceData.owner : null;
        var targetOwner = (targetData !== null && 'owner' in targetData) ? targetData.owner : null;
        var itemIdx = (sourceData !== null && 'index' in sourceData) ? sourceData.index : null;

        if (sourceOwner === null || targetOwner === null) {
            console.error('Failed to drop item. Owner is invalid.');
            return false;
        }

        // we don't allow swapping within the shop container
        if (sourceOwner === WorldTownScreenShop.ItemOwner.Shop && targetOwner === WorldTownScreenShop.ItemOwner.Shop) {
            //console.error('Failed to swap item within shop container. Not allowed.');
            return false;
        }

        // we don't allow swapping if there is not enough money or space left
        if (sourceOwner === WorldTownScreenShop.ItemOwner.Shop) {
            return self.hasEnoughMoneyToBuy(itemIdx) && self.isStashSpaceLeft();
        }

        return true;
    };

    result.assignListItemDragAndDrop(_screenDiv, null, dragEndHandler, _owner === WorldTownScreenShop.ItemOwner.Stash ? dropHandler : null);

    result.assignListItemRightClick(function (_item, _event) {
        var data = _item.data('item');

        var isEmpty = (data !== null && 'isEmpty' in data) ? data.isEmpty : true;
        var owner = (data !== null && 'owner' in data) ? data.owner : null;
        //var itemId = (data !== null && 'id' in data) ? data.id : null;
        var itemIdx = (data !== null && 'index' in data) ? data.index : null;
        var destroyItem = false;
        var repairItem = KeyModiferConstants.AltKey in _event && _event[KeyModiferConstants.AltKey] === true;
        var removeUpgrades = (KeyModiferConstants.ShiftKey in _event && _event[KeyModiferConstants.ShiftKey] === true && ("isUsable" in data && data.isUsable === false));

        if (/*doSomething &&*/ isEmpty === false && owner !== null /*&& itemId !== null*/ && itemIdx !== null) {
            // buy, remove upgrades, sell or destroy
            switch (owner) {
                case WorldTownScreenShop.ItemOwner.Stash:
                    {
                        if (removeUpgrades === true) {
                            self.notifyBackendRemoveInventoryItemUpgrades(itemIdx);
                        }
                        else if (repairItem === true) {
                            //console.info('destroy');
                            self.repairItem(itemIdx);
                        }
                        else {
                            //console.info('sell');
                            self.triggerSwapFlow(itemIdx, owner, null, WorldTownScreenShop.ItemOwner.Shop, false);
                        }
                    } break;
                case WorldTownScreenShop.ItemOwner.Shop:
                    {
                        if (destroyItem !== true) {
                        //console.info('buy');
                        /*if(*/self.triggerSwapFlow(itemIdx, owner, null, WorldTownScreenShop.ItemOwner.Stash, false);//))
                            // 						{
                            // 							var slot = self.querySlotByIndex(self.mShopSlots, data.index);
                            // 							slot.assignListItemImage();
                            // 						}
                        }
                    } break;
            }
        }
    });

    return result;
};

WorldTownScreenShopDialogModule.prototype.repairItem = function (_itemIdx) {
    var self = this;
    this.notifyBackendRepairItem(_itemIdx, function (_result) {
        if (_result.Item != null) {
            self.updateSlotItem(WorldTownScreenShop.ItemOwner.Stash, self.mStashSlots, _result.Item, _itemIdx, WorldTownScreenShop.ItemFlag.Updated);
        }

        self.mParent.loadAssetData(_result.Assets);
    });
}

WorldTownScreenShopDialogModule.prototype.triggerSwapFlow = function (_sourceItemIdx, _sourceItemOwner, _targetItemIdx, _targetItemOwner, _tryToUpgrade) {
    var self = this;
    this.notifyBackendCanSwapItem(_sourceItemIdx, _sourceItemOwner, _targetItemIdx, _targetItemOwner, _tryToUpgrade, function (data) {
        if (data === undefined || data == null || typeof (data) !== 'object') {
            console.error("ERROR: Item not swappable. Reason: Invalid data result.");
            return;
        }

        if (data.Result == ResponseCode.CanSwap) {
            self.swapItem(_sourceItemIdx, _sourceItemOwner, _targetItemIdx, _targetItemOwner, _tryToUpgrade);
        }
        else {
            var callbackOnConfirm = function () { self.swapItem(_sourceItemIdx, _sourceItemOwner, _targetItemIdx, _targetItemOwner, _tryToUpgrade); }
            self.showSwapConfirmationDialog(data.Item, self.getSwapConfirmationOptionsFromResult(data.Result), callbackOnConfirm);
        }
    })
}

WorldTownScreenShopDialogModule.prototype.swapItem = function (_sourceItemIdx, _sourceItemOwner, _targetItemIdx, _targetItemOwner, _tryToUpgrade) {
    var self = this;
    this.notifyBackendSwapItem(_sourceItemIdx, _sourceItemOwner, _targetItemIdx, _targetItemOwner, _tryToUpgrade, function (data) {
        if (data === undefined || data == null || typeof (data) !== 'object') {
            console.error("ERROR: Failed to swap item. Reason: Invalid data result.");
            return;
        }

        // error?
        if (data.Result != 0) {
            if (data.Result == ErrorCode.NotEnoughMoney) {
                self.mAssets.mMoneyAsset.shakeLeftRight();
            }
            else if (data.Result == ErrorCode.NotEnoughStashSpace) {
                self.mStashSlotSizeContainer.shakeLeftRight();
            }
            else {
                //console.error("Failed to swap item. Reason: Unknown");
            }

            return;
        }

        // update assets
        self.mParent.loadAssetData(data.Assets);

        if ('StashSpaceUsed' in data) {
            self.mStashSpaceUsed = data.StashSpaceUsed;
        }

        if ('StashSpaceMax' in data) {
            self.mStashSpaceMax = data.StashSpaceMax;
        }

        if ('Stash' in data) {
            if (_tryToUpgrade === true) {
                data.Stash.forceUpdate = _targetItemIdx;
            }
            self.updateStashList(data.Stash);
        }

        if ('Shop' in data) {
            self.updateShopList(data.Shop);
        }
    });
};

WorldTownScreenShopDialogModule.prototype.updateStashList = function (_data) {
    if (this.mStashList === null || !jQuery.isArray(this.mStashList) || this.mStashList.length === 0) {
        this.loadStashData(_data);
        return;
    }

    // stash size changed (shouldn't happen)
    if (this.mStashList.length !== _data.length) {
        console.error('ERROR: Failed to update stash. Stash changed in size.');
        return;
    }

    var forceUpdateSlot = -1;
    if (_data["forceUpdate"] != null) {
        forceUpdateSlot = _data["forceUpdate"]
    }

    // check stash for changes
    for (var i = 0; i < this.mStashList.length; ++i) {
        var sourceItem = this.mStashList[i];
        var targetItem = _data[i];
        // item added to stash slot
        if (sourceItem === null && targetItem !== null) {
            if ('id' in targetItem) {
                //console.info('STASH: Item inserted (Index: ' + i + ')');
                this.mStashList[i] = targetItem;
                this.updateSlotItem(WorldTownScreenShop.ItemOwner.Stash, this.mStashSlots, targetItem, i, WorldTownScreenShop.ItemFlag.Inserted);
            }
        }

        // item removed from stash slot
        else if (sourceItem !== null && targetItem === null) {
            //console.info('STASH: Item removed (Index: ' + i + ')');
            this.mStashList[i] = targetItem;
            this.updateSlotItem(WorldTownScreenShop.ItemOwner.Stash, this.mStashSlots, targetItem, i, WorldTownScreenShop.ItemFlag.Removed);
        }
        else if (i == forceUpdateSlot) {
            this.updateSlotItem(WorldTownScreenShop.ItemOwner.Stash, this.mStashSlots, targetItem, i, WorldTownScreenShop.ItemFlag.Updated);
        }
        // item might have changed within stash slot
        else {
            if ((sourceItem !== null && targetItem !== null) && ('id' in sourceItem && 'id' in targetItem) && (sourceItem.id !== targetItem.id)) {
                //console.info('STASH: Item updated (Index: ' + i + ')');
                this.mStashList[i] = targetItem;
                this.updateSlotItem(WorldTownScreenShop.ItemOwner.Stash, this.mStashSlots, targetItem, i, WorldTownScreenShop.ItemFlag.Updated);
            }
        }
    }
};

WorldTownScreenShopDialogModule.prototype.updateShopList = function (_data) {
    if (this.mShopList === null || !jQuery.isArray(this.mShopList) || this.mShopList.length === 0) {
        this.loadShopData(_data);
        return;
    }

    // shop list changed in length, this means we removed or added something to / from stash
    //     if(this.mShopList.length !== _data.length)
    //     {
    //         this.loadShopData(_data);
    //         return;
    //     }

    // create more slots?
    if (_data.length > this.mShopSlots.length) {
        this.createItemSlots(WorldTownScreenShop.ItemOwner.Shop, _data.length - this.mShopSlots.length, this.mShopSlots, this.mShopListScrollContainer);
    }

    // check shop for changes
    var maxLength = this.mShopList.length >= _data.length ? this.mShopList.length : _data.length;

    for (var i = 0; i < maxLength; ++i) {
        var oldItem = this.mShopList[i];
        var newItem = _data[i];

        // item added to shop slot
        if (i >= this.mShopList.length || (oldItem === null && newItem !== null)) {
            //console.info('SHOP: Item inserted (Index: ' + i + ')');
            this.updateSlotItem(WorldTownScreenShop.ItemOwner.Shop, this.mShopSlots, newItem, i, WorldTownScreenShop.ItemFlag.Inserted);
        }

        // item removed from shop slot
        else if (i >= _data.length || (oldItem !== null && newItem === null)) {
            //console.info('SHOP: Item removed (Index: ' + i + ')');
            this.updateSlotItem(WorldTownScreenShop.ItemOwner.Shop, this.mShopSlots, oldItem, i, WorldTownScreenShop.ItemFlag.Removed);
        }

        // item might have changed within shop slot
        else {
            if ((oldItem !== null && newItem !== null) && ('id' in oldItem && 'id' in newItem)) {
                if (oldItem.id !== newItem.id) {
                    //console.info('SHOP: Item updated (Index: ' + i + ')');
                    this.updateSlotItem(WorldTownScreenShop.ItemOwner.Shop, this.mShopSlots, newItem, i, WorldTownScreenShop.ItemFlag.Updated);
                }
                else {
                    this.updateItemPriceLabel(this.mShopSlots[i], newItem, false);
                }
            }
        }
    }

    // update list
    this.mShopList = _data;
};

WorldTownScreenShopDialogModule.prototype.updateItemPriceLabel = function (_slot, _item, _positiveColor) {
    var positiveColor = _positiveColor || false;
    var currentMoney = this.mAssets.getValues().Money;

    if (_item !== null) {
        if ('price' in _item && _item.price !== null) {
            _slot.assignListItemPriceColor(positiveColor || currentMoney >= _item.price);
        }
    }
};

WorldTownScreenShopDialogModule.prototype.updateItemPriceLabels = function (_itemArray, _items, _allPositiveColors) {
    if (_items == null || _itemArray == null) {
        return;
    }

    var allPositiveColors = _allPositiveColors || false;
    var currentMoney = this.mAssets.getValues().Money;

    for (var i = 0; i < _items.length; ++i) {
        // ignore empty slots
        if (_items[i] !== null) {
            var item = _items[i];

            if ('price' in item && item.price !== null) {
                _itemArray[i].assignListItemPriceColor(allPositiveColors || currentMoney >= item.price);
            }
        }
    }
};

WorldTownScreenShopDialogModule.prototype.updateSlotItem = function (_owner, _itemArray, _item, _index, _flag) {
    var slot = this.querySlotByIndex(_itemArray, _index);
    if (slot === null) {
        console.error('ERROR: Failed to update slot item: Reason: Invalid slot index: ' + _index);
        return;
    }

    switch (_flag) {
        case WorldTownScreenShop.ItemFlag.Inserted:
        case WorldTownScreenShop.ItemFlag.Updated:
            {
                this.removeItemFromSlot(slot);
                this.assignItemToInventorySlot(_owner, slot, _item);
                this.updateItemPriceLabel(slot, _item, _owner === WorldTownScreenShop.ItemOwner.Stash);
                break;
            }
        case WorldTownScreenShop.ItemFlag.Removed:
            {
                this.removeItemFromSlot(slot);
                break;
            }
    }

    if (_owner === WorldTownScreenShop.ItemOwner.Stash) {
        this.updateStashFreeSlotsLabel();
    }
};

WorldTownScreenShopDialogModule.prototype.updateStashFreeSlotsLabel = function () {
    var statistics = this.getStashStatistics();
    this.mStashSlotSizeLabel.html('' + statistics.used + '/' + statistics.size);

    if (statistics.used >= statistics.size) {
        this.mStashSlotSizeLabel.removeClass('font-color-value').addClass('font-color-negative-value');
    }
    else {
        this.mStashSlotSizeLabel.removeClass('font-color-negative-value').addClass('font-color-value');
    }
};

WorldTownScreenShopDialogModule.prototype.hasEnoughMoneyToBuy = function (_itemIdx) {
    if (_itemIdx >= 0 && _itemIdx < this.mShopList.length) {
        var item = this.mShopList[_itemIdx];

        if (item !== null && 'price' in item && item.price !== null) {
            return this.mAssets.getValues().Money >= item.price;
        }
    }

    return false;
};

WorldTownScreenShopDialogModule.prototype.isStashSpaceLeft = function () {
    for (var i = 0; i < this.mStashList.length; ++i) {
        if (this.mStashList[i] === null)
            return true;
    }

    return false;
};

WorldTownScreenShopDialogModule.prototype.getStashStatistics = function () {
    /*var usedSpace = 0;

    for(var i = 0; i < this.mStashList.length; ++i)
    {
        if (this.mStashList[i] !== null)
            ++usedSpace;
    }*/

    return { size: this.mStashSpaceMax, used: this.mStashSpaceUsed };
};

WorldTownScreenShopDialogModule.prototype.getSwapConfirmationOptionsFromResult = function (_result) {
    var text = '';
    var confirmable = true;
    var prompt = 'Are you sure?';

    switch (_result) {
        case ResponseCode.ConfirmReplaceSwap:
            {
                text = 'This item may not be acquirable later if you sell it.';
                break;
            }
        case ResponseCode.ConfirmNoReplaceSwap:
            {
                text = 'This item is unique and can\'t be acquired again later!';
                break;
            }
        case ResponseCode.DoNotSwap:
            {
                prompt = 'Not sellable.'
                text = 'This item cannot be sold.';
                confirmable = false;
            }
    }

    return { Prompt: prompt, Text: text, Confirmable: confirmable };
};

WorldTownScreenShopDialogModule.prototype.notifyBackendModuleShown = function () {
    SQ.call(this.mSQHandle, 'onModuleShown');
};

WorldTownScreenShopDialogModule.prototype.notifyBackendModuleHidden = function () {
    SQ.call(this.mSQHandle, 'onModuleHidden');
};

WorldTownScreenShopDialogModule.prototype.notifyBackendModuleAnimating = function () {
    SQ.call(this.mSQHandle, 'onModuleAnimating');
};

WorldTownScreenShopDialogModule.prototype.notifyBackendLeaveButtonPressed = function () {
    SQ.call(this.mSQHandle, 'onLeaveButtonPressed');
};

WorldTownScreenShopDialogModule.prototype.notifyBackendRepairItem = function (_itemIdx, _callback) {
    SQ.call(this.mSQHandle, 'onRepairItem', _itemIdx, _callback);
};


WorldTownScreenShopDialogModule.prototype.notifyBackendCanSwapItem = function (_sourceItemIdx, _sourceItemOwner, _targetItemIdx, _targetItemOwner, _tryToUpgrade, _callback) {
    SQ.call(this.mSQHandle, 'onCanSwapItem', [_sourceItemIdx, _sourceItemOwner, _targetItemIdx, _targetItemOwner], _callback);
};

WorldTownScreenShopDialogModule.prototype.notifyBackendSwapItem = function (_sourceItemIdx, _sourceItemOwner, _targetItemIdx, _targetItemOwner, _tryToUpgrade, _callback) {
    SQ.call(this.mSQHandle, 'onSwapItem', [_sourceItemIdx, _sourceItemOwner, _targetItemIdx, _targetItemOwner, _tryToUpgrade], _callback);
};


WorldTownScreenShopDialogModule.prototype.notifyBackendSortButtonClicked = function () {
    SQ.call(this.mSQHandle, 'onSortButtonClicked');
}

WorldTownScreenShopDialogModule.prototype.notifyBackendFilterAllButtonClicked = function () {
    SQ.call(this.mSQHandle, 'onFilterAll');
};

WorldTownScreenShopDialogModule.prototype.notifyBackendFilterWeaponsButtonClicked = function () {
    SQ.call(this.mSQHandle, 'onFilterWeapons');
};

WorldTownScreenShopDialogModule.prototype.notifyBackendFilterArmorButtonClicked = function () {
    SQ.call(this.mSQHandle, 'onFilterArmor');
};

WorldTownScreenShopDialogModule.prototype.notifyBackendFilterMiscButtonClicked = function () {
    SQ.call(this.mSQHandle, 'onFilterMisc');
};

WorldTownScreenShopDialogModule.prototype.notifyBackendFilterUsableButtonClicked = function () {
    SQ.call(this.mSQHandle, 'onFilterUsable');
};

WorldTownScreenShopDialogModule.prototype.notifyBackendRemoveInventoryItemUpgrades = function (_slot) {
    var self = this;
    SQ.call(this.mSQHandle, 'removeInventoryItemUpgrades', [_slot], function (data) {
        if (data === undefined || data == null || typeof (data) !== 'object') {
            console.error('ERROR: Failed to drop paperdoll item into bag. Invalid data result.');
            return;
        }

        if ('stashSpaceUsed' in data) {
            self.mStashSpaceUsed = data.stashSpaceUsed;
        }

        if ('stashSpaceMax' in data) {
            self.mStashSpaceMax = data.stashSpaceMax;
        }

        if ('stash' in data) {
            if (data.stash !== null && jQuery.isArray(data.stash)) {
                data.stash.forceUpdate = _slot;
                self.updateStashList(data.stash);
            }
        }
    });
};