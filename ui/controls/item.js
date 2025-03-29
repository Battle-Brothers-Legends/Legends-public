/*
 *  @Project:		Battle Brothers
 *	@Company:		Overhype Studios
 *
 *	@Copyright:		(c) Overhype Studios | 2013 - 2020
 *
 *  @Author:		Overhype Studios
 *  @Date:			16.10.2017
 *  @Description:	Item Control JS
 */

"use strict";


var ListItemIdentifier =
{
	KeyEvent:
	{
		ListItemNamespace: '.list-item-event-namespace'
	}
};


/**
 * Create Item
 */
 $.fn.createListItem = function(_withPriceLayer, _backgroundImage, _classes)
 {
	var result = $('<div class="ui-control item is-list-item has-slot-frame"/>');

	if (_classes !== undefined && _classes !== null && typeof(_classes) === 'string')
	{
		result.addClass(_classes);
	}

	// image layer
	var backgroundImage = _backgroundImage || Path.GFX + Asset.SLOT_BACKGROUND_EMPTY;
	var imageLayer = $('<div class="image-layer"/>');
	result.append(imageLayer);

	var emptyImage = $('<img/>');
	emptyImage.attr('src', backgroundImage);
	imageLayer.append(emptyImage);

	// repair layer
	var repairLayer = $('<div class="repair-layer display-none"/>');
	result.append(repairLayer);
	var repairImage = $('<img/>');
	repairImage.attr('src', Path.GFX + Asset.ICON_REPAIR_ITEM);
	repairLayer.append(repairImage);

	// amount layer
	var amountLayer = $('<div class="amount-layer display-block"/>');
	result.append(amountLayer);

	if (_withPriceLayer === undefined || _withPriceLayer === false)
		amountLayer.addClass('no-price-layer');

	var amountLabel = $('<div class="label text-font-very-small font-shadow-outline"/>');
	amountLayer.append(amountLabel);

	// price layer
	if (_withPriceLayer !== undefined && _withPriceLayer === true)
	{
		var priceLayer = $('<div class="price-layer display-none"/>');
		result.append(priceLayer);
		var moneyImage = $('<img/>');
		moneyImage.attr('src', Path.GFX + Asset.ICON_MONEY_SMALL);
		priceLayer.append(moneyImage);
		var priceLabel = $('<div class="label text-font-very-small font-color-value font-shadow-outline"/>');
		priceLayer.append(priceLabel);
	}

	// add item data
	var itemData = this.data('item') || {};
	itemData.isEmpty = true;
	itemData.backgroundImage = backgroundImage;
	itemData.imageLayer = imageLayer;
	itemData.overlays = [];
	result.data('item', itemData);

	this.append(result);

	return result;
};

$.fn.setRepairImageVisible = function(_isVisible, _isSalvage)
{
	var imageLayer = this.find('.repair-layer:first');
	var iconLayer = this.find('.repair-layer:first > img');
	if (imageLayer.length > 0)
	{
		if (_isSalvage)
		{
			iconLayer.attr('src', Path.GFX + 'ui/icons/salvage_item.png');
		}
		else
		{
			iconLayer.attr('src', Path.GFX + Asset.ICON_REPAIR_ITEM);
		}
		if(_isVisible || _isSalvage)
		{
			imageLayer.removeClass('display-none');
			imageLayer.addClass('display-block');
		}
		else
		{
			imageLayer.addClass('display-none');
			imageLayer.removeClass('display-block');
		}
		
	}
};


$.fn.assignListItemImage = function(_imagePath)
{
	var imageLayer = this.find('.image-layer:first');
	if (imageLayer.length > 0)
	{
		var itemData = this.data('item');
		//console.error(itemData);

		// update image
		var image = imageLayer.find('img:first');
		var imagePath = _imagePath || itemData.backgroundImage;
		image.attr('src', imagePath);

		// update item data
		itemData.isEmpty = (imagePath === itemData.backgroundImage);
		this.data('item', itemData);

		// reset amount & tooltip
		if (itemData.isEmpty === true)
		{
			this.assignListItemAmount();
			this.assignListItemPrice();
			this.assignListItemTooltip();			
		}
	}
};

$.fn.assignListItemOverlayImage = function(_imagePaths)
{
	var itemData = this.data('item');
	var imageLayer = itemData.imageLayer;

	var overlays = itemData.overlays;
	overlays.forEach(function (overlay) {
		overlay.remove();
	});
	overlays = [];
	itemData.overlays = overlays

	if (_imagePaths === undefined || _imagePaths === '' || _imagePaths.length === 0)
	{
		return;
	}

	_imagePaths.forEach(function (imagePath) {
		if (imagePath === '') 
		{
			return;
		}
		var overlayImage = $('<img/>');
		overlayImage.attr('src', Path.ITEMS + imagePath);
		overlayImage.addClass('display-block');
		imageLayer.append(overlayImage);
		overlays.push(overlayImage)
	});
};

$.fn.assignListItemAmount = function(_value, _color)
{
	_color = _color || '#ffffff';

	var layer = this.find('.amount-layer:first');
	if (layer.length > 0)
	{
		var label = layer.find('.label:first');
		if (_value !== undefined && _value !== null)
		{
			label.text(_value);
			layer.removeClass('display-none').addClass('display-block');
		}
		else
		{
			layer.removeClass('display-block').addClass('display-none');
		}

		label.css({'color' : _color});
	}
};

$.fn.assignListItemPrice = function(_value)
{
	var layer = this.find('.price-layer:first');
	if (layer.length > 0)
	{
		var label = layer.find('.label:first');
		if (_value !== undefined && _value !== null)
		{
			label.text(Helper.numberWithCommas(_value));
			layer.removeClass('display-none').addClass('display-block');
		}
		else
		{
			layer.removeClass('display-block').addClass('display-none');
		}
	}
};

$.fn.assignListItemPriceColor = function(_showPositiveColor)
{
	var layer = this.find('.price-layer:first');
	if (layer.length > 0)
	{
		var label = layer.find('.label:first');
		if (_showPositiveColor !== undefined && _showPositiveColor === true)
		{
			label.removeClass('font-color-negative-value').addClass('font-color-value');
		}
		else
		{
			label.removeClass('font-color-value').addClass('font-color-negative-value');
		}
	}
};

$.fn.assignListItemRightClick = function(_callback)
{
	if (_callback !== undefined && _callback !== null && typeof(_callback) === 'function')
	{
		this.mousedown(function (event)
		{
			if (event.which === 3)
			{
				_callback($(this), event);
				return false;
			}
		});

		/*this.on('contextmenu' + ListItemIdentifier.KeyEvent.ListItemNamespace, null, this, function (event)
		{
			_callback($(this), event);
			return false;
		});*/
	}
	/*else
	{
		this.off('contextmenu' + ListItemIdentifier.KeyEvent.ListItemNamespace);
	}*/
};

$.fn.assignListItemDragAndDrop = function(_parent, _dragStartCallback, _dragEndCallback, _dropCallback)
{
	// drag handler
	this.drag("start", function(ev, dd)
	{
		// dont allow drag if this is an empty slot
		var data = $(this).data('item');
		if (data.isEmpty === true)
		{
			return false;
		}

		// build proxy
		var proxy = $('<div class="ui-control item is-proxy"/>');
		if (_parent !== undefined && _parent !== null && typeof(_parent) === 'object')
		{
			proxy.appendTo(_parent);
		}
		else
		{
			proxy.appendTo(document.body);
		}
		proxy.data('item', data);

		var imageLayer = $(this).find('.image-layer:first');
		if (imageLayer.length > 0)
		{
			imageLayer = imageLayer.clone();
			proxy.append(imageLayer);
		}

		$(dd.drag).addClass('is-dragged');
		
		var drag = $(dd.drag);

		if (jQuery.isFunction(_dragStartCallback) === true)
		{
			_dragStartCallback(drag, proxy);
		}

		return proxy;
	});

	this.drag(function(ev, dd)
	{
		$(dd.proxy).css({ top: dd.offsetY, left: dd.offsetX });
	}, { relative: false });

	this.drag("end", function(ev, dd)
	{
		var drag = $(dd.drag);
		var drop = $(dd.drop);
		var proxy = $(dd.proxy);

		var allowDragEnd = false;
		if (jQuery.isFunction(_dragEndCallback) === true)
		{
			allowDragEnd = _dragEndCallback(drag, drop, proxy);
		}

		// not dropped onto anything?
		if (drop.length === 0 || allowDragEnd === false)
		{
			proxy.velocity("finish", true).velocity({ top: dd.originalY, left: dd.originalX },
			{
				duration: 300,
				complete: function()
				{
					proxy.remove();
					drag.removeClass('is-dragged');
				}
			});
		}
		else
		{
			proxy.remove();
		}
	});


	// drop handler - add only if there is a callback
	if (jQuery.isFunction(_dropCallback) === true)
	{
		this.drop("start", function()
		{
			$(this).addClass("is-drop-target");
		});
		
		this.drop(function(ev, dd)
		{
			var drag = $(dd.drag);
			var drop = $(dd.drop);
			var proxy = $(dd.proxy);

			_dropCallback(drag, drop, proxy, dd, ev);

			// workaround if the source container was removed before we got here
			if (drag.parent().length === 0)
			{
				$(dd.proxy).remove();
			}
			else
			{
				drag.removeClass('is-dragged');
			}
		}, { mode: "intersect" });

		this.drop("end", function()
		{
			$(this).removeClass("is-drop-target");
		});
	}
};

$.fn.assignListItemTooltip = function(_itemId, _owner, _entityId)
{
	if(_itemId !== undefined && _itemId !== null)
	{

		this.bindTooltip({ contentType: 'ui-item', entityId: _entityId, itemId: _itemId, itemOwner: _owner });
	}
	else
	{
		this.unbindTooltip();
	}
};