var StringSetting = function (_mod, _page, _setting, _parentDiv)
{
	var self = this;
	this.data = _setting;
	this.layout = $('<div class="setting-container string-container"/>');
	_parentDiv.append(this.layout);

	this.titleContainer = $('<div class="setting-title-container"/>');
	this.layout.append(this.titleContainer);

	this.title = $('<div class="title title-font-normal font-color-title">' + _setting.name + '</div>');
	this.titleContainer.append(this.title);

	this.contentContainer = $('<div class="setting-content-container"/>');
	this.layout.append(this.contentContainer);

	this.input = $('<input type="text" class="title-font-normal font-color-brother-name string-input"/>');
	this.updateValue();
	this.contentContainer.append(this.input);
	this.input.on("change", function(){
		self.data.value = self.input.val();
	});

	// Tooltip
	this.title.bindTooltip({ contentType: 'FU-generic', modId: FU.ID, elementId: "ModSettings.Element.Tooltip", elementModId: _mod.id, settingsElementId: _setting.id });
	this.input.bindTooltip({ contentType: 'FU-generic', modId: FU.ID, elementId: "ModSettings.Element.Tooltip", elementModId: _mod.id, settingsElementId: _setting.id });
};

StringSetting.prototype.updateValue = function()
{
	this.input.val(this.data.value);
}

StringSetting.prototype.unbindTooltip = function ()
{
	this.title.unbindTooltip();
	this.input.unbindTooltip();
};
