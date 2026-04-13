/*
 *  @Project:		Battle Brothers
 *	@Company:		Overhype Studios
 *
 *	@Copyright:		(c) Overhype Studios | 2015
 * 
 *  @Author:		Overhype Studios
 *  @Date:			31.10.2017
 *  @Description:	World Relations Screen JS
 */
"use strict";

var WorldObituaryScreen = function(_parent)
{
	this.mSQHandle = null;

	// generic containers
	this.mContainer = null;
    this.mDialogContainer = null;
    this.mListContainer = null;
    this.mListScrollContainer = null;

    // buttons
    this.mLeaveButton = null;

    // generics
    this.mIsVisible = false;

    // selected entry
    this.mSelectedEntry = null;
	
	// dynamic checkboxes
	this.mCreatedCheckboxes = [];
};

WorldObituaryScreen.prototype.isConnected = function ()
{
    return this.mSQHandle !== null;
};

WorldObituaryScreen.prototype.onConnection = function (_handle)
{
	this.mSQHandle = _handle;
	this.register($('.root-screen'));
};

WorldObituaryScreen.prototype.onDisconnection = function ()
{
	this.mSQHandle = null;
	this.unregister();
};

WorldObituaryScreen.prototype.getModule = function (_name)
{
	switch(_name)
	{
        default: return null;
	}
};

WorldObituaryScreen.prototype.getModules = function ()
{
	return [];
};

WorldObituaryScreen.prototype.updateStatPositions = function ()
{
	var statOrder = this.getStatOrder();
	var statClasses = ['hptext', 'fttext', 'brtext', 'ittext', 'matext', 'ratext', 'mdtext', 'rdtext'];

	// For each visible row
	this.mListScrollContainer.children('.l-row').each(function () 
	{
		for (var i = 0; i < statClasses.length; i++) 
		{
			var statClass = statClasses[i];
			var statElement = $(this).find('.' + statClass);
			
			if (statElement.length > 0) 
			{
				var newIndex = statOrder[i];
				var leftRem = 119 + (newIndex * 7.2);
				statElement[0].style.setProperty('left', leftRem + 'rem', 'important');
			}
		}
	});
};

WorldObituaryScreen.prototype.reloadList = function ()
{
	if (!this.mLastData) return;

	this.mListScrollContainer.empty();

	for (var i = 0; i < this.mLastData.Fallen.length; ++i)
	{
		this.addListEntry(this.mLastData.Fallen[i]);
	}

	this.CreateStatHeader();
	this.updateStatPositions();

	if (MSU.getSettingValue("mod_legends", "SwapPerks"))
	{
		$('.trait-group, .perminjury-group, .table-header-traits, .table-header-perminjuries').hide();
		$('.perk-group, .table-header-perks').show();
	}
	else
	{
		$('.perk-group, .table-header-perks').hide();
		$('.trait-group, .perminjury-group, .table-header-traits, .table-header-perminjuries').show();
	}
};

WorldObituaryScreen.prototype.createToggleCheckbox = function(settingKey, labelText, onToggleCallback)
{
	var self = this;

	var container = $('<div class="setting-container boolean-container"/>').css({'margin-bottom': '0.3rem'});
	this.mCreatedCheckboxes.push(container);
	this.mDialogContainer.append(container);

	var titleContainer = $('<div class="setting-title-container"/>');
	container.append(titleContainer);

	var id = 'mod_legends_' + settingKey + '-id';
	var checkbox = $('<input type="checkbox" id="' + id + '" name="' + settingKey + '-name" />');

	titleContainer.append(checkbox);

	checkbox.iCheck({
		checkboxClass: 'icheckbox_flat-orange',
		radioClass: 'iradio_flat-orange',
		increaseArea: '30%'
	});

	var currentValue = MSU.getSettingValue("mod_legends", settingKey);
	checkbox.iCheck(currentValue ? 'check' : 'uncheck');

	var label = $('<label class="bool-checkbox-label title-font-small font-color-title obituary-checkbox-label" for="' + id + '">' + labelText + '</label>');
	
	label.click(function(){
		checkbox.iCheck('toggle');
	});
	
	titleContainer.append(label);

	// Bind Tooltip to label
	label.bindTooltip({
		contentType: 'ui-element',
		elementId: "world-screen.obituary." + settingKey.toLowerCase()
	});

	// Handle checkbox change
	checkbox.on('ifChecked ifUnchecked', function (event) 
	{
		var newValue = event.type === 'ifChecked';
		MSU.setSettingValue("mod_legends", settingKey, newValue);

		if (typeof onToggleCallback === 'function') 
		{
			onToggleCallback.call(self, newValue);
		}
	});

	return container;
};


WorldObituaryScreen.prototype.createDIV = function (_parentDiv)
{
    var self = this;

	// create: containers (init hidden!)
     this.mContainer = $('<div class="world-obituary-screen display-none opacity-none"/>');
     _parentDiv.append(this.mContainer);

    // create: containers (init hidden!)
    var dialogLayout = $('<div class="l-obituary-dialog-container"/>');
    this.mContainer.append(dialogLayout);
    this.mDialogContainer = dialogLayout.createDialog('Obituary', '', '', true, 'dialog-1800-768');

    // create tabs
    var tabButtonsContainer = $('<div class="l-tab-container"/>');
    this.mDialogContainer.findDialogTabContainer().append(tabButtonsContainer);
	
	var checkboxBar = $('<div class="obituary-checkbox-bar" />');
	this.mDialogContainer.findDialogHeaderContainer().append(checkboxBar);
	
	// Swap Perks / Traits
	this.mTogglePerksCheckbox = this.createToggleCheckbox(
		'SwapPerks',
		'Show Perks',
		function (newValue) 
		{
			var $perkElements  = $('.perk-group, .table-header-perks');
			var $traitElements = $('.trait-group, .perminjury-group, .table-header-traits, .table-header-perminjuries');

			if (newValue) 
			{
				$traitElements.hide();
				$perkElements.show();
			} 
			else 
			{
				$perkElements.hide();
				$traitElements.show();
			}
		}
	);
	checkboxBar.append(this.mTogglePerksCheckbox);

	// Swap Stat Display
	this.mToggleStatsCheckbox = this.createToggleCheckbox(
		'SwapStats',
		'Swap Stat Order',
		function () 
		{
			this.CreateStatHeader();
			this.updateStatPositions();
		}
	);
	checkboxBar.append(this.mToggleStatsCheckbox);

	// Swap Stacked Stars
	this.mToggleStarsCheckbox = this.createToggleCheckbox(
		'StackedStars',
		'Stacked Stars',
		function () 
		{
			this.reloadList();
		}
	);
	checkboxBar.append(this.mToggleStarsCheckbox);

    // create content
    var content = this.mDialogContainer.findDialogContentContainer();

	// column headers
    var headers = $('<div class="table-header"/>');
    content.append(headers);

    this.mColumnName = $('<div class="table-header-name title title-font-big font-bold font-color-title">Name</div>');
    headers.append(this.mColumnName);

    //this.mColumnTime = $('<div class="table-header-time title title-font-big font-bold font-color-title">Days</div>');
	this.mColumnTime = $('<div class="table-header-time"><img class="header-icon" src="' + Path.GFX + 'ui/images/day_time.png"></div>');
    headers.append(this.mColumnTime);

    //this.mColumnBattles = $('<div class="table-header-battles title title-font-big font-bold font-color-title">Battles</div>');
	this.mColumnBattles = $('<div class="table-header-battles title title-font-big font-bold font-color-title"><img class="header-icon" src="' + Path.GFX + 'ui/icons/shield_damage.png"></div>');
    headers.append(this.mColumnBattles);

    //this.mColumnKills = $('<div class="table-header-kills title title-font-big font-bold font-color-title">Kills</div>');
	this.mColumnKills = $('<div class="table-header-kills"><img class="header-icon" src="' + Path.GFX + 'ui/icons/miniboss.png"></div>');
    headers.append(this.mColumnKills);

    this.mColumnKilledBy = $('<div class="table-header-killed-by title title-font-big font-bold font-color-title">Fate</div>');
    headers.append(this.mColumnKilledBy);

    this.mLevel = $('<div class="table-header-level title title-font-big font-bold font-color-title">Lv</div>');
    headers.append(this.mLevel);

	this.mTraits = $('<div class="table-header-traits title title-font-big font-bold font-color-title">Traits</div>');
	headers.append(this.mTraits);

	this.mPermInjuries = $('<div class="table-header-perminjuries">\
		<img class="header-icon" src="' + Path.GFX + 'ui/icons/days_wounded.png' + '"></div>');
	headers.append(this.mPermInjuries);

	this.mPerks = $('<div class="table-header-perks title title-font-big font-bold font-color-title">Perks</div>');
	headers.append(this.mPerks);
	
	this.mHP = $('<div class="table-header-hp">\
		<img class="header-icon" src="' + Path.GFX + Asset.ICON_HEALTH + '"></div>');
	headers.append(this.mHP);

	this.mFT = $('<div class="table-header-ft">\
		<img class="header-icon" src="' + Path.GFX + Asset.ICON_FATIGUE + '"></div>');
	headers.append(this.mFT);

	this.mBR = $('<div class="table-header-br">\
		<img class="header-icon" src="' + Path.GFX + Asset.ICON_BRAVERY + '"></div>');
	headers.append(this.mBR);

	this.mIT = $('<div class="table-header-it">\
		<img class="header-icon" src="' + Path.GFX + Asset.ICON_INITIATIVE + '"></div>');
	headers.append(this.mIT);

	this.mMA = $('<div class="table-header-ma">\
		<img class="header-icon" src="' + Path.GFX + Asset.ICON_MELEE_SKILL + '"></div>');
	headers.append(this.mMA);

	this.mRA = $('<div class="table-header-ra">\
		<img class="header-icon" src="' + Path.GFX + Asset.ICON_RANGE_SKILL + '"></div>');
	headers.append(this.mRA);

	this.mMD = $('<div class="table-header-md">\
		<img class="header-icon" src="' + Path.GFX + Asset.ICON_MELEE_DEFENCE + '"></div>');
	headers.append(this.mMD);

	this.mRD = $('<div class="table-header-rd">\
		<img class="header-icon" src="' + Path.GFX + Asset.ICON_RANGE_DEFENCE + '"></div>');
	headers.append(this.mRD);

    // left column
    var column = $('<div class="column is-left"/>');
    content.append(column);
    var listContainerLayout = $('<div class="l-list-container"/>');
    column.append(listContainerLayout);
    this.mListContainer = listContainerLayout.createList(1.0/*8.85*/);
    this.mListScrollContainer = this.mListContainer.findListScrollContainer();

    // create footer button bar
    var footerButtonBar = $('<div class="l-button-bar"/>');
    this.mDialogContainer.findDialogFooterContainer().append(footerButtonBar);

    // create: buttons
    var layout = $('<div class="l-leave-button"/>');
    footerButtonBar.append(layout);
    this.mLeaveButton = layout.createTextButton("Close", function()
	{
        self.notifyBackendCloseButtonPressed();
    }, '', 1);

    this.mIsVisible = false;
	
    $(document).off('keyup.mod_legends');

	$(document).on('keyup.mod_legends', function(event) 
	{
		// Toggle Perks Keybind
		if (MSU.Keybinds.isKeybindPressed("mod_legends", "toggle_perks", event))
		{
			self.mTogglePerksCheckbox.find('input').iCheck('toggle');
			return false;
		}

		// Toggle Stacked Stars Keybind
		else if (MSU.Keybinds.isKeybindPressed("mod_legends", "stacked_talent_stars", event))
		{
			self.mToggleStarsCheckbox.find('input').iCheck('toggle');
			return false;
		}

		// Toggle Stat Order Keybind
		else if (MSU.Keybinds.isKeybindPressed("mod_legends", "toggle_stat_order", event))
		{
			self.mToggleStatsCheckbox.find('input').iCheck('toggle');
			return false;
		}
	});

};

WorldObituaryScreen.prototype.destroyCheckboxes = function () 
{
	if (!this.mCreatedCheckboxes) return;

	for (var i = 0; i < this.mCreatedCheckboxes.length; ++i) 
	{
		var container = this.mCreatedCheckboxes[i];
		container.find('label').unbindTooltip();
		container.find('input').iCheck('destroy');
		container.remove();
	}

	this.mCreatedCheckboxes = [];
};


WorldObituaryScreen.prototype.destroyDIV = function ()
{
	//this.mAssets.destroyDIV();

    this.mListScrollContainer.empty();
    this.mListScrollContainer = null;
    this.mListContainer.destroyList();
    this.mListContainer.remove();
    this.mListContainer = null;

	this.mLeaveButton.remove();
    this.mLeaveButton = null;

    this.mDialogContainer.empty();
    this.mDialogContainer.remove();
    this.mDialogContainer = null;

    this.mContainer.empty();
    this.mContainer.remove();
    this.mContainer = null;
	
	this.destroyCheckboxes();
	
	this.mTogglePerksCheckbox = null;
	this.mToggleStatsCheckbox = null;
	this.mToggleStarsCheckbox = null;

	$(document).off('keyup.mod_legends');
};

WorldObituaryScreen.prototype.getStatOrder = function ()
{
    var SwapStats = MSU.getSettingValue("mod_legends", "SwapStats");

    return SwapStats
        ? [4, 5, 6, 7, 0, 1, 2, 3]
        : [0, 1, 2, 3, 4, 5, 6, 7];
};

WorldObituaryScreen.prototype.CreateStatHeader = function ()
{
    var statOrder = this.getStatOrder();

    var headerMap = [
        'table-header-hp', 'table-header-ft', 'table-header-br', 'table-header-it',
        'table-header-ma', 'table-header-ra', 'table-header-md', 'table-header-rd'
    ];

    for (var i = 0; i < headerMap.length; i++) 
	{
        var className = headerMap[i];
        var selector = '.world-obituary-screen > .l-obituary-dialog-container .table-header .' + className;
        var element = document.querySelector(selector);
        if (element) 
		{
            var newIndex = statOrder[i];
            var leftRem = 119 + (newIndex * 7.2) + 1;
            element.style.setProperty('left', leftRem + 'rem', 'important');
        }
    }
};

WorldObituaryScreen.prototype.createIconGroup = function (items, className, count)
{
	var group = $('<div class="' + className + '"></div>');

	for (var i = 0; i < count; i++) 
	{
		var item = items[i];
		
		if (item) 
		{
			var img = $('<img/>').attr('src', Path.GFX + (item.icon || item));
			if (item.id) 
			{
				img.attr('id', item.id);
				img.bindTooltip({ contentType: 'ui-element', elementId: item.id });
			}
			group.append(img);
		}
	}
	return group;
};

WorldObituaryScreen.prototype.addListEntry = function (_data)
{
    var result = $('<div class="l-row"/>');
    this.mListScrollContainer.append(result);

    result.append($('<div class="name text-font-normal font-color-description">' + _data.Name + '</div>'));
    result.append($('<div class="time text-font-normal font-color-description">' + _data.TimeWithCompany + '</div>'));
    result.append($('<div class="battles text-font-normal font-color-description">' + _data.Battles + '</div>'));
    result.append($('<div class="kills text-font-normal font-color-description">' + _data.Kills + '</div>'));
    result.append($('<div class="killed-by text-font-normal font-color-description">' + _data.KilledBy + '</div>'));

    if (_data.stats && _data.stats[0]) 
    {
        result.append($('<div class="level text-font-normal font-color-description">' + _data.level + '</div>'));

        // Traits (First entry is background)
		if (_data.traits && _data.traits.length > 0)
		{
			var show_num_traits = MSU.getSettingValue("mod_legends", "show_num_traits");
			result.append(this.createIconGroup(_data.traits, 'trait-group', show_num_traits));
		}

        // Permanent Injuries
		if (_data.perminjuries && _data.perminjuries.length > 0)
		{
			var show_num_perminjuries = MSU.getSettingValue("mod_legends", "show_num_perminjuries");
			result.append(this.createIconGroup(_data.perminjuries, 'perminjury-group', show_num_perminjuries));
		}

        // Perks
		if (_data.perks && _data.perks.length > 0)
		{
			var show_num_perks = MSU.getSettingValue("mod_legends", "show_num_perks");
			var perksGroup = this.createIconGroup(_data.perks, 'perk-group', show_num_perks);
			perksGroup.hide(); // Initially hidden; toggle in settings
			result.append(perksGroup);
		}
		
		// Stats
		if (_data.stats && _data.talents && _data.stats.length > 0)
		{
			var statsLabels = ['hptext', 'fttext', 'brtext', 'ittext', 'matext', 'ratext', 'mdtext', 'rdtext'];
			var TalentStackedStars = MSU.getSettingValue("mod_legends", "StackedStars");
			var statOrder = this.getStatOrder();

			var statWidth = !TalentStackedStars ? '6.5rem' : '5.5rem';
			var iconWidth = !TalentStackedStars ? '3.6rem' : '';

			for (var i = 0; i < statOrder.length; i++) 
			{
				var index = statOrder[i];
				var statClass = statsLabels[index];
				var statValue = _data.stats[index];
				var talentIndex = _data.talents[index];
				
				// Use stacked 3 star icon instad if setting enabled
				var talentPrefix = (TalentStackedStars && talentIndex === 3) ? 'stacked_talent_' : 'talent_';

				var statDiv = $('<div class="' + statClass + ' text-font-normal font-color-description">').append(statValue);
				var talentstar = $('<img/>').attr('src', Path.GFX + 'ui/icons/' + talentPrefix + talentIndex + '.png');

				statDiv.append(talentstar);

				var leftRem = 119 + (i * 7.2);
				statDiv[0].style.setProperty('left', leftRem + 'rem', 'important');

				result.append(statDiv);
			}
		}
    }
};


WorldObituaryScreen.prototype.bindTooltips = function ()
{
	this.mColumnName.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.WorldScreen.Obituary.ColumnName });
	this.mColumnTime.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.WorldScreen.Obituary.ColumnTime });
	this.mColumnBattles.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.WorldScreen.Obituary.ColumnBattles });
	this.mColumnKills.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.WorldScreen.Obituary.ColumnKills });
	this.mColumnKilledBy.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.WorldScreen.Obituary.ColumnKilledBy });
	this.mLevel.bindTooltip({ contentType: 'ui-element', elementId: 'world-screen.obituary.Level' });
	this.mTraits.bindTooltip({ contentType: 'ui-element', elementId: 'world-screen.obituary.Traits' });
	this.mPermInjuries.bindTooltip({ contentType: 'ui-element', elementId: 'world-screen.obituary.PermInjuries' });
	this.mPerks.bindTooltip({ contentType: 'ui-element', elementId: 'world-screen.obituary.Perks' });
	this.mHP.bindTooltip({ contentType: 'ui-element', elementId: 'world-screen.obituary.HP' });
	this.mFT.bindTooltip({ contentType: 'ui-element', elementId: 'world-screen.obituary.FT' });
	this.mBR.bindTooltip({ contentType: 'ui-element', elementId: 'world-screen.obituary.BR' });
	this.mIT.bindTooltip({ contentType: 'ui-element', elementId: 'world-screen.obituary.IT' });
	this.mMA.bindTooltip({ contentType: 'ui-element', elementId: 'world-screen.obituary.MA' });
	this.mRA.bindTooltip({ contentType: 'ui-element', elementId: 'world-screen.obituary.RA' });
	this.mMD.bindTooltip({ contentType: 'ui-element', elementId: 'world-screen.obituary.MD' });
	this.mRD.bindTooltip({ contentType: 'ui-element', elementId: 'world-screen.obituary.RD' });
};

WorldObituaryScreen.prototype.unbindTooltips = function ()
{
	this.mColumnName.unbindTooltip();
	this.mColumnTime.unbindTooltip();
	this.mColumnBattles.unbindTooltip();
	this.mColumnKills.unbindTooltip();
	this.mColumnKilledBy.unbindTooltip();
	this.mLevel.unbindTooltip();
	this.mTraits.unbindTooltip();
	this.mPermInjuries.unbindTooltip();
	this.mPerks.unbindTooltip();
	this.mHP.unbindTooltip();
	this.mFT.unbindTooltip();
	this.mBR.unbindTooltip();
	this.mIT.unbindTooltip();
	this.mMA.unbindTooltip();
	this.mRA.unbindTooltip();
	this.mMD.unbindTooltip();
	this.mRD.unbindTooltip();

};


WorldObituaryScreen.prototype.create = function(_parentDiv)
{
    this.createDIV(_parentDiv);
    this.bindTooltips();
};

WorldObituaryScreen.prototype.destroy = function()
{
    this.unbindTooltips();
    this.destroyDIV();
};


WorldObituaryScreen.prototype.register = function (_parentDiv)
{
    console.log('WorldObituaryScreen::REGISTER');

    if (this.mContainer !== null)
    {
        console.error('ERROR: Failed to register Relations Screen. Reason: Already initialized.');
        return;
    }

    if (_parentDiv !== null && typeof(_parentDiv) == 'object')
    {
        this.create(_parentDiv);
    }
};

WorldObituaryScreen.prototype.unregister = function ()
{
    console.log('WorldObituaryScreen::UNREGISTER');

    if (this.mContainer === null)
    {
        console.error('ERROR: Failed to unregister Relations Screen. Reason: Not initialized.');
        return;
    }

    this.destroy();
};

WorldObituaryScreen.prototype.isRegistered = function ()
{
    if (this.mContainer !== null)
    {
        return this.mContainer.parent().length !== 0;
    }

    return false;
};

WorldObituaryScreen.prototype.syncCheckboxStates = function()
{
	var settings = [
		{ key: 'SwapPerks', checkbox: this.mTogglePerksCheckbox },
		{ key: 'SwapStats', checkbox: this.mToggleStatsCheckbox },
		{ key: 'StackedStars', checkbox: this.mToggleStarsCheckbox }
	];

	for (var i = 0; i < settings.length; i++)
	{
		var setting = settings[i];
		var input = setting.checkbox.find('input[type="checkbox"]');
		var value = MSU.getSettingValue("mod_legends", setting.key);
		input.iCheck(value ? 'check' : 'uncheck');
	}
};

WorldObituaryScreen.prototype.show = function (_data)
{
    this.loadFromData(_data);

	if(!this.mIsVisible)
	{
		var self = this;

		var withAnimation = true;//(_data !== undefined && _data['withSlideAnimation'] !== null) ? _data['withSlideAnimation'] : true;
		if (withAnimation === true)
		{
			var offset = -(this.mContainer.parent().width() + this.mContainer.width());
			this.mContainer.css({ 'left': offset });
			this.mContainer.velocity("finish", true).velocity({ opacity: 1, left: '0', right: '0' }, {
				duration: Constants.SCREEN_SLIDE_IN_OUT_DELAY,
				easing: 'swing',
				begin: function () {
					$(this).removeClass('display-none').addClass('display-block');
					self.notifyBackendOnAnimating();
				},
				complete: function () {
					self.mIsVisible = true;
					self.notifyBackendOnShown();
				}
			});
		}
		else
		{
			this.mContainer.css({ opacity: 0 });
			this.mContainer.velocity("finish", true).velocity({ opacity: 1 }, {
				duration: Constants.SCREEN_FADE_IN_OUT_DELAY,
				easing: 'swing',
				begin: function() {
					$(this).removeClass('display-none').addClass('display-block');
					self.notifyBackendOnAnimating();
				},
				complete: function() {
					self.mIsVisible = true;
					self.notifyBackendOnShown();
				}
			});
		}
	}

	this.syncCheckboxStates();
	
	this.updateStatPositions();
	
    this.mContainer.removeClass('display-none').addClass('display-block');

    // Check MSU setting to hide/show the checkboxes
    var shouldHide = MSU.getSettingValue("mod_legends", "HideObituarySetting");

    if (this.mTogglePerksCheckbox)  this.mTogglePerksCheckbox.css('display', shouldHide ? 'none' : 'block');
    if (this.mToggleStatsCheckbox)  this.mToggleStatsCheckbox.css('display', shouldHide ? 'none' : 'block');
    if (this.mToggleStarsCheckbox)  this.mToggleStarsCheckbox.css('display', shouldHide ? 'none' : 'block');

    this.notifyBackendOnShown();
};

WorldObituaryScreen.prototype.hide = function (_withSlideAnimation)
{
    var self = this;

    var withAnimation = true;//(_withSlideAnimation !== undefined && _withSlideAnimation !== null) ? _withSlideAnimation : true;
    if (withAnimation === true)
    {
        var offset = -(this.mContainer.parent().width() + this.mContainer.width());
        this.mContainer.velocity("finish", true).velocity({ opacity: 0, left: offset },
		{
            duration: Constants.SCREEN_SLIDE_IN_OUT_DELAY,
            easing: 'swing',
            begin: function ()
            {
                $(this).removeClass('is-center');
                self.notifyBackendOnAnimating();
            },
            complete: function ()
            {
            	self.mIsVisible = false;
            	self.mListScrollContainer.empty();
                $(this).removeClass('display-block').addClass('display-none');
                self.notifyBackendOnHidden();
            }
        });
    }
    else
    {
    	this.mContainer.velocity("finish", true).velocity({ opacity: 0 },
		{
            duration: Constants.SCREEN_SLIDE_IN_OUT_DELAY,
            easing: 'swing',
            begin: function ()
            {
                $(this).removeClass('is-center');
                self.notifyBackendOnAnimating();
            },
            complete: function ()
            {
                self.mIsVisible = false;
                self.mListScrollContainer.empty();
                $(this).removeClass('display-block').addClass('display-none');
                self.notifyBackendOnHidden();
            }
        });
    }
};

WorldObituaryScreen.prototype.isVisible = function ()
{
    return this.mIsVisible;
};


WorldObituaryScreen.prototype.loadFromData = function (_data)
{
    if(_data === undefined || _data === null)
    {
        return;
    }
	
	this.mLastData = _data;

    this.mListScrollContainer.empty();

    if(_data.Fallen.length == 0)
    	this.mDialogContainer.findDialogSubTitle().text('No one has fallen since you took command');
    else if(_data.Fallen.length == 1)
		this.mDialogContainer.findDialogSubTitle().text('A single man has fallen since you took command');
    else
    	this.mDialogContainer.findDialogSubTitle().text('' + _data.Fallen.length + ' men have fallen since you took command');
	
	for(var i = 0; i < _data.Fallen.length; ++i)
    {
		this.addListEntry(_data.Fallen[i]);
    }
	
	// Stat header
	this.CreateStatHeader();
	
    var $traitElements = $('.trait-group, .perminjury-group, .table-header-traits, .table-header-perminjuries');
    var $perkElements = $('.perk-group, .table-header-perks');

    if (MSU.getSettingValue("mod_legends", "SwapPerks")) {
        $traitElements.hide();
        $perkElements.show();
    } else {
        $perkElements.hide();
        $traitElements.show();
    }
};

WorldObituaryScreen.prototype.notifyBackendOnConnected = function ()
{
	if(this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onScreenConnected');
	}
};

WorldObituaryScreen.prototype.notifyBackendOnDisconnected = function ()
{
	if(this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onScreenDisconnected');
	}
};

WorldObituaryScreen.prototype.notifyBackendOnShown = function ()
{
    if(this.mSQHandle !== null)
    {
        SQ.call(this.mSQHandle, 'onScreenShown');
    }
};

WorldObituaryScreen.prototype.notifyBackendOnHidden = function ()
{
    if(this.mSQHandle !== null)
    {
        SQ.call(this.mSQHandle, 'onScreenHidden');
    }
};

WorldObituaryScreen.prototype.notifyBackendOnAnimating = function ()
{
    if(this.mSQHandle !== null)
    {
        SQ.call(this.mSQHandle, 'onScreenAnimating');
    }
};

WorldObituaryScreen.prototype.notifyBackendCloseButtonPressed = function (_buttonID)
{
    if(this.mSQHandle !== null)
    {
        SQ.call(this.mSQHandle, 'onClose', _buttonID);
    }
};