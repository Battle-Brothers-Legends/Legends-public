var ArraySetting = function (_mod, _page, _setting, _parentDiv)
{
	this.data = _setting;
	var self = this;
	this.layout = $('<div class="setting-container array-container outline"/>');
	_parentDiv.append(this.layout);

	this.titleContainer = $('<div class="setting-title-container"/>');
	this.layout.append(this.titleContainer);

	this.title = $('<div class="title title-font-normal font-color-title">' + _setting.name + '</div>');
	this.titleContainer.append(this.title);

	this.contentContainer = $('<div class="setting-content-container"/>');
	this.layout.append(this.contentContainer);

	this.button = this.contentContainer.createTextButton(_setting.name, function ()
	{
		self.createPopup($(this).parent());
	}, 'popup-button', 4);

	// Tooltip
	this.title.bindTooltip({ contentType: 'FU-generic', modId: FU.ID, elementId: "ModSettings.Element.Tooltip", elementModId: _mod.id, settingsElementId: _setting.id });
	this.button.bindTooltip({ contentType: 'FU-generic', modId: FU.ID, elementId: "ModSettings.Element.Tooltip", elementModId: _mod.id, settingsElementId: _setting.id });

};

ArraySetting.prototype.createPopup = function ()
{
	var self = this;
	this.popup = $('.FU-settings-screen').createPopupDialog('Change Array', this.data.name, null, 'change-array-popup');
	Screens.ModSettingsScreen.setPopupDialog(this.popup);
	var result = this.popup.addPopupDialogContent($('<div class="change-array-container"/>'));
	var rowWidth = 600;
	if (!this.data.data.lockLength) rowWidth = 720;
	this.popup.resizePopup(null, rowWidth);
	//need to do this separately or the list won't render
	this.createArrayScrollContainer(result);
	this.popup.addPopupDialogButton('Cancel', 'l-cancel-keybind-button', function (_dialog)
	{
		Screens.ModSettingsScreen.destroyPopupDialog();
	});
	if (!this.data.data.lockLength)
	{
		this.popup.addPopupDialogButton('Add', 'l-add-keybind-button', function (_dialog)
		{
			self.createEntryRow([null, ""]);
		});
	}
	this.popup.addPopupDialogButton('OK', 'l-ok-keybind-button', function (_dialog)
	{
		self.getPopupValues();
		Screens.ModSettingsScreen.destroyPopupDialog();
	});
};

ArraySetting.prototype.createArrayScrollContainer = function(_dialog)
{
	this.mButtonContainer = _dialog.createList(2);
	for (var x = 0; x < this.data.value.length; x++)
	{
		this.createEntryRow(this.data.value[x]);
	}
};

ArraySetting.prototype.createEntryRow = function(_entry)
{
	var self = this;
	var row = $('<div class="row array-row"/>');
	var entryCopy = [_entry[0], _entry[1]];
	row.data("entry", entryCopy);

	var name = $('<div class="title-font-normal font-color-brother-name array-entry-name">' + _entry[0] +  '</div>');
	row.append(name);

	var buttonLayout = $('<div class="string-input-container"/>');
	row.append(buttonLayout);
	var input = $('<input type="text" class="title-font-normal font-color-brother-name string-input string-input"/>');
	buttonLayout.append(input);
	input.val(_entry[1]);
	input.on("change", function(){
		row.data("entry")[1] = $(this).val();
	});

	//Delete button
	if(!this.data.data.lockLength)
	{
		var destroyButtonLayout = $('<div class="keybind-delete-button-container"/>');
		row.append(destroyButtonLayout);
		var destroyButton = destroyButtonLayout.createTextButton("Delete", function()
		{
			row.remove();
			self.resizePopup();
		}, 'delete-keybind-button', 2);
	}
	this.mButtonContainer.findListScrollContainer().append(row);
	this.resizePopup();
};

ArraySetting.prototype.resizePopup = function ()
{
	var rowHeight = this.popup.find(".row:first").height();
	var rowHeightSum = Math.min(600, (this.popup.find(".row").length) * rowHeight);
	this.popup.resizePopup(rowHeightSum, null);
	this.popup.find(".list").css("height", rowHeightSum);
}

ArraySetting.prototype.getPopupValues = function()
{

	var result = [];
	$(".array-row").each(function(idx){
		result.push($(this).data("entry"));
	})
	this.data.value = result;
}

ArraySetting.prototype.unbindTooltip = function ()
{
	this.title.unbindTooltip();
	this.button.unbindTooltip();
};
