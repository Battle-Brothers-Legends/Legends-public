TacticalCombatResultScreenLootPanel.prototype.assignItemToSlot = function(_owner, _slot, _item)
{
	var remove = false;
	if (!(TacticalCombatResultScreenIdentifier.Item.Id in _item) || !(TacticalCombatResultScreenIdentifier.Item.ImagePath in _item))
	{
		remove =  true;
	}

	if (remove === true)
	{
		this.removeItemFromSlot(_slot);
	}
	else
	{
		// update item data
		var itemData = _slot.data('item') || {};
		itemData.id = _item[TacticalCombatResultScreenIdentifier.Item.Id];
		_slot.data('item', itemData);

		// assign image
		_slot.assignListItemImage(Path.ITEMS + _item[TacticalCombatResultScreenIdentifier.Item.ImagePath]);
		_slot.assignListItemOverlayImage(_item['imageOverlayPath']);

		// show amount
		if(_item['showAmount'] === true && _item[TacticalCombatResultScreenIdentifier.Item.Amount] != '')
		{
			_slot.assignListItemAmount('' + _item[TacticalCombatResultScreenIdentifier.Item.Amount], _item['amountColor']);
		}

		// bind tooltip
		_slot.assignListItemTooltip(itemData.id, _owner);
	}
};

/**
 * Adds sort button below 'loot all button'
 */
mod_legends.Hooks.TacticalCombatResultScreenLootPanel_createDIV = TacticalCombatResultScreenLootPanel.prototype.createDIV;
TacticalCombatResultScreenLootPanel.prototype.createDIV = function (_parentDiv)
{
	mod_legends.Hooks.TacticalCombatResultScreenLootPanel_createDIV.call(this, _parentDiv);
	var self = this;
	var contentRow = $('.column.is-middle .row.is-content');
	var layout = $('<div class="l-button is-sort"/>');
	contentRow.append(layout);
	this.mSortInventoryButton = layout.createImageButton(Path.GFX + Asset.BUTTON_SORT, function() {
		self.mDataSource.notifyBackendSortButtonClicked();
	}, '', 3);
	this.mSortInventoryButton.bindTooltip({ contentType: 'msu-generic', modId: "mod_legends", elementId: "CombatResult.Sort"});
}
