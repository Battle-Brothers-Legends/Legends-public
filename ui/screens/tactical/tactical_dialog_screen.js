/*
 *  @Project:		Battle Brothers
 *	@Company:		Overhype Studios
 *
 *	@Copyright:		(c) Gabriel Uribe | 2015 - 
 * 
 *  @Author:		Overhype Studios
 *  @Date:			26.02.2015
 *  @Description:	Tactical Flee Screen JS
 */
"use strict";


var TacticalDialogScreen = function () {
    this.mSQHandle = null;

    // generic containers
    this.mContainer = null;
    this.mDialogContainer = null;

    // buttons
    this.mYesButton = null;
    this.mNoButton = null;
    this.mText = null;
};


TacticalDialogScreen.prototype.isConnected = function () {
    return this.mSQHandle !== null;
};

TacticalDialogScreen.prototype.onConnection = function (_handle) {
    this.mSQHandle = _handle;
    this.register($('.root-screen'));
};

TacticalDialogScreen.prototype.onDisconnection = function () {
    this.mSQHandle = null;
    this.unregister();
};


TacticalDialogScreen.prototype.createDIV = function (_parentDiv) {
    var self = this;

    // create: containers (init hidden!)
    this.mContainer = $('<div class="tactical-dialog-screen ui-control dialog-modal-background display-none opacity-none"/>');
    _parentDiv.append(this.mContainer);

    // create: dialog container
    var dialogLayout = $('<div class="l-dialog-container"/>');
    this.mContainer.append(dialogLayout);
    this.mDialogContainer = dialogLayout.createDialog('', null, null, false);

    // create content
    this.mContentContainer = this.mDialogContainer.findDialogContentContainer();

    // create footer button bar
    var footerButtonBar = $('<div class="l-button-bar"></div>');
    this.mDialogContainer.findDialogFooterContainer().append(footerButtonBar);

    // create: buttons
    var layout = $('<div class="l-yes-button"/>');
    footerButtonBar.append(layout);
    this.mYesButton = layout.createTextButton("Yes", function () {
        self.notifyBackendYesButtonPressed();
    }, '', 1);

    var layout = $('<div class="l-no-button"/>');
    footerButtonBar.append(layout);
    this.mNoButton = layout.createTextButton("No", function () {
        self.notifyBackendNoButtonPressed();
    }, '', 1);
};

TacticalDialogScreen.prototype.destroyDIV = function () {
    this.mYesButton.remove();
    this.mYesButton = null;
    this.mNoButton.remove();
    this.mNoButton = null;

    this.mContentContainer.remove();
    this.mContentContainer = null;

    this.mDialogContainer.empty();
    this.mDialogContainer.remove();
    this.mDialogContainer = null;

    this.mContainer.empty();
    this.mContainer.remove();
    this.mContainer = null;
};


TacticalDialogScreen.prototype.registerDatasourceListener = function () {
    //this.mDataSource.addListener(Tactical.CombatInformation.Loaded, jQuery.proxy(this.onCombatInformation, this));
};


TacticalDialogScreen.prototype.bindTooltips = function () {
    //this.mFleeButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.TacticalCombatResultScreen.LeaveButton });
};

TacticalDialogScreen.prototype.unbindTooltips = function () {
    //this.mFleeButton.unbindTooltip();
};

TacticalDialogScreen.prototype.create = function (_parentDiv) {
    this.createDIV(_parentDiv);
    this.bindTooltips();
};

TacticalDialogScreen.prototype.destroy = function () {
    this.unbindTooltips();
    this.destroyDIV();
};


TacticalDialogScreen.prototype.register = function (_parentDiv) {
    console.log('TacticalDialogScreen::REGISTER');

    if (this.mContainer !== null) {
        console.error('ERROR: Failed to register Tactical Dialog Screen. Reason: Already initialized.');
        return;
    }

    if (_parentDiv !== null && typeof (_parentDiv) == 'object') {
        this.create(_parentDiv);
    }
};

TacticalDialogScreen.prototype.unregister = function () {
    console.log('TacticalDialogScreen::UNREGISTER');

    if (this.mContainer === null) {
        console.error('ERROR: Failed to unregister Tactical Dialog Screen. Reason: Not initialized.');
        return;
    }

    this.destroy();
};


TacticalDialogScreen.prototype.show = function (_data) {
    this.loadFromData(_data);
    this.mYesButton.enableButton(false);
    this.mNoButton.enableButton(false);
    var self = this;
    this.mContainer.velocity("finish", true).velocity({ opacity: 1 },
        {
            duration: Constants.SCREEN_FADE_IN_OUT_DELAY,
            easing: 'swing',
            begin: function () {
                $(this).removeClass('display-none').addClass('display-block');
                self.notifyBackendOnAnimating();
            },
            complete: function () {
                self.mIsVisible = true;
                self.notifyBackendOnShown();
                self.mYesButton.enableButton(true);
                self.mNoButton.enableButton(true);
            }
        });
};

TacticalDialogScreen.prototype.hide = function () {
    var self = this;

    this.mContainer.velocity("finish", true).velocity({ opacity: 0 },
        {
            duration: Constants.SCREEN_FADE_IN_OUT_DELAY,
            easing: 'swing',
            begin: function () {
                self.notifyBackendOnAnimating();
            },
            complete: function () {
                self.mIsVisible = false;
                $(this).removeClass('display-block').addClass('display-none');
                self.notifyBackendOnHidden();
            }
        });
};


TacticalDialogScreen.prototype.getModule = function (_name) {
    switch (_name) {
        default: return null;
    }
};

TacticalDialogScreen.prototype.getModules = function () {
    return [
    ];
};

TacticalDialogScreen.prototype.loadFromData = function (_data) {
    this.mDialogContainer.findDialogTitle().html(_data.Title);

    this.mYesButton.changeButtonText(_data.YesButtonLabel);
    this.mNoButton.changeButtonText(_data.NoButtonLabel);

    this.mContentContainer.empty();

    var leftColumn = $('<div class="left-column"/>');
    this.mContentContainer.append(leftColumn);
    var fleeImageLayer = $('<div class="l-dialog-image"/>');
    leftColumn.append(fleeImageLayer);

    var rightColumn = $('<div class="right-column "/>');
    this.mContentContainer.append(rightColumn);

    var fleeTitleLabel = $('<div class="dialog-title-label title-font-normal font-bold font-color-title">' + _data.Subtitle + '</div>');
    rightColumn.append(fleeTitleLabel);

    var fleeTextLabel = $('<div class="dialog-text text-font-medium font-color-description font-style-normal">' + _data.Text + '</div>');
    rightColumn.append(fleeTextLabel);
}

TacticalDialogScreen.prototype.notifyBackendOnConnected = function () {
    SQ.call(this.mSQHandle, 'onScreenConnected');
};

TacticalDialogScreen.prototype.notifyBackendOnDisconnected = function () {
    if (this.mSQHandle != null) {
        SQ.call(this.mSQHandle, 'onScreenDisconnected');
    }
};

TacticalDialogScreen.prototype.notifyBackendOnShown = function () {
    SQ.call(this.mSQHandle, 'onScreenShown');
};

TacticalDialogScreen.prototype.notifyBackendOnHidden = function () {
    if (this.mSQHandle != null) {
        SQ.call(this.mSQHandle, 'onScreenHidden');
    }
};

TacticalDialogScreen.prototype.notifyBackendOnAnimating = function () {
    if (this.mSQHandle !== null) {
        SQ.call(this.mSQHandle, 'onScreenAnimating');
    }
};

TacticalDialogScreen.prototype.notifyBackendYesButtonPressed = function () {
    this.mYesButton.enableButton(false);
    this.mNoButton.enableButton(false);
    SQ.call(this.mSQHandle, 'onYesPressed');
};

TacticalDialogScreen.prototype.notifyBackendNoButtonPressed = function () {
    this.mYesButton.enableButton(false);
    this.mNoButton.enableButton(false);
    SQ.call(this.mSQHandle, 'onNoPressed');
};