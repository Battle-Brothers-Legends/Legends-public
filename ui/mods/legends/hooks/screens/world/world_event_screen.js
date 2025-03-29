mod_legends.Hooks.WorldEventScreen_renderListItem = WorldEventScreen.prototype.renderListItem;
WorldEventScreen.prototype.renderListItem = function (_container, _item)
{
	mod_legends.Hooks.WorldEventScreen_renderListItem.call(this, _container, _item);
	var lastRow = _container.find('.row.list').last();
	if ('divider' in _item && _item['divider'] === 'top')
		lastRow.addClass("divider-top");
	if ('divider' in _item && _item['divider'] === 'bottom')
		lastRow.addClass("divider-bottom");
};
