var LegendArmorFilter = {};

LegendArmorFilter.CharacterScreenInventoryListModule = {};
// const to keep in mind
LegendArmorFilter.ArmorUpgrades 	= ["I","II","III","IV","V","R"];
LegendArmorFilter.HelmetUpgrades 	= ["I","II","III","","R"];

LegendArmorFilter.CharacterScreenInventoryListModule.createDIV = CharacterScreenInventoryListModule.prototype.createDIV;
CharacterScreenInventoryListModule.prototype.createDIV = function(_parentDiv) {
	LegendArmorFilter.CharacterScreenInventoryListModule.createDIV.call(this, _parentDiv);
	
	if (this.mDataSource.mIsTacticalMode === true)
		return; // not for the inventory screen in battle

	var layout;
	while(true) {
		layout = this.mFilterArmorButton.parent();
		if (layout.hasClass('is-armor-filter')) // move up to find the parent div with this class
			break;
	}

	if (layout === undefined || layout === null) {
		console.error("layout is undefined or null. Can\'t find the right layout");
		return;
	}

	var self = this;
	this.mIsArmorFilterShow = false;
	this.mArmorFilterPanel = $('<div class="armor-filter-panel display-none"/>')
		.appendTo(layout.parent());

	layout.mousedown(function(_event) {
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
		var title = $('<div class="title title-font-normal font-bold font-color-ink">Body</div>')
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
		var title = $('<div class="title title-font-normal font-bold font-color-ink">Head</div>')
			.appendTo($('<div class="row"/>').appendTo(column2));

		this.mDataSource.mHelmetFilters = [];
		this.mDataSource.mHelmetFilters.push(this.createArmorFilterCheckbox(column2, "Base", -1));

		for (var i = 0; i < LegendArmorFilter.HelmetUpgrades.length; i++) {
			if (LegendArmorFilter.HelmetUpgrades[i].length > 0)
				this.mDataSource.mHelmetFilters.push(this.createArmorFilterCheckbox(column2, LegendArmorFilter.HelmetUpgrades[i], i));
		}
	}

	var flexContainer = $('<div class="flexbox-button-row"/>')
		.appendTo(this.mArmorFilterPanel);
	{
		var selectButton = $('<div class="flex-select-all-button title-font-normal font-color-ink">All</div>')
			.appendTo(flexContainer);
			selectButton.mouseenter(this, function(_event) { $(this).css('border', '3px solid black') });
			selectButton.mouseleave(this, function(_event) { $(this).css('border', '1px solid black') });
			selectButton.click(this, function(_event) {
				var count = 0;
				self.mDataSource.mArmorFilters.forEach(function(_element) {
	            	if (_element.is(':checked'))
	            		++count;
		        });
		        self.mDataSource.mHelmetFilters.forEach(function(_element) {
		        	if (_element.is(':checked'))
		        		++count;
		        });

		        if (count == self.mDataSource.mArmorFilters.length + self.mDataSource.mHelmetFilters.length) {
		        	self.mDataSource.mArmorFilters.forEach(function(_element) { _element.iCheck('uncheck') });
			        self.mDataSource.mHelmetFilters.forEach(function(_element) { _element.iCheck('uncheck') });
		        }
		        else {
		        	self.mDataSource.mArmorFilters.forEach(function(_element) {
		            	if (!_element.is(':checked'))
		            		_element.iCheck('check');
			        });
			        self.mDataSource.mHelmetFilters.forEach(function(_element) {
			        	if (!_element.is(':checked'))
			        		_element.iCheck('check');
			        });
		        }
		    });

		var selectArmorButton = $('<div class="flex-image-button title-font-normal font-color-ink">B</div>')
			.appendTo(flexContainer);
			selectArmorButton.css('width', '2.5rem');
			selectArmorButton.mouseenter(this, function(_event) { $(this).css('border', '3px solid black') });
			selectArmorButton.mouseleave(this, function(_event) { $(this).css('border', '1px solid black') });
			selectArmorButton.click(this, function(_event) {
	            var count = 0;
				self.mDataSource.mArmorFilters.forEach(function(_element) {
	            	if (_element.is(':checked'))
	            		++count;
		        });

		        if (count == self.mDataSource.mArmorFilters.length) {
		        	self.mDataSource.mArmorFilters.forEach(function(_element) { _element.iCheck('uncheck') });
		        }
		        else {
		        	self.mDataSource.mArmorFilters.forEach(function(_element) {
		            	if (!_element.is(':checked'))
		            		_element.iCheck('check');
			        });
		        }
		    });

		var selectHeadButton = $('<div class="flex-image-button title-font-normal font-color-ink">H</div>')
			.appendTo(flexContainer);
			selectHeadButton.css('width', '2.5rem');
			selectHeadButton.mouseenter(this, function(_event) { $(this).css('border', '3px solid black') });
			selectHeadButton.mouseleave(this, function(_event) { $(this).css('border', '1px solid black') });
			selectHeadButton.click(this, function(_event) {
	            var count = 0;
				self.mDataSource.mHelmetFilters.forEach(function(_element) {
	            	if (_element.is(':checked'))
	            		++count;
		        });

		        if (count == self.mDataSource.mHelmetFilters.length) {
		        	self.mDataSource.mHelmetFilters.forEach(function(_element) { _element.iCheck('uncheck') });
		        }
		        else {
		        	self.mDataSource.mHelmetFilters.forEach(function(_element) {
		            	if (!_element.is(':checked'))
		            		_element.iCheck('check');
			        });
		        }
		    });

		var applyButton = $('<div class="flex-image-button"/>')
			.appendTo(flexContainer);
			applyButton.createImage(Path.GFX + "ui/skin/icon_end_turn.png", null, null, '');
			applyButton.mouseenter(this, function(_event) { $(this).css('border', '3px solid black') });
			applyButton.mouseleave(this, function(_event) { $(this).css('border', '1px solid black') });
			applyButton.click(this, function(_event) {
				if (self.mFilterArmorButton.hasClass('is-active')) { self.mDataSource.notifyBackendFilterArmorButtonClicked() }
    			else { self.mFilterArmorButton.click() }
			});

		var closeButton = $('<div class="flex-image-button"/>')
			.appendTo(flexContainer);
			closeButton.createImage(Path.GFX + "ui/skin/icon_cross.png", null, null, '');
			closeButton.mouseenter(this, function(_event) { $(this).css('border', '3px solid black') });
			closeButton.mouseleave(this, function(_event) { $(this).css('border', '1px solid black') });
			closeButton.click(this, function(_event) {
            	self.mIsArmorFilterShow = false;
    			self.mArmorFilterPanel.addClass('display-none').removeClass('display-block');
    			if (self.mFilterArmorButton.hasClass('is-active'))
    				self.mDataSource.notifyBackendFilterArmorButtonClicked();
		    });
	}
}

CharacterScreenInventoryListModule.prototype.createArmorFilterCheckbox = function(_parentDiv, _label, _id) {
	var control = $('<div class="control"/>')
		.appendTo($('<div class="row"/>').appendTo(_parentDiv));
	var checkbox = $('<input type="checkbox" id="layer-' + _label + '"/>')
		.appendTo(control);
	var label = $('<label class="title-font-normal font-color-ink" for="layer-' + _label + '">' + _label + '</label>')
		.appendTo(control);
	checkbox.data("type", _id);
	checkbox.iCheck({ checkboxClass: 'icheckbox_flat-orange', radioClass: 'iradio_flat-orange', increaseArea: '30%'});
	checkbox.iCheck('check'); // checked by default
	return checkbox;
}



/// Data Source
LegendArmorFilter.CharacterScreenDatasource = {};

LegendArmorFilter.CharacterScreenDatasource.notifyBackendFilterArmorButtonClicked = CharacterScreenDatasource.prototype.notifyBackendFilterArmorButtonClicked;
CharacterScreenDatasource.prototype.notifyBackendFilterArmorButtonClicked = function() {
	if (this.mIsTacticalMode === false) { SQ.call(this.mSQHandle, 'onApplyArmorFilter', this.compileArmorFilterData()) }
	else { LegendArmorFilter.CharacterScreenDatasource.notifyBackendFilterArmorButtonClicked.call(this) }
}

CharacterScreenDatasource.prototype.compileArmorFilterData = function() {
	var result = { Armor: [], Helmet: [] };
	this.mArmorFilters.forEach(function(_element) {
    	if (_element.is(':checked'))
        	result.Armor.push(_element.data("type"));
    });
    this.mHelmetFilters.forEach(function(_element) {
        if (_element.is(':checked'))
        	result.Helmet.push(_element.data("type"));
    });
	return result;
}