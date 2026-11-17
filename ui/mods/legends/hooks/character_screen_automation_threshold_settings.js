var LegendAutomationSettings = {};
LegendAutomationSettings.CharacterScreenInventoryListModule = {};
LegendAutomationSettings.CharacterScreenInventoryListModule.createDIV = CharacterScreenInventoryListModule.prototype.createDIV;
CharacterScreenInventoryListModule.prototype.createDIV = function (_parentDiv) {
	LegendAutomationSettings.CharacterScreenInventoryListModule.createDIV.call(this, _parentDiv);

	if (this.mDataSource.mIsTacticalMode === true)
		return; // not for the inventory screen in battle

	var self = this;

	this.mIsRepairWindowShown = false;
	this.mIsSalvageWindowShown = false;
	this.mRepairSettingsPanel = this.createAutomationThresholdSettingsPopup(
		"Gold per 10 durability repaired",
		"automation-repair-threshold-window",
		function (_value) {
			self.mDataSource.mAutomationRepairThreshold = _value;
			self.mDataSource.notifyBackendApplyRepairCostThreshold(_value);
			self.mIsRepairWindowShown = false;
			self.mRepairSettingsPanel.addClass('display-none').removeClass('display-block');
		},
		function () {
			self.mIsRepairWindowShown = false;
			self.mRepairSettingsPanel.addClass('display-none').removeClass('display-block');
		}
	);

	if (this.mMarkForRepairButton !== undefined && this.mMarkForRepairButton !== null) {
		this.mMarkForRepairButton.parent().mousedown(function (_event) {
			if (_event.which === 3) {
				if (self.mIsRepairWindowShown) {
					self.mIsSalvageWindowShown = false;
					self.mSalvageSettingsPanel.addClass('display-none').removeClass('display-block');
					self.mIsRepairWindowShown = false;
					self.mRepairSettingsPanel.addClass('display-none').removeClass('display-block');
				} else {
					self.mRepairSettingsPanel.data('setSliderValue')(self.mDataSource.getRepairThreshold());
					self.mIsSalvageWindowShown = false;
					self.mSalvageSettingsPanel.addClass('display-none').removeClass('display-block');
					self.mIsRepairWindowShown = true;
					self.mRepairSettingsPanel.addClass('display-block').removeClass('display-none');
				}
				return false;
			}
		});
	}

	this.mSalvageSettingsPanel = this.createAutomationThresholdSettingsPopup(
		"Gold per tool recovered",
		"automation-salvage-threshold-window",
		function (_value) {
			self.mDataSource.mAutomationSalvageThreshold = _value;
			self.mDataSource.notifyBackendApplySalvageCostThreshold(_value);
			self.mIsSalvageWindowShown = false;
			self.mSalvageSettingsPanel.addClass('display-none').removeClass('display-block');
		},
		function () {
			self.mIsSalvageWindowShown = false;
			self.mSalvageSettingsPanel.addClass('display-none').removeClass('display-block');
		}
	);

	if (this.mMarkForSalvageButton !== undefined && this.mMarkForSalvageButton !== null) {
		this.mMarkForSalvageButton.parent().mousedown(function (_event) {
			if (_event.which === 3) {
				if (self.mIsSalvageWindowShown) {
					self.mIsRepairWindowShown = false;
					self.mRepairSettingsPanel.addClass('display-none').removeClass('display-block');
					self.mIsSalvageWindowShown = false;
					self.mSalvageSettingsPanel.addClass('display-none').removeClass('display-block');
				} else {
					self.mSalvageSettingsPanel.data('setSliderValue')(self.mDataSource.getSalvageThreshold());
					self.mIsRepairWindowShown = false;
					self.mRepairSettingsPanel.addClass('display-none').removeClass('display-block');
					self.mIsSalvageWindowShown = true;
					self.mSalvageSettingsPanel.addClass('display-block').removeClass('display-none');
				}
				return false;
			}
		});
	}
};

CharacterScreenInventoryListModule.prototype.createAutomationThresholdSettingsPopup = function (_title, _typeClass, _onApply, _onClose) {
	var layout = this.mFilterPanel;
	var panel = $('<div class="automation-threshold-settings-panel display-none ' + _typeClass + '"/>').appendTo(layout.parent());
	var content = $('<div class="panel-content"/>').appendTo(panel);
	var titleRow = $('<div class="row"/>').appendTo(content);
	$('<div class="title title-font-normal font-bold font-color-title">' + _title + '</div>').appendTo(titleRow);

	var sliderRow = $('<div class="row slider-row"/>').appendTo(content);
	var valueControl = $('<div class="value-control"/>').appendTo(sliderRow);
	var sliderInput = $('<input class="value-slider" type="range" min="0" max="50" step="1" value="9"/>').appendTo(valueControl);
	var valueLabel = $('<div class="value-label text-font-normal font-color-subtitle">9</div>').appendTo(valueControl);
	sliderInput.on("input change", function () {
		valueLabel.text($(this).val());
	});

	panel.data('setSliderValue', function (_val) {
		sliderInput.val(_val);
		valueLabel.text(_val);
	});

	panel.data('getSliderValue', function () {
		return parseInt(sliderInput.val(), 10);
	});

	var flexContainer = $('<div class="flexbox-button-row"/>').appendTo(panel);

	var applyButton = $('<div class="flex-image-button"/>').appendTo(flexContainer);
	applyButton.createImageButton(Path.GFX + "ui/icons/unlocked_small.png", function () {
		_onApply(panel.data('getSliderValue')());
	}, '', 3);

	var closeButton = $('<div class="flex-image-button"/>').appendTo(flexContainer);
	closeButton.createImageButton(Path.GFX + "ui/icons/icon_cancel.png", function () {
		_onClose();
	}, '', 3);

	return panel;
};

LegendAutomationSettings.CharacterScreenDatasource = {};
LegendAutomationSettings.CharacterScreenDatasource.loadFromData = CharacterScreenDatasource.prototype.loadFromData;
CharacterScreenDatasource.prototype.loadFromData = function (_data) {
	LegendAutomationSettings.CharacterScreenDatasource.loadFromData.call(this, _data);

	if (_data !== undefined && _data !== null) {
		if ('AutomationRepairThreshold' in _data) {
			this.mAutomationRepairThreshold = _data.AutomationRepairThreshold;
		}
		if ('AutomationSalvageThreshold' in _data) {
			this.mAutomationSalvageThreshold = _data.AutomationSalvageThreshold;
		}
	}
};

CharacterScreenDatasource.prototype.getRepairThreshold = function () {
	return this.mAutomationRepairThreshold;
};

CharacterScreenDatasource.prototype.getSalvageThreshold = function () {
	return this.mAutomationSalvageThreshold;
};

CharacterScreenDatasource.prototype.notifyBackendApplyRepairCostThreshold = function (_value) {
	if (this.mIsTacticalMode === false) {
		SQ.call(this.mSQHandle, 'onApplyRepairCostThreshold', _value);
	}
};

CharacterScreenDatasource.prototype.notifyBackendApplySalvageCostThreshold = function (_value) {
	if (this.mIsTacticalMode === false) {
		SQ.call(this.mSQHandle, 'onApplySalvageCostThreshold', _value);
	}
};