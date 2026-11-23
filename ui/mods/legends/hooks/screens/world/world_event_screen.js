mod_legends.Hooks.WorldEventScreen_renderListItem = WorldEventScreen.prototype.renderListItem;
WorldEventScreen.prototype.renderListItem = function (_container, _item)
{
	mod_legends.Hooks.WorldEventScreen_renderListItem.call(this, _container, _item);
	var lastRow = _container.find('.row.list').last();
	if ('divider' in _item && _item['divider'] === 'top')
		lastRow.addClass("divider-top");
	if ('divider' in _item && _item['divider'] === 'bottom')
		lastRow.addClass("divider-bottom");

	if ('imageOverlayPath' in _item && _item.imageOverlayPath !== null && _item.imageOverlayPath.length > 0)
    {
        var baseImage = lastRow.find('img');
        if (baseImage.length > 0)
        {
            baseImage.wrap('<div class="item-image-container"/>');
            var itemImageContainer = lastRow.find('.item-image-container');

            _item.imageOverlayPath.forEach(function (path) {
                if (path === '') return;
                var overlayImage  = $('<img/>');
                overlayImage .attr('src', Path.ITEMS + path);
                itemImageContainer.append(overlayImage);
            });
        }
    }
};
