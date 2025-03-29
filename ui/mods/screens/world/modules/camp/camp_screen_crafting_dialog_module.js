
"use strict";

var CampScreenCraftingDialogModule = function(_parent)
{
	this.mSQHandle = null;
	this.mParent = _parent;

	this.mBlueprints = null;

	// event listener
	this.mEventListener = null;

	// generic containers
	this.mContainer = null;
	this.mDialogContainer = null;
	this.mListContainer = null;
	this.mListScrollContainer = null;
	this.mNoCraftablesLabel = null;

	this.mQueueContainer = null;
	this.mQueueScrollContainer = null;
	this.mQueueList = null;
	this.mQueueSlots = null;

	this.mDetailsPanel =
	{
		Container: null,
		Components: null,
		Cost: null,
		CraftButton: null,
		CraftForeverButton: null
	};

	// assets labels
	this.mAssetValues = null;
	this.mTimeAsset = null;
	this.mBrothersAsset	= null;

	// buttons
	this.mLeaveButton = null;

	// generics
	this.mIsVisible = false;

	// selected entry
	this.mSelectedEntry = null;

	// buttons
	this.mFilterPanel = null;
	this.mFilterAllButton = null;
	this.mFilterWeaponsButton = null;
	this.mFilterArmorButton = null;
	this.mFilterMiscButton = null;
	this.mFilterUsableButton = null;

	// pagination
	this.mSearch = {
		ResultButtons : [],
		ResultPageList : null,
	};
	this.mItemPerPage = 4;
	this.mMaxVisiblePage = 9;
};


CampScreenCraftingDialogModule.prototype.isConnected = function ()
{
	return this.mSQHandle !== null;
};

CampScreenCraftingDialogModule.prototype.onConnection = function (_handle)
{
	this.mSQHandle = _handle;

	// notify listener
	if (this.mEventListener !== null && ('onModuleOnConnectionCalled' in this.mEventListener))
	{
		this.mEventListener.onModuleOnConnectionCalled(this);
	}
};

CampScreenCraftingDialogModule.prototype.onDisconnection = function ()
{
	this.mSQHandle = null;

	// notify listener
	if (this.mEventListener !== null && ('onModuleOnDisconnectionCalled' in this.mEventListener))
	{
		this.mEventListener.onModuleOnDisconnectionCalled(this);
	}
};

CampScreenCraftingDialogModule.prototype.createDIV = function (_parentDiv)
{
	var self = this;

	// create: containers (init hidden!)
	this.mContainer = $('<div class="l-crafting-dialog-container display-none opacity-none"/>');
	_parentDiv.append(this.mContainer);
	this.mDialogContainer = this.mContainer.createDialog('', '', '', true, 'dialog-1024-768');

	// create tabs
	var tabButtonsContainer = $('<div class="l-tab-container"/>');
	this.mDialogContainer.findDialogTabContainer().append(tabButtonsContainer);

	// create assets
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

	// sort
	this.mFilterPanel = $('<div class="filter-panel"/>');
	column.append(this.mFilterPanel);

	var layout = $('<div class="l-button is-all-filter"/>');
	this.mFilterPanel.append(layout);
	this.mFilterAllButton = layout.createImageButton(Path.GFX + Asset.BUTTON_ALL_FILTER, function ()
	{
		self.mFilterAllButton.addClass('is-active');
		self.mFilterWeaponsButton.removeClass('is-active');
		self.mFilterArmorButton.removeClass('is-active');
		self.mFilterMiscButton.removeClass('is-active');
		self.mFilterUsableButton.removeClass('is-active');
		self.notifyBackendFilterAllButtonClicked();
	}, '', 3);
	this.mFilterAllButton.addClass('is-active');

	var layout = $('<div class="l-button is-weapons-filter"/>');
	this.mFilterPanel.append(layout);
	this.mFilterWeaponsButton = layout.createImageButton(Path.GFX + Asset.BUTTON_WEAPONS_FILTER, function ()
	{
		self.mFilterAllButton.removeClass('is-active');
		self.mFilterWeaponsButton.addClass('is-active');
		self.mFilterArmorButton.removeClass('is-active');
		self.mFilterMiscButton.removeClass('is-active');
		self.mFilterUsableButton.removeClass('is-active');
		self.notifyBackendFilterWeaponsButtonClicked();
	}, '', 3);

	var layout = $('<div class="l-button is-armor-filter"/>');
	this.mFilterPanel.append(layout);
	this.mFilterArmorButton = layout.createImageButton(Path.GFX + Asset.BUTTON_ARMOR_FILTER, function ()
	{
		self.mFilterAllButton.removeClass('is-active');
		self.mFilterWeaponsButton.removeClass('is-active');
		self.mFilterArmorButton.addClass('is-active');
		self.mFilterMiscButton.removeClass('is-active');
		self.mFilterUsableButton.removeClass('is-active');
		self.notifyBackendFilterArmorButtonClicked();
	}, '', 3);

	var layout = $('<div class="l-button is-misc-filter"/>');
	this.mFilterPanel.append(layout);
	this.mFilterMiscButton = layout.createImageButton(Path.GFX + Asset.BUTTON_MISC_FILTER, function ()
	{
		self.mFilterAllButton.removeClass('is-active');
		self.mFilterWeaponsButton.removeClass('is-active');
		self.mFilterArmorButton.removeClass('is-active');
		self.mFilterMiscButton.addClass('is-active');
		self.mFilterUsableButton.removeClass('is-active');
		self.notifyBackendFilterMiscButtonClicked();
	}, '', 3);

	var layout = $('<div class="l-button is-usable-filter"/>');
	this.mFilterPanel.append(layout);
	this.mFilterUsableButton = layout.createImageButton(Path.GFX + Asset.BUTTON_USABLE_FILTER, function ()
	{
		self.mFilterAllButton.removeClass('is-active');
		self.mFilterWeaponsButton.removeClass('is-active');
		self.mFilterArmorButton.removeClass('is-active');
		self.mFilterMiscButton.removeClass('is-active');
		self.mFilterUsableButton.addClass('is-active');
		self.notifyBackendFilterUsableButtonClicked();
	}, '', 3);

	var listContainerLayout = $('<div class="l-list-container"/>');
	column.append(listContainerLayout);
	this.mListContainer = listContainerLayout.createList(8.85);
	this.mListScrollContainer = this.mListContainer.findListScrollContainer();

	this.mNoCraftablesLabel = $('<div class="is-no-craftables-hint text-font-medium font-bottom-shadow font-color-description display-none">Nothing can be crafted from your combination of trophies.</div>');
	listContainerLayout.append(this.mNoCraftablesLabel);

	var pagesContainerLayout = $('<div class="page-bar-row"/>');
	this.mSearch.ResultPageList = $('<div class="l-search-result-page-bar"/>');
	pagesContainerLayout.append(this.mSearch.ResultPageList);
	column.append(pagesContainerLayout);

	// right column
	column = $('<div class="column is-right"/>');
	content.append(column);

	// details container
	var detailsFrame = $('<div class="l-details-frame"/>');
	column.append(detailsFrame);
	this.mDetailsPanel.Container = $('<div class="details-container display-none"/>');
	detailsFrame.append(this.mDetailsPanel.Container);


	// details: character container
	var detailsRow = $('<div class="row is-character-container"/>');
	this.mDetailsPanel.Container.append(detailsRow);
	var queueHeader = $('<div class="row is-header"/>');
	detailsRow.append(queueHeader);
	var queueHeaderLabel = $('<div class="label title-font-normal font-bold font-bottom-shadow font-color-title">Crafting Queue</div>');
	queueHeader.append(queueHeaderLabel);

	detailsRow = $('<div class="row is-queue-container"/>');
	this.mDetailsPanel.Container.append(detailsRow);
	listContainerLayout = $('<div class="l-list-container"></div>');
	detailsRow.append(listContainerLayout);
	this.mQueueContainer = listContainerLayout.createList(1.24/*8.63*/);
	this.mQueueScrollContainer = this.mQueueContainer.findListScrollContainer();

	// details: ingredients
	detailsRow = $('<div class="row is-ingredients-container"/>');
	this.mDetailsPanel.Container.append(detailsRow);
	var ingredientsHeader = $('<div class="row is-header"/>');
	detailsRow.append(ingredientsHeader);
	var ingredientsHeaderLabel = $('<div class="label title-font-normal font-bold font-bottom-shadow font-color-title">Components Required</div>');
	ingredientsHeader.append(ingredientsHeaderLabel);

	this.mDetailsPanel.Components = $('<div class="row is-components-container"/>');
	detailsRow.append(this.mDetailsPanel.Components);

	// details: buttons
	detailsRow = $('<div class="row is-button-container"/>');
	this.mDetailsPanel.Container.append(detailsRow);
	var craftButtonLayout = $('<div class="l-hire-button"/>');
	detailsRow.append(craftButtonLayout);
	this.mDetailsPanel.CraftButton = craftButtonLayout.createTextButton("Craft", function ()
	{
		if (self.mSelectedEntry !== null)
		{
			var data = self.mSelectedEntry.data('entry');
			if ('ID' in data && data['ID'] !== null)
			{
				self.notifyBackendCraft({ID: data['ID'], Variant: 1}, null)
			}
		}
	}, '', 1);

	craftButtonLayout = $('<div class="l-craft-forever-button"/>');
	detailsRow.append(craftButtonLayout);
	this.mDetailsPanel.CraftForeverButton = craftButtonLayout.createTextButton("Craft Forever", function ()
	{
		if (self.mSelectedEntry !== null)
		{
			var data = self.mSelectedEntry.data('entry');
			if ('ID' in data && data['ID'] !== null)
			{
				self.notifyBackendCraftForever({ID: data['ID'], Variant: 1}, null)
			}
		}
	}, '', 1);

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

CampScreenCraftingDialogModule.prototype.destroyDIV = function ()
{
	this.mTimeAsset.remove();
	this.mTimeAsset = null;
	this.mBrothersAsset.remove();
	this.mBrothersAsset = null;

	this.mSelectedEntry = null;

	this.mFilterPanel.empty();
	this.mFilterPanel.remove();
	this.mFilterPanel = null;

	this.mListScrollContainer.empty();
	this.mListScrollContainer = null;
	this.mListContainer.destroyList();
	this.mListContainer.remove();
	this.mListContainer = null;

	this.mQueueScrollContainer.empty();
	this.mQueueScrollContainer = null;
	this.mQueueContainer.destroyList();
	this.mQueueContainer.remove();
	this.mQueueContainer= null;

	this.mLeaveButton.remove();
	this.mLeaveButton = null;

	this.mDialogContainer.empty();
	this.mDialogContainer.remove();
	this.mDialogContainer = null;

	this.mContainer.empty();
	this.mContainer.remove();
	this.mContainer = null;

	this.mSearch.ResultPageList.empty();
	this.mSearch.ResultPageList.remove();
	this.mSearch.ResultPageList = null;

	this.mQueueList = null;
	this.mQueueSlots = null;
};

CampScreenCraftingDialogModule.prototype.loadQueueData = function (_data)
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

	this.assignItems('camp-screen-crafting-dialog-module.shop', _data, _data.length, arrayRef.val, containerRef.val);
};

CampScreenCraftingDialogModule.prototype.assignItemToSlot = function(_owner, _slot, _item)
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
		var itemData = _slot.data('item') || {};
		itemData.id = _item.ID;
		_slot.data('item', itemData);

		// assign image
		_slot.assignListItemImage(Path.ITEMS + _item.ImagePath);
		_slot.assignListItemOverlayImage();

		// show amount

		var percentage = Math.round(_item.Percentage) == _item.Percentage ? _item.Percentage : _item.Percentage.toFixed(1);

		_slot.assignListItemAmount('' + percentage +'%', '#ffffff');

		if (_item.Forever)
		{
			var infinityLayer =$('<div class="infinity-layer display-block"/>');
			_slot.append(infinityLayer);

			var infinityImage = $('<img/>');
			infinityImage.attr('src', Path.GFX + "ui/icons/infinity.png");
			infinityLayer.append(infinityImage)
		}

		// bind tooltip
		_slot.assignListItemTooltip(_item.ID, "stash");
	}
};

CampScreenCraftingDialogModule.prototype.assignItems = function (_owner, _items, _capacity, _itemArray, _itemContainer)
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

CampScreenCraftingDialogModule.prototype.createItemSlots = function (_owner, _size, _itemArray, _itemContainer)
{
	var screen = $('.camp-screen');
	for(var i = 0; i < _size; ++i)
	{
		_itemArray.push(this.createItemSlot(_owner, i, _itemContainer, screen));
	}
};

CampScreenCraftingDialogModule.prototype.destroyItemSlots = function (_itemArray, _itemContainer)
{
	this.clearItemSlots(_itemArray);

	_itemContainer.empty();
	_itemArray.length = 0;
};


CampScreenCraftingDialogModule.prototype.createItemSlot = function (_owner, _index, _parentDiv, _screenDiv)
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

CampScreenCraftingDialogModule.prototype.addListEntry = function (_data)
{
	var result = $('<div class="l-row"/>');
	this.mListScrollContainer.append(result);

	var entry = $('<div class="ui-control list-entry"/>');
	result.append(entry);
	entry.data('entry', _data);
	entry.click(this, function(_event)
	{
		var self = _event.data;
		self.selectListEntry($(this));
	});

	if(!_data.IsCraftable)
		entry.addClass('is-disabled');

	// left column
	var column = $('<div class="column is-left"/>');
	entry.append(column);

	var imageOffsetX = ('ImageOffsetX' in _data ? _data['ImageOffsetX'] : 0);
	var imageOffsetY = ('ImageOffsetY' in _data ? _data['ImageOffsetY'] : 0);
	var image = column.createImage(Path.ITEMS + _data['ImagePath'], function (_image)
	{
		_image.centerImageWithinParent(imageOffsetX, imageOffsetY, 0.64, false);
		_image.removeClass('opacity-none');
	}, null, 'opacity-none');
	image.bindTooltip({ contentType: 'ui-item', itemId: _data.ID, itemOwner: 'craft' });
	if(_data.isAmountShown)
	{
		var amountLayer =$('<div class="amount-layer display-block"/>');
		column.append(amountLayer);
		var amountLabel = $('<div class="label text-font-very-small font-shadow-outline"/>');
		amountLayer.append(amountLabel);
		amountLabel.text(_data.Amount);
		amountLabel.css({'color' : "#ffffff"});
	}
	// right column
	column = $('<div class="column is-right"/>');
	entry.append(column);

	// top row
	var row = $('<div class="row is-top"/>');
	column.append(row);

	// bind tooltip
	//image.bindTooltip({ contentType: 'ui-item', itemId: _data.InstanceID, itemOwner: TooltipIdentifier.ItemOwner.Stash });

	if(_data.IsCraftable)
	{
		var name = $('<div class="name title-font-normal font-bold font-color-brother-name">' + _data.Name + '</div>');
		row.append(name);
	}
	else
	{
		var name = $('<div class="name title-font-normal font-bold font-color-disabled">' + _data.Name + '</div>');
		row.append(name);
	}

	// bottom row
	row = $('<div class="row is-bottom"/>');
	entry.data('bottom', row);
	column.append(row);

	for(var i = 0; i < _data.Ingredients.length; ++i)
	{
		var iconContainer = $('<div class="icons-container"/>');
		row.append(iconContainer);
		var icon;
		if (_data.Ingredients[i].IsSkill === 1)
		{
			icon = $('<img src="' + Path.GFX + _data.Ingredients[i].ImagePath + '"/>');
			icon.bindTooltip({ contentType: 'ui-item', itemId: _data.Ingredients[i].InstanceID, entityId: _data.ID, itemOwner: 'blueprintskill' });
		}
		else
		{
			icon = $('<img src="' + Path.ITEMS + _data.Ingredients[i].ImagePath + '"/>');
			icon.bindTooltip({ contentType: 'ui-item', itemId: _data.Ingredients[i].InstanceID, entityId: _data.ID, itemOwner: 'blueprint' });

			var amountLayer =$('<div class="amount-layer display-block"/>');
			iconContainer.append(amountLayer);
			var amountLabel = $('<div class="label text-font-very-small font-shadow-outline font-size-10"/>');
			amountLayer.append(amountLabel);
			amountLabel.text(_data.Ingredients[i].InvTotal + "/" + _data.Ingredients[i].Num);
			amountLabel.css({'color' : "#ffffff"});
		}
		iconContainer.append(icon);

		if(_data.Ingredients[i].IsMissing)
		{
			icon.css({ '-webkit-filter': 'brightness(60%)' });
			var overlay = $('<img src="' + Path.ITEMS + 'missing_component.png" class="component-overlay" />');
			iconContainer.append(overlay);
		}
	}
};

CampScreenCraftingDialogModule.prototype.selectListEntry = function(_element, _scrollToEntry)
{
	if (_element !== null && _element.length > 0)
	{
		// check if this is already selected
		//if (_element.hasClass('is-selected') !== true)
		{
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
	}
	else
	{
		this.mSelectedEntry = null;
		this.updateDetailsPanel(this.mSelectedEntry);
	}
};

CampScreenCraftingDialogModule.prototype.clearItemSlots = function (_itemArray)
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

CampScreenCraftingDialogModule.prototype.removeItemFromSlot = function(_slot)
{
	// remove item image
	_slot.assignListItemImage();
	_slot.assignListItemOverlayImage();
	_slot.assignListItemTooltip();
};

CampScreenCraftingDialogModule.prototype.updateDetailsPanel = function(_element)
{
	if(_element !== null && _element.length > 0)
	{
		var data = _element.data('entry');

		// this.mDetailsPanel.CharacterImage.attr('src', Path.ITEMS + data.LargeImagePath);
		// this.mDetailsPanel.CharacterImage.centerImageWithinParent(0, 0, 1.0);
		// this.mDetailsPanel.CharacterImage.bindTooltip({ contentType: 'ui-item', itemId: data.ID, itemOwner: 'craft' });

		// this.mDetailsPanel.CharacterName.html(data['Name']);
		// this.mDetailsPanel.DescriptionTextContainer.html(data['Description']);

		this.mDetailsPanel.Components.empty();
		for(var i = 0; i < data.Ingredients.length; ++i)
		{
			var iconContainer = $('<div class="icons-container"/>');
			this.mDetailsPanel.Components.append(iconContainer);
			var icon;
			if (data.Ingredients[i].IsSkill === 1)
			{
				icon = $('<img src="' + Path.GFX + data.Ingredients[i].ImagePath + '"/>');
				icon.bindTooltip({ contentType: 'ui-item', itemId: data.Ingredients[i].InstanceID, entityId: data.ID, itemOwner: 'blueprintskill' });
			}
			else
			{
				icon = $('<img src="' + Path.ITEMS + data.Ingredients[i].ImagePath + '"/>');
				icon.bindTooltip({ contentType: 'ui-item', itemId: data.Ingredients[i].InstanceID, entityId: data.ID, itemOwner: 'blueprint' });

				var amountLayer =$('<div class="amount-layer display-block"/>');
				iconContainer.append(amountLayer);
				var amountLabel = $('<div class="label text-font-very-small font-shadow-outline font-size-15"/>');
				amountLayer.append(amountLabel);
				amountLabel.text(data.Ingredients[i].InvTotal + "/" + data.Ingredients[i].Num);
				amountLabel.css({'color' : "#ffffff"});
			}
			iconContainer.append(icon);

			if(data.Ingredients[i].IsMissing)
			{
				icon.css({ '-webkit-filter': 'brightness(60%)' });
				var overlay = $('<img src="' + Path.ITEMS + 'missing_component.png" class="component-overlay" />');
				iconContainer.append(overlay);
			}
		}

		this.mDetailsPanel.Container.removeClass('display-none').addClass('display-block');
	}
	else
	{
		this.mDetailsPanel.Container.removeClass('display-block').addClass('display-none');
	}
};


CampScreenCraftingDialogModule.prototype.bindTooltips = function ()
{
	this.mTimeAsset.bindTooltip({ contentType: 'ui-element', elementId:  'crafting.Time' });
	this.mBrothersAsset.bindTooltip({ contentType: 'ui-element', elementId: 'crafting.Bros' });
	this.mDetailsPanel.CraftButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.WorldTownScreen.TaxiDermistDialogModule.CraftButton });
	this.mDetailsPanel.CraftForeverButton.bindTooltip({ contentType: 'ui-element', elementId: 'crafting.CraftForeverButton' });
	this.mLeaveButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.WorldTownScreen.HireDialogModule.LeaveButton });
	this.mFilterAllButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterScreen.RightPanelHeaderModule.FilterAllButton });
	this.mFilterWeaponsButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterScreen.RightPanelHeaderModule.FilterWeaponsButton });
	this.mFilterArmorButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterScreen.RightPanelHeaderModule.FilterArmorButton });
	this.mFilterMiscButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterScreen.RightPanelHeaderModule.FilterMiscButton });
	this.mFilterUsableButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterScreen.RightPanelHeaderModule.FilterUsableButton });

};

CampScreenCraftingDialogModule.prototype.unbindTooltips = function ()
{
	this.mTimeAsset.unbindTooltip();
	this.mBrothersAsset.unbindTooltip();
	this.mDetailsPanel.CraftButton.unbindTooltip();
	this.mDetailsPanel.CraftForeverButton.unbindTooltip();
	this.mLeaveButton.unbindTooltip();
	this.mFilterAllButton.unbindTooltip();
	this.mFilterWeaponsButton.unbindTooltip();
	this.mFilterArmorButton.unbindTooltip();
	this.mFilterMiscButton.unbindTooltip();
	this.mFilterUsableButton.unbindTooltip();
};


CampScreenCraftingDialogModule.prototype.create = function(_parentDiv)
{
	this.createDIV(_parentDiv);
	this.bindTooltips();
};

CampScreenCraftingDialogModule.prototype.destroy = function()
{
	this.unbindTooltips();
	this.destroyDIV();
};


CampScreenCraftingDialogModule.prototype.register = function (_parentDiv)
{
	console.log('CampScreenCraftingDialogModule::REGISTER');

	if (this.mContainer !== null)
	{
		console.error('ERROR: Failed to register World Town Screen Taxidermist Dialog Module. Reason: Module is already initialized.');
		return;
	}

	if (_parentDiv !== null && typeof(_parentDiv) == 'object')
	{
		this.create(_parentDiv);
	}
};

CampScreenCraftingDialogModule.prototype.unregister = function ()
{
	console.log('CampScreenCraftingDialogModule::UNREGISTER');

	if (this.mContainer === null)
	{
		console.error('ERROR: Failed to unregister World Town Screen Taxidermist Dialog Module. Reason: Module is not initialized.');
		return;
	}

	this.destroy();
};

CampScreenCraftingDialogModule.prototype.isRegistered = function ()
{
	if (this.mContainer !== null)
	{
		return this.mContainer.parent().length !== 0;
	}

	return false;
};


CampScreenCraftingDialogModule.prototype.registerEventListener = function(_listener)
{
	this.mEventListener = _listener;
};


CampScreenCraftingDialogModule.prototype.show = function (_withSlideAnimation)
{
	var self = this;

	var withAnimation = (_withSlideAnimation !== undefined && _withSlideAnimation !== null) ? _withSlideAnimation : true;
	if (withAnimation === true)
	{
		var offset = -(this.mContainer.parent().width() + this.mContainer.width());
		this.mContainer.css({ 'left': offset });
		this.mContainer.velocity("finish", true).velocity({ opacity: 1, left: '0', right: '0' },
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

CampScreenCraftingDialogModule.prototype.hide = function ()
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

CampScreenCraftingDialogModule.prototype.isVisible = function ()
{
	return this.mIsVisible;
};

CampScreenCraftingDialogModule.prototype.loadFromData = function (_data)
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

	if ('Blueprints' in _data && _data.Blueprints !== null)
	{
		this.mBlueprints = _data.Blueprints;

		this.mListScrollContainer.empty();

		if (_data.Blueprints.length != 0)
		{
			this.mNoCraftablesLabel.addClass('display-none');

			for (var i = 0; i < _data.Blueprints.length; ++i)
			{
				this.addListEntry(_data.Blueprints[i]);
			}

			this.createResultPageButton(_data.CurrentPage, _data.Pages);
		}
		else
		{
			this.mNoCraftablesLabel.removeClass('display-none');
		}

		this.selectListEntry(this.mListContainer.findListEntryByIndex(0), true);
	}


};

CampScreenCraftingDialogModule.prototype.updateAssetValue = function (_container, _value, _valueMax, _valueDifference, _negative)
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

CampScreenCraftingDialogModule.prototype.updateAssets = function (_data)
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

CampScreenCraftingDialogModule.prototype.createAssetDIV = function (_parentDiv, _imagePath, _classExtra)
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

CampScreenCraftingDialogModule.prototype.createImageButton = function (_parentDiv, _imagePath, _callback)
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

CampScreenCraftingDialogModule.prototype.createResultPageButton = function(_currentPage, _pages)
{
	var self = this;
	this.mSearch.ResultPageList.empty();
	this.mSearch.ResultButtons = [];

	var previousButtonLayout = $('<div class="l-flex-button-39-39"/>');
	this.mSearch.ResultPageList.append(previousButtonLayout);
	var previousButton = previousButtonLayout.createImageButton(Path.GFX + 'ui/buttons/arrow_left.png', function(_button) {
		self.notifyBackendPageChanged({ID: Math.max(0, _currentPage - 1)})
	}, '', 10);
	previousButton.enableButton(_currentPage != 0);

	var startPage = 0;
	if (_currentPage >= _pages - Math.floor(this.mMaxVisiblePage / 2)) {
		startPage = Math.max(0, _pages - this.mMaxVisiblePage);
	} else {
		startPage = Math.max(0, _currentPage - Math.floor(this.mMaxVisiblePage / 2));
	}

	for (var i = startPage; i < startPage + this.mMaxVisiblePage && i < _pages; i++) {
		var buttonLayout = $('<div class="l-flex-button-39-39"/>');
		this.mSearch.ResultPageList.append(buttonLayout);
		var button = buttonLayout.createTextButton('' + (i + 1) + '', function(_button) {
			self.notifyBackendPageChanged({ID: _button.data('page')})
		}, '', 10);
		button.data('page', i);
		button.enableButton(i != _currentPage);
		this.mSearch.ResultButtons.push(button);
	}

	var nextButtonLayout = $('<div class="l-flex-button-39-39"/>');
	this.mSearch.ResultPageList.append(nextButtonLayout);
	var nextButton = nextButtonLayout.createImageButton(Path.GFX + 'ui/buttons/arrow_right.png', function(_button) {
		self.notifyBackendPageChanged({ID: Math.min(_pages, _currentPage + 1)})
	}, '', 10);
	nextButton.enableButton(_currentPage != _pages - 1);
}

CampScreenCraftingDialogModule.prototype.notifyBackendModuleShown = function ()
{
	SQ.call(this.mSQHandle, 'onModuleShown');
};

CampScreenCraftingDialogModule.prototype.notifyBackendModuleHidden = function ()
{
	SQ.call(this.mSQHandle, 'onModuleHidden');
};

CampScreenCraftingDialogModule.prototype.notifyBackendModuleAnimating = function ()
{
	SQ.call(this.mSQHandle, 'onModuleAnimating');
};

CampScreenCraftingDialogModule.prototype.notifyBackendLeaveButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onLeaveButtonPressed');
};

CampScreenCraftingDialogModule.prototype.notifyBackendBrothersButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onBrothersButtonPressed');
};

CampScreenCraftingDialogModule.prototype.notifyBackendSwap = function (_source, _target, _callback)
{
	SQ.call(this.mSQHandle, 'onSwap', [_source, _target], _callback);
};

CampScreenCraftingDialogModule.prototype.notifyBackendRemove = function (_index, _callback)
{
	SQ.call(this.mSQHandle, 'onRemove', _index, _callback);
};

CampScreenCraftingDialogModule.prototype.notifyBackendCraft = function (_blueprintID, _callback)
{
	SQ.call(this.mSQHandle, 'onAdd', _blueprintID, _callback);
};

CampScreenCraftingDialogModule.prototype.notifyBackendCraftForever = function (_blueprintID, _callback)
{
	SQ.call(this.mSQHandle, 'onCraftForever', _blueprintID, _callback);
};

CampScreenCraftingDialogModule.prototype.notifyBackendFilterAllButtonClicked = function ()
{
	SQ.call(this.mSQHandle, 'onFilterAll');
};

CampScreenCraftingDialogModule.prototype.notifyBackendFilterWeaponsButtonClicked = function ()
{
	SQ.call(this.mSQHandle, 'onFilterWeapons');
};

CampScreenCraftingDialogModule.prototype.notifyBackendFilterArmorButtonClicked = function ()
{
	SQ.call(this.mSQHandle, 'onFilterArmor');
};

CampScreenCraftingDialogModule.prototype.notifyBackendFilterMiscButtonClicked = function ()
{
	SQ.call(this.mSQHandle, 'onFilterMisc');
};

CampScreenCraftingDialogModule.prototype.notifyBackendFilterUsableButtonClicked = function () {
	SQ.call(this.mSQHandle, 'onFilterUsable');
};

CampScreenCraftingDialogModule.prototype.notifyBackendPageChanged = function (_pageID) {
	SQ.call(this.mSQHandle, 'onPageChange', _pageID, null);
};
