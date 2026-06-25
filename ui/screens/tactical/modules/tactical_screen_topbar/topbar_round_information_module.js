/*
 *  @Project:		Battle Brothers
 *	@Company:		Overhype Studios
 *
 *	@Copyright:		(c) Overhype Studios | 2013 - 2020
 * 
 *  @Author:		Overhype Studios
 *  @Date:			01.03.2017 (refactored: 25.10.2017)
 *  @Description:	Tactical Screen - Topbar: Round Information Module JS
 */
"use strict";


var TacticalScreenTopbarRoundInformationModule = function () {
	this.mSQHandle = null;

	// event listener
	this.mEventListener = null;

	// generic containers
	this.mContainer = null;

	// entities count containers
	this.mBrothersCountContainer = null;
	this.mBrothersCount = null;

	this.mEnemiesCountContainer = null;
	this.mEnemiesCount = null;

	this.mRoundCounterContainer = null;
	this.mRoundNumber = null;
};


TacticalScreenTopbarRoundInformationModule.prototype.isConnected = function () {
	return this.mSQHandle !== null;
};

TacticalScreenTopbarRoundInformationModule.prototype.onConnection = function (_handle) {
	this.mSQHandle = _handle;

	// notify listener
	if (this.mEventListener !== null && ('onModuleOnConnectionCalled' in this.mEventListener)) {
		this.mEventListener.onModuleOnConnectionCalled(this);
	}
};

TacticalScreenTopbarRoundInformationModule.prototype.onDisconnection = function () {
	this.mSQHandle = null;

	// notify listener
	if (this.mEventListener !== null && ('onModuleOnDisconnectionCalled' in this.mEventListener)) {
		this.mEventListener.onModuleOnDisconnectionCalled(this);
	}
};


TacticalScreenTopbarRoundInformationModule.prototype.createDIV = function (_parentDiv) {
	// create: containers
	this.mContainer = $('<div class="topbar-round-information-module"/>');
	_parentDiv.append(this.mContainer);

	var leftContainer = $('<div class="left-container"/>');
	this.mContainer.append(leftContainer);
	var middleContainer = $('<div class="middle-container"/>');
	this.mContainer.append(middleContainer);
	var rightContainer = $('<div class="right-container"/>');
	this.mContainer.append(rightContainer);

	// create: left content
	this.mBrothersCountContainer = $('<div class="l-entities-count-container"/>');
	leftContainer.append(this.mBrothersCountContainer);
	var leftEntitiesCountTextLayout = $('<div class="l-entities-count-text is-right"/>');
	this.mBrothersCountContainer.append(leftEntitiesCountTextLayout);
	this.mBrothersCount = $('<div class="entities-count-text title-font-normal font-bold font-bottom-shadow font-color-title"/>');
	leftEntitiesCountTextLayout.append(this.mBrothersCount);
	var leftEntitiesCountImageContainer = $('<div class="entities-count-image is-right"/>');
	this.mBrothersCountContainer.append(leftEntitiesCountImageContainer);
	var leftEntitiesCountImage = $('<img/>');
	leftEntitiesCountImage.attr('src', Path.GFX + Asset.ICON_BROTHERS);
	leftEntitiesCountImageContainer.append(leftEntitiesCountImage);

	// create: middle content
	var roundCounterContainer = $('<div class="l-round-number-container"/>');
	middleContainer.append(roundCounterContainer);
	this.mRoundCounterContainer = $('<div class="round-number-image-layer"/>');
	roundCounterContainer.append(this.mRoundCounterContainer);
	/*var middleRoundNumberImage = $('<img/>');
	middleRoundNumberImage.attr('src', Path.GFX + Asset.ICON_ROUND_NUMBER);
	this.mRoundCounterContainer.append(middleRoundNumberImage);*/
	var middleRoundNumberTextLayer = $('<div class="round-number-text-layer"/>');
	roundCounterContainer.append(middleRoundNumberTextLayer);
	this.mRoundNumber = $('<div class="round-number-text title-font-big font-bold font-bottom-shadow font-color-title"/>');
	middleRoundNumberTextLayer.append(this.mRoundNumber);

	// create: right content
	this.mEnemiesCountContainer = $('<div class="l-entities-count-container"/>');
	rightContainer.append(this.mEnemiesCountContainer);
	var rightEntitiesCountTextLayout = $('<div class="l-entities-count-text is-left"/>');
	this.mEnemiesCountContainer.append(rightEntitiesCountTextLayout);
	this.mEnemiesCount = $('<div class="entities-count-text title-font-normal font-bold font-bottom-shadow font-color-title"/>');
	rightEntitiesCountTextLayout.append(this.mEnemiesCount);
	var rightEntitiesCountImageContainer = $('<div class="entities-count-image is-left"/>');
	this.mEnemiesCountContainer.append(rightEntitiesCountImageContainer);
	var rightEntitiesCountImage = $('<img/>');
	rightEntitiesCountImage.attr('src', Path.GFX + Asset.ICON_ENEMIES);
	rightEntitiesCountImageContainer.append(rightEntitiesCountImage);
};

TacticalScreenTopbarRoundInformationModule.prototype.destroyDIV = function () {
	this.mBrothersCount.remove();
	this.mBrothersCount = null;
	this.mBrothersCountContainer.empty();
	this.mBrothersCountContainer.remove();
	this.mBrothersCountContainer = null;

	this.mRoundNumber.remove();
	this.mRoundNumber = null;
	this.mRoundCounterContainer.empty();
	this.mRoundCounterContainer.remove();
	this.mRoundCounterContainer = null;

	this.mEnemiesCount.remove();
	this.mEnemiesCount = null;
	this.mEnemiesCountContainer.empty();
	this.mEnemiesCountContainer.remove();
	this.mEnemiesCountContainer = null;

	this.mContainer.empty();
	this.mContainer.remove();
	this.mContainer = null;
};


TacticalScreenTopbarRoundInformationModule.prototype.bindTooltips = function () {
	this.mBrothersCountContainer.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.TacticalScreen.Topbar.RoundInformationModule.BrothersCounter });
	this.mEnemiesCountContainer.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.TacticalScreen.Topbar.RoundInformationModule.EnemiesCounter });
	this.mRoundCounterContainer.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.TacticalScreen.Topbar.RoundInformationModule.RoundCounter });
};

TacticalScreenTopbarRoundInformationModule.prototype.unbindTooltips = function () {
	this.mBrothersCountContainer.unbindTooltip();
	this.mEnemiesCountContainer.unbindTooltip();
	this.mRoundCounterContainer.unbindTooltip();
};


TacticalScreenTopbarRoundInformationModule.prototype.create = function (_parentDiv) {
	this.createDIV(_parentDiv);
	this.bindTooltips();
};

TacticalScreenTopbarRoundInformationModule.prototype.destroy = function () {
	this.unbindTooltips();
	this.destroyDIV();
};


TacticalScreenTopbarRoundInformationModule.prototype.register = function (_parentDiv) {
	console.log('TacticalScreenTopbarRoundInformationModule::REGISTER');

	if (this.mContainer !== null) {
		console.error('ERROR: Failed to register Round Information Module. Reason: Round Information Module is already initialized.');
		return;
	}

	if (_parentDiv !== null && typeof (_parentDiv) == 'object') {
		this.create(_parentDiv);
	}
};

TacticalScreenTopbarRoundInformationModule.prototype.unregister = function () {
	console.log('TacticalScreenTopbarRoundInformationModule::UNREGISTER');

	if (this.mContainer === null) {
		console.error('ERROR: Failed to unregister Round Information Module. Reason: Round Information Module is not initialized.');
		return;
	}

	this.destroy();
};


TacticalScreenTopbarRoundInformationModule.prototype.isRegistered = function () {
	if (this.mContainer !== null) {
		return this.mContainer.parent().length !== 0;
	}

	return false;
};


TacticalScreenTopbarRoundInformationModule.prototype.registerEventListener = function (_listener) {
	this.mEventListener = _listener;
};


TacticalScreenTopbarRoundInformationModule.prototype.update = function (_data) {
	if (_data === null || _data === undefined) {
		console.error('ERROR: Failed to query round information data. Reason: Invalid result.');
		return;
	}

	if (TacticalScreenIdentifier.Topbar.RoundInformation.BrotherCount in _data) {
		this.mBrothersCount.html(_data[TacticalScreenIdentifier.Topbar.RoundInformation.BrotherCount]);
	}

	if (TacticalScreenIdentifier.Topbar.RoundInformation.EnemiesCount in _data) {
		this.mEnemiesCount.html(_data[TacticalScreenIdentifier.Topbar.RoundInformation.EnemiesCount]);
	}

	if (TacticalScreenIdentifier.Topbar.RoundInformation.RoundNumber in _data) {
		this.mRoundNumber.html(_data[TacticalScreenIdentifier.Topbar.RoundInformation.RoundNumber]);
	}
};
