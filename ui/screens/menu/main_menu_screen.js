/*
 *  @Project:		Battle Brothers
 *	@Company:		Overhype Studios
 *
 *	@Copyright:		(c) Overhype Studios | 2013 - 2020
 *
 *  @Author:		Overhype Studios
 *  @Date:			01.10.2017
 *  @Description:	Main Main Menu Screen JS
 */
"use strict";


var MainMenuScreen = function()
{
	this.mSQHandle  = null;
	//this.mCampaignDatasource = new CampaignMenuDatasource();

	// container
	this.mContainer = null;
	this.mContentContainer = null;

	// modules
	this.mMainMenuModule = null;
	this.mLoadCampaignModule = null;
	this.mNewCampaignModule = null;
	this.mScenarioMenuModule = null;
	this.mOptionsMenuModule = null;
	this.mCreditsModule = null;

	this.createModules();
};


MainMenuScreen.prototype.isConnected = function ()
{
	return this.mSQHandle !== null;
};

MainMenuScreen.prototype.onConnection = function (_handle)
{
	this.mSQHandle = _handle;
	this.register($('.root-screen'));
};

MainMenuScreen.prototype.onDisconnection = function ()
{
	this.mSQHandle = null;
   // this.mCampaignDatasource.onDisconnection();

	this.mMainMenuModule.onDisconnection();
	this.mLoadCampaignModule.onDisconnection();
	this.mNewCampaignModule.onDisconnection();
	this.mScenarioMenuModule.onDisconnection();
	this.mOptionsMenuModule.onDisconnection();
	this.mCreditsModule.onDisconnection();

	this.unregister();
};

MainMenuScreen.prototype.onModuleOnConnectionCalled = function (_module)
{
	// check if every module is connected
	if ((this.mMainMenuModule !== null && this.mMainMenuModule.isConnected()) &&
		(this.mLoadCampaignModule !== null && this.mLoadCampaignModule.isConnected()) &&
		(this.mNewCampaignModule !== null && this.mNewCampaignModule.isConnected()) &&
		(this.mOptionsMenuModule !== null && this.mOptionsMenuModule.isConnected()) &&
		(this.mCreditsModule !== null && this.mCreditsModule.isConnected()) &&
		(this.mScenarioMenuModule !== null && this.mScenarioMenuModule.isConnected()))
	{
		this.notifyBackendOnConnected();
	}
};

MainMenuScreen.prototype.onModuleOnDisconnectionCalled = function (_module)
{
	// check if every module is disconnected
	if ((this.mMainMenuModule === null && !this.mMainMenuModule.isConnected()) &&
		(this.mLoadCampaignModule === null && !this.mLoadCampaignModule.isConnected()) &&
		(this.mNewCampaignModule === null && !this.mNewCampaignModule.isConnected()) &&
		(this.mOptionsMenuModule === null && !this.mOptionsMenuModule.isConnected()) &&
		(this.mCreditsModule === null && !this.mCreditsModule.isConnected()) &&
		(this.mScenarioMenuModule === null && !this.mScenarioMenuModule.isConnected()))
	{
		this.notifyBackendOnDisconnected();
	}
};


MainMenuScreen.prototype.createDIV = function (_parentDiv)
{
	// create: container
	this.mContainer = $('<div class="main-menu-screen display-none"/>');
	_parentDiv.append(this.mContainer);

	// background image
	this.mBackgroundImage = this.mContainer.createImage(null, function (_image)
	{
		_image.removeClass('display-none').addClass('display-block');
		_image.fitImageToParent();
	}, function (_image)
	{
		_image.fitImageToParent();
	}, 'display-none');

	//this.mBackgroundImage.velocity("finish", true).velocity({ scaleX: 1.3, scaleY: 1.3, translateY: 50.0 },

	this.mVersion = $('<div class="text-font-medium font-color-subtitle version"/>');
	this.mContainer.append(this.mVersion);

	this.mLegendsVersion = $('<div class="text-font-medium font-color-subtitle legends-version"/>');
	this.mContainer.append(this.mLegendsVersion);

	this.mDLC = $('<div class="dlc-container"/>');
	this.mContainer.append(this.mDLC);

	this.mLMOTDContainer = $('<div class="legends-motd-container display-none"/>');
	this.mContainer.append(this.mLMOTDContainer);

	this.mLMOTD = $('<div class="legends-motd text-font-medium font-color-subtitle"/>');
	this.mLMOTDContainer.append(this.mLMOTD);

	this.mMOTDContainer = $('<div class="motd-container"/>');
	this.mContainer.append(this.mMOTDContainer);

	this.mMOTD = $('<div class="motd text-font-medium font-color-subtitle"/>');
	this.mMOTDContainer.append(this.mMOTD);

	// content container
	this.mContentContainer = $('<div class="screen-content"/>');
	this.mContainer.append(this.mContentContainer);
};

MainMenuScreen.prototype.destroyDIV = function ()
{
	this.mContentContainer.empty();
	this.mContentContainer = null;

	this.mContainer.empty();
	this.mContainer.remove();
	this.mContainer = null;
};


MainMenuScreen.prototype.createModules = function()
{
	this.mMainMenuModule = new MainMenuModule('right');
	this.mMainMenuModule.registerEventListener(this);

	this.mLoadCampaignModule = new LoadCampaignMenuModule(/*this.mCampaignDatasource*/);
	this.mLoadCampaignModule.registerEventListener(this);

	this.mNewCampaignModule = new NewCampaignMenuModule(/*this.mCampaignDatasource*/);
	this.mNewCampaignModule.registerEventListener(this);

	this.mScenarioMenuModule = new ScenarioMenuModule();
	this.mScenarioMenuModule.registerEventListener(this);

	this.mOptionsMenuModule = new OptionsMenuModule();
	this.mOptionsMenuModule.registerEventListener(this);

	this.mCreditsModule = new CreditsModule();
	this.mCreditsModule.registerEventListener(this);
};

MainMenuScreen.prototype.registerModules = function ()
{
	this.mMainMenuModule.register(this.mContentContainer);
	this.mLoadCampaignModule.register(this.mContentContainer);
	this.mNewCampaignModule.register(this.mContentContainer);
	this.mScenarioMenuModule.register(this.mContentContainer);
	this.mOptionsMenuModule.register(this.mContentContainer);
	this.mCreditsModule.register(this.mContentContainer);
};

MainMenuScreen.prototype.unregisterModules = function ()
{
	this.mMainMenuModule.unregister();
	this.mLoadCampaignModule.unregister();
	this.mNewCampaignModule.unregister();
	this.mScenarioMenuModule.unregister();
	this.mOptionsMenuModule.unregister();
	this.mCreditsModule.unregister();
};


MainMenuScreen.prototype.create = function(_parentDiv)
{
	this.createDIV(_parentDiv);
	this.registerModules();
};

MainMenuScreen.prototype.destroy = function()
{
	this.unregisterModules();
	this.destroyDIV();
};


MainMenuScreen.prototype.register = function (_parentDiv)
{
	console.log('MainMenuScreen::REGISTER');

	if (this.mContainer !== null)
	{
		console.error('ERROR: Failed to register Main Menu Screen. Reason: Main Menu Screen is already initialized.');
		return;
	}

	if (_parentDiv !== null && typeof(_parentDiv) == 'object')
	{
		this.create(_parentDiv);
	}
};

MainMenuScreen.prototype.unregister = function ()
{
	console.log('MainMenuScreen::UNREGISTER');

	if (this.mContainer === null)
	{
		console.error('ERROR: Failed to unregister Main Menu Screen. Reason: Main Menu Screen is not initialized.');
		return;
	}

	this.destroy();
};

MainMenuScreen.prototype.isRegistered = function ()
{
	if (this.mContainer !== null)
	{
		return this.mContainer.parent().length !== 0;
	}

	return false;
};


MainMenuScreen.prototype.registerEventListener = function (_listener)
{
	this.mEventListener = _listener;
};


MainMenuScreen.prototype.setScenarioDemoModus = function ()
{
	this.mMainMenuModule.setScenarioDemoModus();
};

MainMenuScreen.prototype.show = function (_animate)
{
	this.mMainMenuModule.showMainMenu(false);

	var bg = ['08', '09', '10', '11'];

	this.mBackgroundImage.attr('src', Path.GFX + Asset.BACKGROUND_MAIN_MENU + bg[Math.floor(Math.random() * bg.length)] + '.jpg');
	this.mContainer.removeClass('display-none').addClass('display-block');

	if(_animate)
	{
		/*this.mBackgroundImage.velocity("finish", true).velocity({ scaleX: 1.3, scaleY: 1.3, translateX: 200.0, translateY: 50.0 },
		{
			duration: 0
		}).velocity("finish", true).velocity({ scaleX: 1.0, scaleY: 1.0, translateX: 0.0, translateY: 0.0 },
		{
			duration: 25000,
			easing: 'ease-out'
		});*/
	}

	this.notifyBackendOnShown();
};

MainMenuScreen.prototype.noshow = function ()
{
	this.mMainMenuModule.setScenarioDemoModus();
	this.mMainMenuModule.showMainMenu(false);

	this.mBackgroundImage.attr('src', Path.GFX + Asset.BACKGROUND_MAIN_MENU);
	this.mContainer.removeClass('display-none').addClass('display-block');

	this.notifyBackendOnShown();
};

MainMenuScreen.prototype.hide = function ()
{
	this.mBackgroundImage.attr('src', '');
	this.mContainer.removeClass('display-block').addClass('display-none');

	this.notifyBackendOnHidden();
};

MainMenuScreen.prototype.showMainMenu = function ()
{
	this.mMainMenuModule.show();
	this.mLoadCampaignModule.hide();
	this.mNewCampaignModule.hide();
	this.mScenarioMenuModule.hide();
	this.mOptionsMenuModule.hide();
};

MainMenuScreen.prototype.showLoadCampaignMenu = function (_data)
{
	//this.mCampaignDatasource.loadCampaigns();

	this.mMainMenuModule.hide();
	this.mLoadCampaignModule.show(_data);
};

MainMenuScreen.prototype.hideLoadCampaignMenu = function ()
{
	this.mMainMenuModule.show();
	this.mLoadCampaignModule.hide();
};

MainMenuScreen.prototype.showNewCampaignMenu = function ()
{
	this.mMainMenuModule.hide();
	this.mNewCampaignModule.show();
};

MainMenuScreen.prototype.hideNewCampaignMenu = function ()
{
	this.mMainMenuModule.show();
	this.mNewCampaignModule.hide();
};

MainMenuScreen.prototype.showScenarioMenu = function (_data)
{
	this.mMainMenuModule.hide();
	this.mScenarioMenuModule.show(_data);
};

MainMenuScreen.prototype.hideScenarioMenu = function ()
{
	this.mMainMenuModule.show();
	this.mScenarioMenuModule.hide();
};

MainMenuScreen.prototype.showCredits = function (_data)
{
	this.mMainMenuModule.hide();
	this.mCreditsModule.show(_data);
};

MainMenuScreen.prototype.hideCredits = function ()
{
	this.mMainMenuModule.show();
	this.mCreditsModule.hide();
};

MainMenuScreen.prototype.showOptionsMenu = function (_data)
{
	this.mMainMenuModule.hide();
	this.mOptionsMenuModule.show(_data);
};

MainMenuScreen.prototype.hideOptionsMenu = function ()
{
	this.mMainMenuModule.show();
	this.mOptionsMenuModule.hide();
};

MainMenuScreen.prototype.addCrossMarketing = function ()
{
    this.mMarketingContainer = $('<div class="marketing-container"/>');
    this.mContainer.append(this.mMarketingContainer);

    this.mMarketing = $('<div class="marketing text-font-medium font-color-subtitle">Wishlist our new game!</>');
    this.mMarketingContainer.append(this.mMarketing);

    this.setDLCClickHandler(this.mMarketing, 'steam://advertise/2432860');

    var img = this.mDLC.createImage(null, null, null, 'marketing-image');
    img.attr('src', Path.GFX + 'ui/images/cross_marketing.jpg');
    this.mMarketing.append(img);
};

MainMenuScreen.prototype.setVersion = function (_v)
{
	this.mVersion.text(_v[0]);
	this.mLegendsVersion.text(_v[1]);
};

MainMenuScreen.prototype.setDLC = function (_data)
{
	for (var i = 0; i < _data.length; ++i)
	{
		var img = this.mDLC.createImage(null, null, null, 'dlc-image');
		img.attr('src', Path.GFX + _data[i].Image);
		img.bindTooltip({ contentType: 'ui-element', elementId: _data[i].Tooltip });

		if (_data[i].URL != null)
		{
			this.setDLCClickHandler(img, _data[i].URL);
		}
	}
};

MainMenuScreen.prototype.setDLCClickHandler = function (_obj, _url)
{
	_obj.on("click", function ()
	{
		openURL(_url);
	});
};

MainMenuScreen.prototype.setMOTD = function (_data)
{
	var parsedDescriptionText = XBBCODE.process({
		text: _data,
		removeMisalignedTags: false,
		addInLineBreaks: true
	});

	this.mMOTD.html(parsedDescriptionText.html);

};

MainMenuScreen.prototype.setLMOTD = function (_data)
{
	var parsedDescriptionText = XBBCODE.process({
		text: _data,
		removeMisalignedTags: false,
		addInLineBreaks: true
	});
	this.mMOTDContainer.removeClass('display-block').addClass('display-none');
	this.mLMOTDContainer.removeClass('display-none').addClass('display-block');

	this.mLMOTD.html(parsedDescriptionText.html);

	this.disableGameButtons();
};

MainMenuScreen.prototype.disableGameButtons = function(){
	this.mMainMenuModule.mDisableButtons = true;
}

MainMenuScreen.prototype.getModule = function (_name)
{
	switch(_name)
	{
		case 'MainMenuModule': return this.mMainMenuModule;
		//case 'CampaignDatasourceModule': return this.mCampaignDatasource;
		case 'LoadCampaignModule': return this.mLoadCampaignModule;
		case 'NewCampaignModule': return this.mNewCampaignModule;
		case 'ScenarioMenuModule': return this.mScenarioMenuModule;
		case 'OptionsMenuModule': return this.mOptionsMenuModule;
		case 'CreditsModule': return this.mCreditsModule;
		default: return null;
	}
};

MainMenuScreen.prototype.getModules = function ()
{
	return [
		{ name: 'MainMenuModule', module: this.mMainMenuModule },
		//{ name: 'CampaignDatasourceModule', module: this.mCampaignDatasource },
		{ name: 'LoadCampaignModule', module: this.mLoadCampaignModule },
		{ name: 'NewCampaignModule', module: this.mNewCampaignModule },
		{ name: 'ScenarioMenuModule', module: this.mScenarioMenuModule },
		{ name: 'OptionsMenuModule', module: this.mOptionsMenuModule },
		{ name: 'CreditsModule', module: this.mCreditsModule }
	];
};


MainMenuScreen.prototype.notifyBackendOnConnected = function ()
{
	SQ.call(this.mSQHandle, 'onScreenConnected');
};

MainMenuScreen.prototype.notifyBackendOnDisconnected = function ()
{
	SQ.call(this.mSQHandle, 'onScreenDisconnected');
};

MainMenuScreen.prototype.notifyBackendOnShown = function ()
{
	SQ.call(this.mSQHandle, 'onScreenShown');
};

MainMenuScreen.prototype.notifyBackendOnHidden = function ()
{
	if (this.mSQHandle != null)
	{
		SQ.call(this.mSQHandle, 'onScreenHidden');
	}
};

