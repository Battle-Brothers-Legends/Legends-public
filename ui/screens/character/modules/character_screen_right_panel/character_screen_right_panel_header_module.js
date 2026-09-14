/*
 *  @Project:		Battle Brothers
 *	@Company:		Overhype Studios
 *
 *	@Copyright:		(c) Overhype Studios | 2013 - 2020
 * 
 *  @Author:		Overhype Studios
 *  @Date:			26.01.2017 / Reworked: 26.11.2017
 *  @Description:	Character Right Panel Header Module JS
 */
"use strict";

var CharacterScreenRightPanelHeaderModule = function (_parent, _dataSource) {
    this.mParent = _parent;
    this.mDataSource = _dataSource;

    // header: containers
    this.mContainer = null;

    // header: buttons
    //this.mToggleSearchButton = null;
    this.mSwitchToInventoryButton = null;
    this.mSwitchToPerksButton = null;
    this.mSwitchToProfessionsButton = null;
    this.mCloseButton = null;

    // button: callbacks
    this.mOnToggleFilterCallback = null;
    this.mOnSwitchToInventoryCallback = null;
    this.mOnSwitchToPerksCallback = null;
    this.mOnSwitchToProfessionsCallback = null;

    this.registerDatasourceListener();
};


CharacterScreenRightPanelHeaderModule.prototype.createDIV = function (_parentDiv) {
    var self = this;

    // create: container
    this.mContainer = $('<div class="right-panel-header-module"/>');
    _parentDiv.append(this.mContainer);

    var leftButtonContainer = $('<div class="buttons-container is-left"/>');
    this.mContainer.append(leftButtonContainer);
    var middleButtonContainer = $('<div class="buttons-container is-middle"/>');
    this.mContainer.append(middleButtonContainer);
    var rightButtonContainer = $('<div class="buttons-container is-right"/>');
    this.mContainer.append(rightButtonContainer);

    // create: buttons
    //this.mToggleSearchButton = this.createImageButtonDIV(leftButtonContainer, 'search-button', Path.GFX + Asset.BUTTON_SEARCH);

    var layout = $('<div class="l-button is-inventory"/>');
    middleButtonContainer.append(layout);
    this.mSwitchToInventoryButton = layout.createTabTextButton("Stash", function () {
        if (self.mOnSwitchToInventoryCallback !== null && jQuery.isFunction(self.mOnSwitchToInventoryCallback)) {
            self.mOnSwitchToInventoryCallback();
        }
    }, null, 'tab-button', 7);

    layout = $('<div class="l-button is-perks"/>');
    middleButtonContainer.append(layout);
    this.mSwitchToPerksButton = layout.createTabTextButton("Perks", function () {
        if (self.mOnSwitchToPerksCallback !== null && jQuery.isFunction(self.mOnSwitchToPerksCallback)) {
            self.mOnSwitchToPerksCallback();
        }
    }, null, 'tab-button', 7);

    layout = $('<div class="l-button is-professions"/>');
    middleButtonContainer.append(layout);
    this.mSwitchToProfessionsButton = layout.createTabTextButton("Professions", function () {
        if (self.mOnSwitchToProfessionsCallback !== null && jQuery.isFunction(self.mOnSwitchToProfessionsCallback)) {
            self.mOnSwitchToProfessionsCallback();
        }
    }, null, 'tab-button', 7);

    layout = $('<div class="l-button is-close"/>');
    rightButtonContainer.append(layout);
    this.mCloseButton = layout.createImageButton(Path.GFX + Asset.BUTTON_QUIT, function () {
        self.mDataSource.notifyBackendCloseButtonClicked();
    }, '', 6);
};

CharacterScreenRightPanelHeaderModule.prototype.destroyDIV = function () {
    this.mSwitchToInventoryButton.remove();
    this.mSwitchToInventoryButton = null;
    this.mSwitchToPerksButton.remove();
    this.mSwitchToPerksButton = null;
    this.mSwitchToProfessionsButton.remove();
    this.mSwitchToProfessionsButton = null;
    this.mCloseButton.remove();
    this.mCloseButton = null;

    this.mContainer.empty();
    this.mContainer.remove();
    this.mContainer = null;
};


CharacterScreenRightPanelHeaderModule.prototype.registerDatasourceListener = function () {
    this.mDataSource.addListener(CharacterScreenDatasourceIdentifier.Inventory.ModeUpdated, jQuery.proxy(this.onInventoryModeUpdated, this));
    this.mDataSource.addListener(CharacterScreenDatasourceIdentifier.Brother.Updated, jQuery.proxy(this.onBrotherUpdated, this));
    this.mDataSource.addListener(CharacterScreenDatasourceIdentifier.Brother.Selected, jQuery.proxy(this.onBrotherSelected, this));
};


CharacterScreenRightPanelHeaderModule.prototype.bindTooltips = function () {
    this.mSwitchToInventoryButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterScreen.RightPanelHeaderModule.InventoryButton });
    this.mSwitchToPerksButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterScreen.RightPanelHeaderModule.PerksButton });
    this.mSwitchToProfessionsButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterScreen.RightPanelHeaderModule.ProfessionsButton });
    this.mCloseButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterScreen.RightPanelHeaderModule.CloseButton });
};

CharacterScreenRightPanelHeaderModule.prototype.unbindTooltips = function () {
    this.mSwitchToInventoryButton.unbindTooltip();
    this.mSwitchToPerksButton.unbindTooltip();
    this.mSwitchToProfessionsButton.unbindTooltip();
    this.mCloseButton.unbindTooltip();
};


CharacterScreenRightPanelHeaderModule.prototype.setOnToggleFilterCallback = function (_callback) {
    this.mOnToggleFilterCallback = _callback;
};

CharacterScreenRightPanelHeaderModule.prototype.setOnSwitchToInventoryCallback = function (_callback) {
    this.mOnSwitchToInventoryCallback = _callback;
};

CharacterScreenRightPanelHeaderModule.prototype.setOnSwitchToPerksCallback = function (_callback) {
    this.mOnSwitchToPerksCallback = _callback;
};

CharacterScreenRightPanelHeaderModule.prototype.setOnSwitchToProfessionsCallback = function (_callback) {
    this.mOnSwitchToProfessionsCallback = _callback;
};


CharacterScreenRightPanelHeaderModule.prototype.create = function (_parentDiv) {
    this.createDIV(_parentDiv);
    this.bindTooltips();
};

CharacterScreenRightPanelHeaderModule.prototype.destroy = function () {
    this.unbindTooltips();
    this.destroyDIV();
};


CharacterScreenRightPanelHeaderModule.prototype.register = function (_parentDiv) {
    console.log('CharacterScreenRightPanelHeaderModule::REGISTER');

    if (this.mContainer !== null) {
        console.error('ERROR: Failed to register Right Panel Header Module. Reason: Module is already initialized.');
        return;
    }

    if (_parentDiv !== null && typeof (_parentDiv) == 'object') {
        this.create(_parentDiv);
    }
};

CharacterScreenRightPanelHeaderModule.prototype.unregister = function () {
    console.log('CharacterScreenRightPanelHeaderModule::UNREGISTER');

    if (this.mContainer === null) {
        console.error('ERROR: Failed to unregister Right Panel Header Module. Reason: Module is not initialized.');
        return;
    }

    this.destroy();
};

CharacterScreenRightPanelHeaderModule.prototype.isRegistered = function () {
    if (this.mContainer !== null) {
        return this.mContainer.parent().length !== 0;
    }

    return false;
};


CharacterScreenRightPanelHeaderModule.prototype.toggleFilterPanel = function () {
    if (this.mOnToggleFilterCallback !== null) {
        this.mOnToggleFilterCallback();
    }
};

CharacterScreenRightPanelHeaderModule.prototype.selectInventoryPanel = function () {
    this.mSwitchToInventoryButton.selectTabTextButton(true);
};

CharacterScreenRightPanelHeaderModule.prototype.selectPerksPanel = function () {
    this.mSwitchToPerksButton.selectTabTextButton(true);
};

CharacterScreenRightPanelHeaderModule.prototype.selectProfessionsPanel = function () {
    this.mSwitchToProfessionsButton.selectTabTextButton(true);
};


CharacterScreenRightPanelHeaderModule.prototype.updateButtonsByBrother = function (_brother) {
    var perkPoints = this.mDataSource.getBrotherPerkPoints(_brother);
    if (perkPoints > 0) {
        this.mSwitchToPerksButton.findButtonText().html('Perks (<span class="font-bold font-color-positive-value">' + perkPoints + '</span>)');
    }
    else {
        this.mSwitchToPerksButton.findButtonText().html('Perks');
    }
    var professionPoints = this.mDataSource.getBrotherProfessionPoints(_brother);
    if (professionPoints > 0) {
        this.mSwitchToProfessionsButton.findButtonText().html('Professions (<span class="font-bold font-color-positive-value">' + professionPoints + '</span>)');
    }
    else {
        this.mSwitchToProfessionsButton.findButtonText().html('Professions');
    }
};

CharacterScreenRightPanelHeaderModule.prototype.updateButtonsByInventoryMode = function (_inventoryMode) {
    switch (_inventoryMode) {
        case CharacterScreenDatasourceIdentifier.InventoryMode.BattlePreparation:
        case CharacterScreenDatasourceIdentifier.InventoryMode.Stash:
            {
                this.mSwitchToInventoryButton.findButtonText().html('Stash');
            } break;
        case CharacterScreenDatasourceIdentifier.InventoryMode.Ground:
            {
                this.mSwitchToInventoryButton.findButtonText().html('Ground');
            } break;
    }
};


CharacterScreenRightPanelHeaderModule.prototype.onInventoryModeUpdated = function (_dataSource, _mode) {
    this.updateButtonsByInventoryMode(_mode);
};

CharacterScreenRightPanelHeaderModule.prototype.onBrotherUpdated = function (_dataSource, _brother) {
    this.onBrotherSelected(_dataSource, _brother);
};

CharacterScreenRightPanelHeaderModule.prototype.onBrotherSelected = function (_dataSource, _brother) {
    if (_brother !== null) {
        this.updateButtonsByBrother(_brother);
    }
};
