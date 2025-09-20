var ColorPickerSetting = function (_mod, _page, _setting, _parentDiv)
{
	this.data = _setting;
	this.values = this.data.data.values;
	this.parent = _parentDiv;
	var self = this;

	this.layout = $('<div class="setting-container color-picker-container"/>');
	_parentDiv.append(this.layout);

	this.titleContainer = $('<div class="setting-title-container"/>');
	this.layout.append(this.titleContainer);

	this.title = $('<div class="title title-font-normal font-color-title">' + _setting.name + '</div>');
	this.titleContainer.append(this.title);

	this.contentContainer = $('<div class="setting-content-container"/>');
	this.layout.append(this.contentContainer);

	this.button = $('<div class="color-picker-button"/>');
	this.button.on("click", function (){
		self.createColorPickerPopup();
	})
	this.contentContainer.append(this.button);

	this.buttonLabel = $('<span class="color-picker-button-label text-font-normal">' + this.getRGBA(this.values) + '</span>');
	this.button.append(this.buttonLabel);

	this.updateColor();

	// Tooltip
	this.title.bindTooltip({ contentType: 'FU-generic', modId: FU.ID, elementId: "ModSettings.Element.Tooltip", elementModId: _mod.id, settingsElementId: _setting.id });
	this.button.bindTooltip({ contentType: 'FU-generic', modId: FU.ID, elementId: "ModSettings.Element.Tooltip", elementModId: _mod.id, settingsElementId: _setting.id });
};

ColorPickerSetting.prototype.updateValue = function()
{
	this.values = this.data.data.values;
	this.updateColor();
}

ColorPickerSetting.prototype.createColorPickerPopup = function ()
{
	var self = this;
	this.popup = $('.FU-settings-screen').createPopupDialog('Color Picker', null, null, 'color-picker-popup', false);
	Screens.ModSettingsScreen.setPopupDialog(this.popup);
	this.popup.values = {
		"Red" : 0,
		"Green" : 0,
		"Blue" : 0,
		"Alpha" : 0
	};
	this.cloneSettingsToFrom(this.popup.values, this.values);
	this.popup.addPopupDialogOkButton(function (_dialog){
		self.cloneSettingsToFrom(self.values, self.popup.values);
		self.updateColor();
		Screens.ModSettingsScreen.destroyPopupDialog();
	});
	this.popup.addPopupDialogCancelButton(function (_dialog){
		Screens.ModSettingsScreen.destroyPopupDialog();
	});
	this.popup.addPopupDialogContent(this.createPopupContent());
	this.updateColorInPopup();
};

ColorPickerSetting.prototype.createPopupContent = function ()
{
	var result = $('<div class="pick-color-content-container"/>');
	this.popup.currentColorDisplay = $('<div class="current-color-display"/>');
	result.append(this.popup.currentColorDisplay);
	this.createColorRowContent(result, "Red");
	this.createColorRowContent(result, "Green");
	this.createColorRowContent(result, "Blue");
	this.createColorRowContent(result, "Alpha");
	return result;
}

ColorPickerSetting.prototype.createColorRowContent = function(_parentDiv, _name )
{
	var self = this;
	var result = $('<div class="row"/>');
	_parentDiv.append(result);

	result.title = $('<div class="title title-font-big font-bold font-color-title">' + _name + '</div>');
	result.append(result.title);

	result.control = $('<div class="scale-control"/>');
	result.append(result.control);

	result.slider = $('<input class="scale-slider" type="range"/>');
	result.slider.attr({
		min : 0,
		max : 255,
		step : 1
	});
	if(_name == "Alpha")
	{
		result.slider.attr({
			min : 0,
			max : 1,
			step : 0.01
		});
	}
	result.slider.val(this.popup.values[_name]);
	result.control.append(result.slider);

	result.label = $('<div class="scale-label title-font-big font-bold font-color-title">' + this.popup.values[_name] + '</div>');
	result.append(result.label);

	result.on("change", function ()
	{
		self.popup.values[_name] = parseFloat(result.slider.val());
		result.label.text('' + self.popup.values[_name]);
		self.updateColorInPopup();
	});
}

ColorPickerSetting.prototype.cloneSettingsToFrom = function ( _destination, _source)
{
	_destination.Red = _source.Red;
	_destination.Green = _source.Green;
	_destination.Blue = _source.Blue;
	_destination.Alpha = _source.Alpha;
}

ColorPickerSetting.prototype.getRGBA = function( _values )
{
	var result = "rgba(";
	result += _values.Red + ", ";
	result += _values.Green + ", ";
	result += _values.Blue + ", ";
	result += _values.Alpha + ");";
	return result;
}

ColorPickerSetting.prototype.updateColor = function()
{
	this.button.css("background-color", this.getRGBA(this.values));
	this.buttonLabel.text('' + this.getRGBA(this.values));
	var valueAsString = this.values.Red.toString() + "," + this.values.Green.toString() + "," + this.values.Blue.toString() + "," + this.values.Alpha;
	this.data.value = valueAsString;
	var oppositeColors = {
		"Red" : 255 - this.values.Red,
		"Green" : 255 - this.values.Green,
		"Blue" : 255 - this.values.Blue,
		"Alpha" : 1
	};
	this.buttonLabel.css("color", this.getRGBA(oppositeColors));
}

ColorPickerSetting.prototype.updateColorInPopup = function()
{
	if (this.popup !== undefined)
	{
		this.popup.currentColorDisplay.css("background-color", this.getRGBA(this.popup.values));
	}
}

ColorPickerSetting.prototype.destroyPopupDialog = function()
{
	this.popup.destroyPopupDialog();
}

ColorPickerSetting.prototype.unbindTooltip = function ()
{
	this.title.unbindTooltip();
	this.button.unbindTooltip();
};
