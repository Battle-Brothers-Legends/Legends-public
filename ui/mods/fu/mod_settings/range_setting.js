var RangeSetting = function (_mod, _page, _setting, _parentDiv)
{
	if (_setting.value % 1 != 0) _setting.value = parseFloat(_setting.value.toPrecision(6)); // fix for JS/Squirrel float conversion weirdness
	if (_setting.min % 1 != 0) _setting.min = parseFloat(_setting.min.toPrecision(6));
	if (_setting.max % 1 != 0) _setting.max = parseFloat(_setting.max.toPrecision(6));
	if (_setting.step % 1 != 0) _setting.step = parseFloat(_setting.step.toPrecision(6));

	this.data = _setting;
	var self = this;
	this.layout = $('<div class="setting-container range-container"/>');
	_parentDiv.append(this.layout);

	this.titleContainer = $('<div class="setting-title-container"/>');
	this.layout.append(this.titleContainer);

	this.title = $('<div class="title title-font-normal font-color-title">' + _setting.name + '</div>');
	this.titleContainer.append(this.title);

	this.contentContainer = $('<div class="setting-content-container"/>');
	this.layout.append(this.contentContainer);

	this.control = $('<div class="scale-control"/>');
	this.contentContainer.append(this.control);

	this.slider = $('<input class="scale-slider" type="range"/>');
	this.control.append(this.slider);

	this.label = $('<div class="scale-label text-font-normal font-color-subtitle">' + _setting.value + '</div>');
	this.control.append(this.label);

	this.layout.on("change", function ()
	{
		_setting.value = parseFloat(self.slider.val());
		self.label.text('' + _setting.value);
	});

	if (_setting.locked)
	{
		this.slider.attr('disabled', true);
	}

	// Tooltip
	this.control.bindTooltip({ contentType: 'FU-generic', modId: FU.ID, elementId: "ModSettings.Element.Tooltip", elementModId: _mod.id, settingsElementId: _setting.id });
	this.title.bindTooltip({ contentType: 'FU-generic', modId: FU.ID, elementId: "ModSettings.Element.Tooltip", elementModId: _mod.id, settingsElementId: _setting.id });
	this.updateValue();
};

RangeSetting.prototype.updateValue = function()
{
	this.slider.attr({
		min : this.data.min,
		max : this.data.max,
		step : this.data.step
	});
	this.slider.val(this.data.value);
	this.label.text('' + this.data.value);
}

RangeSetting.prototype.unbindTooltip = function ()
{
	this.control.unbindTooltip();
	this.title.unbindTooltip();
};
