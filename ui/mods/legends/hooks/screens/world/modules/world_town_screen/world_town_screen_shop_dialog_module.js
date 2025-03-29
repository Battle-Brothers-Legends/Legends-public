WorldTownScreenShopDialogModule.prototype.assignItemToSlot = function(_owner, _slot, _item)
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
