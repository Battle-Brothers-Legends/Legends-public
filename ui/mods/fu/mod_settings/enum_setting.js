var EnumSetting = function (_mod, _page, _setting, _parentDiv)
{
	this.data = _setting;
	var self = this;
	this.idx = _setting.array.indexOf(_setting.value);
	if (this.idx == -1)
	{
		console.error("EnumSetting Error");
	}

	this.layout = $('<div class="setting-container enum-container"/>');
	_parentDiv.append(this.layout);

	this.titleContainer = $('<div class="setting-title-container"/>');
	this.layout.append(this.titleContainer);

	this.title = $('<div class="title title-font-normal font-color-title">' + _setting.name + '</div>');
	this.titleContainer.append(this.title);

	this.contentContainer = $('<div class="setting-content-container"/>');
	this.layout.append(this.contentContainer);

	this.button = this.contentContainer.createTextButton(_setting.value, function ()
	{
		self.cycle(true);
	}, 'enum-button', 4);

	this.button.mousedown(function (event)
	{
		if (event.which === 3)
		{
			self.cycle(false);
		}
	});

	if (_setting.locked)
	{
		this.button.attr('disabled', true);
	}

	// Tooltip
	this.title.bindTooltip({ contentType: 'FU-generic', modId: FU.ID, elementId: "ModSettings.Element.Tooltip", elementModId: _mod.id, settingsElementId: _setting.id });
	this.button.bindTooltip({ contentType: 'FU-generic', modId: FU.ID, elementId: "ModSettings.Element.Tooltip", elementModId: _mod.id, settingsElementId: _setting.id });
};

EnumSetting.prototype.updateValue = function()
{
	this.button.changeButtonText(this.data.value);
}

EnumSetting.prototype.cycle = function (_forward)
{
	this.idx += _forward ? 1 : -1;
	if (this.idx == -1)
	{
		this.idx = this.data.array.length - 1;
	}
	else if (this.idx == this.data.array.length)
	{
		this.idx = 0;
	}
	this.data.value = this.data.array[this.idx];
	this.button.changeButtonText(this.data.value);
};

EnumSetting.prototype.unbindTooltip = function ()
{
	this.title.unbindTooltip();
	this.button.unbindTooltip();
};
