var KeybindSetting = function (_mod, _page, _setting, _parentDiv)
{
	this.data = _setting;
	var self = this;
	this.layout = $('<div class="setting-container string-container outline"/>');
	this.data = _setting;
	this.parent = _parentDiv;
	_parentDiv.append(this.layout);

	this.titleContainer = $('<div class="setting-title-container"/>');
	this.layout.append(this.titleContainer);

	this.title = $('<div class="title title-font-normal font-color-title">' + _setting.name + '</div>');
	this.titleContainer.append(this.title);

	this.contentContainer = $('<div class="setting-content-container"/>');
	this.layout.append(this.contentContainer);

	this.input = $('<input type="text" class="title-font-normal font-color-brother-name string-input"/>');
	this.contentContainer.append(this.input);
	this.updateValue();
	this.input.on("change", function(){
		self.data.value = self.input.val().toLowerCase();
	});

	this.input.on("click", function(){
		this.blur();
		self.createPopup(_parentDiv);
	});

	// Tooltip
	this.title.bindTooltip({ contentType: 'FU-generic', modId: FU.ID, elementId: "ModSettings.Element.Tooltip", elementModId: _mod.id, settingsElementId: _setting.id });
	this.input.bindTooltip({ contentType: 'FU-generic', modId: FU.ID, elementId: "ModSettings.Element.Tooltip", elementModId: _mod.id, settingsElementId: _setting.id });
};

KeybindSetting.prototype.updateValue = function()
{
	this.input.val(FU.Key.capitalizeKeyString(this.data.value));
}


KeybindSetting.prototype.createPopup = function ()
{
	var self = this;
	this.popup = $('.FU-settings-screen').createPopupDialog('Change Keybind', this.data.name, null, 'change-keybind-popup');
	Screens.ModSettingsScreen.setPopupDialog(this.popup);
	var result = this.popup.addPopupDialogContent($('<div class="change-keybind-container"/>'));
	//need to do this separately or the list won't render
	this.createChangeKeybindScrollContainer(result);
	this.popup.addPopupDialogButton('Cancel', 'l-cancel-keybind-button', function (_dialog)
	{
		Screens.ModSettingsScreen.destroyPopupDialog();
	});
	this.popup.addPopupDialogButton('Add', 'l-add-keybind-button', function (_dialog)
	{
		self.createChangeKeybindRow("");
	});
	this.popup.addPopupDialogButton('OK', 'l-ok-keybind-button', function (_dialog)
	{
		var buttons = $(".change-keybind-button");
		var result = "";
		for(var idx = 0; idx < buttons.length; idx++)
		{
			var text = $(buttons[idx]).findButtonText().html();
			if(text.length > 0)
			{
				result += text + "/";
			}
		}
		result = result.slice(0, -1);
		self.input.val(result);
		self.data.value = result.toLowerCase();
		Screens.ModSettingsScreen.destroyPopupDialog();
	});
};

KeybindSetting.prototype.createChangeKeybindScrollContainer = function(_dialog)
{
	this.mButtonContainer = _dialog.createList(2);
	var keybindArray = this.data.value.split("/");
	for (var x = 0; x < keybindArray.length; x++)
	{
		this.createChangeKeybindRow(keybindArray[x]);
	}
};

KeybindSetting.prototype.createChangeKeybindRow = function(_name)
{
	var row = $('<div class="row"/>');
	this.mButtonContainer.findListScrollContainer().append(row);

	var buttonLayout = $('<div class="keybind-button-container"/>');
	row.append(buttonLayout);
	var button = buttonLayout.createTextButton(FU.Key.capitalizeKeyString(_name), null, 'change-keybind-button', 4);
	button.css('margin-top', '-0.4rem'); // not sure why this is necessary but apparently it is for alignment
	button.findButtonText().css('margin-top', '0.8rem');

	var selectedButton = null;

	var callbackKeyboard = function(_event)
	{
		var key = FU.Key.KeyMapJS[_event.keyCode];
		if (key === undefined || key === null)
		{
			return;
		}
		setButton(key);
	};

	var callbackMouse = function(_event)
	{
		var key = FU.Key.MouseMapJS[_event.button];
		if (key === undefined || key === null)
		{
			return;
		}
		setButton(key);
	};

	var setButton = function(_key)
	{
		var pressedKeys = FU.Keybinds.getPressedKeysAsString(_key) + _key;
		selectedButton.changeButtonText(FU.Key.capitalizeKeyString(FU.Key.sortKeyString(pressedKeys)));
		toggle(selectedButton, true);
	};

	var toggle = function(_button, _forcedOff)
	{
		if (_forcedOff === true || _button.data("Selected") === true)
		{
			document.removeEventListener("keyup", callbackKeyboard, true);
			document.removeEventListener("mouseup", callbackMouse, true);
			_button.data("Selected", false);
			_button.removeClass('is-selected');
			_button.css('pointer-events', 'auto');
			selectedButton = null;
		}
		else
		{
			document.addEventListener("keyup", callbackKeyboard, true);
			document.addEventListener("mouseup", callbackMouse, true);
			_button.data("Selected", true);
			_button.addClass('is-selected');
			_button.css('pointer-events', 'none');
			selectedButton = _button;
		}
	};
	button.on("click", function( _event ){
		var mainButton = this;
		var buttons = $(".change-keybind-button");
		buttons.map(function()
		{
			if (this != mainButton)
			{
				toggle($(this), true);
			}
		});
		toggle($(this), false);
	});
	button.off("mouseenter");
	button.off("mouseleave");
	button.off("mousedown");
	button.off("mouseup");
	button.on("mouseenter", function()
	{
		$(this).addClass('is-selected');
	});
	button.on("mouseleave", function()
	{
		if (!$(this).data("Selected"))
		{
			$(this).removeClass('is-selected');
		}
	});

	//Delete button
	var destroyButtonLayout = $('<div class="keybind-delete-button-container"/>');
	row.append(destroyButtonLayout);
	var destroyButton = destroyButtonLayout.createTextButton("Delete", function()
	{
		row.remove();
	}, 'delete-keybind-button', 2);
};

KeybindSetting.prototype.unbindTooltip = function ()
{
	this.title.unbindTooltip();
	this.input.unbindTooltip();
};
