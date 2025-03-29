
"use strict";

var WorldCampfireScreenHireDialogModule = function(_parent)
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
		CharacterBackgroundTextContainer: null,
		CharacterBackgroundTextScrollContainer: null,
		EffectsContainer: null,
		RequirementsContainer: null,
		InitialMoneyCostsText: null,
		HireButton: null
	};

	// assets labels
	this.mAssets = new WorldCampfireScreenAssets(_parent);

	// buttons
	this.mLeaveButton = null;

	// generics
	this.mIsVisible = false;

	// selected entry
	this.mSelectedEntry = null;
};


WorldCampfireScreenHireDialogModule.prototype.isConnected = function ()
{
	return this.mSQHandle !== null;
};

WorldCampfireScreenHireDialogModule.prototype.onConnection = function (_handle)
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

WorldCampfireScreenHireDialogModule.prototype.onDisconnection = function ()
{
	this.mSQHandle = null;

	// notify listener
	if (this.mEventListener !== null && ('onModuleOnDisconnectionCalled' in this.mEventListener)) {
		this.mEventListener.onModuleOnDisconnectionCalled(this);
	}
};

WorldCampfireScreenHireDialogModule.prototype.createDIV = function (_parentDiv)
{
	var self = this;

	// create: containers (init hidden!)
	this.mContainer = $('<div class="l-hire-dialog-container display-none opacity-none"/>');
	_parentDiv.append(this.mContainer);
	this.mDialogContainer = this.mContainer.createDialog('Hire Follower', null, '', true, 'dialog-1024-768');

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

	this.mDetailsPanel.CharacterName = $('<div class="name title-font-normal font-bold font-color-brother-name"/>');
	backgroundRow.append(this.mDetailsPanel.CharacterName);

	backgroundRow = $('<div class="row is-bottom"/>');
	detailsColumn.append(backgroundRow);
	this.mDetailsPanel.CharacterBackgroundTextContainer = backgroundRow.createList(20, 'description-font-medium font-bottom-shadow font-color-description', true);
	this.mDetailsPanel.CharacterBackgroundTextScrollContainer = this.mDetailsPanel.CharacterBackgroundTextContainer.findListScrollContainer();

	// details: effects
	detailsRow = $('<div class="row is-ingredients-container"/>');
	this.mDetailsPanel.Container.append(detailsRow);
	/*var effectsHeader = $('<div class="row is-header"/>');
	detailsRow.append(effectsHeader);
	var effectsHeaderLabel = $('<div class="label title-font-normal font-bold font-bottom-shadow font-color-title">Effects</div>');
	effectsHeader.append(effectsHeaderLabel);*/

	var row  = $('<div class="row is-components-container"/>');
	detailsRow.append(row);
	this.mDetailsPanel.EffectsContainer = row.createList(10, null).findListScrollContainer();

	// details: requirements
	detailsRow = $('<div class="row is-requirements-container"/>');
	this.mDetailsPanel.Container.append(detailsRow);
	var requirementsHeader = $('<div class="row is-header"/>');
	detailsRow.append(requirementsHeader);
	var requirementsHeaderLabel = $('<div class="label title-font-normal font-bold font-bottom-shadow font-color-title">Requirements</div>');
	requirementsHeader.append(requirementsHeaderLabel);

	var row = $('<div class="row is-requirements-components-container"/>');
	detailsRow.append(row);
	this.mDetailsPanel.RequirementsContainer = row.createList(10, null).findListScrollContainer();

	// details: costs
	detailsRow = $('<div class="row is-costs-container"/>');
	this.mDetailsPanel.Container.append(detailsRow);
	var costsHeader = $('<div class="row is-header"/>');
	detailsRow.append(costsHeader);
	var costsHeaderLabel = $('<div class="label title-font-normal font-bold font-bottom-shadow font-color-title">Costs</div>');
	costsHeader.append(costsHeaderLabel);
	//var costsInitial = $('<div class="row is-initial-costs"/>');
	//detailsRow.append(costsInitial);
	//var costsLabel = $('<div class="costs-label title-font-normal font-bold font-bottom-shadow font-color-title">Up Front</div>');
	//costsInitial.append(costsLabel);
	var costsContainer = $('<div class="l-costs-container"/>');
	//costsInitial.append(costsContainer);
	costsHeader.append(costsContainer);
	
	var costsImage = $('<img/>');
	costsImage.attr('src', Path.GFX + Asset.ICON_ASSET_MONEY);
	costsContainer.append(costsImage);
	costsImage.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.Assets.InitialMoney });
	this.mDetailsPanel.InitialMoneyCostsText = $('<div class="label text-font-normal font-bottom-shadow font-color-description"/>');
	costsContainer.append(this.mDetailsPanel.InitialMoneyCostsText);

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

WorldCampfireScreenHireDialogModule.prototype.destroyDIV = function ()
{
	this.mAssets.destroyDIV();

	this.mSelectedEntry = null;

	this.mDetailsPanel.HireButton.remove();
	this.mDetailsPanel.HireButton = null;

	this.mDetailsPanel.InitialMoneyCostsText.empty();
	this.mDetailsPanel.InitialMoneyCostsText.remove();
	this.mDetailsPanel.InitialMoneyCostsText = null;

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
};

WorldCampfireScreenHireDialogModule.prototype.addListEntry = function (_data)
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

	if (!_data.IsUnlocked)
		entry.addClass('is-disabled');

	// left column
	var column = $('<div class="column is-left"/>');
	entry.append(column);

	var imageOffsetX = ('ImageOffsetX' in _data ? _data['ImageOffsetX'] : 0);
	var imageOffsetY = ('ImageOffsetY' in _data ? _data['ImageOffsetY'] : 0);
	column.createImage(Path.GFX + _data['ImagePath'], function (_image)
	{
		_image.centerImageWithinParent(imageOffsetX, imageOffsetY, 0.33, false);
		_image.removeClass('opacity-none');
	}, null, 'opacity-none');

	if(!_data.IsUnlocked)
		column.createImage(Path.GFX + Asset.ICON_LOCKED, null, null, 'is-locked-icon');

	// right column
	column = $('<div class="column is-right"/>');
	entry.append(column);

	// top row
	var row = $('<div class="row is-top"/>');
	column.append(row);

	if(_data.IsUnlocked)
	{
		var name = $('<div class="name title-font-normal font-bold font-color-brother-name">' + _data.Name + '</div>');
		row.append(name);
	}
	else
	{
		var name = $('<div class="name title-font-normal font-bold font-color-disabled">' + _data.Name + '</div>');
		row.append(name);
	}

	// bottom row
	row = $('<div class="row is-bottom"/>');
	column.append(row);

	var assetsCenterContainer = $('<div class="l-assets-center-container"/>');
	row.append(assetsCenterContainer);

	// initial money
	var assetsContainer = $('<div class="l-assets-container"/>');
	assetsCenterContainer.append(assetsContainer);
	var image = $('<img/>');
	image.attr('src', Path.GFX + Asset.ICON_ASSET_MONEY);
	assetsContainer.append(image);
	image.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.Assets.InitialMoney });
	var text = $('<div class="label is-initial-money-cost text-font-normal font-color-subtitle">' + Helper.numberWithCommas(_data.Cost) + '</div>');
	assetsContainer.append(text);
};

WorldCampfireScreenHireDialogModule.prototype.selectListEntry = function(_element, _scrollToEntry)
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

WorldCampfireScreenHireDialogModule.prototype.updateDetailsPanel = function(_element)
{
	if (_element !== null && _element.length > 0)
	{
		var currentMoney = this.mAssets.getValues().Money;
		var data = _element.data('entry');
		var initialMoneyCost = data.Cost;

		this.mDetailsPanel.CharacterImage.attr('src', Path.GFX + data.ImagePath);	 
	   
		// retarded JS calls load callback after a significant delay only - so we call this here manually to position/resize an image that is completely loaded already anyway
		this.mDetailsPanel.CharacterImage.centerImageWithinParent(0, 0, 1.0); 
	   
		this.mDetailsPanel.CharacterName.html(data.Name);
		this.mDetailsPanel.CharacterBackgroundTextScrollContainer.html(data.Description);
		this.mDetailsPanel.InitialMoneyCostsText.html(Helper.numberWithCommas(data.Cost));

		// effects
		this.mDetailsPanel.EffectsContainer.empty();
		var table = "<table>";

		for(var i = 0; i < data.Effects.length; ++i)
		{
			table += "<tr>";
			table += "<td valign='top'><img src='" + Path.GFX + "ui/icons/special.png" + "'/></td>";
			table += "<td><div class='text-font-medium font-color-label'>" + data.Effects[i] + "</div></td>";
			table += "</tr>";
		}

		table += "</table>";
		this.mDetailsPanel.EffectsContainer.append($(table));

		// requirements
		this.mDetailsPanel.RequirementsContainer.empty();
		var table = "<table>";
		var hasAddedSecondaryText = false;

		for(var i = 0; i < data.Requirements.length; ++i)
		{
			if (!hasAddedSecondaryText && data.Requirements[i].NotImportant)
			{
				hasAddedSecondaryText = true;
				table += "<tr><div class='text-font-medium font-color-white'>Fulfill one of the below requirements:</div></tr>";
			}

			table += "<tr>";

			if(data.Requirements[i].IsSatisfied)
			{
				table += "<td><img src='" + Path.GFX + "ui/icons/unlocked_small.png" + "'/></td>";
				table += "<td><div class='text-font-medium font-color-label'>" + data.Requirements[i].Text + "</div></td>";
			}
			else
			{
				table += "<td><img src='" + Path.GFX + "ui/icons/locked_small.png" + "'/></td>";
				table += "<td><div class='text-font-medium font-color-disabled'>" + data.Requirements[i].Text + "</div></td>";
			}
						
			table += "</tr>";
		}

		table += "</table>";
		this.mDetailsPanel.RequirementsContainer.append($(table));

		// special cases for not enough resources
		if(currentMoney < initialMoneyCost)
		{
			this.mDetailsPanel.InitialMoneyCostsText.removeClass('font-color-description').addClass('font-color-assets-negative-value');
			this.mDetailsPanel.HireButton.enableButton(false);
		}
		else
		{
			this.mDetailsPanel.HireButton.enableButton(data.IsUnlocked);
			this.mDetailsPanel.InitialMoneyCostsText.removeClass('font-color-assets-negative-value').addClass('font-color-description');
		}		

		this.mDetailsPanel.Container.removeClass('display-none').addClass('display-block');
	}
	else
	{
		this.mDetailsPanel.Container.removeClass('display-block').addClass('display-none');
	}
};

WorldCampfireScreenHireDialogModule.prototype.updateListEntryValues = function()
{
	var currentMoney = this.mAssets.getValues().Money;
	var container = this.mListContainer.findListScrollContainer();
	container.find('.list-entry').each(function(index, element)
	{
		var entry = $(element);
		var initialMoneyCostElement = entry.find('.is-initial-money-cost');
		var traitsContainer = entry.find('.is-traits-container');
		var data = entry.data('entry');
		var initialMoneyCost = data.Cost;
		initialMoneyCostElement.html(Helper.numberWithCommas(data.Cost));
		if (currentMoney < initialMoneyCost)
		{
			initialMoneyCostElement.removeClass('font-color-subtitle').addClass('font-color-assets-negative-value');
		}
		else
		{
			initialMoneyCostElement.removeClass('font-color-assets-negative-value').addClass('font-color-subtitle');
		}
	});
};

WorldCampfireScreenHireDialogModule.prototype.bindTooltips = function ()
{
	this.mAssets.bindTooltips();
	this.mLeaveButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.WorldTownScreen.HireDialogModule.LeaveButton });
	this.mDetailsPanel.HireButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.WorldTownScreen.HireDialogModule.HireButton });
};

WorldCampfireScreenHireDialogModule.prototype.unbindTooltips = function ()
{
	this.mAssets.unbindTooltips();
	this.mLeaveButton.unbindTooltip();
	this.mDetailsPanel.HireButton.unbindTooltip();
};


WorldCampfireScreenHireDialogModule.prototype.create = function(_parentDiv)
{
	this.createDIV(_parentDiv);
	this.bindTooltips();
};

WorldCampfireScreenHireDialogModule.prototype.destroy = function()
{
	this.unbindTooltips();
	this.destroyDIV();
};


WorldCampfireScreenHireDialogModule.prototype.register = function (_parentDiv)
{
	console.log('WorldCampfireScreenHireDialogModule::REGISTER');

	if (this.mContainer !== null)
	{
		console.error('ERROR: Failed to register World Campfire Screen Hire Dialog Module. Reason: World Campfire Screen Hire Dialog Module is already initialized.');
		return;
	}

	if (_parentDiv !== null && typeof(_parentDiv) == 'object')
	{
		this.create(_parentDiv);
	}
};

WorldCampfireScreenHireDialogModule.prototype.unregister = function ()
{
	console.log('WorldCampfireScreenHireDialogModule::UNREGISTER');

	if (this.mContainer === null)
	{
		console.error('ERROR: Failed to unregister World Town Screen Hire Dialog Module. Reason: World Town Screen Hire Dialog Module is not initialized.');
		return;
	}

	this.destroy();
};

WorldCampfireScreenHireDialogModule.prototype.isRegistered = function ()
{
	if (this.mContainer !== null)
	{
		return this.mContainer.parent().length !== 0;
	}

	return false;
};


WorldCampfireScreenHireDialogModule.prototype.registerEventListener = function(_listener)
{
	this.mEventListener = _listener;
};


WorldCampfireScreenHireDialogModule.prototype.show = function (_withSlideAnimation)
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

WorldCampfireScreenHireDialogModule.prototype.hide = function ()
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

WorldCampfireScreenHireDialogModule.prototype.isVisible = function ()
{
	return this.mIsVisible;
};


WorldCampfireScreenHireDialogModule.prototype.updateAssets = function (_data)
{
	this.mAssets.loadFromData(_data);
	this.updateListEntryValues();
}

WorldCampfireScreenHireDialogModule.prototype.loadFromData = function (_data)
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

WorldCampfireScreenHireDialogModule.prototype.removeRosterEntry  = function (_data)
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

WorldCampfireScreenHireDialogModule.prototype.hireRosterEntry = function (_entryID)
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
			else
			{
				console.error("Failed to hire. Reason: Unknown");
			}

			return;
		}
		else
		{
			self.notifyBackendLeaveButtonPressed();
		}
	});
};

WorldCampfireScreenHireDialogModule.prototype.notifyBackendModuleShown = function ()
{
	SQ.call(this.mSQHandle, 'onModuleShown');
};

WorldCampfireScreenHireDialogModule.prototype.notifyBackendModuleHidden = function ()
{
	SQ.call(this.mSQHandle, 'onModuleHidden');
};

WorldCampfireScreenHireDialogModule.prototype.notifyBackendModuleAnimating = function ()
{
	SQ.call(this.mSQHandle, 'onModuleAnimating');
};

WorldCampfireScreenHireDialogModule.prototype.notifyBackendLeaveButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onLeaveButtonPressed');
};

WorldCampfireScreenHireDialogModule.prototype.notifyBackendHireRosterEntry = function (_entryID, _callback)
{
	SQ.call(this.mSQHandle, 'onHireFollower', _entryID, _callback);
};