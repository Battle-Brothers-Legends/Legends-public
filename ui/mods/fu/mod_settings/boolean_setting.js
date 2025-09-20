var BooleanSetting = function (_mod, _page, _setting, _parentDiv)
{
	this.data = _setting;
	this.layout = $('<div class="setting-container boolean-container"/>');
	_parentDiv.append(this.layout);

	this.titleContainer = $('<div class="setting-title-container"/>');
	this.layout.append(this.titleContainer);

	var id = _mod.id + _setting.id + "-id";
	this.checkbox = $('<input type="checkbox" id="' + id + '" name="' + _setting.id +'-name" />');
	this.titleContainer.append(this.checkbox);
	this.checkbox.iCheck({
		checkboxClass: 'icheckbox_flat-orange',
		radioClass: 'iradio_flat-orange',
		increaseArea: '30%'
	});
	this.updateValue();

	var self = this;
	this.checkbox.on('ifChecked ifUnchecked', null, this, function (_event) {
		_setting.value = self.checkbox.prop('checked') === true;
	});

	if (_setting.locked)
	{
		this.checkbox.attr('disabled', true);
	}

	this.title = $('<label class="bool-checkbox-label title-font-normal font-color-title" for="' + id + '">' + _setting.name + '</label>');
	this.title.click(jQuery.proxy(function(){
		this.checkbox.iCheck('toggle');
	}, this))

	this.titleContainer.append(this.title);

	// Tooltip
	this.title.bindTooltip({ contentType: 'FU-generic', modId: FU.ID, elementId: "ModSettings.Element.Tooltip", elementModId: _mod.id, settingsElementId: _setting.id });
};

BooleanSetting.prototype.updateValue = function()
{
	this.checkbox.iCheck(this.data.value === true ? 'check' : 'uncheck');
}

BooleanSetting.prototype.unbindTooltip = function ()
{
	this.title.unbindTooltip();
};
