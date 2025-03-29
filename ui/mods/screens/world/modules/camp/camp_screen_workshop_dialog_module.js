
"use strict";


var WorkshopScreenShop =
{
	ItemOwner:
	{
		Stash: 'camp-screen-workshop-dialog-module.stash',
		Shop: 'camp-screen-workshop-dialog-module.shop'
	},

	ItemFlag:
	{
		Inserted: 0,
		Removed: 1,
		Updated: 2
	}
};

var CampScreenWorkshopDialogModule = function(_parent)
{
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
	this.mAssetValues = null;
	this.mSuppliesAsset = null;
	this.mRequiredAsset = null;
	this.mTimeAsset = null;
	this.mBrothersAsset	= null;

	// buttons
	this.mLeaveButton = null;

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
	//this.mFilterBroButton = null;
	this.mFilterWeaponsButton = null;
	this.mFilterArmorButton = null;
	this.mAssignAllButton = null;
	this.mRemoveAllButton = null;

	this.mIsRepairOffered = false;

	// generics
	this.mIsVisible = false;
};


CampScreenWorkshopDialogModule.prototype.isConnected = function ()
{
	return this.mSQHandle !== null;
};

CampScreenWorkshopDialogModule.prototype.onConnection = function (_handle)
{
	//if (typeof(_handle) == 'string')
	{
		this.mSQHandle = _handle;

		// notify listener
		if (this.mEventListener !== null && ('onModuleOnConnectionCalled' in this.mEventListener))
		{
			this.mEventListener.onModuleOnConnectionCalled(this);
		}
	}
};

CampScreenWorkshopDialogModule.prototype.onDisconnection = function ()
{
	this.mSQHandle = null;

	// notify listener
	if (this.mEventListener !== null && ('onModuleOnDisconnectionCalled' in this.mEventListener))
	{
		this.mEventListener.onModuleOnDisconnectionCalled(this);
	}
};


CampScreenWorkshopDialogModule.prototype.updateAssetValue = function (_container, _value, _valueMax, _valueDifference, _negative)
{
	var label = _container.find('.label:first');

	if(label.length > 0)
	{
		if(_valueMax !== undefined && _valueMax !== null)
		{
			label.html('' + Helper.numberWithCommas(_value) + '/' + Helper.numberWithCommas(_valueMax));
		}
		else
		{
			label.html(Helper.numberWithCommas(_value));
		}

		if(_valueDifference !== null && _valueDifference !== 0)
		{
			label.animateValueAndFadeOut(_valueDifference < 0, function (_element)
			{
				_element.html(_valueDifference);
			});
		}

		if(_value <= 0 || _negative)
		{
			label.removeClass('font-color-assets-positive-value').addClass('font-color-assets-negative-value');
		}
		else
		{
			label.removeClass('font-color-assets-negative-value').addClass('font-color-assets-positive-value');
		}
	}
};

CampScreenWorkshopDialogModule.prototype.updateAssets = function (_data)
{
	if(_data === undefined || _data === null || !(typeof(_data) === 'object'))
	{
		return;
	}

	var value = null;
	var previousValue = null;
	var valueDifference = null;
	var currentAssetInformation = _data;
	var previousAssetInformation = this.mAssetValues;
	
	if('Supplies' in currentAssetInformation && 'SuppliesMax' in currentAssetInformation &&
		currentAssetInformation['Supplies'] !== null && currentAssetInformation['SuppliesMax'] !== null)
	{

		value = currentAssetInformation['Supplies'];
		var maxValue = currentAssetInformation['SuppliesMax'];
		valueDifference = null;
		if(previousAssetInformation !== null && 'Supplies' in previousAssetInformation && previousAssetInformation['Supplies'] !== null)
		{
			previousValue = previousAssetInformation['Supplies'];
			valueDifference = value - previousValue;
		}
		this.updateAssetValue(this.mSuppliesAsset, value, maxValue, valueDifference);
	}

	if('SuppliesRequired' in currentAssetInformation && currentAssetInformation['SuppliesRequired'] !== null)
	{
		value = currentAssetInformation['SuppliesRequired'];
		valueDifference = null;
		if(previousAssetInformation !== null && 'SuppliesRequired' in previousAssetInformation && previousAssetInformation['SuppliesRequired'] !== null)
		{
			previousValue = previousAssetInformation['SuppliesRequired'];
			valueDifference = value - previousValue;
		}
		
		this.updateAssetValue(this.mRequiredAsset, value, null, valueDifference);
	}
	
	if('Time' in currentAssetInformation && currentAssetInformation['Time'] !== null)
	{
		value = currentAssetInformation['Time'];
		valueDifference = null;
		if(previousAssetInformation !== null && 'Time' in previousAssetInformation && previousAssetInformation['Time'] !== null)
		{
			previousValue = previousAssetInformation['Time'];
			valueDifference = value - previousValue;
		}
		this.updateAssetValue(this.mTimeAsset, value, null, valueDifference);
	}

	if('Brothers' in currentAssetInformation && currentAssetInformation['Brothers'] !== null)
	{
		value = currentAssetInformation['Brothers'];
		valueDifference = null;
		if(previousAssetInformation !== null && 'Brothers' in previousAssetInformation && previousAssetInformation['Brothers'] !== null)
		{
			previousValue = previousAssetInformation['Brothers'];
			valueDifference = value - previousValue;
		}
		this.updateAssetValue(this.mBrothersAsset, value, null, valueDifference);
	}

	this.mAssetValues = currentAssetInformation;

}

CampScreenWorkshopDialogModule.prototype.createAssetDIV = function (_parentDiv, _imagePath, _classExtra)
{
	var layout = $('<div class="l-tab-asset"/>');
	layout.addClass(_classExtra);
	_parentDiv.append(layout);

	var image = $('<img/>');
	image.attr('src', _imagePath);
	layout.append(image);
	var text = $('<div class="label text-font-normal font-color-assets-positive-value"/>');
	layout.append(text);

	return layout;
};

CampScreenWorkshopDialogModule.prototype.createImageButton = function (_parentDiv, _imagePath, _callback)
{
	var layout = $('<div class="l-assets-container"/>');
	var image = $('<img/>');
	image.attr('src', _imagePath);
	layout.append(image);
	var text = $('<div class="label text-font-small font-bold font-bottom-shadow font-color-assets-positive-value"/>');
	layout.append(text);

	if (_callback === undefined)
	{
		_parentDiv.append(layout);
		return layout;
	}
	else
	{
		return _parentDiv.createCustomButton(layout, _callback, '', 2);
	}
};

CampScreenWorkshopDialogModule.prototype.createDIV = function (_parentDiv)
{
	var self = this;


	// create: containers (init hidden!)
	this.mContainer = $('<div class="l-workshop-dialog-container display-none opacity-none"/>');
	_parentDiv.append(this.mContainer);
	this.mDialogContainer = this.mContainer.createDialog('', '', '', true, 'dialog-1024-768');

	// create tabs
	var tabButtonsContainer = $('<div class="l-tab-container"/>');
	this.mDialogContainer.findDialogTabContainer().append(tabButtonsContainer);
	
	//create assets
	this.mSuppliesAsset = this.createAssetDIV(tabButtonsContainer, Path.GFX + Asset.ICON_ASSET_SUPPLIES, 'is-supplies');
	this.mRequiredAsset = this.createAssetDIV(tabButtonsContainer, Path.GFX + 'ui/buttons/asset_supplies_up.png', 'is-num-required');
	this.mTimeAsset = this.createAssetDIV(tabButtonsContainer, Path.GFX + 'ui/buttons/icon_time.png', 'is-time-required');
	var assetContainer = $('<div class="l-tab-asset is-brothers"></div>');
	this.mBrothersAsset = this.createImageButton(assetContainer, Path.GFX + Asset.ICON_ASSET_BROTHERS, function()
	{
		self.notifyBackendBrothersButtonPressed();
	});
	tabButtonsContainer.append(assetContainer);

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
	this.mSortInventoryButton = layout.createImageButton(Path.GFX + Asset.BUTTON_SORT, function()
	{
		self.notifyBackendSortButtonClicked();
	}, '', 3);

	var layout = $('<div class="l-button is-all-filter"/>');
	buttonContainer.append(layout);
	this.mFilterAllButton = layout.createImageButton(Path.GFX + Asset.BUTTON_ALL_FILTER, function()
	{
		self.mFilterAllButton.addClass('is-active');
		self.mFilterWeaponsButton.removeClass('is-active');
		self.mFilterArmorButton.removeClass('is-active');
		//self.mFilterBroButton.removeClass('is-active');
		self.notifyBackendFilterAllButtonClicked();
	}, '', 3);
	self.mFilterAllButton.addClass('is-active');

	var layout = $('<div class="l-button is-weapons-filter"/>');
	buttonContainer.append(layout);
	this.mFilterWeaponsButton = layout.createImageButton(Path.GFX + 'ui/buttons/icon_weapons.png', function()
	{
		self.mFilterAllButton.removeClass('is-active');
		self.mFilterWeaponsButton.addClass('is-active');
		self.mFilterArmorButton.removeClass('is-active');
		//self.mFilterBroButton.removeClass('is-active');
		self.notifyBackendFilterWeaponsButtonClicked();
	}, '', 3);

	var layout = $('<div class="l-button is-armor-filter"/>');
	buttonContainer.append(layout);
	this.mFilterArmorButton = layout.createImageButton(Path.GFX + 'ui/buttons/icon_armor.png', function()
	{
		self.mFilterAllButton.removeClass('is-active');
		self.mFilterWeaponsButton.removeClass('is-active');
		self.mFilterArmorButton.addClass('is-active');
		//self.mFilterBroButton.removeClass('is-active');
		self.notifyBackendFilterArmorButtonClicked();
	}, '', 3);

	var layout = $('<div class="l-button is-assign-all"/>');
	buttonContainer.append(layout);
	this.mAssignAllButton = layout.createImageButton(Path.GFX + 'ui/buttons/arrow_right.png', function()
	{
		self.notifyBackendAssignAllButtonClicked();
	}, '', 3);

	var layout = $('<div class="l-button is-remove-all"/>');
	buttonContainer.append(layout);
	this.mRemoveAllButton = layout.createImageButton(Path.GFX + 'ui/buttons/arrow_left.png', function ()
	{
		self.notifyBackendRemoveAllButtonClicked();
	}, '', 3);

	// create shop loot
	var rightColumn = $('<div class="column is-right"/>');
	content.append(rightColumn);
	headerRow = $('<div class="row is-header title-font-normal font-bold font-color-title">Salvage</div>');
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
	this.mLeaveButton = layout.createTextButton("Leave", function()
	{
		self.notifyBackendLeaveButtonPressed();
	}, '', 1);

	this.mIsVisible = false;

	this.setupEventHandler();
};

CampScreenWorkshopDialogModule.prototype.destroyDIV = function ()
{
	this.mStashSlots = null;
	this.mShopSlots = null;

	// lists
	this.mStashList = null;
	this.mShopList = null;

	this.mStashListContainer.destroyList();
	this.mStashListScrollContainer = null;
	this.mStashListContainer = null;

	this.mShopListContainer.destroyList();
	this.mShopListScrollContainer = null;
	this.mShopListContainer = null;

	this.mSuppliesAsset.remove();
	this.mSuppliesAsset = null;
	this.mRequiredAsset.remove();
	this.mRequiredAsset = null;
	this.mTimeAsset.remove();
	this.mTimeAsset = null;
	this.mBrothersAsset.remove();
	this.mBrothersAsset = null;

	this.mLeaveButton.remove();
	this.mLeaveButton = null;

	this.mDialogContainer.empty();
	this.mDialogContainer.remove();
	this.mDialogContainer = null;

	this.mContainer.empty();
	this.mContainer.remove();
	this.mContainer = null;
};

CampScreenWorkshopDialogModule.prototype.setupEventHandler = function ()
{
	var self = this;

	/*
	var dropStartHandler = function () {
		$(this).addClass("is-drop-target");
	};
	var dropEndHandler = function () {
		$(this).removeClass("is-drop-target");
	};
	*/

	var dropHandler = function (ev, dd)
	{
		var drag = $(dd.drag);
		var drop = $(dd.drop);

		// do the swapping
		var sourceData = drag.data('item') || {};
		var targetData = drop.data('item') || {};

		var sourceOwner = (sourceData !== null && 'owner' in sourceData) ? sourceData.owner : null;
		var targetOwner = (targetData !== null && 'owner' in targetData) ? targetData.owner : null;

		if(sourceOwner === null || targetOwner === null)
		{
			console.error('Failed to drop item. Owner are invalid.');
			return;
		}

		var sourceItemIdx = (sourceData !== null && 'index' in sourceData) ? sourceData.index : null;
		var targetItemIdx = (targetData !== null && 'index' in targetData) ? targetData.index : null;

		if(sourceItemIdx === null)
		{
			console.error('Failed to drop item. Source idx is invalid.');
			return;
		}

		self.swapItem(sourceItemIdx, sourceOwner, targetItemIdx, targetOwner);

		// workaround if the source container was removed before we got here
		if(drag.parent().length === 0)
		{
			$(dd.proxy).remove();
		}
		else
		{
			drag.removeClass('is-dragged');
		}
	};

	// create drop handler for the stash & shop container
	$.drop({ mode: 'middle' });

	this.mStashListContainer.data('item', { owner: WorkshopScreenShop.ItemOwner.Stash });
	//this.mStashListContainer.drop('start', dropStartHandler);
	this.mStashListContainer.drop(dropHandler);
	//this.mStashListContainer.drop('end', dropEndHandler);

	this.mShopListContainer.data('item', { owner: WorkshopScreenShop.ItemOwner.Shop });
	//this.mShopListContainer.drop('start', dropStartHandler);
	this.mShopListContainer.drop(dropHandler);
	//this.mShopListContainer.drop('end', dropEndHandler);
};


CampScreenWorkshopDialogModule.prototype.bindTooltips = function ()
{
	this.mLeaveButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.WorldTownScreen.ShopDialogModule.LeaveButton });

	this.mSortInventoryButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterScreen.RightPanelHeaderModule.SortButton });
	this.mFilterAllButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterScreen.RightPanelHeaderModule.FilterAllButton });
	//this.mFilterBroButton.bindTooltip({ contentType: 'ui-element', elementId: 'camp-screen.repair.filterbro.button' });
	this.mFilterWeaponsButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterScreen.RightPanelHeaderModule.FilterWeaponsButton });
	this.mFilterArmorButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterScreen.RightPanelHeaderModule.FilterArmorButton });
	this.mAssignAllButton.bindTooltip({ contentType: 'ui-element', elementId: 'camp-screen.workshop.assignall.button' });
	this.mRemoveAllButton.bindTooltip({ contentType: 'ui-element', elementId: 'camp-screen.workshop.removeall.button' });

	this.mRequiredAsset.bindTooltip({ contentType: 'ui-element', elementId: 'workshop.Required' });
	this.mSuppliesAsset.bindTooltip({ contentType: 'ui-element', elementId: 'repairs.Supplies' });
	this.mTimeAsset.bindTooltip({ contentType: 'ui-element', elementId:  'workshop.Time' });
	this.mBrothersAsset.bindTooltip({ contentType: 'ui-element', elementId: 'workshop.Bros' });	
};

CampScreenWorkshopDialogModule.prototype.unbindTooltips = function ()
{
	this.mLeaveButton.unbindTooltip();

	this.mSortInventoryButton.unbindTooltip();
	this.mFilterAllButton.unbindTooltip();
	//this.mFilterBroButton.unbindTooltip();
	this.mFilterWeaponsButton.unbindTooltip();
	this.mFilterArmorButton.unbindTooltip();
	this.mAssignAllButton.unbindTooltip();
	this.mRemoveAllButton.unbindTooltip();

	this.mRequiredAsset.unbindTooltip();
	this.mSuppliesAsset.unbindTooltip();
	this.mTimeAsset.unbindTooltip();
	this.mBrothersAsset.unbindTooltip();
};

CampScreenWorkshopDialogModule.prototype.create = function(_parentDiv)
{
	this.createDIV(_parentDiv);
	this.bindTooltips();
};

CampScreenWorkshopDialogModule.prototype.destroy = function()
{
	this.unbindTooltips();
	this.destroyDIV();
};


CampScreenWorkshopDialogModule.prototype.register = function (_parentDiv)
{
	console.log('CampScreenWorkshopDialogModule::REGISTER');

	if (this.mContainer !== null)
	{
		console.error('ERROR: Failed to register World Town Screen Hire Dialog Module. Reason: World Town Screen Hire Dialog Module is already initialized.');
		return;
	}

	if (_parentDiv !== null && typeof(_parentDiv) == 'object')
	{
		this.create(_parentDiv);
	}
};

CampScreenWorkshopDialogModule.prototype.unregister = function ()
{
	console.log('CampScreenWorkshopDialogModule::UNREGISTER');

	if (this.mContainer === null)
	{
		console.error('ERROR: Failed to unregister World Town Screen Hire Dialog Module. Reason: World Town Screen Hire Dialog Module is not initialized.');
		return;
	}

	this.destroy();
};

CampScreenWorkshopDialogModule.prototype.isRegistered = function ()
{
	if (this.mContainer !== null)
	{
		return this.mContainer.parent().length !== 0;
	}

	return false;
};


CampScreenWorkshopDialogModule.prototype.registerEventListener = function(_listener)
{
	this.mEventListener = _listener;
};


CampScreenWorkshopDialogModule.prototype.show = function (_withSlideAnimation)
{
	var self = this;

	var withAnimation = (_withSlideAnimation !== undefined && _withSlideAnimation !== null) ? _withSlideAnimation : true;
	if (withAnimation === true)
	{
		var offset = -(this.mContainer.parent().width() + this.mContainer.width());
		this.mContainer.css({ 'left': offset });
		this.mContainer.velocity("finish", true).velocity({ opacity: 1, left: '0', right: '0' }, {
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
	else
	{
		this.mContainer.css({ opacity: 0 });
		this.mContainer.velocity("finish", true).velocity({ opacity: 1 }, {
			duration: Constants.SCREEN_FADE_IN_OUT_DELAY,
			easing: 'swing',
			begin: function() {
				$(this).removeClass('display-none').addClass('display-block');
				self.notifyBackendModuleAnimating();
			},
			complete: function() {
				self.mIsVisible = true;
				self.notifyBackendModuleShown();
			}
		});
	}
};

CampScreenWorkshopDialogModule.prototype.hide = function ()
{
	var self = this;

	var offset = -(this.mContainer.parent().width() + this.mContainer.width());
	this.mContainer.velocity("finish", true).velocity({ opacity: 0, left: offset },
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
};

CampScreenWorkshopDialogModule.prototype.isVisible = function ()
{
	return this.mIsVisible;
};

CampScreenWorkshopDialogModule.prototype.loadFromData = function (_data)
{
	if(_data === undefined || _data === null || !(typeof(_data) === 'object'))
	{
		return;
	}

	if ('Assets' in _data)
	{
		this.updateAssets(_data.Assets);
	}

	if('Title' in _data && _data.Title !== null)
	{
		 this.mDialogContainer.findDialogTitle().html(_data.Title);
	}

	if('SubTitle' in _data && _data.SubTitle !== null)
	{
		 this.mDialogContainer.findDialogSubTitle().html(_data.SubTitle);
	}
	
	if('Stash' in _data && _data.Stash !== null)
	{
		this.loadStashData(_data.Stash, _data.Capacity);
	}

	if('Repairs' in _data && _data.Repairs !== null)
	{
		this.loadShopData(_data.Repairs, _data.Capacity);
	}
};

CampScreenWorkshopDialogModule.prototype.loadStashData = function (_data, _capacity)
{
	if(_data === undefined || _data === null || !jQuery.isArray(_data))
	{
		return;
	}

	this.mStashList = _data;

	if(this.mStashSlots === null)
	{
		this.mStashSlots = [];
	}

	// call by ref hack
	var arrayRef = { val: this.mStashSlots };
	var containerRef = { val: this.mStashListScrollContainer };

	this.assignItems(WorkshopScreenShop.ItemOwner.Stash, _data, _capacity, arrayRef.val, containerRef.val);
};

CampScreenWorkshopDialogModule.prototype.loadShopData = function (_data, _capacity)
{
	if(_data === undefined || _data === null || !jQuery.isArray(_data))
	{
		return;
	}

	this.mShopList = _data;

	if(this.mShopSlots === null)
	{
		this.mShopSlots = [];
	}

	// call by ref hack
	var arrayRef = { val: this.mShopSlots };
	var containerRef = { val: this.mShopListScrollContainer };

	this.assignItems(WorkshopScreenShop.ItemOwner.Shop, _data, _capacity, arrayRef.val, containerRef.val);
};

CampScreenWorkshopDialogModule.prototype.querySlotByIndex = function(_itemArray, _index)
{
	if(_itemArray === null || _itemArray.length === 0 || _index < 0 || _index >= _itemArray.length)
	{
		return null;
	}

	return _itemArray[_index];
};

CampScreenWorkshopDialogModule.prototype.assignItemToSlot = function(_owner, _slot, _item)
{
	var remove = false;

	if(!('id' in _item) || !('imagePath' in _item))
	{
		remove = true;
	}

	if(remove === true)
	{
		this.removeItemFromSlot(_slot);
	}
	else
	{
		// update item data
		var itemData = _slot.data('item') || {};
		itemData.id = _item.id;
		_slot.data('item', itemData);

		// assign image
		_slot.assignListItemImage(Path.ITEMS + _item.imagePath);
		_slot.assignListItemOverlayImage(_item['imageOverlayPath']);

		// show amount
		if(_item.showAmount === true && _item.amount != '')
		{
			_slot.assignListItemAmount('' + _item.amount, _item['amountColor']);
		}

		// show price
		if('price' in _item && _item.price !== null)
		{
			_slot.assignListItemPrice(_item.price);
		}

		// bind tooltip
		_slot.assignListItemTooltip(itemData.id, _owner);
	}
};

CampScreenWorkshopDialogModule.prototype.assignItems = function (_owner, _items, _capacity, _itemArray, _itemContainer)
{
	this.destroyItemSlots(_itemArray, _itemContainer);
	this.createItemSlots(_owner, _capacity, _itemArray, _itemContainer);
	if(_items.length > 0)
	{
		for(var i = 0; i < _items.length; ++i)
		{
			// ignore empty slots
			if(_items[i] !== undefined && _items[i] !== null)
			{
				this.assignItemToSlot(_owner, _itemArray[i], _items[i]);
			}
		}
		//this.updateItemPriceLabels(_itemArray, _items, _owner === WorkshopScreenShop.ItemOwner.Stash);
	}
};

CampScreenWorkshopDialogModule.prototype.clearItemSlots = function (_itemArray)
{
	if(_itemArray === null || _itemArray.length === 0)
	{
		return;
	}

	for(var i = 0; i < _itemArray.length; ++i)
	{
		// remove item image
		this.removeItemFromSlot(_itemArray[i]);
	}
};

CampScreenWorkshopDialogModule.prototype.removeItemFromSlot = function(_slot)
{
	// remove item image
	_slot.assignListItemImage();
	_slot.assignListItemOverlayImage();
	_slot.assignListItemTooltip();
};

CampScreenWorkshopDialogModule.prototype.createItemSlots = function (_owner, _size, _itemArray, _itemContainer)
{
	var screen = $('.camp-screen');
	for(var i = 0; i < _size; ++i)
	{
		_itemArray.push(this.createItemSlot(_owner, i, _itemContainer, screen));
	}
};

CampScreenWorkshopDialogModule.prototype.createItemSlot = function (_owner, _index, _parentDiv, _screenDiv)
{
	var self = this;

	var result = _parentDiv.createListItem(true);
	result.attr('id', 'slot-index_' + _index);

	// update item data
	var itemData = result.data('item') || {};
	itemData.index = _index;
	itemData.owner = _owner;
	result.data('item', itemData);

	// add event handler
	var dropHandler = function (_source, _target)
	{
		var sourceData = _source.data('item');
		var targetData = _target.data('item');

		var sourceOwner = (sourceData !== null && 'owner' in sourceData) ? sourceData.owner : null;
		var targetOwner = (targetData !== null && 'owner' in targetData) ? targetData.owner : null;

		if(sourceOwner === null || targetOwner === null)
		{
			console.error('Failed to drop item. Owner are invalid.');
			return;
		}

		var sourceItemIdx = (sourceData !== null && 'index' in sourceData) ? sourceData.index : null;
		var targetItemIdx = (targetData !== null && 'index' in targetData) ? targetData.index : null;

		if(sourceItemIdx === null)
		{
			console.error('Failed to drop item. Source idx is invalid.');
			return;
		}

		self.swapItem(sourceItemIdx, sourceOwner, targetItemIdx, targetOwner);
	};

	var dragEndHandler = function (_source, _target)
	{
		if(_source.length === 0 || _target.length === 0)
		{
			return false;
		}

		var sourceData = _source.data('item');
		var targetData = _target.data('item');

		var sourceOwner = (sourceData !== null && 'owner' in sourceData) ? sourceData.owner : null;
		var targetOwner = (targetData !== null && 'owner' in targetData) ? targetData.owner : null;
		var itemIdx = (sourceData !== null && 'index' in sourceData) ? sourceData.index : null;

		if(sourceOwner === null || targetOwner === null)
		{
			console.error('Failed to drop item. Owner is invalid.');
			return false;
		}

		return true;
	};

	result.assignListItemDragAndDrop(_screenDiv, null, dragEndHandler, dropHandler);

	result.assignListItemRightClick(function (_item, _event)
	{
		var data = _item.data('item');

		var isEmpty = (data !== null && 'isEmpty' in data) ? data.isEmpty : true;
		var owner = (data !== null && 'owner' in data) ? data.owner : null;
		//var itemId = (data !== null && 'id' in data) ? data.id : null;
		var itemIdx = (data !== null && 'index' in data) ? data.index : null;
		var destroyItem = false;
		var repairItem = KeyModiferConstants.AltKey in _event && _event[KeyModiferConstants.AltKey] === true;

		if(/*doSomething &&*/ isEmpty === false && owner !== null /*&& itemId !== null*/ && itemIdx !== null)
		{
			// buy, sell or destroy
			switch(owner)
			{
				case WorkshopScreenShop.ItemOwner.Stash:
					self.swapItem(itemIdx, owner, null, WorkshopScreenShop.ItemOwner.Shop);
					break;
				case WorkshopScreenShop.ItemOwner.Shop:
					self.swapItem(itemIdx, owner, null, WorkshopScreenShop.ItemOwner.Stash);
					break;
			}
		}
	});

	return result;
};

CampScreenWorkshopDialogModule.prototype.swapItem = function (_sourceItemIdx, _sourceItemOwner, _targetItemIdx, _targetItemOwner)
{
	var self = this;
	this.notifyBackendSwapItem(_sourceItemIdx, _sourceItemOwner, _targetItemIdx, _targetItemOwner, function (data)
	{
		if (data === undefined || data == null || typeof (data) !== 'object')
		{
			console.error("ERROR: Failed to swap item. Reason: Invalid data result.");
			return;
		}

		if ('Assets' in data)
		{
			self.updateAssets(data.Assets);
		}

		if ('Stash' in data)
		{
			self.updateStashList(data.Stash, data.Capacity);
		}

		if ('Repairs' in data)
		{
			self.updateShopList(data.Repairs, data.Capacity);
		}
	});
};

CampScreenWorkshopDialogModule.prototype.updateSlotItem = function (_owner, _itemArray, _item, _index, _flag)
{
	var slot = this.querySlotByIndex(_itemArray, _index);
	if(slot === null)
	{
		console.error('ERROR: Failed to update slot item: Reason: Invalid slot index: ' + _index);
		return;
	}

	switch(_flag)
	{
		case WorkshopScreenShop.ItemFlag.Inserted:
		case WorkshopScreenShop.ItemFlag.Updated:
		{
			this.removeItemFromSlot(slot);
			this.assignItemToSlot(_owner, slot, _item);
			//this.updateItemPriceLabel(slot, _item, _owner === WorkshopScreenShop.ItemOwner.Stash);
			break;
		}
		case WorkshopScreenShop.ItemFlag.Removed:
		{
			this.removeItemFromSlot(slot);
			break;
		} 
	}
};

CampScreenWorkshopDialogModule.prototype.updateStashList = function (_data, _capacity)
{
	if(this.mStashList === null || !jQuery.isArray(this.mStashList) || this.mStashList.length === 0)
	{
		this.loadStashData(_data, _capacity);
		return;
	}

	// stash size changed (shouldn't happen)
	// if(this.mStashList.length !== _data.length)
	// {
	//	 console.error('ERROR: Failed to update stash. Stash changed in size.');
	//	 return;
	// }

	// check stash for changes
	for(var i = 0; i < this.mStashList.length; ++i)
	{
		var sourceItem = this.mStashList[i];
		var targetItem = _data[i];

		// item added to stash slot
		if(sourceItem === null && targetItem !== null)
		{
			if('id' in targetItem)
			{
				//console.info('STASH: Item inserted (Index: ' + i + ')');
				this.mStashList[i] = targetItem;
				this.updateSlotItem(WorkshopScreenShop.ItemOwner.Stash, this.mStashSlots, targetItem, i, WorkshopScreenShop.ItemFlag.Inserted);
			}
		}

		// item removed from stash slot
		else if(sourceItem !== null && targetItem === null)
		{
			//console.info('STASH: Item removed (Index: ' + i + ')');
			this.mStashList[i] = targetItem;
			this.updateSlotItem(WorkshopScreenShop.ItemOwner.Stash, this.mStashSlots, targetItem, i, WorkshopScreenShop.ItemFlag.Removed);
		}

		// item might have changed within stash slot
		else
		{
			if((sourceItem !== null && targetItem !== null) && ('id' in sourceItem && 'id' in targetItem) && (sourceItem.id !== targetItem.id))
			{
				//console.info('STASH: Item updated (Index: ' + i + ')');
				this.mStashList[i] = targetItem;
				this.updateSlotItem(WorkshopScreenShop.ItemOwner.Stash, this.mStashSlots, targetItem, i, WorkshopScreenShop.ItemFlag.Updated);
			}
		}
	}
};

CampScreenWorkshopDialogModule.prototype.updateShopList = function (_data, _capacity)
{
	if(this.mShopList === null || !jQuery.isArray(this.mShopList) || this.mShopList.length === 0)
	{
		this.loadShopData(_data, _capacity);
		return;
	}

	// create more slots?
	if(_data.length > this.mShopSlots.length)
	{
		this.createItemSlots(WorkshopScreenShop.ItemOwner.Shop, _data.length - this.mShopSlots.length, this.mShopSlots, this.mShopListScrollContainer);
	}

	// check shop for changes
	var maxLength = this.mShopList.length >= _data.length ? this.mShopList.length : _data.length;

	for(var i = 0; i < maxLength; ++i)
	{
		var oldItem = this.mShopList[i];
		var newItem = _data[i];

		// item added to shop slot
		if(i >= this.mShopList.length || (oldItem === null && newItem !== null))
		{
			//console.info('SHOP: Item inserted (Index: ' + i + ')');
			this.updateSlotItem(WorkshopScreenShop.ItemOwner.Shop, this.mShopSlots, newItem, i, WorkshopScreenShop.ItemFlag.Inserted);
		}

		// item removed from shop slot
		else if(i >= _data.length || (oldItem !== null && newItem === null))
		{
			//console.info('SHOP: Item removed (Index: ' + i + ')');
			this.updateSlotItem(WorkshopScreenShop.ItemOwner.Shop, this.mShopSlots, oldItem, i, WorkshopScreenShop.ItemFlag.Removed);
		}

		// item might have changed within shop slot
		else
		{
			if((oldItem !== null && newItem !== null) && ('id' in oldItem && 'id' in newItem))
			{
				if(oldItem.id !== newItem.id)
				{
					//console.info('SHOP: Item updated (Index: ' + i + ')');
					this.updateSlotItem(WorkshopScreenShop.ItemOwner.Shop, this.mShopSlots, newItem, i, WorkshopScreenShop.ItemFlag.Updated);
				}
			}			
		}
	}

	// update list
	this.mShopList = _data;
};

CampScreenWorkshopDialogModule.prototype.destroyItemSlots = function (_itemArray, _itemContainer)
{
	this.clearItemSlots(_itemArray);

	_itemContainer.empty();
	_itemArray.length = 0;
};

CampScreenWorkshopDialogModule.prototype.notifyBackendModuleShown = function ()
{
	SQ.call(this.mSQHandle, 'onModuleShown');
};

CampScreenWorkshopDialogModule.prototype.notifyBackendModuleHidden = function ()
{
	SQ.call(this.mSQHandle, 'onModuleHidden');
};

CampScreenWorkshopDialogModule.prototype.notifyBackendModuleAnimating = function ()
{
	SQ.call(this.mSQHandle, 'onModuleAnimating');
};

CampScreenWorkshopDialogModule.prototype.notifyBackendLeaveButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onLeaveButtonPressed');
};

CampScreenWorkshopDialogModule.prototype.notifyBackendSortButtonClicked = function () 
{
	SQ.call(this.mSQHandle, 'onSortButtonClicked');
}

CampScreenWorkshopDialogModule.prototype.notifyBackendFilterAllButtonClicked = function ()
{
	SQ.call(this.mSQHandle, 'onFilterAll');
};

// CampScreenWorkshopDialogModule.prototype.notifyBackendFilterBroButtonClicked = function ()
// {
// 	SQ.call(this.mSQHandle, 'onFilterBro');
// };

CampScreenWorkshopDialogModule.prototype.notifyBackendFilterWeaponsButtonClicked = function ()
{
	SQ.call(this.mSQHandle, 'onFilterWeapons');
};

CampScreenWorkshopDialogModule.prototype.notifyBackendFilterArmorButtonClicked = function ()
{
	SQ.call(this.mSQHandle, 'onFilterArmor');
};

CampScreenWorkshopDialogModule.prototype.notifyBackendAssignAllButtonClicked = function ()
{
	SQ.call(this.mSQHandle, 'onAssignAll');
};

CampScreenWorkshopDialogModule.prototype.notifyBackendRemoveAllButtonClicked = function ()
{
	SQ.call(this.mSQHandle, 'onRemoveAll');
};

CampScreenWorkshopDialogModule.prototype.notifyBackendBrothersButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onBrothersButtonPressed');
};

CampScreenWorkshopDialogModule.prototype.notifyBackendSwapItem = function (_sourceItemIdx, _sourceItemOwner, _targetItemIdx, _targetItemOwner, _callback)
{
	SQ.call(this.mSQHandle, 'onSwapItem', [_sourceItemIdx, _sourceItemOwner, _targetItemIdx, _targetItemOwner], _callback);
};
