/*
 *  @Project:		Battle Brothers
 *	@Company:		Overhype Studios
 *
 *	@Copyright:		(c) Overhype Studios | 2013 - 2020
 *
 *  @Author:		Overhype Studios
 *  @Date:			10.12.2017
 *  @Description:	Paperdoll Item Control JS
 */

"use strict";

var PaperdollItemIdentifier = {
	KeyEvent: {
		PaperdollItemNamespace: '.paperdoll-item-event-namespace'
	}
};

/**
 * Create Paperdoll Item
 */
 $.fn.createPaperdollItem = function(_isBig, _backgroundImage, _classes)
 {
	var result = $('<div class="ui-control paperdoll-item has-slot-frame"/>');

	var isBig = _isBig || false;
	if (isBig === true)
	{
		result.addClass('is-big');
	}

	if (_classes !== undefined && _classes !== null && typeof(_classes) === 'string')
	{
		result.addClass(_classes);
	}

	// image layer
	var backgroundImage = _backgroundImage || Path.GFX + Asset.SLOT_BACKGROUND_BAG;
	var imageLayer = $('<div class="image-layer"/>');
	result.append(imageLayer);

	var emptyImage = $('<img/>');
	emptyImage.attr('src', backgroundImage);
	imageLayer.append(emptyImage);

	// locked layer
	var lockedLayer = $('<div class="locked-layer display-none"/>');
	result.append(lockedLayer);
	var lockedImage = $('<img/>');
	lockedImage.attr('src', Path.GFX + Asset.ICON_LOCKED);
	lockedLayer.append(lockedImage);

	 // repair layer
	var repairLayer;

	if(_isBig)
		repairLayer = $('<div class="repair-layer repair-layer-big display-none"/>');
	else
		repairLayer = $('<div class="repair-layer display-none"/>');

	result.append(repairLayer);
	var repairImage = $('<img/>');
	repairImage.attr('src', Path.GFX + Asset.ICON_REPAIR_ITEM);
	repairLayer.append(repairImage);

	// amount layer
	var amountLayer = $('<div class="amount-layer display-none"/>');
	result.append(amountLayer);
	var amountLabel = $('<div class="label text-font-very-small font-shadow-outline"/>');
	amountLayer.append(amountLabel);


	// add item data
	var itemData = this.data('item') || {};
	itemData.isBig = isBig;
	itemData.isEmpty = true;
	itemData.isImageSmall = false;
	itemData.backgroundImage = backgroundImage;
	itemData.imageLayer = imageLayer;
	itemData.overlays = [];
	result.data('item', itemData);

	this.append(result);

	return result;
};

$.fn.setPaperdollRepairImageVisible = function(_isVisible)
{
	var imageLayer = this.find('.repair-layer:first');
	if (imageLayer.length > 0)
	{
		if(_isVisible)
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

$.fn.assignPaperdollItemImage = function(_imagePath, _imageIsSmall, _isBlocked)
{
	var imageLayer = this.find('.image-layer:first');
	if (imageLayer.length > 0)
	{
		var itemData = this.data('item');

		// update image
		var image = imageLayer.find('img:first');
		var imagePath = _imagePath || itemData.backgroundImage;
		image.attr('src', imagePath);

		// update item data
		itemData.isEmpty = (imagePath === itemData.backgroundImage);
		itemData.isImageSmall = _imageIsSmall || false;
		this.data('item', itemData);

		// reset amount & tooltip
		if (itemData.isEmpty === true)
		{
			this.assignPaperdollItemAmount();
			this.assignPaperdollItemTooltip();
		}

		if (itemData.isImageSmall === true)
		{
			image.addClass('is-small');
		}
		else
		{
			image.removeClass('is-small');
		}

		if (_isBlocked !== undefined && _isBlocked === true)
		{
			image.addClass('is-blocked');
		}
		else
		{
			image.removeClass('is-blocked');
		}
	}
};

$.fn.assignPaperdollItemOverlayImage = function(_imagePaths, _imageIsSmall, _isBlocked)
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
		if (imagePath === '') {
			return;
		}
		var overlayImage = $('<img/>');
		overlayImage.attr('src', Path.ITEMS + imagePath);
		if(itemData.isImageSmall === true)
			overlayImage.addClass('is-small');
		else
			overlayImage.removeClass('is-small');

		if(_isBlocked !== undefined && _isBlocked === true)
			overlayImage.addClass('is-blocked');
		else
			overlayImage.removeClass('is-blocked');

		imageLayer.append(overlayImage);
		overlays.push(overlayImage)
	})
};

$.fn.showPaperdollLockedImage = function(_value)
{
	var layer = this.find('.locked-layer:first');
	if (layer.length > 0)
	{
		var label = layer.find('.label:first');
		if (_value !== undefined && _value === true)
		{
			layer.removeClass('display-none').addClass('display-block');
			label.html(_value);
		}
		else
		{
			layer.removeClass('display-block').addClass('display-none');
		}
	}
};

$.fn.assignPaperdollItemAmount = function(_value, _color)
{
	_color = _color || '#ffffff';

	var layer = this.find('.amount-layer:first');

	if (layer.length > 0)
	{
		var label = layer.find('.label:first');
		if (_value !== undefined && _value !== null)
		{
			layer.removeClass('display-none').addClass('display-block');
			label.html(_value);
		}
		else
		{
			layer.removeClass('display-block').addClass('display-none');
		}

		label.css({'color' : _color});
	}
};

$.fn.assignPaperdollItemRightClick = function(_callback)
{
	if (_callback !== undefined && _callback !== null && typeof (_callback) === 'function')
	{
		this.mousedown(function (event)
		{
			if (event.which === 3)
			{
				_callback($(this), event);
				return false;
			}
		});
	}

	/*if (_callback !== undefined && _callback !== null && typeof (_callback) === 'function')
	{
		this.on('contextmenu' + PaperdollItemIdentifier.KeyEvent.PaperdollItemNamespace, null, this, function (event)
		{
			_callback($(this), event);
			return false;
		});
	}
	else
	{
		this.off('contextmenu' + PaperdollItemIdentifier.KeyEvent.PaperdollItemNamespace);
	}*/
};

$.fn.assignPaperdollItemDragAndDrop = function(_parent, _dragStartCallback, _dragEndCallback, _dropCallback)
{
	// drag handler
	this.drag("start", function(ev, dd) {
		// dont allow drag if this is an empty slot
		var data = $(this).data('item');
		if (data.isEmpty === true)
		{
			return false;
		}

		// build proxy
		var proxy = $('<div class="ui-control paperdoll-item is-proxy"/>');
		if (data.isBig === true)
		{
			proxy.addClass('is-big');
		}

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

	this.drag(function(ev, dd) {
		$(dd.proxy).css({ top: dd.offsetY, left: dd.offsetX });
	}, { relative: false });

	this.drag("end", function(ev, dd) {
		var drag = $(dd.drag);
		var drop = $(dd.drop);
		var proxy = $(dd.proxy);

		var allowDragEnd = false;
		if (jQuery.isFunction(_dragEndCallback) === true)
		{
			allowDragEnd = _dragEndCallback(drag, drop, proxy);
		}

		// not dropped into anything?
		if (drop.length === 0 || allowDragEnd === false)
		{
			proxy.velocity("finish", true).velocity({ top: dd.originalY, left: dd.originalX }, {
				duration: 300,
				complete: function() {
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
		this.drop("start", function() {
			$(this).addClass("is-drop-target");
		});
		this.drop(function(ev, dd) {
			var drag = $(dd.drag);
			var drop = $(dd.drop);
			var proxy = $(dd.proxy);

			_dropCallback(drag, drop, proxy);

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
		this.drop("end", function() {
			$(this).removeClass("is-drop-target");
		});
	}
};

$.fn.assignPaperdollItemTooltip = function(_itemId, _owner, _entityId)
{
	if (_itemId !== undefined && _itemId !== null)
	{
		this.bindTooltip({ contentType: 'ui-item', entityId: _entityId, itemId: _itemId, itemOwner: _owner });
	}
	else
	{
		this.unbindTooltip();
	}
};