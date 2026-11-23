/*
 *  @Project:		Battle Brothers
 *	@Company:		Overhype Studios
 *
 *	@Copyright:		(c) Overhype Studios | 2013 - 2020
 * 
 *  @Author:		Overhype Studios
 *  @Date:			22.10.2013 (reworked: 21.02.2017)
 *  @Description:	TurnSequenceBar Module JS
 */
"use strict";


var TacticalScreenTurnSequenceBarModule = function () {
	this.mSQHandle = null;

	// event listener
	this.mEventListener = null;

	// container
	this.mContainer = null;
	this.mStatusEffectsContainer = null;
	this.mStatsContainer = null;
	this.mSkillsContainer = null;

	// stats header
	this.mStatsHeaderElevationImage = null;
	this.mStatsHeaderCharacterName = null;

	// left stats row defines	
	this.mLeftStatsRows =
	{
		ActionPoints:
		{
			ImagePath: Path.GFX + Asset.ICON_ACTION_POINTS,
			StyleName: ProgressbarStyleIdentifier.ActionPoints,
			TooltipId: TooltipIdentifier.CharacterStats.ActionPoints,
			Row: null,
			Progressbar: null,
			ProgressbarPreview: null,
			ProgressbarLabel: null,
		},
		Fatigue:
		{
			ImagePath: Path.GFX + Asset.ICON_FATIGUE,
			StyleName: ProgressbarStyleIdentifier.Fatigue,
			TooltipId: TooltipIdentifier.CharacterStats.Fatigue,
			Row: null,
			Progressbar: null,
			ProgressbarPreview: null,
			ProgressbarLabel: null,
		},
		Morale:
		{
			ImagePath: Path.GFX + Asset.ICON_MORALE,
			StyleName: ProgressbarStyleIdentifier.Morale,
			TooltipId: TooltipIdentifier.CharacterStats.Morale,
			Row: null,
			Progressbar: null,
			ProgressbarPreview: null,
			ProgressbarLabel: null,
		}
	};

	// right stats row defines	
	this.mRightStatsRows =
	{
		ArmorHead:
		{
			ImagePath: Path.GFX + Asset.ICON_ARMOR_HEAD,
			StyleName: ProgressbarStyleIdentifier.ArmorHead,
			TooltipId: TooltipIdentifier.CharacterStats.ArmorHead,
			Row: null,
			Progressbar: null,
			ProgressbarPreview: null,
			ProgressbarLabel: null,
		},
		ArmorBody:
		{
			ImagePath: Path.GFX + Asset.ICON_ARMOR_BODY,
			StyleName: ProgressbarStyleIdentifier.ArmorBody,
			TooltipId: TooltipIdentifier.CharacterStats.ArmorBody,
			Row: null,
			Progressbar: null,
			ProgressbarPreview: null,
			ProgressbarLabel: null,
		},
		Hitpoints:
		{
			ImagePath: Path.GFX + Asset.ICON_HEALTH,
			StyleName: ProgressbarStyleIdentifier.Hitpoints,
			TooltipId: TooltipIdentifier.CharacterStats.Hitpoints,
			Row: null,
			Progressbar: null,
			ProgressbarPreview: null,
			ProgressbarLabel: null,
		}
	};

	// turn sequence bar container
	this.mEntityContainer = null;
	this.mEntitySliderClippingContainer = null;
	this.mEntitySliderContainer = null;
	this.mFirstSlotNormalSizeEntityTemplate = null;
	this.mEntitySliderClippingContainer = null;

	// entity hover callbacks
	this.mEntityMouseEnterCallback = null;
	this.mEntityMouseLeaveCallback = null;
	this.mEntityClickedCallback = null;

	// buttons
	this.mEndTurnButton = null;
	this.mEndTurnAllButton = null;
	this.mWaitTurnButton = null;
	this.mOpenInventoryButton = null;

	this.mEndTurnButtonContainer = null;
	this.mEndTurnAllButtonContainer = null;
	this.mWaitTurnButtonContainer = null;

	this.mIsEndTurnAllVisible = true;

	// timing
	this.mFadeInDuration = 150;
	this.mFadeOutDuration = 250;
	this.mFadeOutDurationIfHiddenToPlayer = 60;
	this.mSlideInDuration = 100;
	this.mSlideOutDuration = 260;
	this.mSlideOutDurationIfHiddenToPlayer = 30;
	this.mResizeFirstSlotTime = 180;

	this.mResizeFirstSlotTimeIfPreviousWasHiddenToPlayer = 30;
	this.mResizeFirstSlotImageTime = 180;
	this.mSelectionFadeInDuration = 100;
	this.mSelectionFadeOutDuration = 100;
	this.mProgressbarMovementDuration = 600;
	this.mSkillPreviewFadeIn = 200;
	this.mSkillPreviewFadeOut = 200;
	this.mStatsPanelFadeInTime = 150;
	this.mStatsPanelFadeOutTime = 250;

	// special timer
	this.mFirstEntitySelectionTimer = null;
	this.mFirstEntitySelectionTimerInterval = 10;

	// constants
	this.mNormalEntityImageScale = 0.66;
};


TacticalScreenTurnSequenceBarModule.prototype.isConnected = function () {
	return this.mSQHandle !== null;
};

TacticalScreenTurnSequenceBarModule.prototype.onConnection = function (_handle) {
	this.mSQHandle = _handle;

	// notify listener
	if (this.mEventListener !== null && ('onModuleOnConnectionCalled' in this.mEventListener)) {
		this.mEventListener.onModuleOnConnectionCalled(this);
	}
};

TacticalScreenTurnSequenceBarModule.prototype.onDisconnection = function () {
	this.mSQHandle = null;

	// notify listener
	if (this.mEventListener !== null && ('onModuleOnDisconnectionCalled' in this.mEventListener)) {
		this.mEventListener.onModuleOnDisconnectionCalled(this);
	}
};


TacticalScreenTurnSequenceBarModule.prototype.createDIV = function (_parentDiv) {
	var self = this;

	// create: container
	this.mContainer = $('<div class="turnsequencebar-module ui-control"/>');
	_parentDiv.append(this.mContainer);

	var centerContainerLayout = $('<div class="l-center-container"/>');
	this.mContainer.append(centerContainerLayout);
	var centerContainer = $('<div class="center-container"/>');
	centerContainerLayout.append(centerContainer);

	var leftContainer = $('<div class="left-container"/>');
	centerContainer.append(leftContainer);
	var rightContainer = $('<div class="right-container"/>');
	centerContainer.append(rightContainer);

	// create: status effects container
	this.mStatusEffectsContainer = $('<div class="status-effects-container"/>');
	leftContainer.append(this.mStatusEffectsContainer);

	// create: stats container
	this.mStatsContainer = $('<div class="stats-panel"/>');
	leftContainer.append(this.mStatsContainer);

	// create: stats header
	var statsHeader = $('<div class="header"></div>');
	this.mStatsContainer.append(statsHeader);

	var statsHeaderElevationImageLayout = $('<div class="l-elevation-image"/>');
	statsHeader.append(statsHeaderElevationImageLayout);
	var statsHeaderElevationImageContainer = $('<div class="elevation-image"/>');
	statsHeaderElevationImageLayout.append(statsHeaderElevationImageContainer);
	this.mStatsHeaderElevationImage = $('<img/>');
	statsHeaderElevationImageContainer.append(this.mStatsHeaderElevationImage);

	var statsHeaderCharacterNameLayout = $('<div class="l-character-name"/>');
	statsHeader.append(statsHeaderCharacterNameLayout);
	this.mStatsHeaderCharacterName = $('<div class="character-name title-font-big font-bold font-color-brother-name"/>');
	statsHeaderCharacterNameLayout.append(this.mStatsHeaderCharacterName);

	// create: inventory button
	var layout = $('<div class="l-inventory-button"/>');
	statsHeader.append(layout);
	this.mOpenInventoryButton = layout.createImageButton(Path.GFX + Asset.BUTTON_OPEN_INVENTORY, function () {
		self.notifyBackendOpenInventoryButtonPressed();
	}, '', 6);

	// create: stats values columns
	var statsValuesColumnLeft = $('<div class="stats-column"/>');
	this.mStatsContainer.append(statsValuesColumnLeft);
	var statsValuesColumnLeftLayout = $('<div class="l-stats-column"/>');
	statsValuesColumnLeft.append(statsValuesColumnLeftLayout);

	var statsValuesColumnRight = $('<div class="stats-column"/>');
	this.mStatsContainer.append(statsValuesColumnRight);
	var statsValuesColumnRightLayout = $('<div class="l-stats-column"/>');
	statsValuesColumnRight.append(statsValuesColumnRightLayout);

	// create: stats values rows
	this.createStatsRowDIV(this.mLeftStatsRows, statsValuesColumnLeftLayout);
	this.createStatsRowDIV(this.mRightStatsRows, statsValuesColumnRightLayout);

	// create: right sub-container
	var rightTopContainer = $('<div class="top-container"/>');
	rightContainer.append(rightTopContainer);
	// NOTE: Workaround to get a boxed shadow without flickering...
	var rightBottomShadowContainer = $('<div class="bottom-shadow-container"/>');
	rightContainer.append(rightBottomShadowContainer);
	this.mEntityContainer = $('<div class="bottom-container"/>');
	// END: Workaround
	// Orginal: this.mEntityContainer = $('<div class="bottom-container ui-control-tactical-screen-turnsequencebar"></div>');
	rightContainer.append(this.mEntityContainer);

	// create: skills container
	this.mSkillsContainer = $('<div class="skills-container"/>');
	rightTopContainer.append(this.mSkillsContainer);

	// create: button container
	var buttonsContainer = $('<div class="buttons-container"/>');
	rightTopContainer.append(buttonsContainer);

	// create: buttons
	var buttonBackground = $('<div class="l-button-container"/>');
	buttonsContainer.append(buttonBackground);
	layout = $('<div class="l-button"/>');
	buttonBackground.append(layout);
	this.mEndTurnButton = layout.createImageButton(Path.GFX + Asset.BUTTON_END_TURN, function () {
		self.notifyBackendNextTurnButtonPressed();
	}, '', 6);
	this.mEndTurnButtonContainer = buttonBackground;

	var buttonBackground = $('<div class="l-button-container"/>');
	buttonsContainer.append(buttonBackground);
	layout = $('<div class="l-button"/>');
	buttonBackground.append(layout);
	this.mWaitTurnButton = layout.createImageButton(Path.GFX + Asset.BUTTON_DELAY_TURN, function () {
		self.notifyBackendWaitTurnButtonPressed();
	}, '', 6);
	this.mWaitTurnButtonContainer = buttonBackground;

	var buttonBackground = $('<div class="l-button-container"/>');
	buttonsContainer.append(buttonBackground);
	layout = $('<div class="l-button"/>');
	buttonBackground.append(layout);
	this.mEndTurnAllButton = layout.createImageButton(Path.GFX + Asset.BUTTON_END_ALL_TURNS, function () {
		self.notifyBackendEndTurnAllButtonPressed();
	}, '', 6);
	this.mEndTurnAllButtonContainer = buttonBackground;

	// create: turn sequence bar
	this.mEntitySliderClippingContainer = $('<div class="entity-slider-clipping-container"/>');
	this.mEntityContainer.append(this.mEntitySliderClippingContainer);
	this.mEntitySliderContainer = $('<div class="entity-slider-container"/>');
	this.mEntitySliderClippingContainer.append(this.mEntitySliderContainer);

	// create first slot entity template for measure reasons only
	this.mFirstSlotNormalSizeEntityTemplate = this.createEntityDIV(-1);
	this.mFirstSlotNormalSizeEntityTemplate.css({ width: '8.0rem', visibility: 'hidden' }); // NOTE: Adjust Slot size right here if needed!
	this.mEntitySliderClippingContainer.append(this.mFirstSlotNormalSizeEntityTemplate);

	this.mFirstSlotFullSizeEntityTemplate = this.createEntityDIV(-2);
	this.mFirstSlotFullSizeEntityTemplate.css({ width: '10.4rem', visibility: 'hidden' }); // NOTE: Adjust Slot size right here if needed!
	this.mEntitySliderClippingContainer.append(this.mFirstSlotFullSizeEntityTemplate);
};

TacticalScreenTurnSequenceBarModule.prototype.destroyDIV = function () {
	this.mStatusEffectsContainer.empty();
	this.mStatusEffectsContainer.remove();
	this.mStatusEffectsContainer = null;

	this.mStatsContainer.empty();
	this.mStatsContainer.remove();
	this.mStatsContainer = null;

	this.mStatsHeaderElevationImage.empty();
	this.mStatsHeaderElevationImage.remove();
	this.mStatsHeaderElevationImage = null;

	this.mStatsHeaderCharacterName.empty();
	this.mStatsHeaderCharacterName.remove();
	this.mStatsHeaderCharacterName = null;

	this.mOpenInventoryButton.empty();
	this.mOpenInventoryButton.remove();
	this.mOpenInventoryButton = null;

	this.mEndTurnButton.empty();
	this.mEndTurnButton.remove();
	this.mEndTurnButton = null;

	this.mEndTurnButtonContainer.empty();
	this.mEndTurnButtonContainer.remove();
	this.mEndTurnButtonContainer = null;

	this.mEndTurnAllButton.empty();
	this.mEndTurnAllButton.remove();
	this.mEndTurnAllButton = null;

	this.mEndTurnAllButtonContainer.empty();
	this.mEndTurnAllButtonContainer.remove();
	this.mEndTurnAllButtonContainer = null;

	this.mWaitTurnButton.empty();
	this.mWaitTurnButton.remove();
	this.mWaitTurnButton = null;

	this.mWaitTurnButtonContainer.empty();
	this.mWaitTurnButtonContainer.remove();
	this.mWaitTurnButtonContainer = null;

	this.mSkillsContainer.empty();
	this.mSkillsContainer.remove();
	this.mSkillsContainer = null;

	this.mFirstSlotNormalSizeEntityTemplate.remove();
	this.mFirstSlotNormalSizeEntityTemplate = null;
	this.mFirstSlotFullSizeEntityTemplate.remove();
	this.mFirstSlotFullSizeEntityTemplate = null;

	this.mEntitySliderContainer.empty();
	this.mEntitySliderContainer.remove();
	this.mEntitySliderContainer = null;

	this.mEntitySliderClippingContainer.empty();
	this.mEntitySliderClippingContainer.remove();
	this.mEntitySliderClippingContainer = null;

	this.mEntityContainer.empty();
	this.mEntityContainer.remove();
	this.mEntityContainer = null;

	this.mContainer.empty();
	this.mContainer.remove();
	this.mContainer = null;
};


TacticalScreenTurnSequenceBarModule.prototype.createStatsRowDIV = function (_definitions, _parentDiv) {
	$.each(_definitions, function (_key, _value) {
		_value.Row = $('<div class="stats-row"></div>');
		_parentDiv.append(_value.Row);
		var leftStatsRowLayout = $('<div class="l-stats-row"></div>');
		_value.Row.append(leftStatsRowLayout);

		var statsRowImageLayout = $('<div class="l-stats-row-image-column"></div>');
		leftStatsRowLayout.append(statsRowImageLayout);
		var statsRowImageContainer = $('<div class="stats-row-image"></div>');
		statsRowImageLayout.append(statsRowImageContainer);

		var statsRowImage = $('<img/>');
		statsRowImage.attr('src', _value.ImagePath);
		statsRowImageContainer.append(statsRowImage);

		var statsRowProgressbarLayout = $('<div class="l-stats-row-progressbar-column"></div>');
		leftStatsRowLayout.append(statsRowProgressbarLayout);
		var statsRowProgressbarContainer = $('<div class="stats-progressbar-container ui-control-stats-progressbar-container"></div>');
		statsRowProgressbarLayout.append(statsRowProgressbarContainer);

		_value.Progressbar = $('<div class="stats-progressbar ui-control-stats-progressbar ' + _value.StyleName + '"></div>');
		statsRowProgressbarContainer.append(_value.Progressbar);
		_value.ProgressbarPreview = $('<div class="stats-progressbar-preview ui-control-stats-progressbar-preview ' + _value.StyleName + '"></div>');
		statsRowProgressbarContainer.append(_value.ProgressbarPreview);
		_value.ProgressbarLabel = $('<div class="stats-progressbar-label text-font-small font-color-progressbar-label">100 / 100</div>');
		statsRowProgressbarContainer.append(_value.ProgressbarLabel);
	});
};

TacticalScreenTurnSequenceBarModule.prototype.createEntityDIV = function (_entityId) {
	var self = this;

	var entity = $('<div class="l-entity"></div>');
	entity.data('entity', { id: _entityId });

	// add content only to real game entities
	if (_entityId >= 0) {
		// create entity container
		var entityContainer = $('<div class="entity"/>');
		entity.append(entityContainer);

		// create image layer & image
		var entityImageLayer = $('<div class="image-layer"/>');

		entityContainer.append(entityImageLayer);
		var entityImage = $('<img class="entity-image"/>');
		entityImageLayer.append(entityImage);
		entityImage.css({ opacity: 0 });
		entityImage.data('entity', { id: _entityId });
		entityImage.data('newImage', false);

		var placeholder = $('<img class="placeholder-image no-pointer-events"/>');
		//placeholder.css({ 'background-color': 'red' });
		entityImage.data('placeholder', placeholder);
		entityImageLayer.append(placeholder);

		entityImage.load(function () {
			var isFirst = $(this).data('is-first') || false;
			if (isFirst === false) {
				// NOTE: (js) Das Bild per "Hand" um n-% verkleiner und in seinem Parent zentrieren, da es per CSS ned wirklich funktionieren wollte..
				var offsets = $(this).data('offsets') || { imageOffsetX: 0, imageOffsetY: 0 };
				var parent = $(this).parent();
				var newWidth = this.naturalWidth * self.mNormalEntityImageScale;
				var newHeight = this.naturalHeight * self.mNormalEntityImageScale;
				var marginLeft = (parent.innerWidth() - newWidth + offsets.imageOffsetX) / 2;
				var marginTop = (/*parent.innerHeight()*/ 130 - newHeight + offsets.imageOffsetY) / 2;

				$(this).css({ 'width': newWidth, 'margin-left': marginLeft, 'margin-top': marginTop });
				$(this).data('placeholder').css({ 'width': newWidth, 'margin-left': marginLeft, 'margin-top': marginTop });
			}
			else if ($(this).data('is-scaling') !== true) {
				// NOTE: (js) Das Bild per "Hand" um n-% verkleiner und in seinem Parent zentrieren, da es per CSS ned wirklich funktionieren wollte..
				var offsets = $(this).data('offsets') || { imageOffsetX: 0, imageOffsetY: 0 };
				var parent = $(this).parent();
				var newWidth = this.naturalWidth;
				var newHeight = this.naturalHeight;
				var marginLeft = (parent.innerWidth() - newWidth + offsets.imageOffsetX) / 2;
				var marginTop = (/*parent.innerHeight()*/ 130 - newHeight + offsets.imageOffsetY) / 2;

				$(this).css({ 'width': newWidth, 'margin-left': marginLeft, 'margin-top': marginTop });
				$(this).data('placeholder').css({ 'width': newWidth, 'margin-left': marginLeft, 'margin-top': marginTop });
			}

			$(this).data('placeholder').addClass('opacity-almost-none');
			$(this).data('placeholder').attr('src', $(this).attr('src'));
		});

		// bind tooltip
		entityImageLayer.bindTooltip({ contentType: 'entity', entityId: _entityId, yOffset: -10 });

		// bind event handler
		entityImage.mouseenter(this, this.mEntityMouseEnterCallback);
		entityImage.mouseleave(this, this.mEntityMouseLeaveCallback);
		entityImage.click(this, this.mEntityClickedCallback);

		// create selected layer & image
		var entitySelectedLayer = $('<div class="selected-layer"/>');
		entityContainer.append(entitySelectedLayer);
		var selectedImage = $('<img/>');
		selectedImage.css({ opacity: 0 });
		selectedImage.attr('src', Path.GFX + Asset.IMAGE_ENTITY_SELECTION_ARROW);
		entitySelectedLayer.append(selectedImage);
	}

	return entity;
};

TacticalScreenTurnSequenceBarModule.prototype.addSkillToList = function (_entity, _skill, _label) {
	var bottom = 0.0 + Math.floor((_label - 0) / 8) * 4.7;
	var left = 11.0 + ((_label - 0) - Math.floor((_label - 0) / 8) * 7) * 4.2;

	var skillContainerLayout = $('<div class="l-skill"></div>');
	skillContainerLayout.css({ 'left': left + 'rem', 'bottom': bottom + 'rem' });
	this.mSkillsContainer.append(skillContainerLayout);

	// bind tooltip
	skillContainerLayout.bindTooltip({ contentType: 'skill', entityId: _entity.id, skillId: _skill.id });

	var skillContainer = $('<div class="skill"></div>');
	skillContainerLayout.append(skillContainer);
	skillContainer.data('skill', { entityId: _entity.id, skillId: _skill.id, 'selected-by-backend': false });

	// create image
	var imageLayer = $('<div class="image-layer"></div>');
	skillContainer.append(imageLayer);
	var image = $('<img/>');
	image.attr('src', Path.GFX + _skill.imagePath);
	imageLayer.append(image);

	// bind event handler
	var self = this;
	skillContainer.click(this, function (_event) {
		var self = _event.data;
		var data = $(this).data('skill');
		self.notifyBackendEntitySkillClicked(data.entityId, data.skillId);
	});

	skillContainer.bind("contextmenu", this, function (_event) {
		var self = _event.data;
		var data = $(this).data('skill');
		self.notifyBackendEntitySkillCancelClicked(data.entityId, data.skillId);
		return false;
	});

	// only add click & hover handler if the skill is usable
	if (_skill.isUsable) {
		skillContainer.mouseenter(this, function (_event) {
			//var self = _event.data;
			var data = $(this).data('skill');
			if (data['selected-by-backend'] === false) {
				$(this).removeClass('is-selected').addClass('is-selected');
			}
		});
		skillContainer.mouseleave(this, function (_event) {
			//var self = _event.data;
			var data = $(this).data('skill');
			if (data['selected-by-backend'] === false) {
				$(this).removeClass('is-selected');
			}
		});
	}

	// create label (numeration)
	if (_label == 10)
		_label = 0;

	if (_label < 10) {
		var textLayer = $('<div class="text-layer"></div>');
		skillContainer.append(textLayer);
		var label = $('<div class="numeration-label text-font-very-small font-bold font-color-numeration-label"></div>');
		label.html(_label);
		textLayer.append(label);
	}

	// create overlay & image div
	var overlayLayer = $('<div class="overlay-layer"></div>');
	skillContainer.append(overlayLayer);
	var overlayImage = $('<img/>');
	overlayImage.attr('src', Path.GFX + Asset.IMAGE_SKILL_NOT_USABLE);
	overlayImage.css({ opacity: 0 });
	overlayLayer.append(overlayImage);
};

TacticalScreenTurnSequenceBarModule.prototype.addStatusEffectToList = function (_entity, _statusEffect) {
	var statusEffectLayout = $('<div class="l-status-effect"></div>');
	this.mStatusEffectsContainer.append(statusEffectLayout);

	var statusEffect = $('<div class="status-effect"></div>');
	statusEffectLayout.append(statusEffect);
	statusEffect.data('status-effect', { entityId: _entity.id, statusEffectId: _statusEffect.id });

	// bind tooltip
	statusEffectLayout.bindTooltip({ contentType: 'status-effect', entityId: _entity.id, statusEffectId: _statusEffect.id });

	var statusImage = $('<img/>');
	statusImage.attr('src', Path.GFX + _statusEffect.imagePath);
	statusEffect.append(statusImage);
};


TacticalScreenTurnSequenceBarModule.prototype.createEntityCallbacks = function () {
	// store callbacks so we can remove them later
	this.mEntityMouseEnterCallback = function (_event) {
		var self = _event.data;
		var data = $(this).data('entity');
		self.notifyBackendEntityMouseEnter(data.id);
	};

	this.mEntityMouseLeaveCallback = function (_event) {
		var self = _event.data;
		var data = $(this).data('entity');
		self.notifyBackendEntityMouseLeave(data.id);
	};

	this.mEntityClickedCallback = function (_event) {
		var self = _event.data;
		var data = $(this).data('entity');
		self.notifyBackendEntityClicked(data.id);
	};
};


TacticalScreenTurnSequenceBarModule.prototype.bindTooltips = function () {
	this.mEndTurnAllButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.TacticalScreen.TurnSequenceBarModule.EndTurnAllButton });
	this.mEndTurnButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.TacticalScreen.TurnSequenceBarModule.EndTurnButton });
	this.mWaitTurnButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.TacticalScreen.TurnSequenceBarModule.WaitTurnButton });
	this.mOpenInventoryButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.TacticalScreen.TurnSequenceBarModule.OpenInventoryButton });

	$.each(this.mLeftStatsRows, function (_key, _value) {
		_value.Row.bindTooltip({ contentType: 'ui-element', elementId: _value.TooltipId });
	});
	$.each(this.mRightStatsRows, function (_key, _value) {
		_value.Row.bindTooltip({ contentType: 'ui-element', elementId: _value.TooltipId });
	});
};

TacticalScreenTurnSequenceBarModule.prototype.unbindTooltips = function () {
	this.mEndTurnAllButton.unbindTooltip();
	this.mEndTurnButton.unbindTooltip();
	this.mWaitTurnButton.unbindTooltip();
	this.mOpenInventoryButton.unbindTooltip();

	$.each(this.mLeftStatsRows, function (_key, _value) {
		_value.Row.unbindTooltip();
	});
	$.each(this.mRightStatsRows, function (_key, _value) {
		_value.Row.unbindTooltip();
	});
};


TacticalScreenTurnSequenceBarModule.prototype.setupEventHandler = function () {
	this.mEndTurnButton.unbind('click');
	this.mEndTurnButton.click(this, function (_event) {
		var self = _event.data;
		self.notifyBackendNextTurnButtonPressed();
	});

	this.mWaitTurnButton.unbind('click');
	this.mWaitTurnButton.click(this, function (_event) {
		var self = _event.data;
		self.notifyBackendWaitTurnButtonPressed();
	});

	this.mOpenInventoryButton.unbind('click');
	this.mOpenInventoryButton.click(this, function (_event) {
		var self = _event.data;
		self.notifyBackendOpenInventoryButtonPressed();
	});
};


TacticalScreenTurnSequenceBarModule.prototype.create = function (_parentDiv) {
	this.createEntityCallbacks();
	this.createDIV(_parentDiv);
	this.bindTooltips();

	// hide the stats panel
	this.showStatsPanel(false, true);
};

TacticalScreenTurnSequenceBarModule.prototype.destroy = function () {
	this.unbindTooltips();
	this.destroyDIV();
};


TacticalScreenTurnSequenceBarModule.prototype.register = function (_parentDiv) {
	console.log('TacticalScreenTurnSequenceBarModule::REGISTER');

	if (this.mContainer !== null) {
		console.error('ERROR: Failed to register TurnSequenceBar Module. Reason: TurnSequenceBar Module is already initialized.');
		return;
	}

	if (_parentDiv !== null && typeof (_parentDiv) == 'object') {
		this.create(_parentDiv);
	}
};

TacticalScreenTurnSequenceBarModule.prototype.unregister = function () {
	console.log('TacticalScreenTurnSequenceBarModule::UNREGISTER');

	if (this.mContainer === null) {
		console.error('ERROR: Failed to unregister TurnSequenceBar Module. Reason: TurnSequenceBar Module is not initialized.');
		return;
	}

	this.destroy();
};

TacticalScreenTurnSequenceBarModule.prototype.isRegistered = function () {
	if (this.mContainer !== null) {
		return this.mContainer.parent().length !== 0;
	}

	return false;
};


TacticalScreenTurnSequenceBarModule.prototype.registerEventListener = function (_listener) {
	this.mEventListener = _listener;
};


TacticalScreenTurnSequenceBarModule.prototype.show = function (_delay) {
	var self = this;
	this.mContainer.removeClass('display-none').addClass('display-block');
	this.mContainer.velocity("finish", true).velocity({ bottom: '2.6rem' },
		{
			duration: _delay,
			easing: 'swing',
			begin: function () {
				$(this).removeClass('display-none').addClass('display-block');
			}
		});
};

TacticalScreenTurnSequenceBarModule.prototype.hide = function (_delay) {
	var targetOffset = this.mContainer.offset();
	var parentHeight = this.mContainer.parent().height();
	var offset = parentHeight - targetOffset.top;

	this.mContainer.velocity("finish", true).velocity({ bottom: (-offset) + 'px' },
		{
			duration: _delay,
			easing: 'swing',
			begin: function () {
				$(this).removeClass('display-block').addClass('display-none');
			}
		});
};

/**
 *	Enable/Disable the End Turn Button
**/
/*
TacticalScreenTurnSequenceBarModule.prototype.enableNextTurnButton = function (_enable)
{
	this.mEndTurnButton.unbind('click');
	if (_enable)
	{
		this.mEndTurnButton.removeAttr('disabled');
		this.mEndTurnButton.click(this, function(_event) {
			var self = _event.data;
			self.notifyBackendNextTurnButtonPressed();
		});
	}
	else
	{
		this.mEndTurnButton.attr('disabled', true);
	}
};
*/

/**
 *	Enable/Disable the Pause Turn Button
**/
/*
TacticalScreenTurnSequenceBarModule.prototype.enablePauseTurnButton = function (_enable)
{
	this.mWaitTurnButton.unbind('click');
	if (_enable)
	{
		this.mWaitTurnButton.removeAttr('disabled');
		this.mWaitTurnButton.click(this, function(_event) {
			var self = _event.data;
			self.notifyBackendWaitTurnButtonPressed();
		});
	}
	else
	{
		this.mWaitTurnButton.attr('disabled', true);
	}
};
*/


TacticalScreenTurnSequenceBarModule.prototype.showButton = function (_button, _show) {
	if (_show === true) {
		if (_button.hasClass('display-none')) {
			//_button.css({opacity: 0});
			_button.removeClass('display-none').addClass('display-block');
			_button.velocity("finish", true).velocity({ opacity: 1 },
				{
					duration: this.mStatsPanelFadeInTime,
					easing: 'swing'
				});
		}
	}
	else {
		if (_button.hasClass('display-block')) {
			//_button.css({opacity: 1});
			_button.velocity("finish", true).velocity({ opacity: 0 },
				{
					duration: this.mStatsPanelFadeOutTime,
					easing: 'swing',
					complete: function () {
						$(this).removeClass('display-block').addClass('display-none');
					}
				});
		}
	}
};


TacticalScreenTurnSequenceBarModule.prototype.findEntityDIV = function (_entityId) {
	var result = null;

	this.mEntitySliderContainer.find('.l-entity').each(function (index, element) {
		var entityDIV = $(element);
		var entity = entityDIV.data('entity');

		if (entity !== null && 'id' in entity) {
			if (entity.id === _entityId) {
				result = { div: entityDIV, index: index };
				return false;
			}
		}
	});

	return result;
};

TacticalScreenTurnSequenceBarModule.prototype.searchIndexRange = function (_index) {
	var result = { before: null, after: null };

	this.mEntitySliderContainer.find('.l-entity').each(function (index, element) {
		var entityDIV = $(element);

		if (entityDIV.length > 0 && (index + 1) === _index) {
			result.before = entityDIV;
			result.after = entityDIV.next();
			if (result.after.length === 0) {
				result.after = null;
			}
			return false;
		}
	});

	return result;
};

TacticalScreenTurnSequenceBarModule.prototype.searchSkillDIV = function (_skill) {
	var result = null;

	this.mSkillsContainer.find('.skill').each(function (index, element) {
		var skillDIV = $(element);
		var skill = skillDIV.data('skill');

		if (skill !== null && 'skillId' in skill) {
			if (skill.skillId === _skill.id) {
				result = { div: skillDIV, index: index };
				return false;
			}
		}
	});

	return result;
};

TacticalScreenTurnSequenceBarModule.prototype.searchSelectedSkillDIV = function () {
	var result = null;

	this.mSkillsContainer.find('.skill').each(function (index, element) {
		var skillDIV = $(element);
		if (skillDIV.length > 0 && skillDIV.hasClass('is-selected')) {
			result = { div: skillDIV, index: index };
			return false;
		}
	});

	return result;
};


TacticalScreenTurnSequenceBarModule.prototype.selectFirstEntity = function (_entity, _entityDIV, _previousEntityWasHiddenToPlayer, _retryCount) {
	// notify sq that a new entity went into the first slot
	// +  query entity data from sq backend
	var self = this;
	var retryCount = (_retryCount === undefined) ? 0 : _retryCount;
    var maxRetries = 10;

	this.notifyBackendEntityEntersFirstSlot(_entity.id, function (entityData) {
		if (entityData === null || entityData === undefined) {
			if (retryCount < maxRetries) {
				console.error('ERROR: Failed to query entity data for entity (' + _entity.id + '). Reason: Invalid result. Retrying...');
				setTimeout(function () { self.selectFirstEntity(_entity, _entityDIV, _previousEntityWasHiddenToPlayer, ++retryCount); }, 100);
			}
			else{
				console.error('ERROR: Failed to query entity data for entity (' + _entity.id + '). Reason: Invalid result. Removing the entity from the sequence bar and moving to the next one...');
				self.notifyBackendForceRemoveInvalidEntity(_entity.id);
			}
			return;
		}

		// update the visible to player attribute
		self.updateEntityVisiblity(entityData, _entityDIV);

		// update image
		self.updateEntityImage(entityData, _entityDIV);

		// remove possible selection mark
		self.selectEntity({ id: _entity.id, select: false });

		// update all related controls
		self.updateButtonBar(entityData);
		self.updateStatsPanel(entityData);
		self.updateEntitySkills(entityData);
		self.updateEntityStatusEffects(entityData);

		// update & resize image and keep aligned
		var entityImageLayer = _entityDIV.find('.image-layer:first');
		var entityImage = _entityDIV.find('img:first');
		entityImage.data('is-first', true);
		entityImage.data('is-scaling', true);

		// remove event handler
		entityImage.off('mouseenter', self.mEntityMouseEnterCallback);
		entityImage.off('mouseleave', self.mEntityMouseLeaveCallback);

		// resize first slot div - only if the entity is visible to the player - otherwise we wanna speed things up for the player
		//if (_entityDIV.attr('is-hidden-to-player') !== 'true')
		{
			var resizeFirstSlotTime = (_entityDIV.attr('is-hidden-to-player') === 'true' || _previousEntityWasHiddenToPlayer) ? self.mResizeFirstSlotTimeIfPreviousWasHiddenToPlayer : self.mResizeFirstSlotTime;
			_entityDIV.velocity({ width: '10.4rem' },
				{
					duration: resizeFirstSlotTime,
					easing: 'swing',
					complete: function () {
						// NOTE: (js) Hier zentrieren wir die Image per "Hand"...

						var retries = 0;
						var checkDataAndAnimate = function () {
							var offsets = entityImage.data('offsets') || { imageOffsetX: 0, imageOffsetY: 0 };
							var newWidth = entityImage[0].naturalWidth;
							var newHeight = entityImage[0].naturalHeight;
							if (newWidth === 0 && retries < 5) {
								retries++;
								setTimeout(checkDataAndAnimate, 10);
								return;
							}
							if (newWidth === 0) newWidth = 120;
							if (newHeight === 0) newHeight = 120;
							var marginLeft = (entityImageLayer.innerWidth() - newWidth + offsets.imageOffsetX) / 2;;
							var marginTop = (entityImageLayer.innerHeight() - newHeight + offsets.imageOffsetY) / 2;

							//console.info('w: ' + newWidth + ' h: ' + newHeight);
							//entityImage.css({ 'width': newWidth, 'margin-left': marginLeft, 'margin-top': marginTop});

							entityImage.data('placeholder').velocity({ 'width': newWidth, 'margin-left': marginLeft, 'margin-top': marginTop },
								{
									duration: self.mResizeFirstSlotImageTime,
									easing: 'swing',
									complete: function () {
									}
								});

							entityImage.velocity({ 'width': newWidth, 'margin-left': marginLeft, 'margin-top': marginTop },
								{
									duration: self.mResizeFirstSlotImageTime,
									easing: 'swing',
									complete: function () {
										var placeholder = entityImage.data('placeholder');
										if (placeholder) {
											entityImage.data('placeholder').css({ 'width': newWidth, 'margin-left': marginLeft, 'margin-top': marginTop });
										}
										entityImage.data('is-scaling', false);

										var newImage = entityImage.data('newImage') || false;
										if (newImage !== false) {
											if (placeholder) {
												placeholder.removeClass('opacity-almost-none');
											}
											entityImage.attr('src', newImage);
											entityImage.data('newImage', false);
										}

										// notify sq that a new turn image resize animation has ended
										self.notifyBackendEntityEnteredFirstSlotFully(_entity.id);
									}
								});
						};
						// notify sq that a new turn slot resize animation has ended
						// Note: (js) we do this here to speed up the process of sliden through AI entities
						checkDataAndAnimate();
						self.notifyBackendEntityEnteredFirstSlot(_entity.id);
					}
				});
		}
		// 	else
		// 	{
		// 		// notify sq that a new entity has entered the first slot
		// 		this.notifyBackendEntityEnteredFirstSlot(_entity.id);
		// 		// notify sq that a new turn image resize animation has ended
		// 		this.notifyBackendEntityEnteredFirstSlotFully(_entity.id);
		// 	}
	});
};


TacticalScreenTurnSequenceBarModule.prototype.updateStatsPanel = function (_data) {
	if (_data === null || typeof (_data) != 'object') {
		return;
	}

	// show or hide the stats panel
	var isEnemy = false;
	if ('isEnemy' in _data) {
		isEnemy = _data.isEnemy;
	}

	// only update stats if the entity is NOT an enemy as the panel will not be shown otherwise
	this.showStatsPanel(!isEnemy);
	if (!isEnemy) {
		// update high level image
		if ('levelImagePath' in _data && _data.levelImagePath != '') {
			this.mStatsHeaderElevationImage.attr('src', Path.GFX + _data.levelImagePath);
		}

		// update name
		if ('nameOnly' in _data) {
			this.mStatsHeaderCharacterName.html(_data.nameOnly);
		}


		// LEFT ROW
		// ************************************************************************************************************************

		// update action points
		var newWidth = 0;
		if (ProgressbarValueIdentifier.ActionPoints in _data && ProgressbarValueIdentifier.ActionPointsMax in _data) {
			newWidth = 0;
			if (_data[ProgressbarValueIdentifier.ActionPointsMax] > 0) {
				newWidth = (_data[ProgressbarValueIdentifier.ActionPoints] * 100) / _data[ProgressbarValueIdentifier.ActionPointsMax];
				newWidth = Math.max(Math.min(newWidth, 100), 0);
			}
			this.mLeftStatsRows.ActionPoints.Progressbar.velocity("stop", true).velocity({ 'width': newWidth + '%' }, { duration: this.mProgressbarMovementDuration });
			this.mLeftStatsRows.ActionPoints.ProgressbarPreview.velocity("stop", true).velocity({ 'width': newWidth + '%' }, { duration: this.mProgressbarMovementDuration });
			if (ProgressbarValueIdentifier.ActionPointsLabel in _data)
				this.mLeftStatsRows.ActionPoints.ProgressbarLabel.html(_data[ProgressbarValueIdentifier.ActionPointsLabel]);
			else
				this.mLeftStatsRows.ActionPoints.ProgressbarLabel.html(_data[ProgressbarValueIdentifier.ActionPoints] + ' / ' + _data[ProgressbarValueIdentifier.ActionPointsMax]);
		}

		// update action points preview
		if (ProgressbarValueIdentifier.ActionPointsPreview in _data && ProgressbarValueIdentifier.ActionPointsMaxPreview in _data) {
			newWidth = 0;
			if (_data[ProgressbarValueIdentifier.ActionPointsMaxPreview] > 0) {
				newWidth = (_data[ProgressbarValueIdentifier.ActionPointsPreview] * 100) / _data[ProgressbarValueIdentifier.ActionPointsMaxPreview];
				newWidth = Math.max(Math.min(newWidth, 100), 0);
			}
			this.mLeftStatsRows.ActionPoints.ProgressbarPreview.velocity("stop", true).velocity({ 'width': newWidth + '%' }, { duration: this.mProgressbarMovementDuration });

			if (ProgressbarValueIdentifier.ActionPointsLabel in _data)
				this.mLeftStatsRows.ActionPoints.ProgressbarLabel.html(_data[ProgressbarValueIdentifier.ActionPointsLabel]);
			else
				this.mLeftStatsRows.ActionPoints.ProgressbarLabel.html(_data[ProgressbarValueIdentifier.ActionPointsPreview] + ' / ' + _data[ProgressbarValueIdentifier.ActionPointsMaxPreview]);
		}

		// update morale
		if (ProgressbarValueIdentifier.Morale in _data && ProgressbarValueIdentifier.MoraleMax in _data) {
			newWidth = 0;
			if (_data[ProgressbarValueIdentifier.MoraleMax] > 0) {
				newWidth = (_data[ProgressbarValueIdentifier.Morale] * 100) / _data[ProgressbarValueIdentifier.MoraleMax];
				newWidth = Math.max(Math.min(newWidth, 100), 0);
			}
			this.mLeftStatsRows.Morale.Progressbar.velocity("stop", true).velocity({ 'width': newWidth + '%' }, { duration: this.mProgressbarMovementDuration });
			this.mLeftStatsRows.Morale.ProgressbarPreview.velocity("stop", true).velocity({ 'width': newWidth + '%' }, { duration: this.mProgressbarMovementDuration });

			if (ProgressbarValueIdentifier.MoraleLabel in _data)
				this.mLeftStatsRows.Morale.ProgressbarLabel.html(_data[ProgressbarValueIdentifier.MoraleLabel]);
			else
				this.mLeftStatsRows.Morale.ProgressbarLabel.html(_data[ProgressbarValueIdentifier.Morale] + ' / ' + _data[ProgressbarValueIdentifier.MoraleMax]);
		}

		// update fatigue
		if (ProgressbarValueIdentifier.Fatigue in _data && ProgressbarValueIdentifier.FatigueMax in _data) {
			newWidth = 0;
			if (_data[ProgressbarValueIdentifier.FatigueMax] > 0) {
				newWidth = (_data[ProgressbarValueIdentifier.Fatigue] * 100) / _data[ProgressbarValueIdentifier.FatigueMax];
				newWidth = Math.max(Math.min(newWidth, 100), 0);
			}
			this.mLeftStatsRows.Fatigue.Progressbar.velocity("stop", true).velocity({ 'width': newWidth + '%' }, { duration: this.mProgressbarMovementDuration });
			this.mLeftStatsRows.Fatigue.ProgressbarPreview.velocity("stop", true).velocity({ 'width': newWidth + '%' }, { duration: this.mProgressbarMovementDuration });

			if (ProgressbarValueIdentifier.FatigueLabel in _data)
				this.mLeftStatsRows.Fatigue.ProgressbarLabel.html(_data[ProgressbarValueIdentifier.FatigueLabel]);
			else
				this.mLeftStatsRows.Fatigue.ProgressbarLabel.html(_data[ProgressbarValueIdentifier.Fatigue] + ' / ' + _data[ProgressbarValueIdentifier.FatigueMax]);
		}

		// update fatigue preview
		if (ProgressbarValueIdentifier.FatiguePreview in _data && ProgressbarValueIdentifier.FatigueMaxPreview in _data) {
			newWidth = 0;
			if (_data[ProgressbarValueIdentifier.FatigueMaxPreview] > 0) {
				newWidth = (_data[ProgressbarValueIdentifier.FatiguePreview] * 100) / _data[ProgressbarValueIdentifier.FatigueMaxPreview];
				newWidth = Math.max(Math.min(newWidth, 100), 0);
			}
			this.mLeftStatsRows.Fatigue.ProgressbarPreview.velocity("stop", true).velocity({ 'width': newWidth + '%' }, { duration: this.mProgressbarMovementDuration });

			if (ProgressbarValueIdentifier.FatigueLabel in _data)
				this.mLeftStatsRows.Fatigue.ProgressbarLabel.html(_data[ProgressbarValueIdentifier.FatigueLabel]);
			else
				this.mLeftStatsRows.Fatigue.ProgressbarLabel.html(_data[ProgressbarValueIdentifier.FatiguePreview] + ' / ' + _data[ProgressbarValueIdentifier.FatigueMaxPreview]);
		}


		// RIGHT ROW
		// ************************************************************************************************************************

		// update hit points
		if (ProgressbarValueIdentifier.Hitpoints in _data && ProgressbarValueIdentifier.HitpointsMax in _data) {
			newWidth = 0;
			if (_data[ProgressbarValueIdentifier.HitpointsMax] > 0) {
				newWidth = (_data[ProgressbarValueIdentifier.Hitpoints] * 100) / _data[ProgressbarValueIdentifier.HitpointsMax];
				newWidth = Math.max(Math.min(newWidth, 100), 0);
			}
			this.mRightStatsRows.Hitpoints.Progressbar.velocity("stop", true).velocity({ 'width': newWidth + '%' }, { duration: this.mProgressbarMovementDuration });
			this.mRightStatsRows.Hitpoints.ProgressbarPreview.velocity("stop", true).velocity({ 'width': newWidth + '%' }, { duration: this.mProgressbarMovementDuration });

			if (ProgressbarValueIdentifier.HitpointsLabel in _data)
				this.mRightStatsRows.Hitpoints.ProgressbarLabel.html('' + _data[ProgressbarValueIdentifier.HitpointsLabel]);
			else
				this.mRightStatsRows.Hitpoints.ProgressbarLabel.html(_data[ProgressbarValueIdentifier.Hitpoints] + ' / ' + _data[ProgressbarValueIdentifier.HitpointsMax]);
		}

		// update armor head
		if (ProgressbarValueIdentifier.ArmorHead in _data && ProgressbarValueIdentifier.ArmorHeadMax in _data) {
			newWidth = 0;
			if (_data[ProgressbarValueIdentifier.ArmorHeadMax] > 0) {
				newWidth = (_data[ProgressbarValueIdentifier.ArmorHead] * 100) / _data[ProgressbarValueIdentifier.ArmorHeadMax];
				newWidth = Math.max(Math.min(newWidth, 100), 0);
			}
			this.mRightStatsRows.ArmorHead.Progressbar.velocity("stop", true).velocity({ 'width': newWidth + '%' }, { duration: this.mProgressbarMovementDuration });
			this.mRightStatsRows.ArmorHead.ProgressbarPreview.velocity("stop", true).velocity({ 'width': newWidth + '%' }, { duration: this.mProgressbarMovementDuration });

			if (ProgressbarValueIdentifier.ArmorHeadLabel in _data)
				this.mRightStatsRows.ArmorHead.ProgressbarLabel.html(_data[ProgressbarValueIdentifier.ArmorHeadLabel]);
			else
				this.mRightStatsRows.ArmorHead.ProgressbarLabel.html(_data[ProgressbarValueIdentifier.ArmorHead] + ' / ' + _data[ProgressbarValueIdentifier.ArmorHeadMax]);
		}

		// update armor body
		if (ProgressbarValueIdentifier.ArmorBody in _data && ProgressbarValueIdentifier.ArmorBodyMax in _data) {
			newWidth = 0;
			if (_data[ProgressbarValueIdentifier.ArmorBodyMax] > 0) {
				newWidth = (_data[ProgressbarValueIdentifier.ArmorBody] * 100) / _data[ProgressbarValueIdentifier.ArmorBodyMax];
				newWidth = Math.max(Math.min(newWidth, 100), 0);

			}
			this.mRightStatsRows.ArmorBody.Progressbar.velocity("stop", true).velocity({ 'width': newWidth + '%' }, { duration: this.mProgressbarMovementDuration });
			this.mRightStatsRows.ArmorBody.ProgressbarPreview.velocity("stop", true).velocity({ 'width': newWidth + '%' }, { duration: this.mProgressbarMovementDuration });

			if (ProgressbarValueIdentifier.ArmorBodyLabel in _data)
				this.mRightStatsRows.ArmorBody.ProgressbarLabel.html(_data[ProgressbarValueIdentifier.ArmorBodyLabel]);
			else
				this.mRightStatsRows.ArmorBody.ProgressbarLabel.html(_data[ProgressbarValueIdentifier.ArmorBody] + ' / ' + _data[ProgressbarValueIdentifier.ArmorBodyMax]);
		}
	}
};


TacticalScreenTurnSequenceBarModule.prototype.updateButtonBar = function (_entityData) {
	if (_entityData === null || typeof (_entityData) !== 'object') {
		return;
	}

	if ('isWaitActionSpent' in _entityData) {
		//this.showButton(this.mWaitTurnButton, !_entityData.isWaitActionSpent);
		this.mWaitTurnButton.enableButton(!_entityData.isWaitActionSpent);
	}
};


TacticalScreenTurnSequenceBarModule.prototype.showStatsPanel = function (_show, _instant) {
	var showStatusEffectbarContainer = this.mStatusEffectsContainer.children().length > 0 && _show;

	if (_instant !== undefined && typeof (_instant) == 'boolean') {
		this.mStatsContainer.css({ opacity: _show ? 1 : 0 });
		//this.mEndTurnButton.css({ opacity: _show ? 1 : 0 });
		//this.mWaitTurnButton.css({ opacity: _show ? 1 : 0 });
		this.mWaitTurnButtonContainer.css({ opacity: _show ? 1 : 0 });
		this.mEndTurnButtonContainer.css({ opacity: _show ? 1 : 0 });
		this.mEndTurnAllButtonContainer.css({ opacity: _show ? 1 : 0 });
		this.mStatusEffectsContainer.css({ opacity: showStatusEffectbarContainer ? 1 : 0 });
		this.mSkillsContainer.css({ opacity: _show ? 1 : 0 });

		if (_show) this.mStatsContainer.removeClass('display-none').addClass('display-block');
		else this.mStatsContainer.addClass('display-none').removeClass('display-block');

		if (_show) this.mWaitTurnButtonContainer.removeClass('display-none').addClass('display-block');
		else this.mWaitTurnButtonContainer.addClass('display-none').removeClass('display-block');

		if (_show) this.mEndTurnButtonContainer.removeClass('display-none').addClass('display-block');
		else this.mEndTurnButtonContainer.addClass('display-none').removeClass('display-block');

		if (_show) this.mEndTurnAllButtonContainer.removeClass('display-none').addClass('display-block');
		else this.mEndTurnAllButtonContainer.addClass('display-none').removeClass('display-block');

		if (_show) this.mStatusEffectsContainer.removeClass('display-none').addClass('display-block');
		else this.mStatusEffectsContainer.addClass('display-none').removeClass('display-block');

		if (_show) this.mSkillsContainer.removeClass('display-none').addClass('display-block');
		else this.mSkillsContainer.addClass('display-none').removeClass('display-block');
	}
	else {
		this.mStatsContainer.velocity("finish", true).velocity({ opacity: _show ? 1 : 0 },
			{
				duration: _show ? this.mStatsPanelFadeInTime : this.mStatsPanelFadeOutTime,
				easing: 'swing',
				begin: function () {
					if (_show)
						$(this).removeClass('display-none').addClass('display-block');
				},
				complete: function () {
					if (!_show)
						$(this).removeClass('display-block').addClass('display-none');
				}
			});

		/*this.mEndTurnButton.velocity("finish", true).velocity({ opacity: _show ? 1 : 0 },
		{
			duration: _show ? this.mStatsPanelFadeInTime : this.mStatsPanelFadeOutTime,
			easing: 'swing'
		});

		this.mWaitTurnButton.velocity("finish", true).velocity({ opacity: _show ? 1 : 0 },
		{
			duration: _show ? this.mStatsPanelFadeInTime : this.mStatsPanelFadeOutTime,
			easing: 'swing'
		});*/

		this.mEndTurnButtonContainer.velocity("finish", true).velocity({ opacity: _show ? 1 : 0 },
			{
				duration: _show ? this.mStatsPanelFadeInTime : this.mStatsPanelFadeOutTime,
				easing: 'swing',
				begin: function () {
					if (_show)
						$(this).removeClass('display-none').addClass('display-block');
				},
				complete: function () {
					if (!_show)
						$(this).removeClass('display-block').addClass('display-none');
				}
			});

		this.mEndTurnAllButtonContainer.velocity("finish", true).velocity({ opacity: _show ? 1 : 0 },
			{
				duration: _show ? this.mStatsPanelFadeInTime : this.mStatsPanelFadeOutTime,
				easing: 'swing',
				begin: function () {
					if (_show)
						$(this).removeClass('display-none').addClass('display-block');
				},
				complete: function () {
					if (!_show)
						$(this).removeClass('display-block').addClass('display-none');
				}
			});

		this.mWaitTurnButtonContainer.velocity("finish", true).velocity({ opacity: _show ? 1 : 0 },
			{
				duration: _show ? this.mStatsPanelFadeInTime : this.mStatsPanelFadeOutTime,
				easing: 'swing',
				begin: function () {
					if (_show)
						$(this).removeClass('display-none').addClass('display-block');
				},
				complete: function () {
					if (!_show)
						$(this).removeClass('display-block').addClass('display-none');
				}
			});

		// check if there is any effect within the container
		this.mStatusEffectsContainer.velocity("finish", true).velocity({ opacity: showStatusEffectbarContainer ? 1 : 0 },
			{
				duration: _show ? this.mStatsPanelFadeInTime : this.mStatsPanelFadeOutTime,
				easing: 'swing',
				begin: function () {
					if (_show)
						$(this).removeClass('display-none').addClass('display-block');
				},
				complete: function () {
					if (!_show)
						$(this).removeClass('display-block').addClass('display-none');
				}
			});

		this.mSkillsContainer.velocity("finish", true).velocity({ opacity: _show ? 1 : 0 },
			{
				duration: _show ? this.mStatsPanelFadeInTime : this.mStatsPanelFadeOutTime,
				easing: 'swing',
				begin: function () {
					if (_show)
						$(this).removeClass('display-none').addClass('display-block');
				},
				complete: function () {
					if (!_show)
						$(this).removeClass('display-block').addClass('display-none');
				}
			});
	}
};


TacticalScreenTurnSequenceBarModule.prototype.updateEntitySkills = function (_entityData) {
	// notify each skill that it is about to get deleted - hide the tooltip
	this.notifySkillTooltipsToHide();

	// sanity check
	if (_entityData === null || typeof (_entityData) != 'object' || !('id' in _entityData)) {
		console.error('ERROR: Failed to update entity skills. Reason: Entity has no id.');
		return;
	}

	// show or hide the stats panel
	var isEnemy = false;
	if ('isEnemy' in _entityData) {
		isEnemy = _entityData.isEnemy;
	}

	if (!isEnemy) {
		// query entity skill data from sq backend
		var self = this;
		this.notifyBackendQueryEntitySkills(_entityData.id, function (entitySkills) {
			if (entitySkills === null || !jQuery.isArray(entitySkills) || entitySkills.length === 0) {
				self.showEntitySkillbar(false);
				return;
			}

			// remove current skills
			var wasEmpty = self.mSkillsContainer.find('.l-skill').size() === 0;
			if (entitySkills.length > 0) {
				self.mSkillsContainer.empty();
			}

			// add new skills
			for (var i = 0; i < entitySkills.length; ++i) {
				self.addSkillToList(_entityData, entitySkills[i], i + 1);
			}

			// prepare to fade in
			if (wasEmpty && entitySkills.length > 0) {
				self.mSkillsContainer.css({ opacity: 0 });
			}

			// show skillbar
			self.showEntitySkillbar(entitySkills.length > 0);
		});
	}
	else {
		// hide skillbar
		this.showEntitySkillbar(false);
	}
};


TacticalScreenTurnSequenceBarModule.prototype.updateEntitySkillsPreview = function (_entityId) {
	if (_entityId === null) {
		// TODO: Es wäre besser, wenn man hier dem Tooltip sagen könnte, dass er seinen Inhalt für den Skill neu laden soll!

		// reset skill preview
		var self = this;
		this.mSkillsContainer.find('.skill').each(function (index, element) {
			var skillDIV = $(element);
			if (skillDIV.length > 0) {
				var skillOverlayDiv = skillDIV.find('.overlay-layer:first');
				if (skillOverlayDiv.length > 0) {
					var skillOverlayImgDiv = skillOverlayDiv.children('img:first');
					if (skillOverlayImgDiv.length > 0) {
						skillOverlayImgDiv.velocity("finish", true).velocity({ opacity: 0 }, { duration: self.mSkillPreviewFadeOut });
					}
				}
			}
		});
	}
	else {
		// TODO: Es wäre besser, wenn man hier dem Tooltip sagen könnte, dass er seinen Inhalt für den Skill neu laden soll!

		// notify each skill that it is about to get deleted - hide the tooltip
		//this.notifySkillTooltipsToHide();

		// query entity skill data from sq backend
		var self = this;
		this.notifyBackendQueryEntitySkills(_entityId, function (entitySkills) {
			if (entitySkills === null || !jQuery.isArray(entitySkills) || entitySkills.length === 0) {
				console.error('ERROR: Failed to query entity skills data for entity (' + _entityId + '). Reason: Invalid result.');
				return;
			}

			// update every skill there is
			for (var i = 0; i < entitySkills.length; ++i) {
				var foundSkill = self.searchSkillDIV(entitySkills[i]);
				if (foundSkill !== null) {
					var isSkillSelected = foundSkill.div.hasClass('is-selected');
					var skillOverlayDiv = foundSkill.div.find('.overlay-layer:first');
					if (skillOverlayDiv.length > 0) {
						var skillOverlayImgDiv = skillOverlayDiv.children('img:first');
						if (skillOverlayImgDiv.length > 0) {
							if (entitySkills[i].isUsable) {
								if (!entitySkills[i].isAffordable && !isSkillSelected) {
									skillOverlayImgDiv.velocity("finish", true).velocity({ opacity: 1 }, { duration: self.mSkillPreviewFadeIn });
								}
								else {
									skillOverlayImgDiv.velocity("finish", true).velocity({ opacity: 0 }, { duration: self.mSkillPreviewFadeOut });
								}
							}
							else {
								skillOverlayImgDiv.velocity("finish", true).velocity({ opacity: 0 }, { duration: self.mSkillPreviewFadeOut });
							}
						}
					}
				}
			}
		});
	}
};


TacticalScreenTurnSequenceBarModule.prototype.notifySkillTooltipsToHide = function () {
	// notify each skill that it is about to get deleted - hide the tooltip
	this.mSkillsContainer.find('.l-skill').each(function (index, element) {
		var skill = $(element);
		if (skill.length > 0) {
			skill.unbindTooltip();
		}
	});
};


TacticalScreenTurnSequenceBarModule.prototype.showEntitySkillbar = function (_show) {
	if (!_show) {
		this.notifySkillTooltipsToHide();
	}

	var self = this;
	this.mSkillsContainer.velocity("finish", true).velocity({ opacity: _show ? 1 : 0 },
		{
			duration: _show ? this.mStatsPanelFadeInTime : this.mStatsPanelFadeOutTime,
			complete: function () {
				/*if (_show === false)
				{
					self.mSkillsContainer.empty();
				}*/
			}
		});
};


TacticalScreenTurnSequenceBarModule.prototype.updateEntityStatusEffects = function (_entityData) {
	// notify each status effect that he is about to get deleted - hide the tooltip
	this.notifyStatusEffectTooltipsToHide();

	// sanity check
	if (_entityData === null || typeof (_entityData) != 'object' || !('id' in _entityData)) {
		console.error('ERROR: Failed to update entity status effects. Reason: Entity has no id.');
		return;
	}

	// show or hide the stats panel
	var isEnemy = false;
	if ('isEnemy' in _entityData) {
		isEnemy = _entityData.isEnemy;
	}

	if (!isEnemy) {
		// query entity status effects data from sq backend
		var self = this;
		this.notifyBackendQueryEntityStatusEffects(_entityData.id, function (entityStatusEffects) {
			if (entityStatusEffects === null || !jQuery.isArray(entityStatusEffects) || entityStatusEffects.length === 0) {
				self.showEntityStatusEffectbar(false);
				return;
			}

			// remove current status effects
			var wasEmpty = self.mStatusEffectsContainer.find('.l-status-effect').size() === 0;
			if (entityStatusEffects.length > 0) {
				self.mStatusEffectsContainer.empty();
			}

			for (var i = 0; i < entityStatusEffects.length; ++i) {
				self.addStatusEffectToList(_entityData, entityStatusEffects[i]);
			}

			// prepare to fade in
			if (wasEmpty && entityStatusEffects.length > 0) {
				self.mStatusEffectsContainer.css({ opacity: 0 });
			}

			// show status effect bar
			self.showEntityStatusEffectbar(entityStatusEffects.length > 0);
		});
	}
	else {
		this.showEntityStatusEffectbar(false);
	}
};


TacticalScreenTurnSequenceBarModule.prototype.notifyStatusEffectTooltipsToHide = function () {
	// notify each status effect that he is about to get deleted - hide the tooltip
	this.mStatusEffectsContainer.find('.l-status-effect').each(function (index, element) {
		var statusEffect = $(element);
		if (statusEffect.length > 0) {
			statusEffect.unbindTooltip();
		}
	});
};


TacticalScreenTurnSequenceBarModule.prototype.showEntityStatusEffectbar = function (_show) {
	if (!_show) {
		this.notifyStatusEffectTooltipsToHide();
	}

	var self = this;
	this.mStatusEffectsContainer.velocity("finish", true).velocity({ opacity: _show ? 1 : 0 }, {
		duration: _show ? this.mStatsPanelFadeInTime : this.mStatsPanelFadeOutTime,
		complete: function () {
			if (_show === false) {
				self.mStatusEffectsContainer.empty();
			}
		}
	});
};


TacticalScreenTurnSequenceBarModule.prototype.enableFirstEntitySelection = function (_enable) {
	if (!_enable) {
		if (this.mFirstEntitySelectionTimer !== null) {
			clearInterval(this.mFirstEntitySelectionTimer);
			this.mFirstEntitySelectionTimer = null;
		}
	}
	else {
		if (this.mFirstEntitySelectionTimer === null) {
			var self = this;
			var firstSlotNormalSizeWidth = this.mFirstSlotNormalSizeEntityTemplate.outerWidth(true);
			var firstSlotFullSizeWidth = this.mFirstSlotFullSizeEntityTemplate.outerWidth(true);
			var firstSlotWidth = firstSlotFullSizeWidth;

			this.mFirstEntitySelectionTimer = setInterval(function () {
				var firstEntity = null;

				// find first element which is a candidate for the first slot
				self.mEntitySliderContainer.find('.l-entity').each(function (index, element) {
					firstEntity = $(element);
					if (firstEntity.length > 0 && !firstEntity.is('[in-removal]')) {
						return false;
					}
				});

				if (firstEntity !== null && firstEntity.length > 0) // && firstEntity.position().left < firstSlotWidth)
				{
					// check if there is a previous one and if it is hidden to the player as the div is not resized to first slot size
					var prevEntityWasHiddenToPlayer = false;
					var prevDiv = firstEntity.prev();
					if (prevDiv.length > 0 && prevDiv.attr('is-hidden-to-player') === 'true') {
						firstSlotWidth = firstSlotNormalSizeWidth / 2;
						prevEntityWasHiddenToPlayer = true;
					}

					//console.log('Left: ' + firstEntity.position().left + ' firstSlotWidth:' + firstSlotWidth);
					if (firstEntity.position().left < firstSlotWidth) {
						// disable interval
						clearInterval(self.mFirstEntitySelectionTimer);
						self.mFirstEntitySelectionTimer = null;

						if (firstEntity.position().left >= 0) {
							//console.log('#4 enableFirstEntitySelection: First Element left: ' + firstEntity.position().left + ' first slot: ' + firstSlotWidth);
							//console.log(firstEntity);

							var entityData = firstEntity.data('entity');
							self.selectFirstEntity(entityData, firstEntity, prevEntityWasHiddenToPlayer);
						}
					}
				}

			},
				this.mFirstEntitySelectionTimerInterval);
		}
	}
};


TacticalScreenTurnSequenceBarModule.prototype.updateEntityImage = function (_entityData, _entityDIV) {
	if (_entityDIV.is('[in-removal]')) {
		return;
	}

	var entityImageLayer = _entityDIV.find('.image-layer:first');
	if (entityImageLayer.length === 0) {
		console.error('Error: Failed to find entity image object.');
		return;
	}

	var entityImage = entityImageLayer.find('img:first');
	if (entityImage.attr('src') === (Path.PROCEDURAL + _entityData.imagePath)) {
		return;
	}

	// offsets ?
	if ('imageOffsetX' in _entityData && typeof (_entityData.imageOffsetX) === 'number') {
		var offsets = entityImage.data('offsets') || {};
		offsets.imageOffsetX = _entityData.imageOffsetX;
		entityImage.data('offsets', offsets);
	}
	if ('imageOffsetY' in _entityData && typeof (_entityData.imageOffsetY) === 'number') {
		var offsets = entityImage.data('offsets') || {};
		offsets.imageOffsetY = _entityData.imageOffsetY;
		entityImage.data('offsets', offsets);
	}

	if (!entityImage.data('is-scaling')) {
		// update image
		if ('imagePath' in _entityData) {
			setTimeout(function () {
				if (!_entityDIV.is('[in-removal]')) {
					var placeholder = entityImage.data('placeholder');
					if (placeholder) {
						placeholder.removeClass('opacity-almost-none');
					}
					entityImage.attr('src', Path.PROCEDURAL + _entityData.imagePath);
				}
			}, 10);

			/* var image = new Image();
			 image.onload = function ()
			 {
				 entityImage.attr('src', Path.PROCEDURAL + _entityData.imagePath);
			 };
			 image.src = Path.PROCEDURAL + _entityData.imagePath;*/
		}
		else if ('imagePathFoW' in _entityData) {
			entityImage.attr('src', Path.GFX + _entityData.imagePathFoW);
		}
	}
	else {
		// update image
		if ('imagePath' in _entityData) {
			setTimeout(function () {
				if (!_entityDIV.is('[in-removal]')) {
					entityImage.data('newImage', Path.PROCEDURAL + _entityData.imagePath);
				}
			}, 10);

		}
		else if ('imagePathFoW' in _entityData) {
			entityImage.data('newImage', Path.GFX + _entityData.imagePathFoW);
		}
	}
};


TacticalScreenTurnSequenceBarModule.prototype.updateEntityVisiblity = function (_entityData, _entityDIV) {
	if ('isHiddenToPlayer' in _entityData) {
		_entityDIV.attr('is-hidden-to-player', _entityData.isHiddenToPlayer);
	}
};


TacticalScreenTurnSequenceBarModule.prototype.addEntity = function (_entityData) {
	if (_entityData.id === null) {
		console.error('ERROR: Failed to add entity. Reason: Entity has no id.');
		return;
	}

	// search entity
	var entityDIV = this.findEntityDIV(_entityData.id);
	if (entityDIV !== null && !entityDIV.div.is('[in-removal]')) {
		console.error('ERROR: Failed to add entity. Reason: Entity id: ' + _entityData.id + ' already added.');
		return;
	}

	// compute slider width
	var sliderDIVWidth = this.mEntityContainer.innerWidth();
	//console.log('#1 addEntity(sliderwidth: ' + sliderDIVWidth);

	// find last visible entity in the slide bar
	var lastEntityDIV = this.mEntitySliderContainer.find('.l-entity:last');
	var willBeFirstSlot = (lastEntityDIV.length === 0);
	if (!willBeFirstSlot) {
		sliderDIVWidth = sliderDIVWidth - (lastEntityDIV.position().left + lastEntityDIV.outerWidth(true));
	}

	// notify sq that a new turn animation has started
	if (willBeFirstSlot) {
		this.notifyBackendEntityLeftFirstSlot(null);
	}

	// create slide div & append it to the bar (temporary)
	var sliderDIV = null;
	if (sliderDIVWidth > 0) {
		sliderDIV = $('<div class="entity-slider"></div>');
		sliderDIV.width(sliderDIVWidth + 'px');
		this.mEntitySliderContainer.append(sliderDIV);
	}

	// create entity div & append it to the back of the slider
	entityDIV = this.createEntityDIV(_entityData.id);
	var entityImageLayer = entityDIV.find('.image-layer:first');
	var entityImage = entityImageLayer.find('img:first');
	this.mEntitySliderContainer.append(entityDIV);

	// query entity data from sq backend
	// 	var entityData = this.notifyBackendQueryEntity(_entityId);
	// 	if (entityData === null || entityData === undefined)
	// 	{
	// 		console.error('ERROR: Failed to query entity data for entity (' + _entityId + '). Reason: Invalid result.');
	// 		return;
	// 	}

	// update the visible to player attribute
	this.updateEntityVisiblity(_entityData, entityDIV);

	// update image
	this.updateEntityImage(_entityData, entityDIV);

	// adjust entity payload
	var isEnemy = false;
	if ('isEnemy' in _entityData) {
		isEnemy = _entityData.isEnemy;
	}

	var entityPayload = entityDIV.data('entity');
	if (entityPayload !== null && typeof (entityPayload) == 'object') {
		entityPayload.isEnemy = isEnemy;
		entityDIV.data('entity', entityPayload);
	}

	// compute slide in time
	var entitiesInContainer = this.mEntitySliderContainer.find('.l-entity');
	var entityDIVWidth = entityDIV.outerWidth(true);
	var maxVisibleEntities = Math.floor(this.mEntityContainer.innerWidth() / entityDIVWidth);
	var entities = Math.max(0, entitiesInContainer.size() - 1);
	var slideInMultiplier = Math.max(0, Math.min(maxVisibleEntities, maxVisibleEntities - entities));

	// compute fade in time & fade entity in
	var fadeInMultiplyer = entitiesInContainer.size() + 1;
	entityImage.velocity({ opacity: 1 }, { queue: false, easing: 'swing', duration: this.mFadeInDuration * fadeInMultiplyer });

	// animate slider (only if needed)
	if (sliderDIV !== null) {
		var self = this;
		// slide entity in
		sliderDIV.velocity({ width: 0 },
			{
				duration: this.mSlideInDuration * slideInMultiplier,
				easing: 'swing',
				begin: function (_animation) {
					self.enableFirstEntitySelection(true);
				},
				complete: function () {
					$(this).remove();
				}
			});
	}
	else {
		this.enableFirstEntitySelection(true);
	}
};

TacticalScreenTurnSequenceBarModule.prototype.updateEntity = function (_entityData) {
	if (_entityData.id === null) {
		console.error('ERROR: Failed to update entity. Reason: Entity has no id.');
		return;
	}

	// search entity
	var entityDIV = this.findEntityDIV(_entityData.id);
	if (entityDIV === null || entityDIV.div.is('[in-removal]')) {
		//console.error('ERROR: Failed to update entity. Reason: Entity id: ' + _entityData.id + ' not found.');
		return;
	}

	// query entity data from sq backend
	// 	var entityData = this.notifyBackendQueryEntity(_entityId);
	// 	if (entityData === null || entityData === undefined)
	// 	{
	// 		console.error('ERROR: Failed to query entity data for entity (' + _entityData.id + '). Reason: Invalid result.');
	// 		return;
	// 	}

	// update the visible to player attribute
	this.updateEntityVisiblity(_entityData, entityDIV.div);

	// update image
	this.updateEntityImage(_entityData, entityDIV.div);

	// depending on if the entity is the active one we need to update the status panel as well
	if (entityDIV.index === 0) {
		// update button bar
		this.updateButtonBar(_entityData);

		// update stats panel
		this.updateStatsPanel(_entityData);

		// update entity skills
		this.updateEntitySkills(_entityData);

		// update entity status effects
		this.updateEntityStatusEffects(_entityData);
	}
};

TacticalScreenTurnSequenceBarModule.prototype.insertEntity = function (_entity) {
	if (_entity === null || typeof (_entity) != 'object' || !('id' in _entity)) {
		console.error('ERROR: Failed to insert entity. Reason: Entity has no id.');
		return;
	}

	// search entity
	var entityDIV = this.findEntityDIV(_entity.id);
	if (entityDIV !== null && !entityDIV.div.is('[in-removal]')) {
		console.error('ERROR: Failed to insert entity. Reason: Entity id: ' + _entity.id + ' already added.');
		return;
	}

	// check if the entity comes with an index
	if (!('index' in _entity)) {
		console.error('ERROR: Failed to insert entity. Reason: Field "index" not defined.');
		return;
	}

	// we dont allow to insert into the first slot!
	if (_entity.index <= 0 && this.mEntitySliderContainer.find('.l-entity').size() > 0) {
		console.error('ERROR: Failed to insert entity. Reason: Entity index "<= 0" is NOT allowed if there is a first slot active.');
		return;
	}

	// find the DIVs in which we should insert the new Entity
	var insertRange = this.searchIndexRange(_entity.index);

	// decide which insert case we have
	if ((insertRange.before === null && insertRange.after === null) ||
		(insertRange.before !== null && insertRange.after === null)) {
		var self = this;
		this.notifyBackendQueryEntity(_entity.id, function (entityData) {
			if (entityData === null || entityData === undefined) {
				console.error('ERROR: Failed to query entity data for entity (' + _entity.id + '). Reason: Invalid result.');
				return;
			}

			// simply add to the end
			self.addEntity(entityData);
		});
	}
	else {
		// create entity div & append it to the back of the slider
		entityDIV = this.createEntityDIV(_entity.id);
		entityDIV.width(0);
		var entityImageLayer = entityDIV.find('.image-layer:first');
		var entityImage = entityImageLayer.find('img:first');
		insertRange.before.after(entityDIV);

		// query entity data from sq backend
		var self = this;
		this.notifyBackendQueryEntity(_entity.id, function (entityData) {
			if (entityData === null || entityData === undefined) {
				console.error('ERROR: Failed to query entity data for entity (' + _entity.id + '). Reason: Invalid result.');
				return;
			}

			// update the visible to player attribute
			self.updateEntityVisiblity(entityData, entityDIV);

			// update image
			self.updateEntityImage(entityData, entityDIV);

			// slide the entity in
			entityDIV.velocity({ width: '8.0rem' },
				{
					duration: self.mSlideInDuration,
					easing: 'swing',
					complete: function () {
						entityImage.velocity({ opacity: 1 }, { easing: 'swing', duration: self.mFadeInDuration });
					}
				});
		});
	}
};

TacticalScreenTurnSequenceBarModule.prototype.removeEntity = function (_entityId) {
	if (_entityId === null) {
		console.error('ERROR: Failed to remove entity. Reason: Entity has no id.');
		return;
	}

	// search entity
	var entityDIV = this.findEntityDIV(_entityId);
	if (entityDIV === null) {
		//console.error('ERROR: Failed to remove entity. Reason: Entity id: ' + _entityId + ' not found.');
		return;
	}

	// sanity check
	if (entityDIV.div.is('[in-removal]')) {
		var success = false;

		this.mEntitySliderContainer.find('.l-entity').each(function (_index, _element) {
			var possibleEntityDIV = $(_element);
			var possibleEntity = possibleEntityDIV.data('entity');

			if (possibleEntity !== null && 'id' in possibleEntity && possibleEntity.id === _entityId && !possibleEntityDIV.is('[in-removal]')) {
				entityDIV = { div: possibleEntityDIV, index: _index };
				success = true;
			}
		});

		if (!success) {
			console.error('WARNING: Entity (' + _entityId + ') is about to get removed. Be patient!');
			return;
		}
	}

	// mark this entity as about to get removed for possible further removal chaining of following entities
	entityDIV.div.attr('in-removal', true);

	var entityImage = entityDIV.div.find('img:first');
	entityImage.data('placeholder').addClass('opacity-none');

	// get the immediately following entity
	var nextEntityIsVisibleToPlayer = false;
	var hideStatusPanel = true;
	var nextEntityDIV = entityDIV.div.next();

	if (nextEntityDIV.length > 0) {
		hideStatusPanel = false;
		nextEntityIsVisibleToPlayer = nextEntityDIV.attr('is-hidden-to-player') !== 'true';

		var entityPlayoad = nextEntityDIV.data('entity');
		if (entityPlayoad !== null && typeof (entityPlayoad) == 'object') {
			hideStatusPanel = entityPlayoad.isEnemy;
		}
	}

	// get the previous ones to check if one or more are scheduled to be removed but not finished yet, thus we have to chain the first slot selection further down the row
	var selectNewFirstEntity = (entityDIV.index === 0);
	var prevEntityDIV = entityDIV.div.prev();
	var prevEntityCount = 1;

	while (prevEntityDIV.length > 0) {
		selectNewFirstEntity = prevEntityDIV.is('[in-removal]');
		prevEntityDIV = prevEntityDIV.prev();

		if (selectNewFirstEntity) {
			++prevEntityCount;
		}
	}

	// fade the entity image out
	// take possible next visible entity into account
	var isVisibleToPlayer = nextEntityIsVisibleToPlayer ? true : entityDIV.div.attr('is-hidden-to-player') !== 'true';
	var fadeOutDuration = isVisibleToPlayer ? this.mFadeOutDuration : this.mFadeOutDurationIfHiddenToPlayer;
	var slideOutDuration = isVisibleToPlayer ? this.mSlideOutDuration : this.mSlideOutDurationIfHiddenToPlayer;

	var self = this;
	var firstSlotEntered = false;
	var entityImageLayer = entityDIV.div.find('.image-layer:first');
	var entityImage = entityImageLayer.find('img:first');
	entityImage.velocity({ opacity: 0 },
		{
			duration: fadeOutDuration,
			begin: function (_animation) {
				if (selectNewFirstEntity)
					self.enableFirstEntitySelection(true);

				// if this is the first entity, hide the skills & status effects
				if (entityDIV.index === 0) {
					self.showEntitySkillbar(false);
					self.showEntityStatusEffectbar(false);

					// if there is no following entity or the entity is an enemy - hide the status panel also
					if (hideStatusPanel) {
						self.showStatsPanel(false);
					}
				}

				// Note: see tooltip.js
				entityImageLayer.unbindTooltip();
			},
			complete: function () {
				// slide the entity out and if needed a new in
				entityDIV.div.velocity({ width: 0 },
					{
						duration: slideOutDuration, // * prevEntityCount,
						easing: 'swing',
						begin: function (_animation) {
							// notifiy the sq backend that the first entity is about to get removed
							if (selectNewFirstEntity) {
								self.notifyBackendEntityLeftFirstSlot(_entityId);
							}
						},
						complete: function () {
							// notify sq that the entity has being removed
							self.notifyBackendEntityRemoved(_entityId);
							$(this).remove();
						}
					});
			}
		});
};


TacticalScreenTurnSequenceBarModule.prototype.selectSkill = function (_skill) {
	if (_skill === null || typeof (_skill) != 'object' || !('id' in _skill)) {
		console.error('ERROR: Failed to select skill. Reason: Skill has no id.');
		return;
	}

	if ('select' in _skill) {
		// first unselect the previous one
		this.unselectSkills();

		// get the skill div
		var skillToSelect = this.searchSkillDIV(_skill);
		if (skillToSelect !== null && skillToSelect.div.length > 0) {
			if (_skill.select) {
				skillToSelect.div.data('skill')['selected-by-backend'] = true;
				skillToSelect.div.addClass('is-selected');
			}
			else {
				skillToSelect.div.data('skill')['selected-by-backend'] = false;
				skillToSelect.div.removeClass('is-selected');
			}
		}
	}
};

TacticalScreenTurnSequenceBarModule.prototype.unselectSkills = function () {
	this.mSkillsContainer.find('.skill').each(function (index, element) {
		var skillDIV = $(element);
		if (skillDIV.length > 0 && skillDIV.hasClass('is-selected')) {
			skillDIV.data('skill')['selected-by-backend'] = false;
			skillDIV.removeClass('is-selected');
		}
	});
};


TacticalScreenTurnSequenceBarModule.prototype.selectEntity = function (_entity) {
	if (_entity === null || typeof (_entity) != 'object' || !('id' in _entity)) {
		console.error('ERROR: Failed to select entity. Reason: Entity has no id.');
		return;
	}

	if ('select' in _entity) {
		// unselect every entity
		this.unselectEntities();

		// search entity
		var entityDIV = this.findEntityDIV(_entity.id);
		if (entityDIV === null || entityDIV.div.is('[in-removal]') || entityDIV.index === 0) {
			//console.log('ERROR: Failed to select entity. Reason: Entity id: ' + _entity.id + ' not found.');
			return;
		}

		if (_entity.select) {
			var selectedContainerDiv = entityDIV.div.find('.selected-layer:first');
			var imageDiv = selectedContainerDiv.find('img:first');
			imageDiv.velocity("stop", true).velocity({ opacity: 1 }, { duration: this.mSelectionFadeInDuration });
		}
	}
};

TacticalScreenTurnSequenceBarModule.prototype.unselectEntities = function () {
	var self = this;
	this.mEntitySliderContainer.find('.l-entity').each(function (index, element) {
		var entityDIV = $(element);
		var entitySelectLayer = entityDIV.find('.selected-layer');
		var imageDiv = entitySelectLayer.find('img:first');
		imageDiv.velocity("stop", true).velocity({ opacity: 0 }, { duration: self.mSelectionFadeOutDuration });
	});
};


TacticalScreenTurnSequenceBarModule.prototype.updateCostsPreview = function (_previewData) {
	if (_previewData === null || typeof (_previewData) != 'object') {
		console.error('ERROR: Failed to update preview costs. Reason: Invalid preview data.');
		return;
	}

	this.updateStatsPanel(_previewData);
	this.updateEntitySkillsPreview('id' in _previewData ? _previewData.id : null);
};


TacticalScreenTurnSequenceBarModule.prototype.flashProgressbars = function (_whichBars) {
	if (_whichBars === null || typeof (_whichBars) != 'object') {
		console.error('ERROR: Failed to pulsate progressbars. Reason: Invalid bar data.');
		return;
	}

	var parentDiv = null;
	if ('attackPoints' in _whichBars) {
		parentDiv = this.mLeftStatsRows.ActionPoints.ProgressbarPreview.parent();
		if (parentDiv.length > 0) {
			//parentDiv.velocity("finish", true).velocity("fadeOut", { duration: 100 }).velocity("fadeIn", { duration: 100 }).velocity("fadeOut", { duration: 100 }).velocity("fadeIn", { duration: 100 }).velocity("fadeOut", { duration: 100 }).velocity("fadeIn", { duration: 100 });
			parentDiv.stop(true).fadeOut(100).fadeIn(100).fadeOut(100).fadeIn(100).fadeOut(100).fadeIn(100);
		}
	}

	if ('fatigue' in _whichBars) {
		parentDiv = this.mLeftStatsRows.Fatigue.ProgressbarPreview.parent();
		if (parentDiv.length > 0) {
			//parentDiv.velocity("finish", true).velocity("fadeOut", { duration: 100 }).velocity("fadeIn", { duration: 100 }).velocity("fadeOut", { duration: 100 }).velocity("fadeIn", { duration: 100 }).velocity("fadeOut", { duration: 100 }).velocity("fadeIn", { duration: 100 });
			parentDiv.stop(true).fadeOut(100).fadeIn(100).fadeOut(100).fadeIn(100).fadeOut(100).fadeIn(100);
		}
	}
};


TacticalScreenTurnSequenceBarModule.prototype.setEndTurnAllButtonVisible = function (_visible) {
	this.mEndTurnAllButton.enableButton(_visible);
}


TacticalScreenTurnSequenceBarModule.prototype.clear = function () {
	clearInterval(this.mFirstEntitySelectionTimer);
	this.mFirstEntitySelectionTimer = null;

	// remove all entities
	this.mEntitySliderContainer.empty();

	// remove all skills
	this.mSkillsContainer.empty();

	// remove all status effects
	this.mStatusEffectsContainer.empty();

	// hide every panel
	this.showStatsPanel(false, true);
};


TacticalScreenTurnSequenceBarModule.prototype.notifyBackendEndTurnAllButtonPressed = function () {
	SQ.call(this.mSQHandle, 'onEndTurnAllButtonPressed');
};

TacticalScreenTurnSequenceBarModule.prototype.notifyBackendNextTurnButtonPressed = function () {
	SQ.call(this.mSQHandle, 'onNextTurnButtonPressed');
};

TacticalScreenTurnSequenceBarModule.prototype.notifyBackendWaitTurnButtonPressed = function () {
	SQ.call(this.mSQHandle, 'onWaitTurnButtonPressed');
};

TacticalScreenTurnSequenceBarModule.prototype.notifyBackendOpenInventoryButtonPressed = function () {
	SQ.call(this.mSQHandle, 'onOpenInventoryButtonPressed');
};

TacticalScreenTurnSequenceBarModule.prototype.notifyBackendEntityMouseEnter = function (_entityId) {
	SQ.call(this.mSQHandle, 'onEntityMouseEnter', _entityId);
};

TacticalScreenTurnSequenceBarModule.prototype.notifyBackendEntityMouseLeave = function (_entityId) {
	SQ.call(this.mSQHandle, 'onEntityMouseLeave', _entityId);
};

TacticalScreenTurnSequenceBarModule.prototype.notifyBackendEntityClicked = function (_entityId) {
	SQ.call(this.mSQHandle, 'onEntityClicked', _entityId);
};

TacticalScreenTurnSequenceBarModule.prototype.notifyBackendEntitySkillClicked = function (_entityId, _skillId) {
	SQ.call(this.mSQHandle, 'onEntitySkillClicked', { entityId: _entityId, skillId: _skillId });
};

TacticalScreenTurnSequenceBarModule.prototype.notifyBackendEntitySkillCancelClicked = function (_entityId, _skillId) {
	SQ.call(this.mSQHandle, 'onEntitySkillCancelClicked', { entityId: _entityId, skillId: _skillId });
};

TacticalScreenTurnSequenceBarModule.prototype.notifyBackendEntityEntersFirstSlot = function (_entityId, _callback) {
	SQ.call(this.mSQHandle, 'onEntityEntersFirstSlot', _entityId, _callback);
};

TacticalScreenTurnSequenceBarModule.prototype.notifyBackendEntityEnteredFirstSlot = function (_entityId) {
	SQ.call(this.mSQHandle, 'onEntityEnteredFirstSlot', _entityId);
};

TacticalScreenTurnSequenceBarModule.prototype.notifyBackendEntityEnteredFirstSlotFully = function (_entityId) {
	SQ.call(this.mSQHandle, 'onEntityEnteredFirstSlotFully', _entityId);
};

TacticalScreenTurnSequenceBarModule.prototype.notifyBackendEntityLeftFirstSlot = function (_entityId) {
	// 	if (this.mSQHandle !== null)
	// 	{
	// 		SQ.call(this.mSQHandle, 'onEntityLeftFirstSlot', _entityId);
	// 	}
};

TacticalScreenTurnSequenceBarModule.prototype.notifyBackendEntityRemoved = function (_entityId) {
	// 	if (this.mSQHandle !== null)
	// 	{
	// 		SQ.call(this.mSQHandle, 'onEntityRemoved', _entityId);
	// 	}
};

TacticalScreenTurnSequenceBarModule.prototype.notifyBackendQueryEntitySkills = function (_entityId, _callback) {
	SQ.call(this.mSQHandle, 'onQueryEntitySkills', _entityId, _callback);
};

TacticalScreenTurnSequenceBarModule.prototype.notifyBackendQueryEntityStatusEffects = function (_entityId, _callback) {
	SQ.call(this.mSQHandle, 'onQueryEntityStatusEffects', _entityId, _callback);
};

TacticalScreenTurnSequenceBarModule.prototype.notifyBackendQueryEntity = function (_entityId, _callback) {
	SQ.call(this.mSQHandle, 'onQueryEntity', _entityId, _callback);
};

TacticalScreenTurnSequenceBarModule.prototype.notifyBackendForceRemoveInvalidEntity = function (_entityId, _callback) {
	SQ.call(this.mSQHandle, 'onForceRemoveInvalidEntity', _entityId, _callback);
};