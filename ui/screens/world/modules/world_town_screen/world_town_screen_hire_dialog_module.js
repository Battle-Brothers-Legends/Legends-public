
"use strict";

var WorldTownScreenHireDialogModule = function(_parent)
{
	this.mSQHandle = null;
	this.mParent = _parent;

	this.mRoster = null;

	// event listener
	this.mEventListener = null;

	// generic containers
	this.mContainer = null;
	this.mDialogContainer = null;
	this.mListContainer = null;
	this.mListScrollContainer = null;
	this.mDetailsPanel =
	{
		Container: null,
		CharacterImage: null,
		CharacterName: null,
		CharacterTraitsContainer: null,
		CharacterBackgroundTextContainer: null,
		CharacterBackgroundTextScrollContainer: null,
		CharacterBackgroundImage: null,
		InitialMoneyCostsText: null,
		TryoutMoneyCostsText: null,
		TryoutCostsContainer: null,
		DailyMoneyCostsText: null,
		HireButton: null,
		TryoutButton: null,
		DismissButton: null
	};
	this.dismissButtonLayout = null;

	// assets labels
	this.mAssets = new WorldTownScreenAssets(_parent);

	// buttons
	this.mLeaveButton = null;

	// generics
	this.mIsVisible = false;

	// selected entry
	this.mSelectedEntry = null;
};


WorldTownScreenHireDialogModule.prototype.isConnected = function ()
{
	return this.mSQHandle !== null;
};

WorldTownScreenHireDialogModule.prototype.onConnection = function (_handle)
{
	//if (typeof(_handle) == 'string')
	{
		this.mSQHandle = _handle;

		// notify listener
		if (this.mEventListener !== null && ('onModuleOnConnectionCalled' in this.mEventListener)) {
			this.mEventListener.onModuleOnConnectionCalled(this);
		}
	}
};

WorldTownScreenHireDialogModule.prototype.onDisconnection = function ()
{
	this.mSQHandle = null;

	// notify listener
	if (this.mEventListener !== null && ('onModuleOnDisconnectionCalled' in this.mEventListener)) {
		this.mEventListener.onModuleOnDisconnectionCalled(this);
	}
};

WorldTownScreenHireDialogModule.prototype.createDIV = function (_parentDiv)
{
	var self = this;

	// create: containers (init hidden!)
	this.mContainer = $('<div class="l-hire-dialog-container display-none opacity-none"/>');
	_parentDiv.append(this.mContainer);
	this.mDialogContainer = this.mContainer.createDialog('Hire', null, '', true, 'dialog-1024-768');

	// create tabs
	var tabButtonsContainer = $('<div class="l-tab-container"/>');
	this.mDialogContainer.findDialogTabContainer().append(tabButtonsContainer);

	// create assets
	this.mAssets.createDIV(tabButtonsContainer);

	// create content
	var content = this.mDialogContainer.findDialogContentContainer();

	// left column
	var column = $('<div class="column is-left"/>');
	content.append(column);
	var listContainerLayout = $('<div class="l-list-container"/>');
	column.append(listContainerLayout);
	this.mListContainer = listContainerLayout.createList(1.77/*8.85*/);
	this.mListScrollContainer = this.mListContainer.findListScrollContainer();

	// right column
	column = $('<div class="column is-right"/>');
	content.append(column);

	// details container
	var detailsFrame = $('<div class="l-details-frame"/>');
	column.append(detailsFrame);
	this.mDetailsPanel.Container = $('<div class="details-container display-none"/>');
	detailsFrame.append(this.mDetailsPanel.Container);

	// details: character container
	var detailsRow = $('<div class="row is-character-container"/>');
	this.mDetailsPanel.Container.append(detailsRow);
	var detailsColumn = $('<div class="column is-character-portrait-container"/>');
	detailsRow.append(detailsColumn);
	this.mDetailsPanel.CharacterImage = detailsColumn.createImage(null, function (_image)
	{
		var offsetX = 0;
		var offsetY = 0;

		if(self.mSelectedEntry !== null)
		{
			var data = self.mSelectedEntry.data('entry');
			if('ImageOffsetX' in data && data['ImageOffsetX'] !== null &&
				'ImageOffsetY' in data && data['ImageOffsetY'] !== null)
			{
				offsetX = data['ImageOffsetX'];
				offsetY = data['ImageOffsetY'];
			}
		}

		_image.centerImageWithinParent(offsetX, offsetY, 1.0);
		_image.removeClass('opacity-none');
	}, null, 'opacity-none');
	detailsColumn = $('<div class="column is-character-background-container"/>');
	detailsRow.append(detailsColumn);

	// details: background
	var backgroundRow = $('<div class="row is-top"/>');
	detailsColumn.append(backgroundRow);
	var backgroundRowBorder = $('<div class="row is-top border"/>');
	backgroundRow.append(backgroundRowBorder);

	this.mDetailsPanel.CharacterBackgroundImage = $('<img />');
	detailsColumn.append(this.mDetailsPanel.CharacterBackgroundImage);
	this.mDetailsPanel.CharacterName = $('<div class="name title-font-normal font-bold font-color-brother-name"/>');
	backgroundRow.append(this.mDetailsPanel.CharacterName);

	this.mDetailsPanel.CharacterTraitsContainer = $('<div class="traits-container"/>');
	backgroundRow.append(this.mDetailsPanel.CharacterTraitsContainer);

	backgroundRow = $('<div class="row is-bottom"/>');
	detailsColumn.append(backgroundRow);
	this.mDetailsPanel.CharacterBackgroundTextContainer = backgroundRow.createList(20, 'description-font-medium font-bottom-shadow font-color-description', true);
	this.mDetailsPanel.CharacterBackgroundTextScrollContainer = this.mDetailsPanel.CharacterBackgroundTextContainer.findListScrollContainer();

	// details: costs
	detailsRow = $('<div class="row is-costs-container"/>');
	this.mDetailsPanel.Container.append(detailsRow);
	var costsHeader = $('<div class="row is-header"/>');
	detailsRow.append(costsHeader);
	var costsHeaderLabel = $('<div class="label title-font-normal font-bold font-bottom-shadow font-color-title">Costs</div>');
	costsHeader.append(costsHeaderLabel);
	var costsInitial = $('<div class="row is-initial-costs"/>');
	detailsRow.append(costsInitial);
	var costsLabel = $('<div class="costs-label title-font-normal font-bold font-bottom-shadow font-color-title">Up Front</div>');
	costsInitial.append(costsLabel);
	var costsContainer = $('<div class="l-costs-container"/>');
	costsInitial.append(costsContainer);
	var costsImage = $('<img/>');
	costsImage.attr('src', Path.GFX + Asset.ICON_ASSET_MONEY);
	costsContainer.append(costsImage);
	costsImage.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.Assets.InitialMoney });
	this.mDetailsPanel.InitialMoneyCostsText = $('<div class="label text-font-normal font-bottom-shadow font-color-description"/>');
	costsContainer.append(this.mDetailsPanel.InitialMoneyCostsText);

	var costsDaily = $('<div class="row is-daily-costs"/>');
	detailsRow.append(costsDaily);
	costsLabel = $('<div class="costs-label title-font-normal font-bold font-bottom-shadow font-color-title">Daily</div>');
	costsDaily.append(costsLabel);
	costsContainer = $('<div class="l-costs-container"/>');
	costsDaily.append(costsContainer);
	costsImage = $('<img/>');
	costsImage.attr('src', Path.GFX + Asset.ICON_ASSET_DAILY_MONEY);
	costsContainer.append(costsImage);
	costsImage.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.Assets.DailyMoney });
	this.mDetailsPanel.DailyMoneyCostsText = $('<div class="label text-font-normal font-bottom-shadow font-color-description"/>');
	costsContainer.append(this.mDetailsPanel.DailyMoneyCostsText);

	costsContainer = $('<div class="l-costs-container l-tryout-costs-container"/>');
	this.mDetailsPanel.TryoutCostsContainer = costsContainer;
	costsInitial.append(costsContainer);
	var costsImage = $('<img/>');
	costsImage.attr('src', Path.GFX + Asset.ICON_ASSET_MONEY);
	costsContainer.append(costsImage);
	costsImage.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.Assets.TryoutMoney });
	this.mDetailsPanel.TryoutMoneyCostsText = $('<div class="label text-font-normal font-bottom-shadow font-color-description"/>');
	costsContainer.append(this.mDetailsPanel.TryoutMoneyCostsText);

	// details: buttons
	detailsRow = $('<div class="row is-button-container"/>');
	this.mDetailsPanel.Container.append(detailsRow);
	var hireButtonLayout = $('<div class="l-hire-button"/>');
	detailsRow.append(hireButtonLayout);
	this.mDetailsPanel.HireButton = hireButtonLayout.createTextButton("Hire", function()
	{
		if(self.mSelectedEntry !== null)
		{
			var data = self.mSelectedEntry.data('entry');
			if('ID' in data && data['ID'] !== null)
			{
				self.hireRosterEntry(data['ID']);
			}
		}
	}, '', 1);

	var tryoutButtonLayout = $('<div class="l-tryout-button"/>');
	detailsRow.append(tryoutButtonLayout);
	this.mDetailsPanel.TryoutButton = tryoutButtonLayout.createTextButton("Try out", function()
	{
		if(self.mSelectedEntry !== null)
		{
			var data = self.mSelectedEntry.data('entry');
			if('ID' in data && data['ID'] !== null)
			{
				self.tryoutRosterEntry(data['ID']);
			}
		}
	}, '', 1);

	this.dismissButtonLayout = $('<div class="l-tryout-button"/>');
	detailsRow.append(this.dismissButtonLayout);
	this.mDetailsPanel.DismissButton = this.dismissButtonLayout.createTextButton("Dismiss", function()
	{
		if(self.mSelectedEntry !== null)
		{
			var data = self.mSelectedEntry.data('entry');
			if('ID' in data && data['ID'] !== null)
			{
				self.dismissRosterEntry(data['ID']);
			}
		}
	}, '', 1);
	this.dismissButtonLayout.hide();

	// create footer button bar
	var footerButtonBar = $('<div class="l-button-bar"/>');
	this.mDialogContainer.findDialogFooterContainer().append(footerButtonBar);

	// create: buttons
	var layout = $('<div class="l-leave-button"/>');
	footerButtonBar.append(layout);
	this.mLeaveButton = layout.createTextButton("Leave", function ()
	{
		self.notifyBackendLeaveButtonPressed();
	}, '', 1);

	this.mIsVisible = false;
};

WorldTownScreenHireDialogModule.prototype.destroyDIV = function ()
{
	this.mAssets.destroyDIV();

	this.mSelectedEntry = null;

	this.mDetailsPanel.HireButton.remove();
	this.mDetailsPanel.HireButton = null;

	/*
	this.mDetailsPanel.DailyFoodCostsText.empty();
	this.mDetailsPanel.DailyFoodCostsText.remove();
	this.mDetailsPanel.DailyFoodCostsText = null;
	*/

	this.mDetailsPanel.DailyMoneyCostsText.empty();
	this.mDetailsPanel.DailyMoneyCostsText.remove();
	this.mDetailsPanel.DailyMoneyCostsText = null;

	this.mDetailsPanel.InitialMoneyCostsText.empty();
	this.mDetailsPanel.InitialMoneyCostsText.remove();
	this.mDetailsPanel.InitialMoneyCostsText = null;

	this.mDetailsPanel.CharacterBackgroundImage.empty();
	this.mDetailsPanel.CharacterBackgroundImage.remove();
	this.mDetailsPanel.CharacterBackgroundImage = null;

	this.mDetailsPanel.CharacterBackgroundTextScrollContainer.empty();
	this.mDetailsPanel.CharacterBackgroundTextScrollContainer = null;
	this.mDetailsPanel.CharacterBackgroundTextContainer.destroyList();
	this.mDetailsPanel.CharacterBackgroundTextContainer.remove();
	this.mDetailsPanel.CharacterBackgroundTextContainer = null;

	this.mDetailsPanel.CharacterName.empty();
	this.mDetailsPanel.CharacterName.remove();
	this.mDetailsPanel.CharacterName = null;

	this.mDetailsPanel.CharacterImage.empty();
	this.mDetailsPanel.CharacterImage.remove();
	this.mDetailsPanel.CharacterImage = null;

	this.mDetailsPanel.Container.empty();
	this.mDetailsPanel.Container.remove();
	this.mDetailsPanel.Container = null;

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
	this.dismissButtonLayout = null;
};

WorldTownScreenHireDialogModule.prototype.addListEntry = function (_data)
{
	var result = $('<div class="l-row"/>');
	this.mListScrollContainer.append(result);

	var entry = $('<div class="ui-control list-entry"/>');
	result.append(entry);
	entry.data('entry', _data);
	entry.click(this, function(_event)
	{
		var self = _event.data;
		self.selectListEntry($(this));
	});

	// left column
	var column = $('<div class="column is-left"/>');
	entry.append(column);

	var imageOffsetX = ('ImageOffsetX' in _data ? _data['ImageOffsetX'] : 0);
	var imageOffsetY = ('ImageOffsetY' in _data ? _data['ImageOffsetY'] : 0);
	column.createImage(Path.PROCEDURAL + _data['ImagePath'], function (_image)
	{
		_image.centerImageWithinParent(imageOffsetX, imageOffsetY, 0.64, false);
		_image.removeClass('opacity-none');
	}, null, 'opacity-none');

	// right column
	column = $('<div class="column is-right"/>');
	entry.append(column);

	// top row
	var row = $('<div class="row is-top"/>');
	column.append(row);

	var image = $('<img/>');
	image.attr('src', Path.GFX + _data['BackgroundImagePath']);
	row.append(image);

	// bind tooltip
	image.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterBackgrounds.Generic, elementOwner: TooltipIdentifier.ElementOwner.HireScreen, entityId: _data.ID });

	var name = $('<div class="name title-font-normal font-bold font-color-title">' + _data[WorldTownScreenIdentifier.HireRosterEntry.Name] + '</div>');
	row.append(name);

	// bind tooltip
	if(_data[WorldTownScreenIdentifier.HireRosterEntry.Level] > 1)
	{
		var levelContainer = $('<div class="l-level-container"/>');
		row.append(levelContainer);
		image = $('<img/>');
		image.attr('src', Path.GFX + Asset.ICON_LEVEL);
		levelContainer.append(image);

		//image.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterLevels.Generic, elementOwner: TooltipIdentifier.ElementOwner.HireScreen, entityId: _data[WorldTownScreenIdentifier.HireRosterEntry.Id] });
		image.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterLevels.Generic });
		var level = $('<div class="level text-font-normal font-bold font-color-subtitle">' + _data[WorldTownScreenIdentifier.HireRosterEntry.Level] + '</div>');
		levelContainer.append(level);
	}

	// bottom row
	row = $('<div class="row is-bottom"/>');
	column.append(row);

	var traitsContainer = $('<div class="is-traits-container"/>');
	row.append(traitsContainer);

	var assetsCenterContainer = $('<div class="l-assets-center-container"/>');
	row.append(assetsCenterContainer);

	// initial money
	var assetsContainer = $('<div class="l-assets-container"/>');
	assetsCenterContainer.append(assetsContainer);
	image = $('<img/>');
	image.attr('src', Path.GFX + Asset.ICON_ASSET_MONEY);
	assetsContainer.append(image);
	image.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.Assets.InitialMoney });
	var text = $('<div class="label is-initial-money-cost text-font-normal font-color-subtitle">' + Helper.numberWithCommas(_data[WorldTownScreenIdentifier.HireRosterEntry.InitialMoneyCost]) + '</div>');
	assetsContainer.append(text);

	// daily money
	assetsContainer = $('<div class="l-assets-container"/>');
	assetsCenterContainer.append(assetsContainer);
	image = $('<img/>');
	image.attr('src', Path.GFX + Asset.ICON_ASSET_DAILY_MONEY);
	assetsContainer.append(image);
	image.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.Assets.DailyMoney });
	text = $('<div class="label is-daily-money-cost text-font-normal font-color-subtitle">' + Helper.numberWithCommas(_data[WorldTownScreenIdentifier.HireRosterEntry.DailyMoneyCost]) + '</div>');
	assetsContainer.append(text);

	// daily food
	/* NOTE: (js) We dont want to show daily food anymore..
	assetsContainer = $('<div class="l-assets-container"/>');
	assetsCenterContainer.append(assetsContainer);
	image = $('<img/>');
	image.attr('src', Path.GFX + Asset.ICON_ASSET_DAILY_FOOD);
	assetsContainer.append(image);
	image.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.Assets.DailyFood });
	text = $('<div class="label is-daily-food-cost text-font-normal font-color-assets-positive-value">' + Helper.numberWithCommas(_data[WorldTownScreenIdentifier.HireRosterEntry.DailyFoodCost]) + '</div>');
	assetsContainer.append(text);
	*/
};

WorldTownScreenHireDialogModule.prototype.selectListEntry = function(_element, _scrollToEntry)
{
	if (_element !== null && _element.length > 0)
	{
		// check if this is already selected
		//if (_element.hasClass('is-selected') !== true)
		{
			this.mListContainer.deselectListEntries();
			_element.addClass('is-selected');

			// give the renderer some time to layout his shit...
			if (_scrollToEntry !== undefined && _scrollToEntry === true)
			{
				this.mListContainer.scrollListToElement(_element);
			}

			this.mSelectedEntry = _element;
			this.updateDetailsPanel(this.mSelectedEntry);
			this.updateListEntryValues();
		}
	}
	else
	{
		this.mSelectedEntry = null;
		this.updateDetailsPanel(this.mSelectedEntry);
		this.updateListEntryValues();
	}
};

WorldTownScreenHireDialogModule.prototype.updateDetailsPanel = function(_element)
{
	if (_element !== null && _element.length > 0)
	{
		var currentMoney = this.mAssets.getValues().Money;
		var data = _element.data('entry');
		var initialMoneyCost = data['InitialMoneyCost'];
		var tryoutMoneyCost = data['TryoutCost'];

		this.mDetailsPanel.CharacterImage.attr('src', Path.PROCEDURAL + data['ImagePath']);	 
	   
		// retarded JS calls load callback after a significant delay only - so we call this here manually to position/resize an image that is completely loaded already anyway
		this.mDetailsPanel.CharacterImage.centerImageWithinParent(0, 0, 1.0); 
	   
		this.mDetailsPanel.CharacterName.html(data['Name']);
		this.mDetailsPanel.CharacterBackgroundImage.attr('src', Path.GFX + data['BackgroundImagePath']);
		this.mDetailsPanel.CharacterBackgroundTextScrollContainer.html(data['BackgroundText']);
		this.mDetailsPanel.InitialMoneyCostsText.html(Helper.numberWithCommas(data['InitialMoneyCost']));
		this.mDetailsPanel.DailyMoneyCostsText.html(Helper.numberWithCommas(data['DailyMoneyCost']));
		this.mDetailsPanel.TryoutMoneyCostsText.html(Helper.numberWithCommas(data['TryoutCost']));
		//this.mDetailsPanel.DailyFoodCostsText.html(Helper.numberWithCommas(data['DailyFoodCost']));

		this.mDetailsPanel.CharacterTraitsContainer.empty();

		if(data['IsTryoutDone'])
		{
			var icon = $('<img src="' + Path.GFX + 'ui/icons/known_perks.png' + '"/>');
			icon.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.WorldTownScreen.HireDialogModule.KnownPerks, entityId: data.ID });
			this.mDetailsPanel.CharacterTraitsContainer.append(icon);

			for(var i = 0; i < data.Traits.length; ++i)
			{
				var icon = $('<img src="' + Path.GFX + data.Traits[i].icon + '"/>');
				icon.bindTooltip({ contentType: 'status-effect', entityId: data.ID, statusEffectId: data.Traits[i].id });
				this.mDetailsPanel.CharacterTraitsContainer.append(icon);
			}

			for(var i = 0; i < data.Talents.length; ++i)
			{
				var stars = $('<img></img>');
				stars.attr('src', Path.GFX + 'ui/icons/talent_' + data.Talents[i].value.toString() + '.png');
				stars.css({ 'width': '3.6rem', 'height': '1.8rem', 'margin-bottom': '1.5rem'});
				var icon = "";
				var tooltipId = null
				switch (data.Talents[i].talent) 
				{
					case "HP":
						icon = Asset.ICON_HEALTH;
						tooltipId = TooltipIdentifier.CharacterStats.Hitpoints;
						break;
					case "FAT":
						icon = Asset.ICON_FATIGUE;
						tooltipId = TooltipIdentifier.CharacterStats.Fatigue;
						break;
					case "RES":
						icon = Asset.ICON_BRAVERY;
						tooltipId = TooltipIdentifier.CharacterStats.Bravery;
						break;
					case "INIT":
						icon = Asset.ICON_INITIATIVE;
						tooltipId = TooltipIdentifier.CharacterStats.Initiative;
						break;
					case "MA":
						icon = Asset.ICON_MELEE_SKILL;
						tooltipId = TooltipIdentifier.CharacterStats.MeleeSkill;
						break;
					case "MD":
						icon = Asset.ICON_MELEE_DEFENCE;
						tooltipId = TooltipIdentifier.CharacterStats.MeleeDefense;
						break;
					case "RA":
						icon = Asset.ICON_RANGE_SKILL;
						tooltipId = TooltipIdentifier.CharacterStats.RangeSkill;
						break;
					case "RD":
						icon = Asset.ICON_RANGE_DEFENCE;
						tooltipId = TooltipIdentifier.CharacterStats.RangeDefense;
						break;
				}
				var img = $('<img src="' + Path.GFX + icon + '"/>');
				img.bindTooltip({ contentType: 'ui-element', elementId: tooltipId });
			   // img.css({ 'width': '3.6rem', 'height': '1.8rem' });
			   // + data.Talents[i].talent + '
				var text = $('<span class="text-font-small font-color-assets-positive-value"></span>');
				text.append(img)
				text.append(stars)
				this.mDetailsPanel.CharacterTraitsContainer.append(text);
			}
		}
		else
		{
			var icon = $('<img src="' + Path.GFX + 'ui/icons/unknown_perks.png' + '"/>');
			icon.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.WorldTownScreen.HireDialogModule.UnknownPerks, entityId: data.ID });
			this.mDetailsPanel.CharacterTraitsContainer.append(icon);

			var icon = $('<img src="' + Path.GFX + Asset.ICON_UNKNOWN_TRAITS + '"/>');
			icon.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.WorldTownScreen.HireDialogModule.UnknownTraits });
			this.mDetailsPanel.CharacterTraitsContainer.append(icon);
		}

		// bin tooltips
		this.mDetailsPanel.CharacterBackgroundImage.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterBackgrounds.Generic, elementOwner: TooltipIdentifier.ElementOwner.HireScreen, entityId: data.ID });

		// special cases for not enough resources
		if(currentMoney < initialMoneyCost)
		{
			this.mDetailsPanel.InitialMoneyCostsText.removeClass('font-color-description').addClass('font-color-assets-negative-value');
			this.mDetailsPanel.HireButton.enableButton(false);
		}
		else
		{
			this.mDetailsPanel.HireButton.enableButton(true);
			this.mDetailsPanel.InitialMoneyCostsText.removeClass('font-color-assets-negative-value').addClass('font-color-description');
		}

		if(currentMoney < tryoutMoneyCost)
		{
			this.mDetailsPanel.TryoutMoneyCostsText.removeClass('font-color-description').addClass('font-color-assets-negative-value');
			this.mDetailsPanel.TryoutButton.enableButton(false);
		}
		else
		{
			this.mDetailsPanel.TryoutButton.enableButton(true);
			this.mDetailsPanel.TryoutMoneyCostsText.removeClass('font-color-assets-negative-value').addClass('font-color-description');
		}

		if(data['IsTryoutDone'])
		{
			this.mDetailsPanel.TryoutButton.removeClass('display-block').addClass('display-none');
			this.dismissButtonLayout.show();
			this.mDetailsPanel.DismissButton.removeClass('display-none').addClass('display-block');
			//this.mDetailsPanel.TryoutCostsContainer.removeClass('display-block').addClass('display-none');
			this.mDetailsPanel.TryoutCostsContainer.addClass('display-block').removeClass('display-none');
			this.mDetailsPanel.DismissButton.bindTooltip({ contentType: 'ui-element', elementId: "world-town-screen.hire-dialog-module.DismissButton" });
		}
		else
		{
			this.mDetailsPanel.TryoutButton.addClass('display-block').removeClass('display-none');
			this.mDetailsPanel.TryoutCostsContainer.addClass('display-block').removeClass('display-none');
			this.mDetailsPanel.DismissButton.unbindTooltip();
			this.dismissButtonLayout.hide();
			this.mDetailsPanel.DismissButton.removeClass('display-block').addClass('display-none');
		}

		this.mDetailsPanel.Container.removeClass('display-none').addClass('display-block');
	}
	else
	{
		this.mDetailsPanel.Container.removeClass('display-block').addClass('display-none');
	}
};

WorldTownScreenHireDialogModule.prototype.updateListEntryValues = function()
{
	var currentMoney = this.mAssets.getValues().Money;
	var container = this.mListContainer.findListScrollContainer();
	container.find('.list-entry').each(function(index, element)
	{
		var entry = $(element);
		var initialMoneyCostElement = entry.find('.is-initial-money-cost');
		var traitsContainer = entry.find('.is-traits-container');
		var data = entry.data('entry');
		var initialMoneyCost = data['InitialMoneyCost'];
		initialMoneyCostElement.html(Helper.numberWithCommas(data[WorldTownScreenIdentifier.HireRosterEntry.InitialMoneyCost]));
		if (currentMoney < initialMoneyCost)
		{
			initialMoneyCostElement.removeClass('font-color-subtitle').addClass('font-color-assets-negative-value');
		}
		else
		{
			initialMoneyCostElement.removeClass('font-color-assets-negative-value').addClass('font-color-subtitle');
		}

		traitsContainer.empty();
		if(data['IsTryoutDone'])
		{
			var icon = $('<img src="' + Path.GFX + 'ui/icons/known_perks.png' + '"/>');
			icon.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.WorldTownScreen.HireDialogModule.KnownPerks, entityId: data.ID});
			traitsContainer.append(icon);

			for(var i = 0; i < data.Traits.length; ++i)
			{
				var icon = $('<img src="' + Path.GFX + data.Traits[i].icon + '"/>');
				icon.bindTooltip({ contentType: 'status-effect', entityId: data.ID, statusEffectId: data.Traits[i].id });
				traitsContainer.append(icon);
			}
		}
		else
		{
			var icon = $('<img src="' + Path.GFX + 'ui/icons/unknown_perks.png' + '"/>');
			icon.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.WorldTownScreen.HireDialogModule.UnknownPerks, entityId: data.ID });
			traitsContainer.append(icon);

			var icon = $('<img src="' + Path.GFX + Asset.ICON_UNKNOWN_TRAITS + '"/>');
			icon.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.WorldTownScreen.HireDialogModule.UnknownTraits });
			traitsContainer.append(icon);
		}
	});
};

WorldTownScreenHireDialogModule.prototype.bindTooltips = function ()
{
	this.mAssets.bindTooltips();
	this.mLeaveButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.WorldTownScreen.HireDialogModule.LeaveButton });
	this.mDetailsPanel.HireButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.WorldTownScreen.HireDialogModule.HireButton });
	this.mDetailsPanel.TryoutButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.WorldTownScreen.HireDialogModule.TryoutButton });
	this.mDetailsPanel.DismissButton.bindTooltip({ contentType: 'ui-element', elementId: "world-town-screen.hire-dialog-module.DismissButton" });
};

WorldTownScreenHireDialogModule.prototype.unbindTooltips = function ()
{
	this.mAssets.unbindTooltips();
	this.mLeaveButton.unbindTooltip();
	this.mDetailsPanel.HireButton.unbindTooltip();
	this.mDetailsPanel.TryoutButton.unbindTooltip();
	this.mDetailsPanel.DismissButton.unbindTooltip();
	this.mDetailsPanel.CharacterBackgroundImage.unbindTooltip();
};


WorldTownScreenHireDialogModule.prototype.create = function(_parentDiv)
{
	this.createDIV(_parentDiv);
	this.bindTooltips();
};

WorldTownScreenHireDialogModule.prototype.destroy = function()
{
	this.unbindTooltips();
	this.destroyDIV();
};


WorldTownScreenHireDialogModule.prototype.register = function (_parentDiv)
{
	console.log('WorldTownScreenHireDialogModule::REGISTER');

	if (this.mContainer !== null)
	{
		console.error('ERROR: Failed to register World Town Screen Hire Dialog Module. Reason: World Town Screen Hire Dialog Module is already initialized.');
		return;
	}

	if (_parentDiv !== null && typeof(_parentDiv) == 'object')
	{
		this.create(_parentDiv);
	}
};

WorldTownScreenHireDialogModule.prototype.unregister = function ()
{
	console.log('WorldTownScreenHireDialogModule::UNREGISTER');

	if (this.mContainer === null)
	{
		console.error('ERROR: Failed to unregister World Town Screen Hire Dialog Module. Reason: World Town Screen Hire Dialog Module is not initialized.');
		return;
	}

	this.destroy();
};

WorldTownScreenHireDialogModule.prototype.isRegistered = function ()
{
	if (this.mContainer !== null)
	{
		return this.mContainer.parent().length !== 0;
	}

	return false;
};


WorldTownScreenHireDialogModule.prototype.registerEventListener = function(_listener)
{
	this.mEventListener = _listener;
};


WorldTownScreenHireDialogModule.prototype.show = function (_withSlideAnimation)
{
	var self = this;

	var withAnimation = (_withSlideAnimation !== undefined && _withSlideAnimation !== null) ? _withSlideAnimation : true;
	if (withAnimation === true)
	{
		var offset = -(this.mContainer.parent().width() + this.mContainer.width());
		this.mContainer.css({ 'left': offset });
		this.mContainer.velocity("finish", true).velocity({ opacity: 1, left: '0', right: '0' },
		{
			duration: Constants.SCREEN_SLIDE_IN_OUT_DELAY,
			easing: 'swing',
			begin: function ()
			{
				$(this).removeClass('display-none').addClass('display-block');
				self.notifyBackendModuleAnimating();
			},
			complete: function ()
			{
				self.mIsVisible = true;
				self.notifyBackendModuleShown();
			}
		});
	}
	else
	{
		this.mContainer.css({ opacity: 0 });
		this.mContainer.velocity("finish", true).velocity({ opacity: 1 },
		{
			duration: Constants.SCREEN_FADE_IN_OUT_DELAY,
			easing: 'swing',
			begin: function ()
			{
				$(this).removeClass('display-none').addClass('display-block');
				self.notifyBackendModuleAnimating();
			},
			complete: function ()
			{
				self.mIsVisible = true;
				self.notifyBackendModuleShown();
			}
		});
	}
};

WorldTownScreenHireDialogModule.prototype.hide = function ()
{
	var self = this;

	var offset = -(this.mContainer.parent().width() + this.mContainer.width());
	this.mContainer.velocity("finish", true).velocity({ opacity: 0, left: offset },
	{
		duration: Constants.SCREEN_SLIDE_IN_OUT_DELAY,
		easing: 'swing',
		begin: function ()
		{
			$(this).removeClass('is-center');
			self.notifyBackendModuleAnimating();
		},
		complete: function ()
		{
			self.mIsVisible = false;
			self.mListScrollContainer.empty();
			$(this).removeClass('display-block').addClass('display-none');
			self.notifyBackendModuleHidden();
		}
	});
};

WorldTownScreenHireDialogModule.prototype.isVisible = function ()
{
	return this.mIsVisible;
};


// WorldTownScreenHireDialogModule.prototype.onHireInformation = function (_dataSource, _data)
// {
//	 if (_data === undefined || _data === null || !(typeof(_data) === 'object')) {
//		 return;
//	 }
// 
//	 if (WorldTownScreenIdentifier.HireInformation.HeaderImagePath in _data && _data[WorldTownScreenIdentifier.HireInformation.HeaderImagePath] !== null)
//	 {
//		 this.mDialogContainer.findDialogHeaderImage().attr('src', Path.GFX + _data[WorldTownScreenIdentifier.HireInformation.HeaderImagePath]);
//	 }
// };

WorldTownScreenHireDialogModule.prototype.updateAssets = function (_data)
{
	this.mAssets.loadFromData(_data);
	this.updateListEntryValues();
}

WorldTownScreenHireDialogModule.prototype.loadFromData = function (_data)
{
	if (_data === undefined || _data === null || !jQuery.isArray(_data))
	{
		return;
	}

	this.mRoster = _data;

	this.mListScrollContainer.empty();

	for(var i = 0; i < _data.length; ++i)
	{
		var entry = _data[i];
		this.addListEntry(entry);
	}

	this.selectListEntry(this.mListContainer.findListEntryByIndex(0), true);
};

WorldTownScreenHireDialogModule.prototype.removeRosterEntry  = function (_data)
{
	if(_data === null || typeof(_data) !== 'object' || !('item' in _data) || !('index' in _data))
	{
		return;
	}

	var entry = this.mListContainer.findListEntryByIndex(_data.index);
	if(entry !== null)
	{
		var data = entry.data('entry');
		if('ID' in data && data['ID'] !== null && _data.item['ID'] === data['ID'])
		{
			entry = entry.parent(); // get the 'l-row' container
			var prevEntry = entry.prev();
			entry.remove();
			
			if(prevEntry.length > 0)
			{
				this.selectListEntry(prevEntry.find('.list-entry:first'), false/*true*/);
			}
			else
			{
				this.selectListEntry(this.mListContainer.findListEntryByIndex(0), true);
			}

			this.mRoster.splice(_data.index, 1);
		}
		else
		{
			console.error('ERROR: Failed to update hire roster. Invalid entry data.');
		}
	}
};

WorldTownScreenHireDialogModule.prototype.dismissRosterEntry = function (_entryID)
{
	var self = this;
	this.notifyBackendDismissRosterEntry(_entryID, function (data)
	{
		// error?
		if (data.Result != 0)
		{
			if (data.Result == ErrorCode.NotEnoughMoney)
			{
				self.mAssets.mMoneyAsset.shakeLeftRight();
			}
			else if (data.Result == ErrorCode.NotEnoughRosterSpace)
			{
				self.mAssets.mBrothersAsset.shakeLeftRight();
			}
			else
			{
				console.error("Failed to hire. Reason: Unknown");
			}

			return;
		}

		// remove entity from list
		for (var i = 0; i < self.mRoster.length; ++i)
		{
			if (self.mRoster[i]['ID'] == _entryID)
			{
				self.removeRosterEntry({ item: self.mRoster[i], index: i });
				break;
			}
		}

		// update assets
		self.mParent.loadAssetData(data.Assets);
		self.updateListEntryValues();

		self.updateDetailsPanel(self.mSelectedEntry);
	});
};


WorldTownScreenHireDialogModule.prototype.hireRosterEntry = function (_entryID)
{
	var self = this;
	this.notifyBackendHireRosterEntry(_entryID, function (data)
	{
		// error?
		if (data.Result != 0)
		{
			if (data.Result == ErrorCode.NotEnoughMoney)
			{
				self.mAssets.mMoneyAsset.shakeLeftRight();
			}
			else if (data.Result == ErrorCode.NotEnoughRosterSpace)
			{
				self.mAssets.mBrothersAsset.shakeLeftRight();
			}
			else
			{
				console.error("Failed to hire. Reason: Unknown");
			}

			return;
		}

		// remove entity from list
		for (var i = 0; i < self.mRoster.length; ++i)
		{
			if (self.mRoster[i]['ID'] == _entryID)
			{
				self.removeRosterEntry({ item: self.mRoster[i], index: i });
				break;
			}
		}

		// update assets
		self.mParent.loadAssetData(data.Assets);
		self.updateListEntryValues();

		self.updateDetailsPanel(self.mSelectedEntry);
	});
};

WorldTownScreenHireDialogModule.prototype.tryoutRosterEntry = function (_entryID)
{
	var self = this;
	this.notifyBackendTryoutRosterEntry(_entryID, function (data)
	{
		// error?
		if (data.Result != 0)
		{
			if (data.Result == ErrorCode.NotEnoughMoney)
			{
				self.mAssets.mMoneyAsset.shakeLeftRight();
			}
			else
			{
				console.error("Failed to hire. Reason: Unknown");
			}

			return;
		}

		// update assets
		self.mRoster = data.Roster;

		var container = self.mListContainer.findListScrollContainer();
		container.find('.list-entry').each(function (index, element)
		{
			var entry = $(element);
			entry.data('entry', self.mRoster[index]);
		});

		self.mParent.loadAssetData(data.Assets);
		self.updateListEntryValues();

		self.updateDetailsPanel(self.mSelectedEntry);
	});
};

// WorldTownScreenHireDialogModule.prototype.dismissRosterEntry = function (_entryID)
// {
//	 var self = this;
//	 this.notifyBackendDismissRosterEntry(_entryID, function (data)
//	 {
//		 // error?
//		 if (data.Result != 0)
//		 {
//			 return;
//		 }

//		 // update assets
//		 self.mRoster = data.Roster;

//		 var container = self.mListContainer.findListScrollContainer();
//		 container.find('.list-entry').each(function (index, element)
//		 {
//			 var entry = $(element);
//			 entry.data('entry', self.mRoster[index]);
//		 });

//		 self.mParent.loadAssetData(data.Assets);
//		 self.updateListEntryValues();

//		 self.updateDetailsPanel(self.mSelectedEntry);
//	 });
// };

WorldTownScreenHireDialogModule.prototype.notifyBackendModuleShown = function ()
{
	SQ.call(this.mSQHandle, 'onModuleShown');
};

WorldTownScreenHireDialogModule.prototype.notifyBackendModuleHidden = function ()
{
	SQ.call(this.mSQHandle, 'onModuleHidden');
};

WorldTownScreenHireDialogModule.prototype.notifyBackendModuleAnimating = function ()
{
	SQ.call(this.mSQHandle, 'onModuleAnimating');
};

WorldTownScreenHireDialogModule.prototype.notifyBackendLeaveButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onLeaveButtonPressed');
};

WorldTownScreenHireDialogModule.prototype.notifyBackendBrothersButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onBrothersButtonPressed');
};

WorldTownScreenHireDialogModule.prototype.notifyBackendHireRosterEntry = function (_entryID, _callback)
{
	SQ.call(this.mSQHandle, 'onHireRosterEntry', _entryID, _callback);
};

WorldTownScreenHireDialogModule.prototype.notifyBackendDismissRosterEntry = function (_entryID, _callback)
{
	SQ.call(this.mSQHandle, 'onDismissRosterEntry', _entryID, _callback);
};

WorldTownScreenHireDialogModule.prototype.notifyBackendTryoutRosterEntry = function (_entryID, _callback)
{
	SQ.call(this.mSQHandle, 'onTryoutRosterEntry', _entryID, _callback);
};