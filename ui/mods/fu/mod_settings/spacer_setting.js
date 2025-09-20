var SpacerSetting = function (_mod, _page, _setting, _parentDiv)
{
	this.data = _setting;
	this.layout = $('<div class="spacer"/>');
	_parentDiv.append(this.layout);
	this.layout.css("width", this.data.data.Width);
	this.layout.css("height", this.data.data.Height);
};

SpacerSetting.prototype.unbindTooltip = function ()
{
};
