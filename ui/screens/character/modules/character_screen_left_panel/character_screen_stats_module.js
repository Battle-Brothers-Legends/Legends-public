/*
 *  @Project:		Battle Brothers
 *	@Company:		Overhype Studios
 *
 *	@Copyright:		(c) Overhype Studios | 2013 - 2020
 * 
 *  @Author:		Overhype Studios
 *  @Date:			24.01.2017 / Reworked: 26.11.2017
 *  @Description:	Stats Module JS
 */
"use strict";

/* TODO:
 + Progressbar gegen Komponente austauschen
 */

var CharacterScreenStatsModule = function (_parent, _dataSource) {
	this.mParent = _parent;
	this.mDataSource = _dataSource;

	// container
	this.mContainer = null;

	// left stats row defines
	this.mLeftStatsRows = {
		ArmorHead: {
			IconPath: Path.GFX + Asset.ICON_ARMOR_HEAD,
			StyleName: ProgressbarStyleIdentifier.ArmorHead,
			TooltipId: TooltipIdentifier.CharacterStats.ArmorHead,
			Row: null,
			Progressbar: null,
			Talent: null
		},
		ArmorBody: {
			IconPath: Path.GFX + Asset.ICON_ARMOR_BODY,
			StyleName: ProgressbarStyleIdentifier.ArmorBody,
			TooltipId: TooltipIdentifier.CharacterStats.ArmorBody,
			Row: null,
			Progressbar: null,
			Talent: null
		},
		Hitpoints: {
			IconPath: Path.GFX + Asset.ICON_HEALTH,
			StyleName: ProgressbarStyleIdentifier.Hitpoints,
			TooltipId: TooltipIdentifier.CharacterStats.Hitpoints,
			Row: null,
			Progressbar: null,
			Talent: null
		},
		ActionPoints: {
			IconPath: Path.GFX + Asset.ICON_ACTION_POINTS,
			StyleName: ProgressbarStyleIdentifier.ActionPoints,
			TooltipId: TooltipIdentifier.CharacterStats.ActionPoints,
			Row: null,
			Progressbar: null,
			Talent: null
		},
		Fatigue: {
			IconPath: Path.GFX + Asset.ICON_FATIGUE,
			StyleName: ProgressbarStyleIdentifier.Fatigue,
			TooltipId: TooltipIdentifier.CharacterStats.Fatigue,
			Row: null,
			Progressbar: null,
			Talent: null
		},
		Morale: {
			IconPath: Path.GFX + Asset.ICON_MORALE,
			StyleName: ProgressbarStyleIdentifier.Morale,
			TooltipId: TooltipIdentifier.CharacterStats.Morale,
			Row: null,
			Progressbar: null,
			Talent: null
		},
		Bravery: {
			IconPath: Path.GFX + Asset.ICON_BRAVERY,
			StyleName: ProgressbarStyleIdentifier.Bravery,
			TooltipId: TooltipIdentifier.CharacterStats.Bravery,
			Row: null,
			Progressbar: null,
			Talent: null
		},
		Initiative: {
			IconPath: Path.GFX + Asset.ICON_INITIATIVE,
			StyleName: ProgressbarStyleIdentifier.Initiative,
			TooltipId: TooltipIdentifier.CharacterStats.Initiative,
			Row: null,
			Progressbar: null,
			Talent: null
		}
	};

	// middle stats row defines
	this.mMiddleStatsRows = {
		MeleeSkill: {
			IconPath: Path.GFX + Asset.ICON_MELEE_SKILL,
			StyleName: ProgressbarStyleIdentifier.MeleeSkill,
			TooltipId: TooltipIdentifier.CharacterStats.MeleeSkill,
			Row: null,
			Progressbar: null,
			Talent: null
		},
		RangeSkill: {
			IconPath: Path.GFX + Asset.ICON_RANGE_SKILL,
			StyleName: ProgressbarStyleIdentifier.RangeSkill,
			TooltipId: TooltipIdentifier.CharacterStats.RangeSkill,
			Row: null,
			Progressbar: null,
			Talent: null
		},
		MeleeDefense: {
			IconPath: Path.GFX + Asset.ICON_MELEE_DEFENCE,
			StyleName: ProgressbarStyleIdentifier.MeleeDefense,
			TooltipId: TooltipIdentifier.CharacterStats.MeleeDefense,
			Row: null,
			Progressbar: null,
			Talent: null
		},
		RangeDefense: {
			IconPath: Path.GFX + Asset.ICON_RANGE_DEFENCE,
			StyleName: ProgressbarStyleIdentifier.RangeDefense,
			TooltipId: TooltipIdentifier.CharacterStats.RangeDefense,
			Row: null,
			Progressbar: null,
			Talent: null
		},
		RegularDamage: {
			IconPath: Path.GFX + Asset.ICON_REGULAR_DAMAGE,
			StyleName: ProgressbarStyleIdentifier.RegularDamage,
			TooltipId: TooltipIdentifier.CharacterStats.RegularDamage,
			Row: null,
			Progressbar: null,
			Talent: null
		},
		CrushingDamage: {
			IconPath: Path.GFX + Asset.ICON_CRUSHING_DAMAGE,
			StyleName: ProgressbarStyleIdentifier.CrushingDamage,
			TooltipId: TooltipIdentifier.CharacterStats.CrushingDamage,
			Row: null,
			Progressbar: null,
			Talent: null
		},
		ChanceToHitHead: {
			IconPath: Path.GFX + Asset.ICON_CHANCE_TO_HIT_HEAD,
			StyleName: ProgressbarStyleIdentifier.ChanceToHitHead,
			TooltipId: TooltipIdentifier.CharacterStats.ChanceToHitHead,
			Row: null,
			Progressbar: null,
			Talent: null
		},
		SightDistance: {
			IconPath: Path.GFX + Asset.ICON_SIGHT_DISTANCE,
			StyleName: ProgressbarStyleIdentifier.SightDistance,
			TooltipId: TooltipIdentifier.CharacterStats.SightDistance,
			Row: null,
			Progressbar: null,
			Talent: null
		}
	};

	this.registerDatasourceListener();
};


CharacterScreenStatsModule.prototype.createDIV = function (_parentDiv) {
	// create: containers
	this.mContainer = $('<div class="stats-module"/>');
	_parentDiv.append(this.mContainer);

	// create: stats containers & layouts
	var leftStatsColumn = $('<div class="stats-column"/>');
	this.mContainer.append(leftStatsColumn);

	var middleStatsColumn = $('<div class="stats-column"/>');
	this.mContainer.append(middleStatsColumn);

	// create: progressbars
	this.createRowsDIV(this.mLeftStatsRows, leftStatsColumn);
	this.createRowsDIV(this.mMiddleStatsRows, middleStatsColumn);
};

CharacterScreenStatsModule.prototype.destroyDIV = function () {
	this.destroyRowsDIV(this.mLeftStatsRows);
	this.destroyRowsDIV(this.mMiddleStatsRows);

	this.mContainer.empty();
	this.mContainer.remove();
	this.mContainer = null;
};


CharacterScreenStatsModule.prototype.createRowsDIV = function (_definitions, _parentDiv) {
	$.each(_definitions, function (_key, _value) {
		_value.Row = $('<div class="stats-row"/>');
		_parentDiv.append(_value.Row);
		var leftStatsRowLayout = $('<div class="l-stats-row"/>');
		_value.Row.append(leftStatsRowLayout);

		var statsRowIconLayout = $('<div class="l-stats-row-icon-column"/>');
		leftStatsRowLayout.append(statsRowIconLayout);
		var statsRowIcon = $('<img/>');
		statsRowIcon.attr('src', _value.IconPath);
		statsRowIconLayout.append(statsRowIcon);

		var statsRowProgressbarLayout = $('<div class="l-stats-row-progressbar-column"/>');
		leftStatsRowLayout.append(statsRowProgressbarLayout);
		var statsRowProgressbarContainer = $('<div class="stats-progressbar-container"/>');
		statsRowProgressbarLayout.append(statsRowProgressbarContainer);

		_value.Progressbar = statsRowProgressbarContainer.createProgressbar(true, _value.StyleName);

		_value.Talent = $('<img class="talent"/>');
		statsRowIconLayout.append(_value.Talent);
	});
};

CharacterScreenStatsModule.prototype.destroyRowsDIV = function (_definitions) {
	$.each(_definitions, function (_key, _value) {
		_value.Progressbar.empty();
		_value.Progressbar.remove();
		_value.Progressbar = null;

		_value.Row.empty();
		_value.Row.remove();
		_value.Row = null;
	});
};

CharacterScreenStatsModule.prototype.setupEventHandler = function () {
	$.each(this.mLeftStatsRows, function (_key, _value) {
		_value.Row.bindTooltip({ contentType: 'ui-element', elementId: _value.TooltipId });
		//_value.Talent.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterStats.Talent });
	});

	$.each(this.mMiddleStatsRows, function (_key, _value) {
		_value.Row.bindTooltip({ contentType: 'ui-element', elementId: _value.TooltipId });
		//_value.Talent.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterStats.Talent });
	});
};

CharacterScreenStatsModule.prototype.removeEventHandler = function () {
	$.each(this.mLeftStatsRows, function (_key, _value) {
		_value.Row.unbindTooltip();
		//_value.Talent.unbindTooltip();
	});
	$.each(this.mMiddleStatsRows, function (_key, _value) {
		_value.Row.unbindTooltip();
		//_value.Talent.unbindTooltip();
	});
};


CharacterScreenStatsModule.prototype.registerDatasourceListener = function () {
	this.mDataSource.addListener(CharacterScreenDatasourceIdentifier.Brother.Updated, jQuery.proxy(this.onBrotherUpdated, this));
	this.mDataSource.addListener(CharacterScreenDatasourceIdentifier.Brother.Selected, jQuery.proxy(this.onBrotherSelected, this));
};


CharacterScreenStatsModule.prototype.create = function (_parentDiv) {
	this.createDIV(_parentDiv);
	this.setupEventHandler();
};

CharacterScreenStatsModule.prototype.destroy = function () {
	this.removeEventHandler();
	this.destroyDIV();
};


CharacterScreenStatsModule.prototype.register = function (_parentDiv) {
	console.log('CharacterScreenStatsModule::REGISTER');

	if (this.mContainer !== null) {
		console.error('ERROR: Failed to registerStats Module. Reason: Module is already initialized.');
		return;
	}

	if (_parentDiv !== null && typeof (_parentDiv) == 'object') {
		this.create(_parentDiv);
	}
};

CharacterScreenStatsModule.prototype.unregister = function () {
	console.log('CharacterScreenStatsModule::UNREGISTER');

	if (this.mContainer === null) {
		console.error('ERROR: Failed to unregister Stats Module. Reason: Module is not initialized.');
		return;
	}

	this.destroy();
};

CharacterScreenStatsModule.prototype.isRegistered = function () {
	if (this.mContainer !== null) {
		return this.mContainer.parent().length !== 0;
	}

	return false;
};

CharacterScreenStatsModule.prototype.setProgressbarValue = function (_progressbarDiv, _data, _valueKey, _valueMaxKey, _labelKey) {
	if (_valueKey in _data && _data[_valueKey] !== null && _valueMaxKey in _data && _data[_valueMaxKey] !== null) {
		_progressbarDiv.changeProgressbarNormalWidth(_data[_valueKey], _data[_valueMaxKey]);

		if (_labelKey in _data && _data[_labelKey] !== null) {
			_progressbarDiv.changeProgressbarLabel(_data[_labelKey]);
		}
		else {
			var potential = (_data.potentials != null && _data.potentials[_valueKey] != null && _data.potentials[_valueKey] != "" ? " (" + (parseInt(_data.potentials[_valueKey].split("-")[0])+parseInt(_data.potentials[_valueKey].split("-")[1]))/2 + ")" : '')
			switch (_valueKey) {
				case ProgressbarValueIdentifier.ArmorHead:
				case ProgressbarValueIdentifier.ArmorBody:
				case ProgressbarValueIdentifier.Hitpoints:
				case ProgressbarValueIdentifier.ActionPoints:
				case ProgressbarValueIdentifier.Fatigue:
				case ProgressbarValueIdentifier.Morale:
					{
						_progressbarDiv.changeProgressbarLabel('' + _data[_valueKey] + ' / ' + _data[_valueMaxKey] + potential);
					} break;
				default:
					{
						_progressbarDiv.changeProgressbarLabel('' + _data[_valueKey] + potential);
					}
			}
		}
	}
};

CharacterScreenStatsModule.prototype.setTalentValue = function (_what, _data) {
	_what.Talent.attr('src', Path.GFX + 'ui/icons/talent_' + _data + '.png');
	_what.Talent.css({ 'width': '3.6rem', 'height': '1.8rem' });
}

CharacterScreenStatsModule.prototype.setProgressbarValues = function (_data) {
	// LEFT ROW
	// ************************************************************************************************************************
	this.setProgressbarValue(this.mLeftStatsRows.ArmorHead.Progressbar, _data, ProgressbarValueIdentifier.ArmorHead, ProgressbarValueIdentifier.ArmorHeadMax, ProgressbarValueIdentifier.ArmorHeadLabel);
	this.setProgressbarValue(this.mLeftStatsRows.ArmorBody.Progressbar, _data, ProgressbarValueIdentifier.ArmorBody, ProgressbarValueIdentifier.ArmorBodyMax, ProgressbarValueIdentifier.ArmorBodyLabel);
	this.setProgressbarValue(this.mLeftStatsRows.Hitpoints.Progressbar, _data, ProgressbarValueIdentifier.Hitpoints, ProgressbarValueIdentifier.HitpointsMax, ProgressbarValueIdentifier.HitpointsLabel);
	this.setProgressbarValue(this.mLeftStatsRows.ActionPoints.Progressbar, _data, ProgressbarValueIdentifier.ActionPoints, ProgressbarValueIdentifier.ActionPointsMax, ProgressbarValueIdentifier.ActionPointsLabel);
	this.setProgressbarValue(this.mLeftStatsRows.Fatigue.Progressbar, _data, ProgressbarValueIdentifier.Fatigue, ProgressbarValueIdentifier.FatigueMax, ProgressbarValueIdentifier.FatigueLabel);
	this.setProgressbarValue(this.mLeftStatsRows.Morale.Progressbar, _data, ProgressbarValueIdentifier.Morale, ProgressbarValueIdentifier.MoraleMax, ProgressbarValueIdentifier.MoraleLabel);
	this.setProgressbarValue(this.mLeftStatsRows.Bravery.Progressbar, _data, ProgressbarValueIdentifier.Bravery, ProgressbarValueIdentifier.BraveryMax, ProgressbarValueIdentifier.BraveryLabel);
	this.setProgressbarValue(this.mLeftStatsRows.Initiative.Progressbar, _data, ProgressbarValueIdentifier.Initiative, ProgressbarValueIdentifier.InitiativeMax, ProgressbarValueIdentifier.InitiativeLabel);

	this.setTalentValue(this.mLeftStatsRows.Hitpoints, _data.hitpointsTalent);
	this.setTalentValue(this.mLeftStatsRows.Fatigue, _data.fatigueTalent);
	this.setTalentValue(this.mLeftStatsRows.Bravery, _data.braveryTalent);
	this.setTalentValue(this.mLeftStatsRows.Initiative, _data.initiativeTalent);

	// MIDDLE ROW
	// ************************************************************************************************************************
	this.setProgressbarValue(this.mMiddleStatsRows.MeleeSkill.Progressbar, _data, ProgressbarValueIdentifier.MeleeSkill, ProgressbarValueIdentifier.MeleeSkillMax, ProgressbarValueIdentifier.MeleeSkillLabel);
	this.setProgressbarValue(this.mMiddleStatsRows.RangeSkill.Progressbar, _data, ProgressbarValueIdentifier.RangeSkill, ProgressbarValueIdentifier.RangeSkillMax, ProgressbarValueIdentifier.RangeSkillLabel);
	this.setProgressbarValue(this.mMiddleStatsRows.MeleeDefense.Progressbar, _data, ProgressbarValueIdentifier.MeleeDefense, ProgressbarValueIdentifier.MeleeDefenseMax, ProgressbarValueIdentifier.MeleeDefenseLabel);
	this.setProgressbarValue(this.mMiddleStatsRows.RangeDefense.Progressbar, _data, ProgressbarValueIdentifier.RangeDefense, ProgressbarValueIdentifier.RangeDefenseMax, ProgressbarValueIdentifier.RangeDefenseLabel);
	this.setProgressbarValue(this.mMiddleStatsRows.RegularDamage.Progressbar, _data, ProgressbarValueIdentifier.RegularDamage, ProgressbarValueIdentifier.RegularDamageMax, ProgressbarValueIdentifier.RegularDamageLabel);
	this.setProgressbarValue(this.mMiddleStatsRows.CrushingDamage.Progressbar, _data, ProgressbarValueIdentifier.CrushingDamage, ProgressbarValueIdentifier.CrushingDamageMax, ProgressbarValueIdentifier.CrushingDamageLabel);
	this.setProgressbarValue(this.mMiddleStatsRows.ChanceToHitHead.Progressbar, _data, ProgressbarValueIdentifier.ChanceToHitHead, ProgressbarValueIdentifier.ChanceToHitHeadMax, ProgressbarValueIdentifier.ChanceToHitHeadLabel);
	this.setProgressbarValue(this.mMiddleStatsRows.SightDistance.Progressbar, _data, ProgressbarValueIdentifier.SightDistance, ProgressbarValueIdentifier.SightDistanceMax, ProgressbarValueIdentifier.SightDistanceLabel);

	this.setTalentValue(this.mMiddleStatsRows.MeleeSkill, _data.meleeSkillTalent);
	this.setTalentValue(this.mMiddleStatsRows.RangeSkill, _data.rangeSkillTalent);
	this.setTalentValue(this.mMiddleStatsRows.MeleeDefense, _data.meleeDefenseTalent);
	this.setTalentValue(this.mMiddleStatsRows.RangeDefense, _data.rangeDefenseTalent);
};


CharacterScreenStatsModule.prototype.onBrotherUpdated = function (_dataSource, _brother) {
	if (this.mDataSource.isSelectedBrother(_brother) && CharacterScreenIdentifier.Entity.Stats in _brother) {
		this.setProgressbarValues(_brother[CharacterScreenIdentifier.Entity.Stats]);
	}
};

CharacterScreenStatsModule.prototype.onBrotherSelected = function (_dataSource, _brother) {
	if (_brother !== null && CharacterScreenIdentifier.Entity.Id in _brother && CharacterScreenIdentifier.Entity.Stats in _brother) {
		this.setProgressbarValues(_brother[CharacterScreenIdentifier.Entity.Stats]);
	}
};