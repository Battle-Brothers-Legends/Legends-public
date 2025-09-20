var ModSettingsScreen = function ()
{
	FUUIScreen.call(this);
	this.mID = "ModSettingsScreen";


	this.mDialogContainer = null;
	this.mListContainer = null;
	this.mListScrollContainer = null;
	this.mModPageScrollContainer = null;
	this.mPageTabContainer = null;

	this.mModSettings = {};
	this.mOrderedPanels = [];
	this.mActivePanel = null;
	this.mLastActivePanel = null;
	this.mActivePage = null;
	this.mLastActivePage = null;
	this.mActiveSettings = [];

	this.mIsFirstShow = null;
	/*

	this.mModSettings =
	[
		panelID = {
			id = "",
			modID = "",
			name = "",
			pages = [
				id = "",
				name = "",
				settings = [
					{
						id = "",
						type = "",
						name = "",
						value = 0,
						locked = false,
					}
				]
			]
			//settings references page settings
			settings = {
				settingID = {
					...
				}
			}
		}
	]
	*/
};

// Inheritance in JS
ModSettingsScreen.prototype = Object.create(FUUIScreen.prototype);
Object.defineProperty(ModSettingsScreen.prototype, 'constructor', {
	value: ModSettingsScreen,
	enumerable: false,
	writable: true
});

ModSettingsScreen.prototype.createDIV = function (_parentDiv)
{
	var self = this;
	FUUIScreen.prototype.createDIV.call(this, _parentDiv);
	this.mPopupDialog = null;
	this.mContainer = $('<div class="FU-settings-screen dialog-screen ui-control display-none opacity-none"/>');
	_parentDiv.append(this.mContainer);

	var dialogLayout = $('<div class="l-dialog-container"/>');
	this.mContainer.append(dialogLayout);
	this.mDialogContainer = dialogLayout.createDialog('Mod Settings', "Select a Mod From the List", null, true, 'dialog-1024-768');

	this.mPageTabContainer = $('<div class="l-tab-button-bar"/>');
	this.mDialogContainer.findDialogTabContainer().append(this.mPageTabContainer);

	//Footer Bar
	var footerButtonBar = $('<div class="l-button-bar"></div>');
	this.mDialogContainer.findDialogFooterContainer().append(footerButtonBar);

	var layout = $('<div class="l-cancel-button"/>');
	footerButtonBar.append(layout);
	layout.createTextButton("Cancel", function ()
	{
		self.notifyBackendCancelButtonPressed();
	}, 'main-cancel-button', 1);

	layout = $('<div class="l-ok-button"/>');
	footerButtonBar.append(layout);
	layout.createTextButton("Reset", function ()
	{
		self.notifyBackendResetButtonPressed();
	}, 'main-reset-button', 1);

	layout = $('<div class="l-ok-button"/>');
	footerButtonBar.append(layout);
	layout.createTextButton("Apply", function ()
	{
		self.notifyBackendApplyButtonPressed();
	}, 'main-apply-button', 1);

	layout = $('<div class="l-ok-button"/>');
	footerButtonBar.append(layout);
	layout.createTextButton("Save", function ()
	{
		self.notifyBackendSaveButtonPressed();
	}, 'main-save-button', 1);

	var content = this.mContainer.findDialogContentContainer();

	//Mod List Container
	var pagesListScrollContainer = $('<div class="l-list-container"/>');
	content.append(pagesListScrollContainer);
	this.mListContainer = pagesListScrollContainer.createList(2);
	this.mListScrollContainer = this.mListContainer.findListScrollContainer();

	//Mod Page Container
	var modPageContainerLayout = $('<div class="l-page-container"/>');
	content.append(modPageContainerLayout);
	this.mModPageContainer = modPageContainerLayout.createList(2);
	this.mModPageScrollContainer = this.mModPageContainer.findListScrollContainer();
};

ModSettingsScreen.prototype.bindTooltips = function ()
{
	this.mDialogContainer.find('.main-cancel-button').bindTooltip({ contentType: 'FU-generic', modId: FU.ID, elementId: "ModSettings.Main.Cancel"});
	this.mDialogContainer.find('.main-reset-button').bindTooltip({ contentType: 'FU-generic', modId: FU.ID, elementId: "ModSettings.Main.Reset"});
	this.mDialogContainer.find('.main-apply-button').bindTooltip({ contentType: 'FU-generic', modId: FU.ID, elementId: "ModSettings.Main.Apply"});
	this.mDialogContainer.find('.main-save-button').bindTooltip({ contentType: 'FU-generic', modId: FU.ID, elementId: "ModSettings.Main.OK"});
};

ModSettingsScreen.prototype.destroy = function ()
{
	this.mActiveSettings.forEach(function(setting)
	{
		setting.remove();
	});

	this.mActiveSettings = [];

	FUUIScreen.prototype.destroy.call(this);
};

ModSettingsScreen.prototype.unbindTooltips = function ()
{
	this.mActiveSettings.forEach(function(setting)
	{
		setting.unbindTooltip();
	});
	this.mDialogContainer.find('.main-cancel-button').unbindTooltip();
	this.mDialogContainer.find('.main-reset-button').unbindTooltip();
	this.mDialogContainer.find('.main-apply-button').unbindTooltip();
	this.mDialogContainer.find('.main-save-button').unbindTooltip();

	FUUIScreen.prototype.unbindTooltips.call(this);
};

ModSettingsScreen.prototype.destroyDIV = function ()
{
	if (this.mPopupDialog !== null)
	{
		this.mPopupDialog.destroyPopupDialog();
	}
	this.mPopupDialog = null;
	this.mDialogContainer.empty();
	this.mDialogContainer.remove();
	this.mDialogContainer = null;
	FUUIScreen.prototype.destroyDIV.call(this);
};

ModSettingsScreen.prototype.hide = function()
{
	this.mDialogContainer.findDialogSubTitle().html("Select a Mod From the List");

	this.mActiveButton = null;

	this.mPageTabContainer.empty();
	this.mModPageScrollContainer.empty();
	this.mListScrollContainer.empty();

	FUUIScreen.prototype.hide.call(this);
};

ModSettingsScreen.prototype.show = function (_data)
{
	this.mIsFirstShow = true;
	this.setSettings(_data);
	this.createModPanelList();
	FUUIScreen.prototype.show.call(this,_data);
	this.mActivePanel = null;
	this.mActivePage = null;
	if (this.mLastActivePanel != null && this.mLastActivePage != null)
	{
		var panel = this.getPanel(this.mLastActivePanel);
		if (panel != null && !panel.hidden)
		{
			var page = this.getPage(panel, this.mLastActivePage);
			if (page != null && !page.hidden) this.switchToPage(panel, page);
		}
	}
	if (this.mActivePanel == null || this.mActivePage == null)
	{
		this.switchToFirstPanel();
		this.switchToFirstPage(this.mActivePanel);
	}
	this.mIsFirstShow = false;
};

ModSettingsScreen.prototype.setSettings = function (_settings)
{
	this.mModSettings = _settings;
	FU.iterateObject(this.mModSettings, function(_panelID, _panel)
	{
		_panel.settings = {};
		_panel.pages.forEach(function(_page)
		{
			_page.settings.forEach(function(_setting)
			{
				_panel.settings[_setting.id] = _setting;
			})
		})
		return true;
	})
};

ModSettingsScreen.prototype.createModPanelList = function ()
{
	var self = this;
	this.mOrderedPanels = [];
	FU.iterateObject(this.mModSettings, function(_panelID, _panel)
	{
		if (_panel.hidden) return;
		self.mOrderedPanels.push(_panel);
	});
	this.mOrderedPanels.sort(function(a, b){
		return (a.order - b.order);
	})
	this.mOrderedPanels.forEach(function(_sortedPanel)
	{
		self.addModPanelButtonToList(_sortedPanel);
	})
};

ModSettingsScreen.prototype.addModPanelButtonToList = function (_panel)
{
	var self = this;
	var button = this.mListScrollContainer.createCustomButton(null, function (_button)
	{
		self.switchToPanel(_panel);
		self.switchToFirstPage(_panel);
	}, 'FU-button');

	button.text(_panel.name);
	button.removeClass('button');

	_panel.button = button;
};

ModSettingsScreen.prototype.switchToPanel = function (_panel)
{
	var self = this;
	this.mPageTabContainer.empty();
	this.mContainer.findDialogSubTitle().html(_panel.name);
	if (this.mActivePanel !== null)
	{
		this.mActivePanel.button.removeClass('is-active');
	}
	this.mActivePanel = _panel;
	this.mLastActivePanel = _panel.id;
	this.mActivePanel.button.addClass('is-active');

	_panel.pages.forEach(function(page)
	{
		if (page.hidden) return
		var layout = $('<div class="l-tab-button"/>');
		self.mPageTabContainer.append(layout);
		var button = layout.createTabTextButton(page.name, function ()
		{
			self.switchToPage(_panel, page);
		}, null, 'tab-button', 7);
		page.button = button;
	});
};

ModSettingsScreen.prototype.switchToPage = function (_panel, _page)
{
	var self = this;
	if (this.mActivePanel != _panel) this.switchToPanel(_panel);

	if (this.mActivePage !== null)
	{
		this.mActivePage.button.removeClass('is-active');
	}
	this.mActivePage = _page;
	this.mLastActivePage = _page.id;
	this.mActivePage.button.addClass('is-active');

	this.mActiveSettings.forEach(function(element)
	{
		element.unbindTooltip();
	});
	this.mActiveSettings = [];
	this.mModPageScrollContainer.empty();

	_page.settings.forEach(function(element)
	{
		if (element.hidden) return
		self.mActiveSettings.push(new window[element.type + "Setting"](_panel, _page, element, self.mModPageScrollContainer));
	});
	// if called from show(), the elements need to be added to the dom first or something so need to add it on a delay
	if (this.mIsFirstShow) setTimeout(this.adjustTitles, 300, this);
	else this.adjustTitles(this)
};

ModSettingsScreen.prototype.getPanel = function( _id )
{
	var self = this;
	var ret = null;
	this.mOrderedPanels.every(function(_panel)
	{
		if (_panel.id == _id)
		{
			ret = _panel;
			return false;
		}
		return true;
	});
	return ret;
};

ModSettingsScreen.prototype.getPage = function( _panel, _id )
{
	var self = this;
	var ret = null;
	_panel.pages.every(function(page)
	{
		if (page.id == _id)
		{
			ret = page;
			return false;
		}
		return true;
	});
	return ret;
};

ModSettingsScreen.prototype.switchToFirstPanel = function ()
{
	var self = this;
	this.mOrderedPanels.every(function(_panel)
	{
		if (!_panel.hidden)
		{
			self.switchToPanel(_panel);
			return false;
		}
		return true;
	});
};

ModSettingsScreen.prototype.switchToFirstPage = function( _panel )
{
	var self = this;
	_panel.pages.every(function(page)
	{
		if (!page.hidden)
		{
			self.switchToPage(_panel, page);
			return false;
		}
		return true;
	});
};

ModSettingsScreen.prototype.adjustTitles = function (self)
{
	self.mActiveSettings.forEach(function(element)
	{
		if ('title' in element && 'titleContainer' in element)
		{
			while (element.title[0].scrollWidth > element.title.innerWidth())
			{
				element.title.css('font-size', (parseInt(element.title.css('font-size').slice(0, -2)) - 1) + 'px');
				if (parseInt(element.title.css('font-size').slice(0, -2)) <= 1)
				{
					console.error("Setting with ID " + element.data.id + ": Font size of title too small! Stopping font size adjustment.");
					return;
				}
			}
		}
	});
}

ModSettingsScreen.prototype.setTypeIfFloatOrInt = function ( _data )
{
	if (_data.type == "number")
	{
		if (_data.value % 1 == 0) _data.type = "integer";
		else
		{
			_data.type = "float";
			_data.value = _data.value.toPrecision(6);
		}
	}
	return _data;
}

ModSettingsScreen.prototype.getChanges = function () // Could still be significantly improved/optimized
{
	var self = this;
	var changes = {};
	FU.iterateObject(this.mModSettings, function(_panelID, modPanel)
	{
		changes[_panelID] = {};
		FU.iterateObject(modPanel.settings, function(_elementID, element)
		{
			if ("IsSetting" in element.data && !element.locked && element.currentValue != element.value)
			{
				changes[_panelID][_elementID] = self.setTypeIfFloatOrInt({
					type : typeof element.value,
					value : element.value
				});
			}
		});
	});
	return changes;
};

ModSettingsScreen.prototype.discardChanges = function () // Could still be significantly improved/optimized
{
	var self = this;
	FU.iterateObject(this.mModSettings, function(_panelID, modPanel)
	{
		FU.iterateObject(modPanel.settings, function(_elementID, element)
		{
			if ("IsSetting" in element.data && !element.locked)
			{
				element.value = element.currentValue;
			}
		});
	});
};

ModSettingsScreen.prototype.updateSetting = function (_setting)
{
	this.mModSettings[_setting.mod].settings[_setting.id].value = _setting.value;
	this.mModSettings[_setting.mod].settings[_setting.id].currentValue = _setting.value;
	this.mModSettings[_setting.mod].settings[_setting.id].data = _setting.data;
	this.mActiveSettings.forEach(function(_activeSetting)
	{
		if(_activeSetting.data.id == _setting.id && "updateValue" in _activeSetting)
		{
			_activeSetting.updateValue();
		}
	})
};

ModSettingsScreen.prototype.setModSettingValue = function (_modID, _settingID, _value)
{
	var out = this.setTypeIfFloatOrInt({
		mod : _modID,
		type : typeof _value,
		id : _settingID,
		value : _value
	});

	this.updateSetting(out);
	this.updateSettingInNut(out);
};

ModSettingsScreen.prototype.updateSettingInNut = function (_data)
{
	SQ.call(this.mSQHandle, "updateSettingFromJS", _data);
};

ModSettingsScreen.prototype.notifyBackendCancelButtonPressed = function ()
{
	this.discardChanges();
	SQ.call(this.mSQHandle, 'onCancelButtonPressed');
};

ModSettingsScreen.prototype.notifyBackendResetButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onResetButtonPressed', {
		"panelID" : this.mActivePanel.id,
		"pageID" : this.mActivePage.id,
	});
};

ModSettingsScreen.prototype.notifyBackendApplyButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onApplyButtonPressed', this.getChanges());
};

ModSettingsScreen.prototype.notifyBackendSaveButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onSaveButtonPressed', this.getChanges());
};

ModSettingsScreen.prototype.notifyBackendSettingButtonPressed = function (_data)
{
	SQ.call(this.mSQHandle, 'onSettingPressed', _data);
};

FU.getSetting = function (_modID, _settingID)
{
	return Screens.ModSettingsScreen.mModSettings[_modID].settings[_settingID];
};

FU.getSettingValue = function (_modID, _settingID)
{
	return Screens.ModSettingsScreen.mModSettings[_modID].settings[_settingID].value;
};

FU.setSettingValue = function (_modID, _settingID, _value)
{
	Screens.ModSettingsScreen.setModSettingValue(_modID, _settingID, _value);
};

registerScreen("ModSettingsScreen", new ModSettingsScreen());
