"use strict";

var CampScreenHealerDialogModule = function(_parent)
{
	this.mSQHandle = null;
	this.mParent = _parent;

	this.mRoster = null;

	// event listener
	this.mEventListener = null;

	// generic containers
	this.mContainer = null;
	this.mDialogContainer = null;
	this.mListContainer = null;
	this.mListScrollContainer = null;
	this.mNoInjuredLabel = null;

	this.mQueueContainer = null;
	this.mQueueScrollContainer = null;
	this.mQueueList = null;
	this.mQueueSlots = null;

	this.mDetailsPanel = {
		Container: null,
		CharacterName: null,
		ScrollContainer: null,
		ScrollContainerList: null
	};
	// assets labels
	this.mAssetValues = null;
	this.mSuppliesAsset = null;
	this.mRequiredAsset = null;
	this.mTimeAsset = null;
	this.mBrothersAsset	= null;

	// buttons
	this.mLeaveButton = null;

	// generics
	this.mIsVisible = false;

	// selected entry
	this.mSelectedEntry = null;
	this.mSelectedID = null;
};


CampScreenHealerDialogModule.prototype.isConnected = function ()
{
	return this.mSQHandle !== null;
};

CampScreenHealerDialogModule.prototype.onConnection = function (_handle)
{
	this.mSQHandle = _handle;

	// notify listener
	if (this.mEventListener !== null && ('onModuleOnConnectionCalled' in this.mEventListener))
	{
		this.mEventListener.onModuleOnConnectionCalled(this);
	}
};

CampScreenHealerDialogModule.prototype.onDisconnection = function ()
{
	this.mSQHandle = null;

	// notify listener
	if (this.mEventListener !== null && ('onModuleOnDisconnectionCalled' in this.mEventListener))
	{
		this.mEventListener.onModuleOnDisconnectionCalled(this);
	}
};

CampScreenHealerDialogModule.prototype.updateAssetValue = function (_container, _value, _valueMax, _valueDifference, _negative)
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

CampScreenHealerDialogModule.prototype.updateAssets = function (_data)
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
	
	if('Meds' in currentAssetInformation && 'MedsMax' in currentAssetInformation &&
		currentAssetInformation['Meds'] !== null && currentAssetInformation['MedsMax'] !== null)
	{

		value = currentAssetInformation['Meds'];
		var maxValue = currentAssetInformation['MedsMax'];
		valueDifference = null;
		if(previousAssetInformation !== null && 'Meds' in previousAssetInformation && previousAssetInformation['Meds'] !== null)
		{
			previousValue = previousAssetInformation['Meds'];
			valueDifference = value - previousValue;
		}
		this.updateAssetValue(this.mSuppliesAsset, value, maxValue, valueDifference);
	}

	if('MedsRequired' in currentAssetInformation && currentAssetInformation['MedsRequired'] !== null)
	{
		value = currentAssetInformation['MedsRequired'];
		valueDifference = null;
		if(previousAssetInformation !== null && 'MedsRequired' in previousAssetInformation && previousAssetInformation['MedsRequired'] !== null)
		{
			previousValue = previousAssetInformation['MedsRequired'];
			valueDifference = value - previousValue;
		}
		
		this.updateAssetValue(this.mRequiredAsset, value, null, valueDifference, value > _data['Meds']);
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

CampScreenHealerDialogModule.prototype.createAssetDIV = function (_parentDiv, _imagePath, _classExtra)
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

CampScreenHealerDialogModule.prototype.createImageButton = function (_parentDiv, _imagePath, _callback)
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

CampScreenHealerDialogModule.prototype.createDIV = function (_parentDiv)
{
	var self = this;

	// create: containers (init hidden!)
	this.mContainer = $('<div class="l-healer-dialog-container display-none opacity-none"/>');
	_parentDiv.append(this.mContainer);
	this.mDialogContainer = this.mContainer.createDialog('', '', '', true, 'dialog-1024-768');

	// create tabs
	var tabButtonsContainer = $('<div class="l-tab-container"/>');
	this.mDialogContainer.findDialogTabContainer().append(tabButtonsContainer);

	// create assets
	this.mSuppliesAsset = this.createAssetDIV(tabButtonsContainer, Path.GFX + Asset.ICON_ASSET_MEDICINE, 'is-supplies');
	this.mRequiredAsset = this.createAssetDIV(tabButtonsContainer, Path.GFX + 'ui/buttons/asset_medicine_down.png', 'is-num-required');
	this.mTimeAsset = this.createAssetDIV(tabButtonsContainer, Path.GFX + 'ui/buttons/icon_time.png', 'is-time-required');
	var assetContainer = $('<div class="l-tab-asset is-brothers"></div>');
	this.mBrothersAsset = this.createImageButton(assetContainer, Path.GFX + Asset.ICON_ASSET_BROTHERS, function()
	{
		self.notifyBackendBrothersButtonPressed();
	});
	tabButtonsContainer.append(assetContainer);

	// create content
	var content = this.mDialogContainer.findDialogContentContainer();

	// left column
	var column = $('<div class="column is-left"/>');
	content.append(column);
	var listContainerLayout = $('<div class="l-list-container"/>');
	column.append(listContainerLayout);
	this.mListContainer = listContainerLayout.createList(8.85);
	this.mListScrollContainer = this.mListContainer.findListScrollContainer();

	this.mNoInjuredLabel = $('<div class="is-no-wounded-hint text-font-medium font-bottom-shadow font-color-description display-none">No one has been assigned to this tent.</div>');
	listContainerLayout.append(this.mNoInjuredLabel);

	// right column
	column = $('<div class="column is-right"/>');
	content.append(column);

	// details container
	var detailsFrame = $('<div class="l-details-frame"/>');
	column.append(detailsFrame);
	this.mDetailsPanel.Container = $('<div class="details-container display-none"/>');
	detailsFrame.append(this.mDetailsPanel.Container);

	// details: character container

	var queueHeader = $('<div class="row is-header"/>');
	this.mDetailsPanel.Container.append(queueHeader);
	var queueHeaderLabel = $('<div class="label title-font-normal font-bold font-bottom-shadow font-color-title">Injury Queue</div>');
	queueHeader.append(queueHeaderLabel);


	var detailsRow = $('<div class="row is-queue-container"/>');
	this.mDetailsPanel.Container.append(detailsRow);
	listContainerLayout = $('<div class="l-list-container"></div>');
	detailsRow.append(listContainerLayout);
	this.mQueueContainer = listContainerLayout.createList(1.24/*8.63*/);
	this.mQueueScrollContainer = this.mQueueContainer.findListScrollContainer();

	// details: injuries
	var injuryHeader = $('<div class="row is-header"/>');
	this.mDetailsPanel.Container.append(injuryHeader);
	var injuriesHeaderLabel = $('<div class="label title-font-normal font-bold font-bottom-shadow font-color-title">Injuries List</div>');
	injuryHeader.append(injuriesHeaderLabel);
	this.mDetailsPanel.CharacterName = injuriesHeaderLabel;

	var detailsRow = $('<div class="row is-injuries-container"/>');
	this.mDetailsPanel.Container.append(detailsRow);
	listContainerLayout = $('<div class="l-list-container"></div>');
	detailsRow.append(listContainerLayout);
	this.mDetailsPanel.ScrollContainer = listContainerLayout.createList(1.24, 'is-injury-list', true);
	this.mDetailsPanel.ScrollContainerList = this.mDetailsPanel.ScrollContainer.findListScrollContainer();

	// create footer button bar
	var footerButtonBar = $('<div class="l-button-bar"/>');
	this.mDialogContainer.findDialogFooterContainer().append(footerButtonBar);

	// create: buttons
	var layout = $('<div class="l-leave-button"/>');
	footerButtonBar.append(layout);
	this.mLeaveButton = layout.createTextButton("Leave", function ()
	{
		self.notifyBackendLeaveButtonPressed();
	}, '', 1);

	this.mIsVisible = false;
};

CampScreenHealerDialogModule.prototype.destroyDIV = function ()
{
	this.mSuppliesAsset.remove();
	this.mSuppliesAsset = null;
	this.mRequiredAsset.remove();
	this.mRequiredAsset = null;
	this.mTimeAsset.remove();
	this.mTimeAsset = null;
	this.mBrothersAsset.remove();
	this.mBrothersAsset = null;

	this.mQueueList = null;
	this.mQueueSlots = null;
	
	this.mSelectedEntry = null;
	this.mSelectedID = null;

	this.mQueueScrollContainer.empty();
	this.mQueueScrollContainer = null;
	this.mQueueContainer.destroyList();
	this.mQueueContainer.remove();
	this.mQueueContainer = null;

	this.mDetailsPanel.Container.empty();
	this.mDetailsPanel.Container.remove();
	this.mDetailsPanel.Container = null;

	this.mListScrollContainer.empty();
	this.mListScrollContainer = null;
	this.mListContainer.destroyList();
	this.mListContainer.remove();
	this.mListContainer = null;

	this.mLeaveButton.remove();
	this.mLeaveButton = null;

	this.mDialogContainer.empty();
	this.mDialogContainer.remove();
	this.mDialogContainer = null;

	this.mContainer.empty();
	this.mContainer.remove();
	this.mContainer = null;
};

CampScreenHealerDialogModule.prototype.loadQueueData = function (_data)
{
	if(_data === undefined || _data === null || !jQuery.isArray(_data))
	{
		return;
	}

	this.mQueueList = _data;

	if(this.mQueueSlots === null)
	{
		this.mQueueSlots = [];
	}

	// call by ref hack
	var arrayRef = { val: this.mQueueSlots };
	var containerRef = { val: this.mQueueScrollContainer };

	this.assignItems('camp-screen-healing-dialog-module.shop', _data, _data.length, arrayRef.val, containerRef.val);
};

CampScreenHealerDialogModule.prototype.assignItemToSlot = function(_owner, _slot, _item)
{
	var remove = false;

	if(!('ID' in _item) || !('ImagePath' in _item))
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
		var itemData = _slot.data('item') || _item;
		itemData.id = _item.ID;
		_slot.data('item', itemData);

		// assign image
		_slot.assignListItemImage(Path.GFX + _item.ImagePath);
		_slot.assignListItemOverlayImage();

		// show amount
		_slot.assignListItemAmount('' + _item.Percentage +'%', '#ffffff');

		// bind tooltip
		_slot.assignListItemTooltip(_item.ID, "stash");
	}
};

CampScreenHealerDialogModule.prototype.assignItems = function (_owner, _items, _capacity, _itemArray, _itemContainer)
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
		//this.updateItemPriceLabels(_itemArray, _items, _owner === RepairScreenShop.ItemOwner.Stash);
	}
};

CampScreenHealerDialogModule.prototype.createItemSlots = function (_owner, _size, _itemArray, _itemContainer)
{
	var screen = $('.camp-screen');
	for(var i = 0; i < _size; ++i)
	{
		_itemArray.push(this.createItemSlot(_owner, i, _itemContainer, screen));
	}
};

CampScreenHealerDialogModule.prototype.destroyItemSlots = function (_itemArray, _itemContainer)
{
	this.clearItemSlots(_itemArray);

	_itemContainer.empty();
	_itemArray.length = 0;
};

CampScreenHealerDialogModule.prototype.createItemSlot = function (_owner, _index, _parentDiv, _screenDiv)
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

		self.notifyBackendSwap(sourceItemIdx, targetItemIdx, null)
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
		if(/*doSomething &&*/ isEmpty === false && owner !== null /*&& itemId !== null*/ && itemIdx !== null)
		{
			self.notifyBackendRemove(itemIdx, null);
		}
	});

	return result;
};

CampScreenHealerDialogModule.prototype.clearItemSlots = function (_itemArray)
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

CampScreenHealerDialogModule.prototype.removeItemFromSlot = function(_slot)
{
	// remove item image
	_slot.assignListItemImage();
	_slot.assignListItemOverlayImage();
	_slot.assignListItemTooltip();
};

CampScreenHealerDialogModule.prototype.addListEntry = function (_data)
{
	var result = $('<div class="l-row"/>');
	this.mListScrollContainer.append(result);

	var entry = $('<div class="ui-control list-entry"/>');
	result.append(entry);
	entry.data('entry', _data);
	entry.click(this, function(_event)
	{
		var self = _event.data;
		self.selectListEntry( $(this));
	});

	// left column
	var column = $('<div class="column is-left"/>');
	entry.append(column);

	var imageOffsetX = ('ImageOffsetX' in _data ? _data['ImageOffsetX'] : 0);
	var imageOffsetY = ('ImageOffsetY' in _data ? _data['ImageOffsetY'] : 0);
	column.createImage(Path.PROCEDURAL + _data['ImagePath'], function (_image)
	{
		_image.centerImageWithinParent(imageOffsetX, imageOffsetY, 0.64, false);
		_image.removeClass('opacity-none');
	}, null, 'opacity-none');

	// right column
	column = $('<div class="column is-right"/>');
	entry.append(column);

	// top row
	var row = $('<div class="row is-top"/>');
	column.append(row);

	var image = $('<img/>');
	image.attr('src', Path.GFX + _data['BackgroundImagePath']);
	row.append(image);

	// bind tooltip
	image.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterBackgrounds.Generic, elementOwner: TooltipIdentifier.ElementOwner.HireScreen, entityId: _data.ID });

	var name = $('<div class="name title-font-normal font-bold font-color-brother-name">' + _data[WorldTownScreenIdentifier.HireRosterEntry.Name] + '</div>');
	row.append(name);

	// bottom row
	row = $('<div class="row is-bottom"/>');
	entry.data('bottom', row);
	column.append(row);

	for (var i = 0; i < _data.Injuries.length; ++i)
	{
		var icon = $('<img src="' + Path.GFX + _data.Injuries[i].icon + '"/>');
		icon.bindTooltip({ contentType: 'status-effect', entityId: _data.ID, statusEffectId: _data.Injuries[i].id });
		row.append(icon);
	}
	return entry;
};


CampScreenHealerDialogModule.prototype.updateSelectedListEntry = function (_data)
{
	if (this.mSelectedEntry == null)
		return;

	this.mSelectedEntry.data('entry', _data);

	// portrait
	var result = this.mSelectedEntry.find('img:first');
	if (result.length > 0)
	{
		result.attr('src', Path.PROCEDURAL + _data['ImagePath']);
	}

	// injuries
	var row = this.mSelectedEntry.data('bottom');
	row.empty();
	
	for (var i = 0; i < _data.Injuries.length; ++i)
	{
		var icon = $('<img src="' + Path.GFX + _data.Injuries[i].icon + '"/>');
		icon.bindTooltip({ contentType: 'status-effect', entityId: _data.ID, statusEffectId: _data.Injuries[i].id });
		row.append(icon);
	}
};

CampScreenHealerDialogModule.prototype.selectListEntry = function(_element, _scrollToEntry)
{
	if (_element !== null && _element.length > 0)
	{
		this.mSelectedEntry = _element;
		this.mListContainer.deselectListEntries();
		_element.addClass('is-selected');

		// give the renderer some time to layout his shit...
		if (_scrollToEntry !== undefined && _scrollToEntry === true)
		{
			this.mListContainer.scrollListToElement(_element);
		}
		this.mSelectedEntry = _element;
		this.updateDetailsPanel(this.mSelectedEntry);
	}
	else
	{
		this.mSelectedEntry = null;
		this.updateDetailsPanel(this.mSelectedEntry);
	}
};

CampScreenHealerDialogModule.prototype.updateDetailsPanel = function(_element)
{
	if(_element !== null && _element.length > 0)
	{
		var currentMoney = this.mAssetValues.Meds;
		var data = _element.data('entry');
		
		this.mDetailsPanel.ScrollContainerList.empty();
		//this.mDetailsPanel.CharacterName.html(data.name);
		for (var i = 0; i < data.Injuries.length; ++i)
		{
			this.createInjuryControlDIV(i, this.mDetailsPanel.ScrollContainerList, data.ID, data.Injuries[i], currentMoney);
		}

		this.mDetailsPanel.Container.removeClass('display-none').addClass('display-block');
	}
	else
	{
		this.mDetailsPanel.Container.removeClass('display-block').addClass('display-none');
	}
};

CampScreenHealerDialogModule.prototype.createInjuryControlDIV = function (_i, _parentDiv, _entityID, _data, _money)
{
	var self = this;
	var row = $('<div class="is-injury-row display-block"/>');
	row.css({ 'top': ((7.5*_i) + 'rem') });
	_parentDiv.append(row);

	var icon = $('<img class="is-icon"/>');
	icon.attr('src', Path.GFX + _data.icon);
	icon.bindTooltip({ contentType: 'status-effect', entityId: _entityID, statusEffectId: _data.id });
	row.append(icon);

	var name = $('<div class="is-name text-font-normal font-bottom-shadow font-color-description">' + _data.name + '</div>');
	row.append(name);

	var layout = $('<div class="is-button"/>');
	row.append(layout);

	var price;
	if (_data.treatable)
		price = $('<div class="is-price"><div class="is-price-ffs font-color-assets-negative-value"><img src="' + Path.GFX + Asset.ICON_ASSET_MEDICINE + '"/> ' + Helper.numberWithCommas(_data.price) + '</div></div>');
	else
		price = $('<div class="is-price"><div class="is-price-ffs"><img src="' + Path.GFX + Asset.ICON_ASSET_MEDICINE + '"/> ' + Helper.numberWithCommas(_data.price) + '</div></div>');

	var button = layout.createCustomButton(price, function ()
	{
		self.notifyBackendTreatInjury(_entityID, _data.id, null);
	}, '', 1);

	if (!_data.treatable)
		button.enableButton(false);
};

CampScreenHealerDialogModule.prototype.bindTooltips = function ()
{

	this.mRequiredAsset.bindTooltip({ contentType: 'ui-element', elementId: 'healer.Required' });
	this.mSuppliesAsset.bindTooltip({ contentType: 'ui-element', elementId: 'healer.Supplies' });
	this.mTimeAsset.bindTooltip({ contentType: 'ui-element', elementId:  'healer.Time' });
	this.mBrothersAsset.bindTooltip({ contentType: 'ui-element', elementId: 'healer.Bros' });   
	this.mLeaveButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.WorldTownScreen.HireDialogModule.LeaveButton });
};

CampScreenHealerDialogModule.prototype.unbindTooltips = function ()
{
	this.mRequiredAsset.unbindTooltip();
	this.mSuppliesAsset.unbindTooltip();
	this.mTimeAsset.unbindTooltip();
	this.mBrothersAsset.unbindTooltip();
	this.mLeaveButton.unbindTooltip();
};

CampScreenHealerDialogModule.prototype.create = function(_parentDiv)
{
	this.createDIV(_parentDiv);
	this.bindTooltips();
};

CampScreenHealerDialogModule.prototype.destroy = function()
{
	this.unbindTooltips();
	this.destroyDIV();
};

CampScreenHealerDialogModule.prototype.register = function (_parentDiv)
{
	console.log('CampScreenHealerDialogModule::REGISTER');

	if (this.mContainer !== null)
	{
		console.error('ERROR: Failed to register World Town Screen Temple Dialog Module. Reason: Module is already initialized.');
		return;
	}

	if (_parentDiv !== null && typeof(_parentDiv) == 'object')
	{
		this.create(_parentDiv);
	}
};

CampScreenHealerDialogModule.prototype.unregister = function ()
{
	console.log('CampScreenHealerDialogModule::UNREGISTER');

	if (this.mContainer === null)
	{
		console.error('ERROR: Failed to unregister World Town Screen Temple Dialog Module. Reason: Module is not initialized.');
		return;
	}

	this.destroy();
};

CampScreenHealerDialogModule.prototype.isRegistered = function ()
{
	if (this.mContainer !== null)
	{
		return this.mContainer.parent().length !== 0;
	}

	return false;
};


CampScreenHealerDialogModule.prototype.registerEventListener = function(_listener)
{
	this.mEventListener = _listener;
};


CampScreenHealerDialogModule.prototype.show = function (_withSlideAnimation)
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

CampScreenHealerDialogModule.prototype.hide = function ()
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
			self.mListScrollContainer.empty();
			$(this).removeClass('display-block').addClass('display-none');
			self.notifyBackendModuleHidden();
		}
	});
};

CampScreenHealerDialogModule.prototype.isVisible = function ()
{
	return this.mIsVisible;
};


CampScreenHealerDialogModule.prototype.loadFromData = function (_data)
{
	if(_data === undefined || _data === null)
	{
		return;
	}

	if('Title' in _data && _data.Title !== null)
	{
		 this.mDialogContainer.findDialogTitle().html(_data.Title);
	}

	if('SubTitle' in _data && _data.SubTitle !== null)
	{
		 this.mDialogContainer.findDialogSubTitle().html(_data.SubTitle);
	}
	
	if('Assets' in _data && _data.Assets !== null)
	{
		this.updateAssets(_data.Assets);
	}

	if('Queue' in _data && _data.Queue !== null)
	{
		this.loadQueueData(_data.Queue);
	}

	if ('Roster' in _data && _data.Roster !== null) 
	{
		this.mRoster = _data.Roster;

		var selectedID = null;
		if (this.mSelectedEntry !== null)
		{
			var data = this.mSelectedEntry.data('entry');
			if (data)
			{
				selectedID = data.ID;
			}
		}
		this.mListScrollContainer.empty();

		var selectedElement = null;
		if (_data.Roster.length != 0)
		{
			this.mNoInjuredLabel.addClass('display-none');
	
			for (var i = 0; i < _data.Roster.length; ++i)
			{
				var entry = _data.Roster[i];
				var element = this.addListEntry(entry);
				if (entry.ID === selectedID)
				{
					selectedElement = element;
				}
			}
		}
		else
		{
			this.mNoInjuredLabel.removeClass('display-none');
		}
		if (selectedElement === null)
		{
			selectedElement = this.mListContainer.findListEntryByIndex(0) 
		}
		this.selectListEntry(selectedElement, true);
	}

};

CampScreenHealerDialogModule.prototype.changeRosterEntry = function (_entryID)
{
	var self = this;
	this.notifyBackendChangeAppearance(_entryID, function(imagePath)
	{
		var result = self.mSelectedEntry.find('img:first');
		if(result.length > 0)
		{
		   result.attr('src', Path.PROCEDURAL + imagePath);
		}
	});
};

CampScreenHealerDialogModule.prototype.notifyBackendModuleShown = function ()
{
	SQ.call(this.mSQHandle, 'onModuleShown');
};

CampScreenHealerDialogModule.prototype.notifyBackendModuleHidden = function ()
{
	SQ.call(this.mSQHandle, 'onModuleHidden');
};

CampScreenHealerDialogModule.prototype.notifyBackendModuleAnimating = function ()
{
	SQ.call(this.mSQHandle, 'onModuleAnimating');
};

CampScreenHealerDialogModule.prototype.notifyBackendLeaveButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onLeaveButtonPressed');
};

CampScreenHealerDialogModule.prototype.notifyBackendBrothersButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onBrothersButtonPressed');
};

CampScreenHealerDialogModule.prototype.notifyBackendSwap = function (_source, _target, _callback)
{
	SQ.call(this.mSQHandle, 'onSwap', [_source, _target], _callback);
};

CampScreenHealerDialogModule.prototype.notifyBackendRemove = function (_index, _callback)
{
	SQ.call(this.mSQHandle, 'onRemove', _index, _callback);
};

CampScreenHealerDialogModule.prototype.notifyBackendTreatInjury = function ( _entityID, _injuryID, _callback)
{
	SQ.call(this.mSQHandle, 'onAdd', [ _entityID, _injuryID ], _callback);
};
