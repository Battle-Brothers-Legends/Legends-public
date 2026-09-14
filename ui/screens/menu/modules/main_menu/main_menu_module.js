/*
 *  @Project:		Battle Brothers
 *	@Company:		Overhype Studios
 *
 *	@Copyright:		(c) Overhype Studios | 2013 - 2020
 * 
 *  @Author:		Overhype Studios
 *  @Date:			01.10.2017
 *  @Description:	Main Menu Module JS
 */
"use strict";


var MainMenuModule = function(_alignment)
{
	this.mSQHandle = null;

	// event listener
	this.mEventListener = null;

	// generic containers
	this.mContainer = null;
	this.mButtonContainer = null;
	this.mDisableButtons = false;
	this.mRetirePopupDialog = null;

/*	this.mFleeButton = null;*/

	// alignment
	this.mAlignmentClass = null;
	switch(_alignment)
	{
		case 'left': break;
		case 'center': this.mAlignmentClass = 'is-center'; break;
		case 'right': this.mAlignmentClass = 'is-center'; break;
		//case 'right': this.mAlignmentClass = 'is-right'; break;
	}

	// generics
	this.mIsVisible = false;
	this.mIsDemoModus = false;
};


MainMenuModule.prototype.isConnected = function ()
{
	return this.mSQHandle !== null;
};

MainMenuModule.prototype.onConnection = function (_handle)
{
	this.mSQHandle = _handle;

	// notify listener
	if (this.mEventListener !== null && ('onModuleOnConnectionCalled' in this.mEventListener))
	{
		this.mEventListener.onModuleOnConnectionCalled(this);
	}
};

MainMenuModule.prototype.onDisconnection = function ()
{
	this.mSQHandle = null;

	// notify listener
	if (this.mEventListener !== null && ('onModuleOnDisconnectionCalled' in this.mEventListener))
	{
		this.mEventListener.onModuleOnDisconnectionCalled(this);
	}
};


MainMenuModule.prototype.createDIV = function (_parentDiv)
{
	// create: containers (init hidden!)
	this.mContainer = $('<div class="main-menu-module ui-control display-none"></div>');
	this.mContainer.addClass(this.mAlignmentClass);
	_parentDiv.append(this.mContainer);

	// header
	var header = $('<div class="header"></div>');
	this.mContainer.append(header);

	// logo
	var logoImage = $('<img/>');
	logoImage.attr('src', Path.GFX + 'ui/skin/main_menu_logo.png');
	header.append(logoImage);

	// button container
	this.mButtonContainer = $('<div class="container"></div>');
	this.mContainer.append(this.mButtonContainer);

	this.mIsVisible = false;
};

MainMenuModule.prototype.destroyDIV = function ()
{
	if(this.mRetirePopupDialog !== null)
		this.mRetirePopupDialog.destroyPopupDialog();

	this.mRetirePopupDialog = null;
	this.mButtonContainer.empty();
	this.mButtonContainer = null;


	this.mContainer.empty();
	this.mContainer.remove();
	this.mContainer = null;
};

MainMenuModule.prototype.createMainMenuButtons = function ()
{
	var self = this;

	this.mContainer.removeClass('is-world-map is-tactical-map');
	this.mButtonContainer.empty();

	// buttons
	var row = $('<div class="row"></div>');
	this.mButtonContainer.append(row);
	var buttonLayout = $('<div class="l-center"></div>');
	row.append(buttonLayout);
	var button = buttonLayout.createTextButton("New Campaign", function ()
	{
		self.notifyBackendNewCampaignButtonPressed();
	}, '', 4);
	if (this.mIsDemoModus === true || this.mDisableButtons === true)
	{
		button.attr('disabled', 'disabled');
	}

	row = $('<div class="row"></div>');
	this.mButtonContainer.append(row);
	buttonLayout = $('<div class="l-center"></div>');
	row.append(buttonLayout);
	button = buttonLayout.createTextButton("Load Campaign", function ()
	{
		self.notifyBackendLoadCampaignButtonPressed();
	}, '', 4);
	if (this.mIsDemoModus === true || this.mDisableButtons === true)
	{
		button.attr('disabled', 'disabled');
	}
	row = $('<div class="row"></div>');
	this.mButtonContainer.append(row);
	buttonLayout = $('<div class="l-center"></div>');
	row.append(buttonLayout);
	button = buttonLayout.createTextButton("Scenarios", function ()
	{
		self.notifyBackendScenariosButtonPressed();
	}, '', 4);

	row = $('<div class="row"></div>');
	this.mButtonContainer.append(row);
	buttonLayout = $('<div class="l-center"></div>');
	row.append(buttonLayout);
	button = buttonLayout.createTextButton("Options", function ()
	{
		self.notifyBackendOptionsButtonPressed();
	}, '', 4);

	row = $('<div class="row"></div>');
	this.mButtonContainer.append(row);
	buttonLayout = $('<div class="l-center"></div>');
	row.append(buttonLayout);
	button = buttonLayout.createTextButton("Tutorial Videos", function ()
	{
		openURL("https://www.youtube.com/playlist?list=PLMbw15ySmbBtpEj0segi1DzKu2f_Yqr-W");
	}, '', 4);

	row = $('<div class="row"></div>');
	this.mButtonContainer.append(row);
	buttonLayout = $('<div class="l-center"></div>');
	row.append(buttonLayout);
	button = buttonLayout.createTextButton("Credits", function ()
	{
		self.notifyBackendCreditsButtonPressed();
	}, '', 4);  
	//button.attr('disabled', 'disabled');

	row = $('<div class="divider"></div>');
	this.mButtonContainer.append(row);

	row = $('<div class="row"></div>');
	this.mButtonContainer.append(row);
	buttonLayout = $('<div class="l-center"></div>');
	row.append(buttonLayout);
	button = buttonLayout.createTextButton("Quit", function ()
	{
		self.notifyBackendQuitButtonPressed();
	}, '', 4);
};


MainMenuModule.prototype.createWorldMapMenuButtons = function (_isSavingAllowed, _seed)
{
	var self = this;

	this.mContainer.removeClass('is-tactical-map');
	this.mContainer.addClass('is-world-map');

	this.mButtonContainer.empty();

	if(_seed != '')
	{
		row = $('<div class="row"></div>');
		this.mButtonContainer.append(row);
		buttonLayout = $('<div class="is-map-seed text-font-medium font-color-subtitle">&nbsp;&nbsp;&nbsp;&nbsp;Map Seed: ' + _seed + '</div>');
		row.append(buttonLayout);
	}

	// buttons
	var row = $('<div class="row"></div>');
	this.mButtonContainer.append(row);
	var buttonLayout = $('<div class="l-center"></div>');
	row.append(buttonLayout);
	buttonLayout.createTextButton("Resume", function ()
	{
		self.notifyBackendResumeButtonPressed();
	}, '', 4);

	row = $('<div class="row"></div>');
	this.mButtonContainer.append(row);
	buttonLayout = $('<div class="l-center"></div>');
	row.append(buttonLayout);
	buttonLayout.createTextButton("Load Campaign", function ()
	{
		self.notifyBackendLoadCampaignButtonPressed();
	}, '', 4);

	row = $('<div class="row"></div>');
	this.mButtonContainer.append(row);
	buttonLayout = $('<div class="l-center"></div>');
	row.append(buttonLayout);
	var saveButton = buttonLayout.createTextButton("Save Campaign", function ()
	{
		self.notifyBackendSaveCampaignButtonPressed();
	}, '', 4);

	if (_isSavingAllowed !== true)
		saveButton.enableButton(false);

	row = $('<div class="row"></div>');
	this.mButtonContainer.append(row);
	buttonLayout = $('<div class="l-center"></div>');
	row.append(buttonLayout);
	buttonLayout.createTextButton("Options", function ()
	{
		self.notifyBackendOptionsButtonPressed();
	}, '', 4);

	row = $('<div class="divider"></div>');
	this.mButtonContainer.append(row);

	row = $('<div class="row"></div>');
	this.mButtonContainer.append(row);
	buttonLayout = $('<div class="l-center"></div>');
	row.append(buttonLayout);
	buttonLayout.createTextButton("Retire", function ()
	{
		self.mRetirePopupDialog = $('.main-menu-module.is-world-map').createPopupDialog('Retire', null, null, 'retire-dialog', false);

		self.mRetirePopupDialog.addPopupDialogOkButton(function (_dialog)
		{
			self.mRetirePopupDialog = null;
			_dialog.destroyPopupDialog();

			self.notifyBackendRetireButtonPressed();
		});

		self.mRetirePopupDialog.addPopupDialogCancelButton(function (_dialog)
		{
			self.mRetirePopupDialog = null;
			_dialog.destroyPopupDialog();
		});

		self.mRetirePopupDialog.addPopupDialogContent(self.createRetireDialogContent(self.mRetirePopupDialog));
	}, '', 4);

	row = $('<div class="row"></div>');
	this.mButtonContainer.append(row);
	buttonLayout = $('<div class="l-center"></div>');
	row.append(buttonLayout);
	buttonLayout.createTextButton(_isSavingAllowed ? "Quit" : "Save & Quit", function ()
	{
		self.notifyBackendQuitButtonPressed();
	}, '', 4);
};

MainMenuModule.prototype.createTacticalMapMenuButtons = function (_isRetreatAllowed, _isQuitAllowed, _quitText)
{
	var self = this;

	this.mContainer.removeClass('is-world-map');
	this.mContainer.addClass('is-tactical-map');

	this.mButtonContainer.empty();

	// buttons
	var row = $('<div class="row"></div>');
	this.mButtonContainer.append(row);
	var buttonLayout = $('<div class="l-center"></div>');
	row.append(buttonLayout);
	buttonLayout.createTextButton("Resume", function ()
	{
		self.notifyBackendResumeButtonPressed();
	}, '', 4);

	row = $('<div class="row"></div>');
	this.mButtonContainer.append(row);
	buttonLayout = $('<div class="l-center"></div>');
	row.append(buttonLayout);
	buttonLayout.createTextButton("Options", function ()
	{
		self.notifyBackendOptionsButtonPressed();
	}, '', 4);

	row = $('<div class="divider"></div>');
	this.mButtonContainer.append(row);

	row = $('<div class="row"></div>');
	this.mButtonContainer.append(row);
	buttonLayout = $('<div class="l-center"></div>');
	row.append(buttonLayout);
	var fleeButton = buttonLayout.createTextButton("Retreat", function ()
	{
		self.notifyBackendFleeButtonPressed();
	}, '', 4);

	if (_isRetreatAllowed !== true)
		fleeButton.enableButton(false);

	if (_isQuitAllowed)
	{
		row = $('<div class="row"></div>');
		this.mButtonContainer.append(row);
		buttonLayout = $('<div class="l-center"></div>');
		row.append(buttonLayout);
		var quitButton = buttonLayout.createTextButton(_quitText, function ()
		{
			self.notifyBackendQuitButtonPressed();
		}, '', 4);
	}
};


MainMenuModule.prototype.createRetireDialogContent = function (_dialog)
{
	var result = $('<div class="retire-campaign-container"/>');

	var row = $('<div class="row"/>');
	result.append(row);

	var label = $('<div class="text-font-normal font-color-label">Are you sure you want to retire from the company? This will permanently end your campaign and leave the men in charge.</div>');
	row.append(label);

	return result;
};


MainMenuModule.prototype.bindTooltips = function ()
{
	/*
	this.mBrothersCountContainer.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.TacticalScreen.RoundInformationModule.BrothersCounter });
	*/
};

MainMenuModule.prototype.unbindTooltips = function ()
{

};


MainMenuModule.prototype.create = function(_parentDiv)
{
	this.createDIV(_parentDiv);
	this.bindTooltips();
};

MainMenuModule.prototype.destroy = function()
{
	this.unbindTooltips();
	this.destroyDIV();
};


MainMenuModule.prototype.register = function (_parentDiv)
{
	console.log('MainMenuModule::REGISTER');

	if (this.mContainer !== null)
	{
		console.error('ERROR: Failed to register Main Menu Module. Reason: Main Menu Module is already initialized.');
		return;
	}

	if (_parentDiv !== null && typeof(_parentDiv) == 'object')
	{
		this.create(_parentDiv);
	}
};

MainMenuModule.prototype.unregister = function ()
{
	console.log('MainMenuModule::UNREGISTER');

	if (this.mContainer === null)
	{
		console.error('ERROR: Failed to unregister Main Menu Module. Reason: Main Menu Module is not initialized.');
		return;
	}

	this.destroy();
};

MainMenuModule.prototype.isRegistered = function ()
{
	if (this.mContainer !== null)
	{
		return this.mContainer.parent().length !== 0;
	}

	return false;
};


MainMenuModule.prototype.registerEventListener = function(_listener)
{
	this.mEventListener = _listener;
};


MainMenuModule.prototype.setScenarioDemoModus = function ()
{
	this.mIsDemoModus = true;
};

MainMenuModule.prototype.showMainMenu = function (_withAnimation)
{
	this.createMainMenuButtons();
	this.show(_withAnimation);
};

MainMenuModule.prototype.showWorldMapMenu = function (_withAnimation, _isSavingAllowed, _seed)
{
	this.createWorldMapMenuButtons(_isSavingAllowed, _seed);
	this.show(_withAnimation);
};

MainMenuModule.prototype.showTacticalMapMenu = function (_withAnimation, _isRetreatAllowed, _isQuitAllowed, _quitText)
{
	this.createTacticalMapMenuButtons(_isRetreatAllowed, _isQuitAllowed, _quitText);
	this.show(_withAnimation);
};

// MainMenuModule.prototype.setFleeButtonEnabled = function (_enabled)
// {
// 	this.mFleeButton.showButton(_enabled);
// };


MainMenuModule.prototype.show = function (_withAnimation)
{
	var self = this;
	var withAnimation = (_withAnimation !== undefined && _withAnimation !== null) ? _withAnimation : true;
	if (withAnimation === true)
	{
		var moveTo = { opacity: 1, right: '10.0rem' };
		var offset = -this.mContainer.width();
		if (self.mContainer.hasClass('is-center') === true)
		{
			moveTo = { opacity: 1, left: '0', right: '0' };
			offset = -(this.mContainer.parent().width() + this.mContainer.width());
			this.mContainer.css({ 'left': '0' });
		}

		this.mContainer.css({ 'right': offset });
		this.mContainer.velocity("finish", true).velocity(moveTo,
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
			begin: function() {
				$(this).removeClass('display-none').addClass('display-block');
				self.notifyBackendModuleAnimating();
			},
			complete: function() {
				self.mIsVisible = true;
				self.notifyBackendModuleShown();
			}
		});

		/*
		self.mIsVisible = true;
		this.mContainer.removeClass('display-none').addClass('display-block');
		self.notifyBackendModuleShown();
		*/
	}
};

MainMenuModule.prototype.hide = function ()
{
	var self = this;

	var offset = -this.mContainer.width();
	if (self.mContainer.hasClass('is-center') === true)
	{
		offset = -(this.mContainer.parent().width() + this.mContainer.width());
	}

	this.mContainer.velocity("finish", true).velocity({ opacity: 0, right: offset },
	{
		duration: Constants.SCREEN_SLIDE_IN_OUT_DELAY,
		easing: 'swing',
		begin: function() {
			self.notifyBackendModuleAnimating();
		},
		complete: function() {
			self.mIsVisible = false;
			$(this).removeClass('display-block').addClass('display-none');
			self.notifyBackendModuleHidden();
		}
	});
};

MainMenuModule.prototype.isVisible = function ()
{
	return this.mIsVisible;
};


MainMenuModule.prototype.notifyBackendModuleShown = function ()
{
	SQ.call(this.mSQHandle, 'onModuleShown');
};

MainMenuModule.prototype.notifyBackendModuleHidden = function ()
{
	SQ.call(this.mSQHandle, 'onModuleHidden');
};

MainMenuModule.prototype.notifyBackendModuleAnimating = function ()
{
	SQ.call(this.mSQHandle, 'onModuleAnimating');
};

MainMenuModule.prototype.notifyBackendResumeButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onResumeButtonPressed');
};

MainMenuModule.prototype.notifyBackendNewCampaignButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onNewCampaignButtonPressed');
};

MainMenuModule.prototype.notifyBackendLoadCampaignButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onLoadCampaignButtonPressed');
};

MainMenuModule.prototype.notifyBackendSaveCampaignButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onSaveCampaignButtonPressed');
};

MainMenuModule.prototype.notifyBackendScenariosButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onScenariosButtonPressed');
};

MainMenuModule.prototype.notifyBackendOptionsButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onOptionsButtonPressed');
};

MainMenuModule.prototype.notifyBackendCreditsButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onCreditsButtonPressed');
};

MainMenuModule.prototype.notifyBackendQuitButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onQuitButtonPressed');
};

MainMenuModule.prototype.notifyBackendFleeButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onFleeButtonPressed');
};

MainMenuModule.prototype.notifyBackendRetireButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onRetireButtonPressed');
};