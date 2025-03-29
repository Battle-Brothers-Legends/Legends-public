/*
 *  @Project:		Battle Brothers
 *	@Company:		Overhype Studios
 *
 *	@Copyright:		(c) Overhype Studios | 2013 - 2020
 *
 *  @Author:		Overhype Studios
 *  @Date:			24.01.2017 / Reworked: 26.11.2017
 *  @Description:	Inventory List Module JS
 */
"use strict";

/* TODO
 + Items Swappen / Draggen / Droppen an Datasource anbinden
 */

var CharacterScreenInventoryListModule = function(_parent, _dataSource)
{
	this.mParent = _parent;
	this.mDataSource = _dataSource;
	this.mDataSource.setInventoryModule(this);

	// container
	this.mContainer = null;
	//this.mInventoryFilterContainer	  = null;
	this.mListContainer = null;
	this.mListScrollContainer = null;
	this.mSlotCountPanel = null;
	this.mSlotCountLabel = null;
	this.mSlotCountContainer = null;

	// inventory
	this.mInventorySlots = null;

	// buttons
	this.mFilterPanel = null;
	this.mFilterMoodButton = null;
	this.mSortInventoryButton = null;
	this.mFilterAllButton = null;
	this.mFilterWeaponsButton = null;
	this.mFilterArmorButton = null;
	this.mFilterMiscButton = null;
	this.mFilterUsableButton = null;

	this.mCurrentPopupDialog = null;

	this.registerDatasourceListener();
};


CharacterScreenInventoryListModule.prototype.createDIV = function (_parentDiv)
{
	var self = this; 


	// create: containers
	this.mContainer = $('<div class="inventory-list-module opacity-none"/>');
	//this.mContainer = $('<div class="inventory-list-module display-none"/>');
	_parentDiv.append(this.mContainer);

	var listContainerLayout = $('<div class="l-list-container"/>');
	this.mContainer.append(listContainerLayout);
	this.mListContainer = listContainerLayout.createList(1.24/*7.41*/, null, true);
	this.mListScrollContainer = this.mListContainer.findListScrollContainer();

	// slot & bro count
	this.mSlotCountPanel = $('<div class="slot-count-panel"/>');
	this.mContainer.append(this.mSlotCountPanel);
	
	this.mSlotCountContainer = $('<div class="slot-count-container"/>');
	this.mSlotCountPanel.append(this.mSlotCountContainer);
	var slotSizeImage = $('<img/>');
	slotSizeImage.attr('src', Path.GFX + Asset.ICON_BAG);
	this.mSlotCountContainer.append(slotSizeImage);
	this.mSlotCountLabel = $('<div class="label text-font-small font-bold font-color-value"/>');
	this.mSlotCountContainer.append(this.mSlotCountLabel);

	// sort
	this.mFilterPanel = $('<div class="filter-panel"/>');
	this.mSlotCountPanel.append(this.mFilterPanel);

	var layout = $('<div class="l-button is-mood-filter"/>');
	this.mFilterPanel.append(layout);
	this.mFilterMoodButton = layout.createImageButton(Path.GFX + Asset.BUTTON_MOOD_FILTER, function ()
	{
		if(self.mParent.mParent.mBrothersModule.toggleMoodVisibility())
			self.mFilterMoodButton.changeButtonImage(Path.GFX + Asset.BUTTON_MOOD_FILTER);
		else
			self.mFilterMoodButton.changeButtonImage(Path.GFX + Asset.BUTTON_MOOD_FILTER_OFF);
	}, '', 3);

	var layout = $('<div class="l-button is-sort"/>');
	this.mFilterPanel.append(layout);
	this.mSortInventoryButton = layout.createImageButton(Path.GFX + Asset.BUTTON_SORT, function ()
	{
		self.mDataSource.notifyBackendSortButtonClicked();
	}, '', 3);

	var layout = $('<div class="l-button is-all-filter"/>');
	this.mFilterPanel.append(layout);
	this.mFilterAllButton = layout.createImageButton(Path.GFX + Asset.BUTTON_ALL_FILTER, function ()
	{
		self.mFilterAllButton.addClass('is-active');
		self.mFilterWeaponsButton.removeClass('is-active');
		self.mFilterArmorButton.removeClass('is-active');
		self.mFilterMiscButton.removeClass('is-active');
		self.mFilterUsableButton.removeClass('is-active');
		self.mDataSource.notifyBackendFilterAllButtonClicked();
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
		self.mDataSource.notifyBackendFilterWeaponsButtonClicked();
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
		self.mDataSource.notifyBackendFilterArmorButtonClicked();
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
		self.mDataSource.notifyBackendFilterMiscButtonClicked();
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
		self.mDataSource.notifyBackendFilterUsableButtonClicked();
	}, '', 3);

};

CharacterScreenInventoryListModule.prototype.destroyDIV = function ()
{
	this.mInventorySlots = null;

	this.mSlotCountPanel = null;

	this.mSlotCountLabel.remove();
	this.mSlotCountLabel = null;
	this.mSlotCountContainer.unbindTooltip();
	this.mSlotCountContainer.empty();
	this.mSlotCountContainer.remove();
	this.mSlotCountContainer = null;

	this.mListScrollContainer.empty();
	this.mListScrollContainer = null;
	this.mListContainer.destroyList();
	this.mListContainer = null;

	this.mContainer.empty();
	this.mContainer.remove();
	this.mContainer = null;
};


CharacterScreenInventoryListModule.prototype.querySlotByIndex = function(_itemArray, _index)
{
	if (_itemArray === null || _itemArray.length === 0 || _index < 0 || _index >= _itemArray.length)
	{
		return null;
	}

	return _itemArray[_index];
};

CharacterScreenInventoryListModule.prototype.createItemSlot = function (_owner, _index, _parentDiv, _screenDiv)
{
	var self = this;
	
	var result = _parentDiv.createListItem(false);
	result.attr('id', 'slot-index_' + _index);

	// update item data
	var itemData = result.data('item') || {};
	itemData.index = _index;
	itemData.owner = _owner;
	result.data('item', itemData);

	// add event handler
	var dropHandler = function (_source, _target, _proxy, _dd, _event)
	{		
		if (_proxy.data('item') === undefined || _target.data('item') === undefined)
		{
			console.error("not an item!");
			return false;
		}

		if (_dd.offsetY > self.mSlotCountPanel.offset().top - 25)
			return false;

		//var sourceData = _source.data('item');
		var sourceData = _proxy.data('item');
		var targetData = _target.data('item');

		var sourceOwner = (sourceData !== null && 'owner' in sourceData) ? sourceData.owner : null;
		var targetOwner = (targetData !== null && 'owner' in targetData) ? targetData.owner : null;
	  
//		 console.info(sourceData);
//		 console.info(targetData);   

		// dont allow drop animation just yet
		sourceData.isAllowedToDrop = false;
		_proxy.data('item', sourceData);

		if (sourceOwner === null || targetOwner === null)
		{
			//console.error('Failed to drop item. Owner are invalid.');
			return;
		}

		var entityId = (sourceData !== null && 'entityId' in sourceData) ? sourceData.entityId : null;
		var sourceItemId = (sourceData !== null && 'itemId' in sourceData) ? sourceData.itemId : null;
		var sourceItemIdx = (sourceData !== null && 'index' in sourceData) ? sourceData.index : null;
		var targetItemIdx = (targetData !== null && 'index' in targetData) ? targetData.index : null;
		var sourceSlotType = (sourceData !== null && 'slotType' in sourceData) ? sourceData.slotType : null;
		var targetSlotType = (targetData !== null && 'slotType' in targetData) ? targetData.slotType : null;
		var sourceIsBlockingOffhand = (sourceData !== null && 'isBlockingOffhand' in sourceData) ? sourceData.isBlockingOffhand : false;
		var targetIsBlockingOffhand = (targetData !== null && 'isBlockingOffhand' in targetData) ? targetData.isBlockingOffhand : false;

		if (sourceOwner !== CharacterScreenIdentifier.ItemOwner.Paperdoll)
		{
			if (sourceItemIdx === null)
			{
				//console.error('Failed to drop item. Source idx is invalid. #2');
				return;
			}
		}

		// don't allow swapping within the ground container
		if (sourceOwner === CharacterScreenIdentifier.ItemOwner.Ground &&
			targetOwner === CharacterScreenIdentifier.ItemOwner.Ground)
		{
			//console.error('Inventory::dropHandler: Ground item swapping not allowed!');
			return false;
		}

		if (sourceOwner === CharacterScreenIdentifier.ItemOwner.Stash &&
			targetOwner === CharacterScreenIdentifier.ItemOwner.Stash)
		{
			// don't allow swapping with same slot..
			if (sourceItemIdx === targetItemIdx)
			{
				//console.error('Inventory::dropHandler: Failed to drop item. Source idx is same as target idx.');
				return;
			}

			// allow drop animation
			sourceData.isAllowedToDrop = true;
			_proxy.data('item', sourceData);

			console.info('Stash -> Stash (swap)');
			var shiftPressed = (KeyModiferConstants.ShiftKey in _event && _event[KeyModiferConstants.ShiftKey] === true)
			var tryToUpgrade = shiftPressed && ((sourceData.slotType == "body" || sourceData.slotType == "head") && targetData.slotType == sourceData.slotType)
			self.mDataSource.swapInventoryItem(sourceItemIdx, targetItemIdx, tryToUpgrade);
			return;
		}

		// enough APs ?
		if (self.mDataSource.hasEnoughAPToEquip() === false)
		{
			//console.error('Inventory::dropHandler: Not enough Action points!');
			return;
		}

		// from Paperdoll -> Stash | Ground
		if (sourceOwner === CharacterScreenIdentifier.ItemOwner.Paperdoll &&
			(targetOwner === CharacterScreenIdentifier.ItemOwner.Stash || targetOwner === CharacterScreenIdentifier.ItemOwner.Ground)
		   )
		{
			// NOTE: (js) check conditions
			var ignoreSlotType = false;

			// Special Case: Source = Twohander and Target = Offhand and Inventory = Stash and Main & Offhand are filled with Item and Stash = full
			if (sourceSlotType === CharacterScreenIdentifier.ItemSlot.Offhand && sourceIsBlockingOffhand === true)
			{
				//console.info('yay');
				ignoreSlotType = true;
			}

			// Same Slot type ?
			if (ignoreSlotType === false && targetSlotType !== null)
			{
				if (sourceSlotType !== targetSlotType)
				{
					//console.error('Inventory::dropHandler: Item must be the same slot type!');
					return;
				}
			}

			// allow drop animation
			sourceData.isAllowedToDrop = true;
			_proxy.data('item', sourceData);

			//console.info('Paperdoll -> Stash | Ground (targetIdx: ' + targetItemIdx + ')');
			self.mDataSource.dropPaperdollItem(entityId, sourceItemId, targetItemIdx);
			return;
		}

		// from Backpack -> Stash | Ground
		if (sourceOwner === CharacterScreenIdentifier.ItemOwner.Backpack &&
			(targetOwner === CharacterScreenIdentifier.ItemOwner.Stash || targetOwner === CharacterScreenIdentifier.ItemOwner.Ground)
			)
		{
			// don't allow helmets / armor within the bags
			if (targetSlotType === CharacterScreenIdentifier.ItemSlot.Head || targetSlotType === CharacterScreenIdentifier.ItemSlot.Body || targetSlotType === CharacterScreenIdentifier.ItemSlot.Accessory || targetSlotType === CharacterScreenIdentifier.ItemSlot.None)
			{
				//console.error('Inventory::dropHandler: Swapping with Head | Body into Backpack is not allowed!');
				return;
			}

			// allow drop animation
			sourceData.isAllowedToDrop = true;
			_proxy.data('item', sourceData);

			//console.info('Backpack -> Stash | Ground (targetIdx: ' + targetItemIdx + ')');
			self.mDataSource.dropBagItemIntoInventory(entityId, sourceItemId, sourceItemIdx, targetItemIdx);
		}
	};

	var dragEndHandler = function (_source, _target, _proxy)
	{   
		//var paperdollModule = $('.paperdoll-module');
		$(".is-equipable").each(function()
		{
			$(this).removeClass('is-equipable');
		});
		
		if (_source.length === 0 || _target.length === 0)
		{
			return false;
		}

		//var sourceData = _source.data('item');
		var sourceData = _proxy.data('item');
		var targetData = _target.data('item');
		//var proxyData = _source.data('item');

//		console.info('dragEndHandler: #1');
// 		console.info(sourceData);
//		 console.info(targetData);
		//console.info(proxyData);

		var isAllowedToDrop = (sourceData !== null && 'isAllowedToDrop' in sourceData && targetData !== undefined && targetData !== null) ? sourceData.isAllowedToDrop : false;
		if (isAllowedToDrop === false)
		{
			//console.warn('Inventory::dragEndHandler: Failed to drop item. Not allowed.');
			return false;
		}

		var sourceOwner = (sourceData !== null && 'owner' in sourceData) ? sourceData.owner : null;
		var targetOwner = (targetData !== null && 'owner' in targetData) ? targetData.owner : null;
		//var itemIdx = (sourceData !== null && 'index' in sourceData) ? sourceData.index : null;
		var isEmpty = (targetData !== null && 'isEmpty' in targetData) ? targetData.isEmpty : true;

/*
		if (sourceOwner === null || targetOwner === null)
		{
			console.error('Failed to drop item. Owner are invalid.');
			return false;
		}
*/

		// we don't allow swapping within the ground container
		if (sourceOwner === CharacterScreenIdentifier.ItemOwner.Ground && targetOwner === CharacterScreenIdentifier.ItemOwner.Ground)
		{
			console.error('Failed to swap item within ground container. Not allowed.');
			return false;
		}

		// we allow direct swapping within the stash container
		if (sourceOwner === CharacterScreenIdentifier.ItemOwner.Stash && targetOwner === CharacterScreenIdentifier.ItemOwner.Stash)
		{
			return true;
		}

/*
		// we only allow equipping items with the same slot type
		var sourceSlotType = (sourceData !== null && 'slotType' in sourceData) ? sourceData.slotType : null;
		var targetSlotType = (targetData !== null && 'slotType' in targetData) ? targetData.slotType : null;
		var proxySlotType = (proxyData !== null && 'slotType' in proxyData) ? proxyData.slotType : null;
		var sourceIsBlockingOffhand = (sourceData !== null && 'isBlockingOffhand' in sourceData) ? sourceData.isBlockingOffhand : false;
		var targetIsBlockingOffhand = (targetData !== null && 'isBlockingOffhand' in targetData) ? targetData.isBlockingOffhand : false;

		console.info('sourceType: ' + sourceSlotType);
		console.info('targetType: ' + targetSlotType);
		console.info('proxyType: ' + proxySlotType);

		console.info('sourceIsBlockingOffhand: ' + sourceIsBlockingOffhand);
		console.info('targetIsBlockingOffhand: ' + targetIsBlockingOffhand);

		// same slot type?
		if ((sourceSlotType === CharacterScreenIdentifier.ItemSlot.Mainhand && sourceIsBlockingOffhand === true) &&
			targetSlotType === CharacterScreenIdentifier.ItemSlot.Mainhand && self.mDataSource.hasItemEquipped(CharacterScreenIdentifier.ItemSlot.Offhand)
			)
		{
			console.error('#3');
			return false;
		}

		if (sourceSlotType === CharacterScreenIdentifier.ItemSlot.Offhand &&
			(targetSlotType === CharacterScreenIdentifier.ItemSlot.Mainhand && targetIsBlockingOffhand === true)
			)
		{
			console.info('#4');
			return true;
		}

		if (sourceSlotType !== targetSlotType)
		{
			console.error('Failed to drop item. Slot types have to be the same. #2');
			return false;
		}
*/

		// we don't allow swapping if there is not enough money or space left
		/*
		if (sourceOwner === WorldTownScreenIdentifier.ItemOwner.Shop)
		{
			return self.mDataSource.hasEnoughMoneyToBuy(itemIdx) && self.mDataSource.isStashSpaceLeft();
		}
		*/

		return true;
	};
	
	var dragStartHandler = function (_source, _proxy)
	{
		var paperdollModule = $('.paperdoll-module');
				
		if (_source.length === 0)
		{
			return false;
		}

		//var sourceData = _source.data('item');
		var sourceData = _proxy.data('item');
		//var proxyData = _source.data('item');
		var sourceSlotType = (sourceData !== null && 'slotType' in sourceData) ? sourceData.slotType : null;
		//console.log("Source data: " + sourceSlotType);	   
			   
		switch (sourceSlotType)
		{
			case CharacterScreenIdentifier.ItemSlot.Mainhand:
				var leftColumn = paperdollModule.find('.equipment-column:first');
				var mainhandContainer = leftColumn.find('.ui-control.paperdoll-item.has-slot-frame.is-big:first');
				mainhandContainer.addClass('is-equipable');
				break;
			case CharacterScreenIdentifier.ItemSlot.Head:
				var middleColumn = paperdollModule.find('.equipment-column:eq(1)');
				var headContainer = middleColumn.find('.ui-control.paperdoll-item.has-slot-frame:first');
				headContainer.addClass('is-equipable');
				break;
			case CharacterScreenIdentifier.ItemSlot.Offhand:
				var rightColumn = paperdollModule.find('.equipment-column:eq(2)');
				var offhandContainer = rightColumn.find('.ui-control.paperdoll-item.has-slot-frame.is-big:first');
				offhandContainer.addClass('is-equipable');
				break;
			case CharacterScreenIdentifier.ItemSlot.Body:
				var middleColumn = paperdollModule.find('.equipment-column:eq(1)');
				var bodyArmorContainer = middleColumn.find('.ui-control.paperdoll-item.has-slot-frame.is-big:first');
				bodyArmorContainer.addClass('is-equipable');
				break;
			case CharacterScreenIdentifier.ItemSlot.Ammo:
				var rightColumn = paperdollModule.find('.equipment-column:eq(2)');
				var ammoContainer = rightColumn.find('.ui-control.paperdoll-item.has-slot-frame:first');
				ammoContainer.addClass('is-equipable');
				break;
			case CharacterScreenIdentifier.ItemSlot.Accessory:
				var leftColumn = paperdollModule.find('.equipment-column:first');
				var accessoryContainer = leftColumn.find('.ui-control.paperdoll-item.has-slot-frame:first');
				accessoryContainer.addClass('is-equipable');   
		}
		
		// if the item is not a head or armor piece, the item can go in the bag slots
		if (sourceData.isAllowedInBag === true)
		{
			$('div.l-backpack-row div.paperdoll-item.has-slot-frame').addClass('is-equipable');
		}
		
		/*
		console.info(sourceData);
		console.info(proxyData);
		*/

		return true;	   
	};

	result.assignListItemDragAndDrop(_screenDiv, dragStartHandler, dragEndHandler, dropHandler); //_owner === CharacterScreenIdentifier.ItemOwner.Stash ? dropHandler : null);

	result.assignListItemRightClick(function (_item, _event)
	{
		var data = _item.data('item');


		var isEmpty = (data !== null && 'isEmpty' in data) ? data.isEmpty : ytrue;
		//var owner = (data !== null && 'owner' in data) ? data.owner : null;
		var itemId = (data !== null && 'itemId' in data) ? data.itemId : null;
		var entityId = (data !== null && 'entityId' in data) ? data.entityId : null;
		var sourceItemIdx = (data !== null && 'index' in data) ? data.index : null;
		var dropIntoBag = (KeyModiferConstants.CtrlKey in _event && _event[KeyModiferConstants.CtrlKey] === true);
		var repairItem = (KeyModiferConstants.AltKey in _event && _event[KeyModiferConstants.AltKey] === true);
		var removeUpgrades = (KeyModiferConstants.ShiftKey in _event && _event[KeyModiferConstants.ShiftKey] === true && ("isUsable" in data && data.isUsable === false));
		var sourceSlotType = (data !== null && 'slotType' in data) ? data.slotType : null;

		if (isEmpty === false && /*owner !== null &&*/ itemId !== null /*&& itemIdx !== null*/)
		{
			// equip or drop in bag
			if (dropIntoBag === true)
			{
				if (data.isAllowedInBag === false)
				{
					console.info('put item into bag: ' + itemId + ' not allowed for: ' + sourceSlotType);
					return;
				}

				self.mDataSource.dropInventoryItemIntoBag(entityId, itemId, sourceItemIdx, null);
			}
			else if (removeUpgrades === true)
			{
				self.mDataSource.notifyBackendRemoveInventoryItemUpgrades(sourceItemIdx);
			}
			else
			{
				if (repairItem === true)
				{
					self.mDataSource.toggleInventoryItem(itemId, null, function(ret)
					{
						data['repair'] = ret['repair'];
						data['salvage'] = ret['salvage'];
						result.setRepairImageVisible(data['repair'], data['salvage']);
						//result.setSalvageImageVisible(data['salvage']);
					})
				}
				else
				{
					self.mDataSource.equipInventoryItem(entityId, itemId, null);
				}
			}
		}
	});

	return result;
};

CharacterScreenInventoryListModule.prototype.createItemSlots = function (_owner, _size, _itemArray, _itemContainer)
{
	var screen = $('.character-screen');
	for (var i = 0; i < _size; ++i)
	{
		_itemArray.push(this.createItemSlot(_owner, i, _itemContainer, screen));
	}
};

CharacterScreenInventoryListModule.prototype.assignItems = function (_entityId, _owner, _items, _itemArray, _itemContainer)
{
	this.destroyItemSlots(_itemArray, _itemContainer);

	if (_items.length > 0)
	{
		this.createItemSlots(_owner, _items.length, _itemArray, _itemContainer);

		for (var i = 0; i < _items.length; ++i)
		{
			// ignore empty slots
			if (_items[i] !== undefined && _items[i] !== null)
			{
				this.assignItemToSlot(_entityId, _owner, _itemArray[i], _items[i]);
			}
		}

		//this.updateItemPriceLabels(_itemArray, _items, _owner === WorldTownScreenIdentifier.ItemOwner.Stash);

		this.updateSlotsLabel();
	}
};

CharacterScreenInventoryListModule.prototype.assignItemToSlot = function(_entityId, _owner, _slot, _item)
{
	var remove = false;

	if(!(CharacterScreenIdentifier.Item.Id in _item) || !(CharacterScreenIdentifier.Item.ImagePath in _item))
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
		var itemData = _slot.data('item');
		itemData.itemId = _item[CharacterScreenIdentifier.Item.Id];
		itemData.slotType = _item[CharacterScreenIdentifier.Item.Slot];
		itemData.entityId = _entityId;
		itemData.isBlockingOffhand = (CharacterScreenIdentifier.ItemFlag.IsBlockingOffhand in _item ? _item[CharacterScreenIdentifier.ItemFlag.IsBlockingOffhand] : false);
		itemData.isAllowedInBag = _item.isAllowedInBag;
		itemData.isUsable = _item.isUsable;
		_slot.data('item', itemData);

		// assign image
		_slot.assignListItemImage(Path.ITEMS + _item[CharacterScreenIdentifier.Item.ImagePath]);
		_slot.assignListItemOverlayImage(_item['imageOverlayPath']);

		// show repair icon?
		itemData.repair = _item['repair'];
		itemData.salvage = _item['salvage'];
		_slot.setRepairImageVisible(_item['repair'], _item['salvage']);

		// show amount
		if(_item['showAmount'] === true && _item[CharacterScreenIdentifier.Item.Amount] != '')
		{
			_slot.assignListItemAmount('' + _item[CharacterScreenIdentifier.Item.Amount], _item[CharacterScreenIdentifier.Item.AmountColor]);
		}

		// bind tooltip
		_slot.assignListItemTooltip(itemData.itemId, _owner, _entityId);
	}
};

CharacterScreenInventoryListModule.prototype.updateSlotItem = function (_entityId, _owner, _itemArray, _item, _index, _flag)
{
	var slot = this.querySlotByIndex(_itemArray, _index);
	if (slot === null)
	{
		console.error('ERROR: Failed to update slot item: Reason: Invalid slot index: ' + _index);
		return;
	}

	switch(_flag)
	{
		case CharacterScreenDatasourceIdentifier.Inventory.StashItemUpdated.Flag.Inserted:
		case CharacterScreenDatasourceIdentifier.Inventory.StashItemUpdated.Flag.Updated:
		{
			this.removeItemFromSlot(slot);
			this.assignItemToSlot(_entityId, _owner, slot, _item);
			//this.updateItemPriceLabel(slot, _item, _owner === CharacterScreenIdentifier.ItemOwner.Stash);

			break;
		}
		case CharacterScreenDatasourceIdentifier.Inventory.StashItemUpdated.Flag.Removed:
		{
			this.removeItemFromSlot(slot);

			break;
		}
		case 'Grow':
		
			break;
	}

	/*
	if (_owner === CharacterScreenIdentifier.ItemOwner.Stash)
	{
		this.updateStashFreeSlotsLabel();
	}
	*/
};

CharacterScreenInventoryListModule.prototype.removeItemFromSlot = function(_slot)
{
	// remove item image
	_slot.assignListItemImage();
	_slot.assignListItemOverlayImage();
	_slot.setRepairImageVisible(false, false);

	// update item data
	var itemData = _slot.data('item') || {};
	itemData.itemId = null;
	itemData.slotType = null;
	itemData.entityId  = null;
	itemData.isBlockingOffhand = null;
	itemData.isAllowedInBag = null;
	_slot.data('item', itemData);
};

CharacterScreenInventoryListModule.prototype.clearItemSlots = function (_itemArray)
{
	if (_itemArray === null || _itemArray.length === 0)
	{
		return;
	}

	for (var i = 0; i < _itemArray.length; ++i)
	{
		// remove item image
		this.removeItemFromSlot(_itemArray[i]);
	}
};

CharacterScreenInventoryListModule.prototype.destroyItemSlots = function (_itemArray, _itemContainer)
{
	this.clearItemSlots(_itemArray);

	_itemContainer.empty();

	if (_itemArray !== undefined && _itemArray !== null)
	{
		_itemArray.length = 0;
	}
};



CharacterScreenInventoryListModule.prototype.registerDatasourceListener = function()
{
	this.mDataSource.addListener(ErrorCode.Key, jQuery.proxy(this.onDataSourceError, this));

	this.mDataSource.addListener(CharacterScreenDatasourceIdentifier.Brother.Updated, jQuery.proxy(this.onBrotherUpdated, this));
	this.mDataSource.addListener(CharacterScreenDatasourceIdentifier.Brother.Selected, jQuery.proxy(this.onBrotherSelected, this));
	this.mDataSource.addListener(CharacterScreenDatasourceIdentifier.Inventory.ModeUpdated, jQuery.proxy(this.onInventoryModeUpdated, this));

	this.mDataSource.addListener(CharacterScreenDatasourceIdentifier.Inventory.StashLoaded, jQuery.proxy(this.onStashLoaded, this));
	this.mDataSource.addListener(CharacterScreenDatasourceIdentifier.Inventory.StashItemUpdated.Key, jQuery.proxy(this.onStashItemUpdated, this));
};


CharacterScreenInventoryListModule.prototype.create = function(_parentDiv)
{
	this.createDIV(_parentDiv);
	this.bindTooltips();
};

CharacterScreenInventoryListModule.prototype.destroy = function()
{
	this.unbindTooltips();
	this.destroyDIV();
};

CharacterScreenInventoryListModule.prototype.bindTooltips = function ()
{
	this.mSortInventoryButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterScreen.RightPanelHeaderModule.SortButton });
	this.mFilterAllButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterScreen.RightPanelHeaderModule.FilterAllButton });
	this.mFilterWeaponsButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterScreen.RightPanelHeaderModule.FilterWeaponsButton });
	this.mFilterArmorButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterScreen.RightPanelHeaderModule.FilterArmorButton });
	this.mFilterMiscButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterScreen.RightPanelHeaderModule.FilterMiscButton });
	this.mFilterUsableButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterScreen.RightPanelHeaderModule.FilterUsableButton });
	this.mFilterMoodButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterScreen.RightPanelHeaderModule.FilterMoodButton });
};

CharacterScreenInventoryListModule.prototype.unbindTooltips = function ()
{
	this.mSortInventoryButton.unbindTooltip();
	this.mFilterAllButton.unbindTooltip();
	this.mFilterWeaponsButton.unbindTooltip();
	this.mFilterArmorButton.unbindTooltip();
	this.mFilterMiscButton.unbindTooltip();
	this.mFilterUsableButton.unbindTooltip();
	this.mFilterMoodButton.unbindTooltip();
};

CharacterScreenInventoryListModule.prototype.register = function (_parentDiv)
{
	console.log('CharacterScreenInventoryListModule::REGISTER');

	if (this.mContainer !== null)
	{
		console.error('ERROR: Failed to register Inventory Module. Reason: Module is already initialized.');
		return;
	}

	if (_parentDiv !== null && typeof(_parentDiv) == 'object')
	{
		this.create(_parentDiv);
	}
};

CharacterScreenInventoryListModule.prototype.unregister = function ()
{
	console.log('CharacterScreenInventoryListModule::UNREGISTER');

	if (this.mContainer === null)
	{
		console.error('ERROR: Failed to unregister Inventory Module. Reason: Module is not initialized.');
		return;
	}

	this.destroy();
};

CharacterScreenInventoryListModule.prototype.isRegistered = function ()
{
	if (this.mContainer !== null)
	{
		return this.mContainer.parent().length !== 0;
	}

	return false;
};


CharacterScreenInventoryListModule.prototype.show = function ()
{
	// NOTE: (js) HACK which prevents relayouting..
	this.mContainer.removeClass('opacity-none no-pointer-events').addClass('opacity-full');
	//this.mContainer.removeClass('display-none').addClass('display-full');
};

CharacterScreenInventoryListModule.prototype.hide = function ()
{
	// NOTE: (js) HACK which prevents relayouting..
	this.mContainer.removeClass('opacity-full is-top').addClass('opacity-none no-pointer-events');
	//this.mContainer.removeClass('display-block is-top').addClass('display-none');
};

CharacterScreenInventoryListModule.prototype.isVisible = function ()
{
	//return this.mContainer.hasClass('display-block');
	return this.mContainer.hasClass('opacity-full');
};

CharacterScreenInventoryListModule.prototype.toggleFilterPanel = function (val)
{
	if (val) {
		this.mFilterPanel.show();
		return;
	}
	this.mSlotCountContainer.show();
	this.mFilterPanel.hide();   
};


CharacterScreenInventoryListModule.prototype.setSlotCountTooltip = function ()
{
	if (this.mDataSource.isInStashMode() === true)
	{
		this.mSlotCountContainer.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.Stash.FreeSlots });
	}
	else
	{
		this.mSlotCountContainer.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.Ground.Slots });
	}
};

CharacterScreenInventoryListModule.prototype.updateSlotsLabel = function ()
{
	var statistics = null;
	if (this.mDataSource.isInStashMode() === true)
	{
		statistics = this.mDataSource.getStashStatistics();
		this.mSlotCountLabel.html('' + statistics.used + '/' + statistics.size);
		if (statistics.used >= statistics.size)
		{
			this.mSlotCountLabel.removeClass('font-color-value').addClass('font-color-negative-value');
		}
		else
		{
			this.mSlotCountLabel.removeClass('font-color-negative-value').addClass('font-color-value');
		}
	}
	else
	{
		statistics = this.mDataSource.getGroundStatistics();
		this.mSlotCountLabel.html('' + statistics.size);
		this.mSlotCountLabel.removeClass('font-color-negative-value').addClass('font-color-value');  
	}
};


CharacterScreenInventoryListModule.prototype.onInventoryModeUpdated = function (_dataSource, _mode)
{
	if (_mode === null || typeof(_mode) !== 'string')
	{
		return;
	}

	switch(_mode)
	{
		case CharacterScreenDatasourceIdentifier.InventoryMode.Ground:
		{
			this.mSlotCountContainer.hide();
			this.onBrotherSelected(_dataSource, _dataSource.getSelectedBrother());
		} break;
		case CharacterScreenDatasourceIdentifier.InventoryMode.Stash:
		case CharacterScreenDatasourceIdentifier.InventoryMode.BattlePreparation:
		{
			this.onStashLoaded(_dataSource, _dataSource.getStashList());
		} break;
	}

	this.setSlotCountTooltip();
};

CharacterScreenInventoryListModule.prototype.onBrotherUpdated = function (_dataSource, _brother)
{
	if (_dataSource.isSelectedBrother(_brother))
	{
		this.onBrotherSelected(_dataSource, _brother);
	}
};

CharacterScreenInventoryListModule.prototype.onBrotherSelected = function (_dataSource, _data)
{
	if (_data === null || !(CharacterScreenIdentifier.Entity.Id in _data))
	{
		return;
	}

	// ignore update if the inventory is in stash mode
	if (_dataSource.isInGroundMode() !== true)
	{
		//console.error("ERROR: Failed to update inventory. Reason: Inventory not in ground mode.");
		return;
	}

	if (this.mInventorySlots === null)
	{
		this.mInventorySlots = [];
	}

	// call by ref hack
	var arrayRef = { val: this.mInventorySlots };
	var containerRef = { val: this.mListScrollContainer };

	this.assignItems(_data[CharacterScreenIdentifier.Entity.Id], CharacterScreenIdentifier.ItemOwner.Ground, _data[CharacterScreenIdentifier.Entity.Ground], arrayRef.val, containerRef.val);
};

CharacterScreenInventoryListModule.prototype.onStashLoaded = function (_dataSource, _data, _reset)
{
	if (_data === undefined || _data === null || !jQuery.isArray(_data))
	{
		return;
	}

	/*
	if (_dataSource.isInStashMode() !== true)
	{
		console.error("ERROR: Failed to update inventory. Reason: Inventory not in stash mode.");
		return;
	}
	*/

	if (this.mInventorySlots === null || _reset)
	{
		this.mInventorySlots = [];
	}

	// call by ref hack
	var arrayRef = { val: this.mInventorySlots };
	var containerRef = { val: this.mListScrollContainer };

	this.assignItems(null, _dataSource.isInStashMode() ? CharacterScreenIdentifier.ItemOwner.Stash : CharacterScreenIdentifier.ItemOwner.Ground, _data, arrayRef.val, containerRef.val);
};

CharacterScreenInventoryListModule.prototype.onStashItemUpdated = function (_dataSource, _data)
{
	if (_data === null || typeof(_data) !== 'object' || !('item' in _data) || !('index' in _data) || !('flag' in _data))
	{
		return;
	}

	if (_dataSource.isInStashMode() !== true)
	{
		console.error("ERROR: Failed to update inventory item. Reason: Inventory not in stash mode.");
		return;
	}

	this.updateSlotItem(null, _dataSource.isInStashMode() ? CharacterScreenIdentifier.ItemOwner.Stash : CharacterScreenIdentifier.ItemOwner.Ground, this.mInventorySlots, _data.item, _data.index, _data.flag);
};

CharacterScreenInventoryListModule.prototype.onDataSourceError  = function (_dataSource, _data)
{
	if (_data  === undefined || _data === null || typeof(_data) !== 'number')
	{
		return;
	}

	switch(_data)
	{
		case ErrorCode.NotEnoughStashSpace:
		{
			this.mSlotCountLabel.shakeLeftRight();
		} break;
	}

	console.info('CharacterScreenInventoryListModule::onDataSourceError(' + _data + ')');
};


