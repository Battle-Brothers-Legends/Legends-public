/*
 *  @Project:		Battle Brothers
 *	@Company:		Overhype Studios
 *
 *	@Copyright:		(c) Overhype Studios | 2013 - 2020
 * 
 *  @Author:		Overhype Studios
 *  @Date:			31.10.2017
 *  @Description:	World Town Screen JS
 */
"use strict";


var WorldTownScreen = function()
{
	this.mSQHandle					= null;

	// generic containers
	this.mContainer					= null;

	// modules
	this.mMainDialogModule			= null;
	this.mHireDialogModule			= null;
	this.mShopDialogModule			= null;
	this.mTravelDialogModule		= null;
	this.mBarberDialogModule		= null;
	this.mTempleDialogModule		= null;
	this.mTavernDialogModule		= null;
	this.mTrainingDialogModule	  = null;
	this.mTaxidermistDialogModule   = null;
	this.mStablesDialogModule	   = null;
	this.mActiveModule				= null;

	this.mAssetValues				= null;

	this.createModules();
};


WorldTownScreen.prototype.isConnected = function ()
{
	return this.mSQHandle !== null;
};

WorldTownScreen.prototype.onConnection = function (_handle)
{
	this.mSQHandle = _handle;
	this.register($('.root-screen'));
};

WorldTownScreen.prototype.onDisconnection = function ()
{
	this.mSQHandle = null;

	this.mMainDialogModule.onDisconnection();
	this.mHireDialogModule.onDisconnection();
	this.mShopDialogModule.onDisconnection();
	this.mTravelDialogModule.onDisconnection();
	this.mBarberDialogModule.onDisconnection();
	this.mTempleDialogModule.onDisconnection();
	this.mTavernDialogModule.onDisconnection();
	this.mTrainingDialogModule.onDisconnection();
	this.mTaxidermistDialogModule.onDisconnection();
	this.mStablesDialogModule.onDisconnection();

	this.unregister();
};

WorldTownScreen.prototype.onModuleOnConnectionCalled = function (_module)
{
	// check if every module is connected
	if ((this.mMainDialogModule !== null && this.mMainDialogModule.isConnected()) &&
		(this.mHireDialogModule !== null && this.mHireDialogModule.isConnected()) &&
		(this.mTravelDialogModule !== null && this.mTravelDialogModule.isConnected()) &&
		(this.mTempleDialogModule !== null && this.mTempleDialogModule.isConnected()) &&
		(this.mBarberDialogModule !== null && this.mBarberDialogModule.isConnected()) &&
		(this.mTavernDialogModule !== null && this.mTavernDialogModule.isConnected()) &&
		(this.mTrainingDialogModule !== null && this.mTrainingDialogModule.isConnected()) &&
		(this.mTaxidermistDialogModule !== null && this.mTaxidermistDialogModule.isConnected()) &&
		(this.mStablesDialogModule !== null && this.mStablesDialogModule.isConnected()) &&
		(this.mShopDialogModule !== null && this.mShopDialogModule.isConnected()) )
	{
		this.notifyBackendOnConnected();
	}
};

WorldTownScreen.prototype.onModuleOnDisconnectionCalled = function (_module)
{
	// check if every module is disconnected
	if ((this.mMainDialogModule === null && !this.mMainDialogModule.isConnected()) &&
		(this.mHireDialogModule === null && !this.mHireDialogModule.isConnected()) &&
		(this.mTravelDialogModule === null && !this.mTravelDialogModule.isConnected()) &&
		(this.mTempleDialogModule === null && !this.mTempleDialogModule.isConnected()) &&
		(this.mBarberDialogModule === null && !this.mBarberDialogModule.isConnected()) &&
		(this.mTavernDialogModule === null && !this.mTavernDialogModule.isConnected()) &&
		(this.mTrainingDialogModule === null && !this.mTrainingDialogModule.isConnected()) &&
		(this.mTaxidermistDialogModule === null && !this.mTaxidermistDialogModule.isConnected()) &&
		(this.mStablesDialogModule === null && !this.mStablesDialogModule.isConnected()) &&
		(this.mShopDialogModule === null && !this.mShopDialogModule.isConnected()) )
	{
		this.notifyBackendOnDisconnected();
	}
};

WorldTownScreen.prototype.createDIV = function (_parentDiv)
{
	// create: containers (init hidden!)
	this.mContainer = $('<div class="world-town-screen ui-control dialog-modal-background display-none opacity-none"/>');
	_parentDiv.append(this.mContainer);
};

WorldTownScreen.prototype.destroyDIV = function ()
{
	this.mContainer.empty();
	this.mContainer.remove();
	this.mContainer = null;
};

WorldTownScreen.prototype.createModules = function()
{
	this.mMainDialogModule = new WorldTownScreenMainDialogModule(this);
	this.mHireDialogModule = new WorldTownScreenHireDialogModule(this);
	this.mStablesDialogModule = new WorldTownScreenHireDialogModule(this);
	this.mShopDialogModule = new WorldTownScreenShopDialogModule(this);
	this.mTravelDialogModule = new WorldTownScreenTravelDialogModule(this);
	this.mTempleDialogModule = new WorldTownScreenTempleDialogModule(this);
	this.mBarberDialogModule = new WorldTownScreenBarberDialogModule(this);
	this.mTavernDialogModule = new WorldTownScreenTavernDialogModule(this);
	this.mTrainingDialogModule = new WorldTownScreenTrainingDialogModule(this);
	this.mTaxidermistDialogModule = new WorldTownScreenTaxidermistDialogModule(this);
};

WorldTownScreen.prototype.registerModules = function ()
{
	this.mMainDialogModule.register(this.mContainer);
	this.mHireDialogModule.register(this.mContainer);
	this.mShopDialogModule.register(this.mContainer);
	this.mTravelDialogModule.register(this.mContainer);
	this.mTempleDialogModule.register(this.mContainer);
	this.mBarberDialogModule.register(this.mContainer);
	this.mTavernDialogModule.register(this.mContainer);
	this.mTrainingDialogModule.register(this.mContainer);
	this.mStablesDialogModule.register(this.mContainer);
	this.mTaxidermistDialogModule.register(this.mContainer);
};

WorldTownScreen.prototype.unregisterModules = function ()
{
	this.mMainDialogModule.unregister();
	this.mHireDialogModule.unregister();
	this.mShopDialogModule.unregister();
	this.mTravelDialogModule.unregister();
	this.mTempleDialogModule.unregister();
	this.mBarberDialogModule.unregister();
	this.mTavernDialogModule.unregister();
	this.mTrainingDialogModule.unregister();
	this.mStablesDialogModule.unregister();
	this.mTaxidermistDialogModule.unregister();
};

WorldTownScreen.prototype.create = function(_parentDiv)
{
	this.createDIV(_parentDiv);
	this.registerModules();
};

WorldTownScreen.prototype.destroy = function()
{
	this.unregisterModules();
	this.destroyDIV();
};


WorldTownScreen.prototype.register = function (_parentDiv)
{
	console.log('WorldTownScreen::REGISTER');

	if(this.mContainer !== null)
	{
		console.error('ERROR: Failed to register World Town Screen. Reason: World Town Screen is already initialized.');
		return;
	}

	if(_parentDiv !== null && typeof(_parentDiv) == 'object')
	{
		this.create(_parentDiv);
	}
};

WorldTownScreen.prototype.unregister = function ()
{
	console.log('WorldTownScreen::UNREGISTER');

	if(this.mContainer === null)
	{
		console.error('ERROR: Failed to unregister World Town Screen. Reason: World Town Screen is not initialized.');
		return;
	}

	this.destroy();
};

WorldTownScreen.prototype.show = function (_data)
{
	if(_data !== undefined && _data !== null && typeof(_data) === 'object')
	{
		this.mMainDialogModule.loadFromData(_data);
		this.loadAssetData(_data['Assets']);
	}

	this.mActiveModule = null;

	var self = this;
	this.mContainer.velocity("finish", true).velocity({ opacity: 1 },
	{
		duration: Constants.SCREEN_FADE_IN_OUT_DELAY,
		easing: 'swing',
		begin: function ()
		{
			$(this).css({ opacity: 0 });
			$(this).removeClass('display-none').addClass('display-block');
			self.notifyBackendOnAnimating();
			self.showMainDialog(null);
		},
		complete: function ()
		{
			self.notifyBackendOnShown();
		}
	});
};

WorldTownScreen.prototype.hide = function ()
{
	var self = this;

	this.mActiveModule = null;

	this.mContainer.velocity("finish", true).velocity({ opacity: 0 },
	{
		duration: Constants.SCREEN_FADE_IN_OUT_DELAY,
		easing: 'swing',
		begin: function()
		{
			self.notifyBackendOnAnimating();
		},
		complete: function()
		{
			$(this).css({ opacity: 0 });
			$(this).removeClass('display-block').addClass('display-none');
			self.mMainDialogModule.mDialogContainer.findDialogContentContainer().empty();
			self.notifyBackendOnHidden();
		}
	});
};

WorldTownScreen.prototype.hideAllDialogs = function (_withSlideAnimation)
{
	this.mMainDialogModule.hide(false);
	
	if(this.mActiveModule != null)
	{
		this.mActiveModule.hide(_withSlideAnimation);
		this.mActiveModule = null;
	}

	this.mContainer.removeClass('display-block').addClass('display-none');
};

WorldTownScreen.prototype.refresh = function (_data)
{
	if (_data !== undefined && _data !== null && typeof (_data) === 'object')
	{
		this.mMainDialogModule.loadFromData(_data);
		this.loadAssetData(_data['Assets']);
	}

	if (this.mActiveModule != null)
	{
		this.mActiveModule.hide();
		this.mActiveModule = null;
	}

	this.mMainDialogModule.show(false);
};

WorldTownScreen.prototype.updateContracts = function (_data)
{
	this.mMainDialogModule.updateContracts(_data);
}

WorldTownScreen.prototype.showMainDialog = function (/*_withSlideAnimation,*/ _data)
{
	var _withSlideAnimation = true;

	this.mContainer.addClass('display-block').removeClass('display-none');

	if(this.mActiveModule != null)
		this.mActiveModule.hide(false);

	this.mActiveModule = null;

	if (_data != null)
		this.mAssetValues = null;
	else
		_withSlideAnimation = false;

	this.loadAssetData(_data);
	this.mMainDialogModule.show(_withSlideAnimation);
};

WorldTownScreen.prototype.showHireDialog = function (/*_withSlideAnimation,*/ _data)
{
	var _withSlideAnimation = true;

	this.mContainer.addClass('display-block').removeClass('display-none');

	if(this.mActiveModule != null)
		this.mActiveModule.hide(_withSlideAnimation);
	else
		this.mMainDialogModule.hide();

	this.mActiveModule = this.mHireDialogModule;

	if(_data !== undefined && _data !== null && typeof(_data) === 'object')
	{
		this.loadAssetData(_data.Assets);
		this.mHireDialogModule.loadFromData(_data.Roster);
	}

	this.mHireDialogModule.show(_withSlideAnimation);
};

WorldTownScreen.prototype.showStablesDialog = function (/*_withSlideAnimation,*/ _data)
{
	var _withSlideAnimation = true;

	this.mContainer.addClass('display-block').removeClass('display-none');

	if(this.mActiveModule != null)
		this.mActiveModule.hide(_withSlideAnimation);
	else
		this.mMainDialogModule.hide();

	this.mActiveModule = this.mStablesDialogModule;

	if(_data !== undefined && _data !== null && typeof(_data) === 'object')
	{
		this.loadAssetData(_data.Assets);
		this.mStablesDialogModule.loadFromData(_data.Roster);
	}

	this.mStablesDialogModule.show(_withSlideAnimation);
};

WorldTownScreen.prototype.showShopDialog = function (/*_withSlideAnimation,*/ _data)
{
	var _withSlideAnimation = true;

	this.mContainer.addClass('display-block').removeClass('display-none');

	if (this.mActiveModule != null)
		this.mActiveModule.hide(_withSlideAnimation);
	else
		this.mMainDialogModule.hide();

	this.mActiveModule = this.mShopDialogModule;

	if(_data !== undefined && _data !== null && typeof(_data) === 'object')
	{
		this.loadAssetData(_data.Assets);
		this.mShopDialogModule.loadFromData(_data);
	}

	this.mShopDialogModule.show(_withSlideAnimation, _data);
};

WorldTownScreen.prototype.showTravelDialog = function (/*_withSlideAnimation,*/ _data)
{
	var _withSlideAnimation = true;

	this.mContainer.addClass('display-block').removeClass('display-none');

	if(this.mActiveModule != null)
		this.mActiveModule.hide(_withSlideAnimation);
	else
		this.mMainDialogModule.hide();

	this.mActiveModule = this.mTravelDialogModule;

	if(_data !== undefined && _data !== null && typeof(_data) === 'object')
	{
		this.loadAssetData(_data.Assets);
		this.mTravelDialogModule.loadFromData(_data.Data);
	}

	this.mTravelDialogModule.show(_withSlideAnimation);
};

WorldTownScreen.prototype.showBarberDialog = function (/*_withSlideAnimation,*/ _data)
{
	var _withSlideAnimation = true;

	this.mContainer.addClass('display-block').removeClass('display-none');

	if(this.mActiveModule != null)
		this.mActiveModule.hide(_withSlideAnimation);
	else
		this.mMainDialogModule.hide();

	this.mActiveModule = this.mBarberDialogModule;

	if(_data !== undefined && _data !== null && typeof(_data) === 'object')
	{
		this.loadAssetData(_data.Assets);
		this.mBarberDialogModule.loadFromData(_data);
	}

	this.mBarberDialogModule.show(_withSlideAnimation);
};

WorldTownScreen.prototype.showTempleDialog = function (/*_withSlideAnimation,*/ _data)
{
	var _withSlideAnimation = true;

	this.mContainer.addClass('display-block').removeClass('display-none');

	if (this.mActiveModule != null)
		this.mActiveModule.hide(_withSlideAnimation);
	else
		this.mMainDialogModule.hide();

	this.mActiveModule = this.mTempleDialogModule;

	if (_data !== undefined && _data !== null && typeof (_data) === 'object')
	{
		this.loadAssetData(_data.Assets);
		this.mTempleDialogModule.loadFromData(_data);
	}

	this.mTempleDialogModule.show(_withSlideAnimation);
};

WorldTownScreen.prototype.showTrainingDialog = function (/*_withSlideAnimation,*/ _data)
{
	var _withSlideAnimation = true;

	this.mContainer.addClass('display-block').removeClass('display-none');

	if (this.mActiveModule != null)
		this.mActiveModule.hide(_withSlideAnimation);
	else
		this.mMainDialogModule.hide();

	this.mActiveModule = this.mTrainingDialogModule;

	if (_data !== undefined && _data !== null && typeof (_data) === 'object')
	{
		this.loadAssetData(_data.Assets);
		this.mTrainingDialogModule.loadFromData(_data);
	}

	this.mTrainingDialogModule.show(_withSlideAnimation);
};

WorldTownScreen.prototype.showTaxidermistDialog = function (/*_withSlideAnimation,*/ _data)
{
	var _withSlideAnimation = true;

	this.mContainer.addClass('display-block').removeClass('display-none');

	if (this.mActiveModule != null)
		this.mActiveModule.hide(_withSlideAnimation);
	else
		this.mMainDialogModule.hide();

	this.mActiveModule = this.mTaxidermistDialogModule;

	if (_data !== undefined && _data !== null && typeof (_data) === 'object')
	{
		this.loadAssetData(_data.Assets);
		this.mTaxidermistDialogModule.loadFromData(_data);
	}

	this.mTaxidermistDialogModule.show(_withSlideAnimation);
};

WorldTownScreen.prototype.showTavernDialog = function (/*_withSlideAnimation,*/ _data)
{
	var _withSlideAnimation = true;

	this.mContainer.addClass('display-block').removeClass('display-none');

	if(this.mActiveModule != null)
		this.mActiveModule.hide(_withSlideAnimation);
	else
		this.mMainDialogModule.hide();

	this.mActiveModule = this.mTavernDialogModule;

	if(_data !== undefined && _data !== null && typeof(_data) === 'object')
	{
		this.loadAssetData(_data.Assets);
		this.mTavernDialogModule.loadFromData(_data);
	}

	this.mTavernDialogModule.show(_withSlideAnimation);
};

WorldTownScreen.prototype.loadAssetData = function (_data)
{
	if(_data !== undefined && _data !== null)
	{	 
		this.mMainDialogModule.updateAssets(_data);

		if(this.mActiveModule != null)
			this.mActiveModule.updateAssets(_data);

		this.mAssetValues = _data;
	}
};

WorldTownScreen.prototype.getModule = function (_name)
{
	switch(_name)
	{
		case 'MainDialogModule': return this.mMainDialogModule;
		case 'HireDialogModule': return this.mHireDialogModule;
		case 'ShopDialogModule': return this.mShopDialogModule;
		case 'TravelDialogModule': return this.mTravelDialogModule;
		case 'TempleDialogModule': return this.mTempleDialogModule;
		case 'BarberDialogModule': return this.mBarberDialogModule;
		case 'TavernDialogModule': return this.mTavernDialogModule;
		case 'TrainingDialogModule': return this.mTrainingDialogModule;
		case 'TaxidermistDialogModule': return this.mTaxidermistDialogModule;
		case 'StablesDialogModule': return this.mStablesDialogModule;
		default: return null;
	}
};

WorldTownScreen.prototype.getModules = function ()
{
	return [
		{ name: 'MainDialogModule', module: this.mMainDialogModule },
		{ name: 'HireDialogModule', module: this.mHireDialogModule },
		{ name: 'TravelDialogModule', module: this.mTravelDialogModule },
		{ name: 'ShopDialogModule', module: this.mShopDialogModule },
		{ name: 'TempleDialogModule', module: this.mTempleDialogModule },
		{ name: 'BarberDialogModule', module: this.mBarberDialogModule },
		{ name: 'TrainingDialogModule', module: this.mTrainingDialogModule },
		{ name: 'TaxidermistDialogModule', module: this.mTaxidermistDialogModule },
		{ name: 'TavernDialogModule', module: this.mTavernDialogModule },
		{ name: 'StablesDialogModule', module: this.mStablesDialogModule }
	];
};

WorldTownScreen.prototype.notifyBackendOnConnected = function ()
{
	if(this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onScreenConnected');
	}
};

WorldTownScreen.prototype.notifyBackendOnDisconnected = function ()
{
	if(this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onScreenDisconnected');
	}
};

WorldTownScreen.prototype.notifyBackendOnShown = function ()
{
	if(this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onScreenShown');
	}
};

WorldTownScreen.prototype.notifyBackendOnHidden = function ()
{
	if(this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onScreenHidden');
	}
};

WorldTownScreen.prototype.notifyBackendOnAnimating = function ()
{
	if(this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onScreenAnimating');
	}
};

WorldTownScreen.prototype.notifyBackendBrothersButtonPressed = function ()
{
	if(this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onBrothersButtonPressed');
	}
};

WorldTownScreen.prototype.notifyBackendSlotClicked = function (_data)
{
	if(this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onSlotClicked', _data);
	}
};

WorldTownScreen.prototype.notifyBackendContractClicked = function (_data)
{
	if(this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onContractClicked', _data);
	}
};