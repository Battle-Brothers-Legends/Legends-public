/*
 *  @Project:		Battle Brothers
 *	@Company:		Overhype Studios
 *
 *	@Copyright:		(c) Overhype Studios | 2013 - 2020
 * 
 *  @Author:		Overhype Studios
 *  @Date:			24.05.2017 / Reworked: 26.11.2017
 *  @Description:	Left Panel Header Module JS
 */
"use strict";

/* TODO:
	+ Progressbar gegen Komponente austauschen
	+ Image auch mit Offsets positionieren?
 */

var CharacterScreenLeftPanelHeaderModule = function(_parent, _dataSource)
{
	this.mParent = _parent;
	this.mDataSource = _dataSource;

	// containers
	this.mContainer = null;
	
	this.mPortraitContainer = null;
	this.mPortraitImage = null;
	this.mPortraitPlaceholder = null;

	this.mNameContainer = null;
	this.mLevelContainer = null;
	this.mXPProgressbar = null;

	this.mDismissButton	= null;
	this.mReserveButton	= null;	
	this.mPayDismissalWage = false;

	// current popup dialog
	this.mCurrentPopupDialog = null;

	// LevelUp Dialog Defines
	this.mLevelUpLeftStatsRows =
	{
		Hitpoints:
		{
			IconPath: Path.GFX + Asset.ICON_HEALTH,
			StyleName: ProgressbarStyleIdentifier.Hitpoints,
			TooltipId: TooltipIdentifier.CharacterStats.Hitpoints,
			ProgressbarValueIdentifier: ProgressbarValueIdentifier.Hitpoints,
			ProgressbarValueIdentifierMax: ProgressbarValueIdentifier.HitpointsMax,
			StatValueIdentifier: CharacterScreenIdentifier.Entity.Character.LevelUp.HitpointsIncrease,
			TalentIdentifier: 'hitpointsTalent',
			Progressbar: null,
			Talent: null,
			Button: null
		},

		Fatigue:
		{
			IconPath: Path.GFX + Asset.ICON_FATIGUE,
			StyleName: ProgressbarStyleIdentifier.Fatigue,
			TooltipId: TooltipIdentifier.CharacterStats.MaximumFatigue,
			ProgressbarValueIdentifier: ProgressbarValueIdentifier.Fatigue,
			ProgressbarValueIdentifierMax: ProgressbarValueIdentifier.FatigueMax,
			StatValueIdentifier: CharacterScreenIdentifier.Entity.Character.LevelUp.FatigueIncrease,
			TalentIdentifier: 'fatigueTalent',
			Progressbar: null,
			Talent: null,
			Button: null
		},

		Bravery:
		{
			IconPath: Path.GFX + Asset.ICON_BRAVERY,
			StyleName: ProgressbarStyleIdentifier.Bravery,
			TooltipId: TooltipIdentifier.CharacterStats.Bravery,
			ProgressbarValueIdentifier: ProgressbarValueIdentifier.Bravery,
			ProgressbarValueIdentifierMax: ProgressbarValueIdentifier.BraveryMax,
			StatValueIdentifier: CharacterScreenIdentifier.Entity.Character.LevelUp.BraveryIncrease,
			TalentIdentifier: 'braveryTalent',
			Progressbar: null,
			Talent: null,
			Button: null
		},

		Initiative:
		{
			IconPath: Path.GFX + Asset.ICON_INITIATIVE,
			StyleName: ProgressbarStyleIdentifier.Initiative,
			TooltipId: TooltipIdentifier.CharacterStats.Initiative,
			ProgressbarValueIdentifier: ProgressbarValueIdentifier.Initiative,
			ProgressbarValueIdentifierMax: ProgressbarValueIdentifier.InitiativeMax,
			StatValueIdentifier: CharacterScreenIdentifier.Entity.Character.LevelUp.InitiativeIncrease,
			TalentIdentifier: 'initiativeTalent',
			Progressbar: null,
			Talent: null,
			Button: null
		}
	};

	this.mLevelUpRightStatsRows =
	{
		MeleeSkill:
		{
			IconPath: Path.GFX + Asset.ICON_MELEE_SKILL,
			StyleName: ProgressbarStyleIdentifier.MeleeSkill,
			TooltipId: TooltipIdentifier.CharacterStats.MeleeSkill,
			ProgressbarValueIdentifier: ProgressbarValueIdentifier.MeleeSkill,
			ProgressbarValueIdentifierMax: ProgressbarValueIdentifier.MeleeSkillMax,
			StatValueIdentifier: CharacterScreenIdentifier.Entity.Character.LevelUp.MeleeSkillIncrease,
			TalentIdentifier: 'meleeSkillTalent',
			Progressbar: null,
			Talent: null,
			Button: null
		},

		RangeSkill:
		{
			IconPath: Path.GFX + Asset.ICON_RANGE_SKILL,
			StyleName: ProgressbarStyleIdentifier.RangeSkill,
			TooltipId: TooltipIdentifier.CharacterStats.RangeSkill,
			ProgressbarValueIdentifier: ProgressbarValueIdentifier.RangeSkill,
			ProgressbarValueIdentifierMax: ProgressbarValueIdentifier.RangeSkillMax,
			StatValueIdentifier: CharacterScreenIdentifier.Entity.Character.LevelUp.RangeSkillIncrease,
			TalentIdentifier: 'rangeSkillTalent',
			Progressbar: null,
			Talent: null,
			Button: null
		},

		MeleeDefense:
		{
			IconPath: Path.GFX + Asset.ICON_MELEE_DEFENCE,
			StyleName: ProgressbarStyleIdentifier.MeleeDefense,
			TooltipId: TooltipIdentifier.CharacterStats.MeleeDefense,
			ProgressbarValueIdentifier: ProgressbarValueIdentifier.MeleeDefense,
			ProgressbarValueIdentifierMax: ProgressbarValueIdentifier.MeleeDefenseMax,
			StatValueIdentifier: CharacterScreenIdentifier.Entity.Character.LevelUp.MeleeDefenseIncrease,
			TalentIdentifier: 'meleeDefenseTalent',
			Progressbar: null,
			Talent: null,
			Button: null
		},

		RangeDefense:
		{
			IconPath: Path.GFX + Asset.ICON_RANGE_DEFENCE,
			StyleName: ProgressbarStyleIdentifier.RangeDefense,
			TooltipId: TooltipIdentifier.CharacterStats.RangeDefense,
			ProgressbarValueIdentifier: ProgressbarValueIdentifier.RangeDefense,
			ProgressbarValueIdentifierMax: ProgressbarValueIdentifier.RangeDefenseMax,
			StatValueIdentifier: CharacterScreenIdentifier.Entity.Character.LevelUp.RangeDefenseIncrease,
			TalentIdentifier: 'rangeDefenseTalent',
			Progressbar: null,
			Talent: null,
			Button: null
		}
	};

	// LevelUp Increase Values
	this.mLevelUpIncreaseValues = null;

	this.registerDatasourceListener();
};


CharacterScreenLeftPanelHeaderModule.prototype.createDIV = function (_parentDiv)
{
	var self = this;

	// create: header container
	this.mContainer = $('<div class="left-panel-header-module"/>');
	_parentDiv.append(this.mContainer);

	// create: portrait
	var portraitContainer = $('<div class="portrait-container"/>');
	this.mContainer.append(portraitContainer);
	this.mPortraitContainer = $('<div class="l-portrait-image-container"/>');
	portraitContainer.append(this.mPortraitContainer);

	this.mPortraitPlaceholder = this.mPortraitContainer.createImage('', function (_image)
	{
		self.mPortraitPlaceholder.centerImageWithinParent(0, 0, 1.0, false);
	}, null, 'opacity-almost-none');

	this.mPortraitImage = this.mPortraitContainer.createImage('', function (_image)
	{
		self.mPortraitImage.centerImageWithinParent(0, 0, 1.0, false);
		self.mPortraitImage.removeClass('opacity-almost-none');
		self.mPortraitPlaceholder.addClass('opacity-almost-none');
		self.mPortraitPlaceholder.attr('src', self.mPortraitImage.attr('src'));
	}, null, '');

	var layout = $('<div class="l-button is-dismiss"/>');
	portraitContainer.append(layout);
	this.mDismissButton = layout.createImageButton(Path.GFX + Asset.BUTTON_DISMISS_CHARACTER, function (_event)
	{
		self.mPayDismissalWage = false;
		self.mDataSource.notifyBackendPopupDialogIsVisible(true);
		self.mCurrentPopupDialog = $('.character-screen').createPopupDialog('Dismiss', null, null, 'dismiss-popup');

		self.mCurrentPopupDialog.addPopupDialogOkButton(function (_dialog)
		{
			self.mDataSource.notifyBackendDismissCharacter(self.mPayDismissalWage);
			self.mCurrentPopupDialog = null;
			_dialog.destroyPopupDialog();
			self.mDataSource.notifyBackendPopupDialogIsVisible(false);
		});
		
		self.mCurrentPopupDialog.addPopupDialogCancelButton(function (_dialog)
		{
			self.mCurrentPopupDialog = null;
			_dialog.destroyPopupDialog();
			self.mDataSource.notifyBackendPopupDialogIsVisible(false);
		});

		self.mCurrentPopupDialog.addPopupDialogContent(self.createDismissDialogContent(self.mCurrentPopupDialog));
	}, 'display-none', 6);

	var layout = $('<div class="l-button is-reserve"/>');
	portraitContainer.append(layout);
	this.mReserveButton = layout.createImageButton(Path.GFX + "ui/icons/stat_screen_dmg_dealt.png", function (_event)
	{
		self.mDataSource.notifyBackendToggleReservesCharacter();
	}, 'display-none', 6);

	

	this.mNameContainer = $('<div class="name-container"/>');
	this.mContainer.append(this.mNameContainer);
	//var editNameimage = $('<img class="display-none"/>');
	///editNameimage.attr('src', Path.GFX + Asset.ICON_EDIT_NAME_AND_TITLE);
	//this.mNameContainer.append(editNameimage);

	var nameLabel = $('<div class="label title-font-big font-bold font-color-brother-name"/>');
	this.mNameContainer.append(nameLabel);
	this.mNameContainer.click(function ()
	{
		if ($(this).hasClass('is-clickable') === false)
		{
			return false;
		}

		self.mDataSource.notifyBackendPopupDialogIsVisible(true);
		self.mCurrentPopupDialog = $('.character-screen').createPopupDialog('Change Name & Title', null, null, 'change-name-and-title-popup');

		self.mCurrentPopupDialog.addPopupDialogOkButton(function (_dialog)
		{
			self.updateNameAndTitle(_dialog);
			self.mCurrentPopupDialog = null;
			_dialog.destroyPopupDialog();
			self.mDataSource.notifyBackendPopupDialogIsVisible(false);
		});
		
		self.mCurrentPopupDialog.addPopupDialogCancelButton(function (_dialog)
		{
			self.mCurrentPopupDialog = null;
			_dialog.destroyPopupDialog();
			self.mDataSource.notifyBackendPopupDialogIsVisible(false);
		});

		self.mCurrentPopupDialog.addPopupDialogContent(self.createChangeNameAndTitleDialogContent(self.mCurrentPopupDialog));

		// focus!
		var inputFields = self.mCurrentPopupDialog.findPopupDialogContentContainer().find('input');
		$(inputFields[0]).focus();
	});

	this.mLevelContainer = $('<div class="level-container"/>');
	this.mContainer.append(this.mLevelContainer);
		
	this.mLevelContainer.click(function ()
	{
		if ($(this).hasClass('is-clickable') === false)
		{
			return false;
		}

		self.mDataSource.notifyBackendPopupDialogIsVisible(true);
		self.mCurrentPopupDialog = $('.character-screen').createPopupDialog('Level Up', null, null, 'levelup-popup');
		self.mCurrentPopupDialog.addPopupDialogSubHeader(self.createLevelUpDialogSubHeader());
		self.mCurrentPopupDialog.addPopupDialogOkButton(function (_dialog)
		{
			self.commitLevelUpStats();
			self.mCurrentPopupDialog = null;
			_dialog.destroyPopupDialog();
			self.mDataSource.notifyBackendPopupDialogIsVisible(false);
		}, true);
		self.mCurrentPopupDialog.addPopupDialogCancelButton(function (_dialog)
		{
			self.mCurrentPopupDialog = null;
			_dialog.destroyPopupDialog();
			self.mDataSource.notifyBackendPopupDialogIsVisible(false);
		});
		self.mCurrentPopupDialog.addPopupDialogContent(self.createLevelUpDialogContent());
	});

	var levelupLabel = $('<div class="label text-font-normal font-bold font-bottom-shadow font-color-value"/>');
	this.mLevelContainer.append(levelupLabel);

	var levelupImage = $('<img class="display-none"/>');
	levelupImage.attr('src', Path.GFX + Asset.ICON_LEVELED_UP);
	this.mLevelContainer.append(levelupImage);

	var xpContainer = $('<div class="xp-container"/>');
	this.mContainer.append(xpContainer);
	var xpCenterContainer = $('<div class="l-xp-center-container"/>');
	xpContainer.append(xpCenterContainer);
	this.mXPProgressbar = xpCenterContainer.createProgressbar(true, 'xp has-frame-xp');

	this.mXPProgressbar.click(function ()
	{
		if ($(this).hasClass('is-clickable') === false)
		{
			return false;
		}

		self.mDataSource.notifyBackendPopupDialogIsVisible(true);
		self.mCurrentPopupDialog = $('.character-screen').createPopupDialog('Level Up', null, null, 'levelup-popup');
		self.mCurrentPopupDialog.addPopupDialogSubHeader(self.createLevelUpDialogSubHeader());
		self.mCurrentPopupDialog.addPopupDialogOkButton(function (_dialog)
		{
			self.commitLevelUpStats();
			self.mCurrentPopupDialog = null;
			_dialog.destroyPopupDialog();
			self.mDataSource.notifyBackendPopupDialogIsVisible(false);
		}, true);
		self.mCurrentPopupDialog.addPopupDialogCancelButton(function (_dialog)
		{
			self.mCurrentPopupDialog = null;
			_dialog.destroyPopupDialog();
			self.mDataSource.notifyBackendPopupDialogIsVisible(false);
		});
		self.mCurrentPopupDialog.addPopupDialogContent(self.createLevelUpDialogContent());
	});
};

CharacterScreenLeftPanelHeaderModule.prototype.destroyDIV = function ()
{
	if(this.mCurrentPopupDialog !== null)
	{
		this.mCurrentPopupDialog.destroyPopupDialog();
		this.mCurrentPopupDialog = null;
	}

	this.mPortraitContainer.empty();
	this.mPortraitContainer.remove();
	this.mPortraitContainer = null;

	this.mNameContainer.empty();
	this.mNameContainer.remove();
	this.mNameContainer = null;

	this.mLevelContainer.empty();
	this.mLevelContainer.remove();
	this.mLevelContainer = null;

	this.mXPProgressbar.empty();
	this.mXPProgressbar.remove();
	this.mXPProgressbar = null;

	this.mContainer.empty();
	this.mContainer.remove();
	this.mContainer = null;
};


CharacterScreenLeftPanelHeaderModule.prototype.createChangeNameAndTitleDialogContent = function (_dialog)
{
	var data = this.mDataSource.getSelectedBrother();
	var selectedBrother = CharacterScreenIdentifier.Entity.Character.Key in data ? data[CharacterScreenIdentifier.Entity.Character.Key] : null;
	if (selectedBrother === null)
	{
		console.error('Failed to create dialog content. Reason: No brother selected.');
		return null;
	}

	var result = $('<div class="change-name-and-title-container"/>');

	// create & set name
	var row = $('<div class="row"/>');
	result.append(row);
	var label = $('<div class="label text-font-normal font-color-label font-bottom-shadow">Name</div>');
	row.append(label);

	var self = this;

	var inputLayout = $('<div class="l-input"/>');
	row.append(inputLayout);
	var inputField = inputLayout.createInput('', 0, Constants.Game.MAX_BROTHER_NAME_LENGTH, 1, function (_input)
	{
		_dialog.findPopupDialogOkButton().enableButton(_input.getInputTextLength() >= Constants.Game.MIN_BROTHER_NAME_LENGTH);
	}, 'title-font-big font-bold font-color-brother-name', function (_input)
	{
		var button = _dialog.findPopupDialogOkButton();
		if(button.isEnabled())
		{
			button.click();
		}
	});

	if(CharacterScreenIdentifier.Entity.Character.Name in selectedBrother)
		inputField.setInputText(selectedBrother[CharacterScreenIdentifier.Entity.Character.Name]);

	// create & set title
	row = $('<div class="row"/>');
	result.append(row);
	label = $('<div class="label text-font-normal font-color-label font-bottom-shadow">Title</div>');
	row.append(label);

	inputLayout = $('<div class="l-input"/>');
	row.append(inputLayout);
	inputField = inputLayout.createInput('', Constants.Game.MIN_BROTHER_TITLE_LENGTH, Constants.Game.MAX_BROTHER_TITLE_LENGTH, 2, null, 'title-font-big font-bold font-color-brother-name', function (_input)
	{
		var button = _dialog.findPopupDialogOkButton();
		if(button.isEnabled())
			button.click();
	});
	
	if(CharacterScreenIdentifier.Entity.Character.Title in selectedBrother)
		inputField.setInputText(selectedBrother[CharacterScreenIdentifier.Entity.Character.Title]);

	return result;
};

CharacterScreenLeftPanelHeaderModule.prototype.createDismissDialogContent = function (_dialog)
{
	var self = this;

	var data = this.mDataSource.getSelectedBrother();
	var selectedBrother = CharacterScreenIdentifier.Entity.Character.Key in data ? data[CharacterScreenIdentifier.Entity.Character.Key] : null;
	if (selectedBrother === null)
	{
		console.error('Failed to create dialog content. Reason: No brother selected.');
		return null;
	}

	var result = $('<div class="dismiss-character-container"/>');
	var titleLabel;

	if (selectedBrother['dailyMoneyCost'] == 0)
		titleLabel = $('<div class="title-label title-font-normal font-bold font-color-title">Really free ' + selectedBrother[CharacterScreenIdentifier.Entity.Character.Name] + '?</div>');
	else
		titleLabel = $('<div class="title-label title-font-normal font-bold font-color-title">Really dismiss ' + selectedBrother[CharacterScreenIdentifier.Entity.Character.Name] + '?</div>');

	result.append(titleLabel);

	var textLabel = $('<div class="label text-font-medium font-color-description font-style-normal">' + selectedBrother[CharacterScreenIdentifier.Entity.Character.Name] + ' will permanently leave you and place his <br/>current equipment in the stash.</div>');
	result.append(textLabel);

	// ---

	var retirementPackage = $('<div class="retirement-package"/>');
	result.append(retirementPackage);

	var checkbox = $('<input type="checkbox" class="compensation-checkbox" id="compensation" name="display"/>');
	retirementPackage.append(checkbox);

	var checkboxLabel;

	if (selectedBrother['dailyMoneyCost'] == 0)
		checkboxLabel = $('<label class="blub text-font-medium font-color-subtitle font-style-normal" for="compensation">Pay <img src="' + Path.GFX + Asset.ICON_MONEY_SMALL + '"/>' + (Math.max(1, selectedBrother['daysWithCompany']) * 10) + ' Reparations</label>');
	else
		checkboxLabel = $('<label class="blub text-font-medium font-color-subtitle font-style-normal" for="compensation">Pay <img src="' + Path.GFX + Asset.ICON_MONEY_SMALL + '"/>' + (Math.max(1, selectedBrother['daysWithCompany']) * 10) + ' Compensation</label>');

	retirementPackage.append(checkboxLabel);

	checkboxLabel.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterScreen.DismissPopupDialog.Compensation });

	checkbox.iCheck({
		checkboxClass: 'icheckbox_flat-orange',
		radioClass: 'iradio_flat-orange',
		increaseArea: '0%'
	});

	checkbox.on('ifChecked ifUnchecked', null, this, function (_event)
	{
		self.mPayDismissalWage = checkbox.prop('checked') === true;
	});

	return result;
};

CharacterScreenLeftPanelHeaderModule.prototype.updateNameAndTitle = function (_dialog)
{
	var contentContainer = _dialog.findPopupDialogContentContainer();
	var inputFields = contentContainer.find('input');

	this.mDataSource.updateNameAndTitle(null, $(inputFields[0]).getInputText(), $(inputFields[1]).getInputText());
};


CharacterScreenLeftPanelHeaderModule.prototype.createLevelUpDialogSubHeader = function ()
{
	var result = $('<div class="levelup-header"/>');
	var centerLayout  = $('<div class="l-center-container"/>');
	result.append(centerLayout);

	var image = $('<img/>');
	image.attr('src', Path.GFX + Asset.ICON_LEVELED_UP);
	centerLayout.append(image);

	var label = $('<div class="label text-font-normal font-bold font-bottom-shadow font-color-value"/>');
	centerLayout.append(label);
	label.html('' + Constants.Game.MAX_STATS_INCREASE_COUNT + ' / ' + Constants.Game.MAX_STATS_INCREASE_COUNT);
	label.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterScreen.LevelUpPopupDialog.StatIncreasePoints });

	return result;
};

CharacterScreenLeftPanelHeaderModule.prototype.createLevelUpDialogContent = function ()
{
	var self = this;

	var data = this.mDataSource.getSelectedBrother();
	var selectedBrother = CharacterScreenIdentifier.Entity.Character.Key in data ? data[CharacterScreenIdentifier.Entity.Character.Key] : null;
	if (selectedBrother === null)
	{
		console.error('Failed to create dialog content. Reason: No brother selected.');
		return null;
	}

	var levelUpData = CharacterScreenIdentifier.Entity.Character.LevelUp.Key in selectedBrother ? selectedBrother[CharacterScreenIdentifier.Entity.Character.LevelUp.Key] : null;
	if (levelUpData === null)
	{
		console.error('Failed to create dialog content. Reason: Brother has no level up data.');
		return null;
	}

	// create result values
	this.mLevelUpIncreaseValues = {};
	$.each(CharacterScreenIdentifier.Entity.Character.LevelUp, function(_key, _value)
	{
		if (_value !== CharacterScreenIdentifier.Entity.Character.LevelUp.Key)
		{
			self.mLevelUpIncreaseValues[_value] = 0;
		}
	});

	/*
	console.info(this.mLevelUpIncreaseValues);
	console.info(levelUpData);
*/

	var result = $('<div class="levelup-container"/>');

	// left
	var column = $('<div class="column"/>');
	result.append(column);
	this.createLevelUpDialogContentRow(this.mLevelUpLeftStatsRows, column, levelUpData, data.stats);

	// right
	column = $('<div class="column"/>');
	result.append(column);
	this.createLevelUpDialogContentRow(this.mLevelUpRightStatsRows, column, levelUpData, data.stats);

	return result;
};

CharacterScreenLeftPanelHeaderModule.prototype.createLevelUpDialogContentRow = function (_definitions, _parentDiv, _data, _stats)
{
	var self = this;

	$.each(_definitions, function(_key, _value)
	{
		var row = $('<div class="row"/>');
		_parentDiv.append(row);
		row.bindTooltip({ contentType: 'ui-element', elementId: _value.TooltipId });

		var image = $('<img/>');
		image.attr('src', _value.IconPath);
		row.append(image);

		_value.Talent = $('<img class="talent" src="' + Path.GFX + 'ui/icons/talent_' + _stats[_value.TalentIdentifier] + '.png"/>');
		_value.Talent.css({ 'width': '3.6rem', 'height': '1.8rem' });
		row.append(_value.Talent);

		var progressbarLayout = $('<div class="l-progressbar-container"/>');
		row.append(progressbarLayout);
		_value.Progressbar = progressbarLayout.createProgressbar(true, _value.StyleName);

		self.setLevelUpDialogContentProgressbarValue(_value.Progressbar, _data, _value.ProgressbarValueIdentifier, _value.ProgressbarValueIdentifierMax);

		var buttonLayout = $('<div class="l-increase-button-container"/>');
		row.append(buttonLayout);

		//_value.Button = buttonLayout.createTextButton("+", function(_button)
		_value.Button = buttonLayout.createTextButton("+" + _data[_value.StatValueIdentifier], function(_button)
		{
			self.increaseLevelUpStatValue(_button);
			self.mDataSource.notifyBackendDiceThrow();
		}, 'font-bold', 8);
		_value.Button.data('stat', _key);
		_value.Button.data('isIncreased', false);
	});
};

CharacterScreenLeftPanelHeaderModule.prototype.destroyLevelUpDialogContentRow = function (_definitions)
{
	$.each(_definitions, function(_key, _value)
	{
		_value.Button.empty();
		_value.Button.remove();
		_value.Button = null;

		_value.Progressbar.empty();
		_value.Progressbar.remove();
		_value.Progressbar = null;
	});
};

CharacterScreenLeftPanelHeaderModule.prototype.setLevelUpDialogContentProgressbarValue = function (_progressbarDiv, _data, _valueKey, _valueMaxKey)
{
	if (_valueKey in _data && _data[_valueKey] !== null && _valueMaxKey in _data && _data[_valueMaxKey] !== null)
	{
		_progressbarDiv.changeProgressbarNormalWidth(_data[_valueKey], _data[_valueMaxKey], true);
		_progressbarDiv.changeProgressbarLabel('' + _data[_valueKey]);
	}
};

CharacterScreenLeftPanelHeaderModule.prototype.queryLevelUpStatsIncreasedValue = function ()
{
	// create result values
	var statsIncreased = 0;
	$.each(this.mLevelUpIncreaseValues, function(_key, _value)
	{
		if (_value >= 1)
		{
			++statsIncreased;
		}
	});

	return statsIncreased;
};

CharacterScreenLeftPanelHeaderModule.prototype.increaseLevelUpStatValue = function (_button)
{
	var data = this.mDataSource.getSelectedBrother();
	var selectedBrother = CharacterScreenIdentifier.Entity.Character.Key in data ? data[CharacterScreenIdentifier.Entity.Character.Key] : null;
	if (selectedBrother === null)
	{
		console.error('Failed to increase stat value. Reason: No brother selected.');
		return null;
	}

	var levelUpData = CharacterScreenIdentifier.Entity.Character.LevelUp.Key in selectedBrother ? selectedBrother[CharacterScreenIdentifier.Entity.Character.LevelUp.Key] : null;
	if (levelUpData === null)
	{
		console.error('Failed to increase stat value. Reason: Brother has no level up data.');
		return null;
	}

	var stat = null;
	var statName = _button.data('stat');
	if (statName in this.mLevelUpLeftStatsRows)
	{
		stat = this.mLevelUpLeftStatsRows[statName];
	}
	else
	{
		stat = this.mLevelUpRightStatsRows[statName];
	}

	var statIncrease = stat.StatValueIdentifier;
	if (statIncrease in this.mLevelUpIncreaseValues)
	{
		if (this.mLevelUpIncreaseValues[statIncrease] === 0)
		{
			// increase value within tmp object
			var tmpLevelUpData = $.extend({}, levelUpData);
			tmpLevelUpData[stat.ProgressbarValueIdentifier] += tmpLevelUpData[statIncrease];
			this.setLevelUpDialogContentProgressbarValue(stat.Progressbar, tmpLevelUpData, stat.ProgressbarValueIdentifier, stat.ProgressbarValueIdentifierMax);

			this.mLevelUpIncreaseValues[statIncrease] = tmpLevelUpData[statIncrease];

			_button.enableButton(false);
			_button.changeButtonText('+' + tmpLevelUpData[statIncrease]);
			_button.data('isIncreased', true);

			// update header
			var statsIncreasedValue = this.queryLevelUpStatsIncreasedValue();
			var statsIncreasesLeftLabel = this.mCurrentPopupDialog.findPopupDialogSubHeaderContainer().find('.label:first');
			if (statsIncreasesLeftLabel.length > 0)
			{
				statsIncreasesLeftLabel.html('' + (Constants.Game.MAX_STATS_INCREASE_COUNT - statsIncreasedValue) + ' / ' + Constants.Game.MAX_STATS_INCREASE_COUNT);
			}

			if (statsIncreasedValue >= Constants.Game.MAX_STATS_INCREASE_COUNT)
			{
				this.setLevelUpDialogToFinish();
			}
		}
		else
		{
			console.error('Failed to increase stat value. Reason: Already increased.');
		}
	}
};

CharacterScreenLeftPanelHeaderModule.prototype.disableLevelUpButtons = function (_definitions)
{
	$.each(_definitions, function(_key, _value)
	{
		_value.Button.enableButton(false);

		if(!_value.Button.data('isIncreased'))
			_value.Button.changeButtonText('');
	});
};

CharacterScreenLeftPanelHeaderModule.prototype.setLevelUpDialogToFinish = function ()
{
	this.disableLevelUpButtons(this.mLevelUpLeftStatsRows);
	this.disableLevelUpButtons(this.mLevelUpRightStatsRows);
	this.mCurrentPopupDialog.findPopupDialogOkButton().enableButton(true);
};

CharacterScreenLeftPanelHeaderModule.prototype.commitLevelUpStats = function ()
{
	this.destroyLevelUpDialogContentRow(this.mLevelUpLeftStatsRows);
	this.destroyLevelUpDialogContentRow(this.mLevelUpRightStatsRows);

	this.mDataSource.commitLevelUpStats(null, this.mLevelUpIncreaseValues);
	this.mLevelUpIncreaseValues = null;
};


CharacterScreenLeftPanelHeaderModule.prototype.bindTooltips = function ()
{
	if(this.mDataSource.isTacticalMode() !== true)
	{
		this.mNameContainer.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterScreen.LeftPanelHeaderModule.ChangeNameAndTitle });
	}

	this.mXPProgressbar.bindProgressbarTooltip(TooltipIdentifier.CharacterScreen.LeftPanelHeaderModule.Experience);
	this.mLevelContainer.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterScreen.LeftPanelHeaderModule.Level });
	this.mDismissButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterScreen.LeftPanelHeaderModule.Dismiss });
	this.mReserveButton.bindTooltip({ contentType: 'ui-element', entityId: "", elementId: TooltipIdentifier.CharacterScreen.LeftPanelHeaderModule.Reserves });
	
};

CharacterScreenLeftPanelHeaderModule.prototype.unbindTooltips = function ()
{
	if(this.mDataSource.isTacticalMode() !== true)
	{
		this.mNameContainer.unbindTooltip();
	}

	this.mXPProgressbar.bindProgressbarTooltip();
	this.mLevelContainer.unbindTooltip();
	this.mDismissButton.unbindTooltip();
	this.mReserveButton.unbindTooltip();
};


CharacterScreenLeftPanelHeaderModule.prototype.registerDatasourceListener = function()
{
	this.mDataSource.addListener(CharacterScreenDatasourceIdentifier.Brother.Updated, jQuery.proxy(this.onBrotherUpdated, this));
	this.mDataSource.addListener(CharacterScreenDatasourceIdentifier.Brother.Selected, jQuery.proxy(this.onBrotherSelected, this));
};


CharacterScreenLeftPanelHeaderModule.prototype.create = function(_parentDiv)
{
	this.createDIV(_parentDiv);
	this.bindTooltips();
};

CharacterScreenLeftPanelHeaderModule.prototype.destroy = function()
{
	this.unbindTooltips();
	this.destroyDIV();
};


CharacterScreenLeftPanelHeaderModule.prototype.register = function (_parentDiv)
{
	console.log('CharacterScreenLeftPanelHeaderModule::REGISTER');

	if (this.mContainer !== null)
	{
		console.error('ERROR: Failed to register Left Panel Header Module. Reason: Module is already initialized.');
		return;
	}

	if (_parentDiv !== null && typeof(_parentDiv) == 'object')
	{
		this.create(_parentDiv);
	}
};

CharacterScreenLeftPanelHeaderModule.prototype.unregister = function ()
{
	console.log('CharacterScreenLeftPanelHeaderModule::UNREGISTER');

	if (this.mContainer === null)
	{
		console.error('ERROR: Failed to unregister Left Panel Header Module. Reason: Module is not initialized.');
		return;
	}

	this.destroy();
};

CharacterScreenLeftPanelHeaderModule.prototype.isRegistered = function ()
{
	if (this.mContainer !== null)
	{
		return this.mContainer.parent().length !== 0;
	}

	return false;
};


CharacterScreenLeftPanelHeaderModule.prototype.setPortraitImage = function(_imagePath)
{
	if (this.mPortraitImage.attr('src') == Path.PROCEDURAL + _imagePath)
		return;

	this.mPortraitPlaceholder.removeClass('opacity-almost-none');
	this.mPortraitImage.attr('src', Path.PROCEDURAL + _imagePath);
};

CharacterScreenLeftPanelHeaderModule.prototype.setNameAndTitle = function(_name, _title)
{
	var label = this.mNameContainer.find('.label:first');
	if (label.length > 0)
	{
		if (_title !== null && typeof(_title) === 'string' && _title.length > 0)
		{
			label.html(_name + '<br/>' + _title);
		}
		else
		{
			label.html(_name);
		}
	}

	/*var image = this.mNameContainer.find('img:first');
	if (image.length > 0)
	{*/
		if (this.mDataSource.isTacticalMode() !== true)
		{
			this.mNameContainer.addClass('is-clickable');
			//image.removeClass('display-none').addClass('display-block');
		}
		else
		{
			this.mNameContainer.removeClass('is-clickable');
			//image.removeClass('display-block').addClass('display-none');
		}
   // }
};

CharacterScreenLeftPanelHeaderModule.prototype.setLevel = function(_levelValue, _hasLevelUp)
{
	var label = this.mLevelContainer.find('.label:first');
	if (label.length > 0)
	{
		label.html('' + _levelValue);
	}

	var image = this.mLevelContainer.find('img:first');
	if (image.length > 0)
	{
		if (this.mDataSource.isTacticalMode() !== true && _hasLevelUp === true)
		{
			this.mLevelContainer.addClass('is-clickable');
			this.mXPProgressbar.addClass('is-clickable');
			image.removeClass('display-none').addClass('display-block');
			//this.mLevelContainer.blinkColorIndefinitely();

		}
		else
		{
			this.mLevelContainer.stop();
			this.mLevelContainer.removeClass('is-clickable');
			this.mXPProgressbar.removeClass('is-clickable');
			image.removeClass('display-block').addClass('display-none');
		}
	}
	/*else 
	{
		this.mLevelContainer.stop();
	}*/
};

CharacterScreenLeftPanelHeaderModule.prototype.setXP = function(_xpValue, _xpValueMax, _level, _hasLevelUp)
{
	if(_level >= 11)
	{
		this.mXPProgressbar.addClass('xp-paragon');
	}
	else
	{
		this.mXPProgressbar.removeClass('xp-paragon');
	}

	if (_hasLevelUp)
	{
		this.mXPProgressbar.changeProgressbarNormalWidth(100, 100);
		this.mXPProgressbar.changeProgressbarLabel('Click here to level up!');
	}
	else
	{
		this.mXPProgressbar.changeProgressbarNormalWidth(_xpValue, _xpValueMax);
		this.mXPProgressbar.changeProgressbarLabel('' + _xpValue + ' / ' + _xpValueMax);
	}
};


CharacterScreenLeftPanelHeaderModule.prototype.updateControls = function(_id, _data)
{
	/*this.mLevelContainer.css('backgroundColor', 'transparent');
	this.mLevelContainer.stop();*/

	if (_data === null || typeof(_data) !== 'object')
	{
		return;
	}

	// update image
	if (CharacterScreenIdentifier.Entity.Character.ImagePath in _data)
	{
		this.setPortraitImage(_data[CharacterScreenIdentifier.Entity.Character.ImagePath]);
	}

	// update name & title
	if (CharacterScreenIdentifier.Entity.Character.Name in _data)
	{
		var titel = '';
		if (CharacterScreenIdentifier.Entity.Character.Title in _data)
		{
			titel = _data[CharacterScreenIdentifier.Entity.Character.Title];
		}
		this.setNameAndTitle(_data[CharacterScreenIdentifier.Entity.Character.Name], titel);
	}

	// update level
	if (CharacterScreenIdentifier.Entity.Character.Level in _data)
	{
		this.setLevel(_data[CharacterScreenIdentifier.Entity.Character.Level], _data[CharacterScreenIdentifier.Entity.Character.LevelUp.Key] !== null);
	}

	// update xp
	if (CharacterScreenIdentifier.Entity.Character.XPValue in _data && CharacterScreenIdentifier.Entity.Character.XPValueMax in _data)
	{
		this.setXP(_data[CharacterScreenIdentifier.Entity.Character.XPValue], _data[CharacterScreenIdentifier.Entity.Character.XPValueMax], _data[CharacterScreenIdentifier.Entity.Character.Level], _data[CharacterScreenIdentifier.Entity.Character.LevelUp.Key] !== null);
	}

	// update dismiss button
	if (this.mDataSource.getNumBrothers() > 1 && !this.mDataSource.isTacticalMode() && !_data[CharacterScreenIdentifier.Entity.Character.IsPlayerCharacter])
	{
		this.mDismissButton.removeClass('display-none').addClass('display-block');
	}
	else
	{
		this.mDismissButton.addClass('display-none').removeClass('display-block');
	}
	
	// update reserve button
	if (!this.mDataSource.isTacticalMode())
	{
		this.mReserveButton.removeClass('display-none').addClass('display-block');
	}
	else
	{
		this.mReserveButton.addClass('display-none').removeClass('display-block');
	}
	
	if (_data['inReserves'])
	{
		this.mReserveButton.changeButtonImage(Path.GFX + "ui/buttons/mood_heal.png")
	}
	else
	{
		this.mReserveButton.changeButtonImage(Path.GFX + "ui/icons/stat_screen_dmg_dealt.png")
	}
	this.mReserveButton.unbindTooltip();
	this.mReserveButton.bindTooltip({ contentType: 'ui-element', entityId: _id, elementId: TooltipIdentifier.CharacterScreen.LeftPanelHeaderModule.Reserves });
};


CharacterScreenLeftPanelHeaderModule.prototype.onBrotherUpdated = function (_dataSource, _brother)
{
	/*this.mLevelContainer.css('backgroundColor', 'transparent');
	this.mLevelContainer.stop();*/
	
	if (this.mDataSource.isSelectedBrother(_brother) && CharacterScreenIdentifier.Entity.Character.Key in _brother)
	{
		this.updateControls(_brother[CharacterScreenIdentifier.Entity.Id], _brother[CharacterScreenIdentifier.Entity.Character.Key]);
	}
};

CharacterScreenLeftPanelHeaderModule.prototype.onBrotherSelected = function (_dataSource, _brother)
{
	/*this.mLevelContainer.css('backgroundColor', 'transparent');
	this.mLevelContainer.stop();*/
	
	if (_brother !== null && (CharacterScreenIdentifier.Entity.Id in _brother && CharacterScreenIdentifier.Entity.Character.Key in _brother))
	{
		this.updateControls(_brother[CharacterScreenIdentifier.Entity.Id], _brother[CharacterScreenIdentifier.Entity.Character.Key]);
	}
};