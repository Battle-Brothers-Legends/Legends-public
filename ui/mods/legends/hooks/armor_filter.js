var LegendArmorFilter = {};

LegendArmorFilter.CharacterScreenInventoryListModule = {};
// const to keep in mind
LegendArmorFilter.ArmorUpgrades = ["I", "II", "III", "IV", "V", "R"];
LegendArmorFilter.HelmetUpgrades = ["I", "II", "III", "", "R"];

LegendArmorFilter.CharacterScreenInventoryListModule.createDIV = CharacterScreenInventoryListModule.prototype.createDIV;
CharacterScreenInventoryListModule.prototype.createDIV = function (_parentDiv) {
	LegendArmorFilter.CharacterScreenInventoryListModule.createDIV.call(this, _parentDiv);

	if (this.mDataSource.mIsTacticalMode === true)
		return; // not for the inventory screen in battle

	var layout = this.mFilterButton.parent();
	if (layout === undefined || layout === null) {
		console.error("layout is undefined or null. Can\'t find the right layout");
		return;
	}

	var self = this;
	this.mIsArmorFilterShow = false;
	this.mArmorFilterPanel = $('<div class="armor-filter-panel display-none"/>')
		.appendTo(layout.parent());

	layout.mousedown(function (_event) {
		if (_event.which === 3) { // is right-clicking
			if (self.mIsArmorFilterShow) {
				self.mIsArmorFilterShow = false;
				self.mArmorFilterPanel.addClass('display-none').removeClass('display-block');
			}
			else {
				self.mIsArmorFilterShow = true;
				self.mArmorFilterPanel.addClass('display-block').removeClass('display-none');
			}
			return false;
		}
	});

	var column1 = $('<div class="filter-column"/>')
		.appendTo(this.mArmorFilterPanel);
	{
		var title = $('<div class="title title-font-normal font-bold font-color-title">Body</div>')
			.appendTo($('<div class="row"/>').appendTo(column1));

		this.mDataSource.mArmorFilters = [];
		this.mDataSource.mArmorFilters.push(this.createArmorFilterCheckbox(column1, "Base", -1));

		for (var i = 0; i < LegendArmorFilter.ArmorUpgrades.length; i++) {
			if (LegendArmorFilter.ArmorUpgrades[i].length > 0)
				this.mDataSource.mArmorFilters.push(this.createArmorFilterCheckbox(column1, LegendArmorFilter.ArmorUpgrades[i], i));
		}
	}

	var column2 = $('<div class="filter-column"/>')
		.appendTo(this.mArmorFilterPanel);
	{
		var title = $('<div class="title title-font-normal font-bold font-color-title">Head</div>')
			.appendTo($('<div class="row"/>').appendTo(column2));

		this.mDataSource.mHelmetFilters = [];
		this.mDataSource.mHelmetFilters.push(this.createArmorFilterCheckbox(column2, "Base", -1));

		for (var i = 0; i < LegendArmorFilter.HelmetUpgrades.length; i++) {
			if (LegendArmorFilter.HelmetUpgrades[i].length > 0)
				this.mDataSource.mHelmetFilters.push(this.createArmorFilterCheckbox(column2, LegendArmorFilter.HelmetUpgrades[i], i));
		}
	}

	var flexContainer = $('<div class="flexbox-button-row"/>').appendTo(this.mArmorFilterPanel);

	var selectArmorButton = $('<div class="flex-image-button"/>').appendTo(flexContainer);
	selectArmorButton.createImageButton(Path.GFX + "ui/icons/armor_body.png", function () {
		var count = 0;
		self.mDataSource.mArmorFilters.forEach(function (_element) {
			if (_element.is(':checked'))
				++count;
		});

		if (count == self.mDataSource.mArmorFilters.length) {
			self.mDataSource.mArmorFilters.forEach(function (_element) { _element.iCheck('uncheck') });
		}
		else {
			self.mDataSource.mArmorFilters.forEach(function (_element) {
				if (!_element.is(':checked'))
					_element.iCheck('check');
			});
		}
	}, '', 3);

	var selectHeadButton = $('<div class="flex-image-button"/>').appendTo(flexContainer);
	selectHeadButton.createImageButton(Path.GFX + "ui/icons/armor_head.png", function () {
		var count = 0;
		self.mDataSource.mHelmetFilters.forEach(function (_element) {
			if (_element.is(':checked'))
				++count;
		});

		if (count == self.mDataSource.mHelmetFilters.length) {
			self.mDataSource.mHelmetFilters.forEach(function (_element) { _element.iCheck('uncheck') });
		}
		else {
			self.mDataSource.mHelmetFilters.forEach(function (_element) {
				if (!_element.is(':checked'))
					_element.iCheck('check');
			});
		}
	}, '', 3);

	var applyButton = $('<div class="flex-image-button"/>').appendTo(flexContainer);
	applyButton.createImageButton(Path.GFX + "ui/icons/unlocked_small.png", function () {
		self.mDataSource.mSelectedFilterIndex = 2;
		self.cycleFilterImage();
		self.mDataSource.notifyBackendFilterArmorButtonClicked();
	}, '', 3);

	var closeButton = $('<div class="flex-image-button"/>').appendTo(flexContainer);
	closeButton.createImageButton(Path.GFX + "ui/icons/icon_cancel.png", function () {
		self.mIsArmorFilterShow = false;
		self.mArmorFilterPanel.addClass('display-none').removeClass('display-block');
	}, '', 3);
}

CharacterScreenInventoryListModule.prototype.createArmorFilterCheckbox = function (_parentDiv, _label, _id) {
	var control = $('<div class="control"/>')
		.appendTo($('<div class="row"/>').appendTo(_parentDiv));
	var checkbox = $('<input type="checkbox" id="layer-' + _label + '"/>')
		.appendTo(control);
	var label = $('<label class="title-font-normal font-color-title" for="layer-' + _label + '">' + _label + '</label>')
		.appendTo(control);
	checkbox.data("type", _id);
	checkbox.iCheck({ checkboxClass: 'icheckbox_flat-orange', radioClass: 'iradio_flat-orange', increaseArea: '30%' });
	checkbox.iCheck('check'); // checked by default
	return checkbox;
}



/// Data Source
LegendArmorFilter.CharacterScreenDatasource = {};

LegendArmorFilter.CharacterScreenDatasource.notifyBackendFilterArmorButtonClicked = CharacterScreenDatasource.prototype.notifyBackendFilterArmorButtonClicked;
CharacterScreenDatasource.prototype.notifyBackendFilterArmorButtonClicked = function () {
	if (this.mIsTacticalMode === false) { SQ.call(this.mSQHandle, 'onApplyArmorFilter', this.compileArmorFilterData()) }
	else { LegendArmorFilter.CharacterScreenDatasource.notifyBackendFilterArmorButtonClicked.call(this) }
}

CharacterScreenDatasource.prototype.compileArmorFilterData = function () {
	var result = { Armor: [], Helmet: [] };
	this.mArmorFilters.forEach(function (_element) {
		if (_element.is(':checked'))
			result.Armor.push(_element.data("type"));
	});
	this.mHelmetFilters.forEach(function (_element) {
		if (_element.is(':checked'))
			result.Helmet.push(_element.data("type"));
	});
	return result;
}