/*
 *  @Project:		Battle Brothers
 *	@Company:		Overhype Studios
 *
 *	@Copyright:		(c) Overhype Studios | 2013 - 2017
 * 
 *  @Author:		Overhype Studios
 *  @Date:			31.10.2017
 *  @Description:	World Town Screen JS
 */
"use strict";


var CampScreen = function()
{
	this.mSQHandle					= null;

	// generic containers
	this.mContainer					= null;

	// modules
	this.mMainDialogModule			= null;
	this.mCommanderDialogModule		= null;
	this.mBarberDialogModule		= null;
	this.mCraftingDialogModule			= null;
	this.mEnchanterDialogModule		= null;
	this.mFletcherDialogModule		= null;
	this.mHealerDialogModule		= null;
	this.mTrainingDialogModule	  = null;
	this.mHunterDialogModule   = null;
	this.mPainterDialogModule		= null;
	this.mRepairDialogModule   = null;
	this.mRestDialogModule   = null;
	this.mScoutDialogModule   = null;
	this.mGathererDialogModule = null;
	this.mWorkshopDialogModule = null;

	this.mActiveModule				= null;
	this.mAssetValues				= null;

	this.createModules();
};


CampScreen.prototype.isConnected = function ()
{
	return this.mSQHandle !== null;
};

CampScreen.prototype.onConnection = function (_handle)
{
	this.mSQHandle = _handle;
	this.register($('.root-screen'));
};

CampScreen.prototype.onDisconnection = function ()
{
	this.mSQHandle = null;

	this.mMainDialogModule.onDisconnection();
	this.mCommanderDialogModule.onDisconnection();
	this.mBarberDialogModule.onDisconnection();
	this.mCraftingDialogModule.onDisconnection();
	this.mEnchanterDialogModule.onDisconnection();
	this.mFletcherDialogModule.onDisconnection();
	this.mHealerDialogModule.onDisconnection();
	this.mTrainingDialogModule.onDisconnection();
	this.mHunterDialogModule.onDisconnection();
	this.mPainterDialogModule.onDisconnection();
	this.mRepairDialogModule.onDisconnection();
	this.mRestDialogModule.onDisconnection();
	this.mScoutDialogModule.onDisconnection();
	this.mGathererDialogModule.onDisconnection();
	this.mWorkshopDialogModule.onDisconnection();
	this.unregister();
};

CampScreen.prototype.onModuleOnConnectionCalled = function (_module)
{
	// check if every module is connected
	if ((this.mMainDialogModule !== null && this.mMainDialogModule.isConnected()) &&
		(this.mCommanderDialogModule !== null && this.mCommanderDialogModule.isConnected()) &&
		(this.mBarberDialogModule !== null && this.mBarberDialogModule.isConnected()) &&
		(this.mCraftingDialogModule !== null && this.mCraftingDialogModule.isConnected()) &&
		(this.mEnchanterDialogModule !== null && this.mEnchanterDialogModule.isConnected()) &&
		(this.mFletcherDialogModule !== null && this.mFletcherDialogModule.isConnected()) &&
		(this.mHealerDialogModule !== null && this.mHealerDialogModule.isConnected()) &&
		(this.mTrainingDialogModule !== null && this.mTrainingDialogModule.isConnected()) &&
		(this.mHunterDialogModule !== null && this.mHunterDialogModule.isConnected()) &&
		(this.mPainterDialogModule !== null && this.mPainterDialogModule.isConnected()) &&
		(this.mRepairDialogModule !== null && this.mRepairDialogModule.isConnected()) &&
		(this.mRestDialogModule !== null && this.mRestDialogModule.isConnected()) &&
		(this.mScoutDialogModule !== null && this.mScoutDialogModule.isConnected()) &&
		(this.mGathererDialogModule !== null && this.mGathererDialogModule.isConnected()) &&
		(this.mWorkshopDialogModule !== null && this.mWorkshopDialogModule.isConnected()))
	{
		this.notifyBackendOnConnected();
	}
};

CampScreen.prototype.onModuleOnDisconnectionCalled = function (_module)
{
	// check if every module is disconnected
	if ((this.mMainDialogModule === null && !this.mMainDialogModule.isConnected()) &&
		(this.mCommanderDialogModule === null && !this.mCommanderDialogModule.isConnected()) &&
		(this.mBarberDialogModule === null && !this.mBarberDialogModule.isConnected()) &&
		(this.mCraftingDialogModule === null && !this.mCraftingDialogModule.isConnected()) &&
		(this.mEnchanterDialogModule === null && !this.mEnchanterDialogModule.isConnected()) &&
		(this.mFletcherDialogModule === null && !this.mFletcherDialogModule.isConnected()) &&
		(this.mHealerDialogModule === null && !this.mHealerDialogModule.isConnected()) &&
		(this.mTrainingDialogModule === null && !this.mTrainingDialogModule.isConnected()) &&
		(this.mHunterDialogModule === null && !this.mHunterDialogModule.isConnected()) &&
		(this.mPainterDialogModule === null && !this.mPainterDialogModule.isConnected()) &&
		(this.mRepairDialogModule === null && !this.mRepairDialogModule.isConnected()) &&
		(this.mRestDialogModule === null && !this.mRestDialogModule.isConnected()) &&
		(this.mScoutDialogModule === null && !this.mScoutDialogModule.isConnected()) &&
		(this.mGathererDialogModule === null && !this.mGathererDialogModule.isConnected()) &&
		(this.mWorkshopDialogModule === null && !this.mWorkshopDialogModule.isConnected()))
	{
		this.notifyBackendOnDisconnected();
	}
};

CampScreen.prototype.createDIV = function (_parentDiv)
{
	// create: containers (init hidden!)
	this.mContainer = $('<div class="camp-screen ui-control dialog-modal-background display-none opacity-none"/>');
	_parentDiv.append(this.mContainer);
};

CampScreen.prototype.destroyDIV = function ()
{
	this.mContainer.empty();
	this.mContainer.remove();
	this.mContainer = null;
};

CampScreen.prototype.createModules = function()
{
	this.mMainDialogModule = new CampScreenMainDialogModule(this);
	this.mCommanderDialogModule = new CampScreenCommanderDialogModule(this);
	this.mBarberDialogModule = new WorldTownScreenBarberDialogModule(this);
	this.mCraftingDialogModule = new CampScreenCraftingDialogModule(this);
	this.mEnchanterDialogModule = new CampScreenCraftingDialogModule(this);
	this.mFletcherDialogModule = new CampScreenFletcherDialogModule(this);
	this.mHealerDialogModule = new CampScreenHealerDialogModule(this);
	this.mTrainingDialogModule = new CampScreenTrainingDialogModule(this);
	this.mHunterDialogModule = new CampScreenHunterDialogModule(this);
	this.mPainterDialogModule = new CampScreenPainterDialogModule(this);
	this.mRepairDialogModule  = new CampScreenRepairDialogModule(this);
	this.mRestDialogModule  = new CampScreenRestDialogModule(this);
	this.mScoutDialogModule = new CampScreenScoutDialogModule(this);
	this.mGathererDialogModule = new CampScreenGathererDialogModule(this);
	this.mWorkshopDialogModule = new CampScreenWorkshopDialogModule(this);

};

CampScreen.prototype.registerModules = function ()
{
	this.mMainDialogModule.register(this.mContainer);
	this.mCommanderDialogModule.register(this.mContainer);
	this.mBarberDialogModule.register(this.mContainer);
	this.mCraftingDialogModule.register(this.mContainer);
	this.mEnchanterDialogModule.register(this.mContainer);
	this.mFletcherDialogModule.register(this.mContainer);
	this.mHealerDialogModule.register(this.mContainer);
	this.mTrainingDialogModule.register(this.mContainer);
	this.mHunterDialogModule.register(this.mContainer);
	this.mPainterDialogModule.register(this.mContainer);
	this.mRepairDialogModule.register(this.mContainer);
	this.mRestDialogModule.register(this.mContainer);
	this.mScoutDialogModule.register(this.mContainer);
	this.mGathererDialogModule.register(this.mContainer);
	this.mWorkshopDialogModule.register(this.mContainer);
};

CampScreen.prototype.unregisterModules = function ()
{
	this.mMainDialogModule.unregister();
	this.mCommanderDialogModule.unregister();
	this.mBarberDialogModule.unregister();
	this.mCraftingDialogModule.unregister();
	this.mEnchanterDialogModule.unregister();
	this.mFletcherDialogModule.unregister();
	this.mHealerDialogModule.unregister();
	this.mTrainingDialogModule.unregister();
	this.mHunterDialogModule.unregister();
	this.mPainterDialogModule.unregister();
	this.mRepairDialogModule.unregister();
	this.mRestDialogModule.unregister();
	this.mScoutDialogModule.unregister();
	this.mGathererDialogModule.unregister();
	this.mWorkshopDialogModule.unregister();
};

CampScreen.prototype.create = function(_parentDiv)
{
	this.createDIV(_parentDiv);
	this.registerModules();
};

CampScreen.prototype.destroy = function()
{
	this.unregisterModules();
	this.destroyDIV();
};


CampScreen.prototype.register = function (_parentDiv)
{
	console.log('CampScreen::REGISTER');

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

CampScreen.prototype.unregister = function ()
{
	console.log('CampScreen::UNREGISTER');

	if(this.mContainer === null)
	{
		console.error('ERROR: Failed to unregister World Town Screen. Reason: World Town Screen is not initialized.');
		return;
	}

	this.destroy();
};

CampScreen.prototype.show = function (_data)
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

CampScreen.prototype.hide = function ()
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

CampScreen.prototype.hideAllDialogs = function (_withSlideAnimation)
{
	this.mMainDialogModule.hide(false);
	
	if(this.mActiveModule != null)
	{
		this.mActiveModule.hide(_withSlideAnimation);
		this.mActiveModule = null;
	}

	this.mContainer.removeClass('display-block').addClass('display-none');
};

CampScreen.prototype.refresh = function (_data)
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

CampScreen.prototype.showMainDialog = function (/*_withSlideAnimation,*/ _data)
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

CampScreen.prototype.showCommanderDialog = function (/*_withSlideAnimation,*/ _data)
{
	var _withSlideAnimation = true;

	this.mContainer.addClass('display-block').removeClass('display-none');

	if(this.mActiveModule != null)
		this.mActiveModule.hide(_withSlideAnimation);
	else
		this.mMainDialogModule.hide();

	this.mActiveModule = this.mCommanderDialogModule;

	if(_data !== undefined && _data !== null && typeof(_data) === 'object')
	{
		//this.loadAssetData(_data.Assets);
		this.mCommanderDialogModule.loadFromData(_data);
	}

	this.mCommanderDialogModule.show(_withSlideAnimation);
};

CampScreen.prototype.showBarberDialog = function (/*_withSlideAnimation,*/ _data)
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

CampScreen.prototype.showCraftingDialog = function (/*_withSlideAnimation,*/ _data)
{
	var _withSlideAnimation = true;

	this.mContainer.addClass('display-block').removeClass('display-none');

	if (this.mActiveModule != null)
		this.mActiveModule.hide(_withSlideAnimation);
	else
		this.mMainDialogModule.hide();

	this.mActiveModule = this.mCraftingDialogModule;

	if (_data !== undefined && _data !== null && typeof (_data) === 'object')
	{
		this.loadAssetData(_data.Assets);
		this.mCraftingDialogModule.loadFromData(_data);
	}

	this.mCraftingDialogModule.show(_withSlideAnimation);
};

CampScreen.prototype.showTrainingDialog = function (/*_withSlideAnimation,*/ _data)
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

CampScreen.prototype.showCraftingDialog = function (/*_withSlideAnimation,*/ _data)
{
	var _withSlideAnimation = true;

	this.mContainer.addClass('display-block').removeClass('display-none');

	if (this.mActiveModule != null)
		this.mActiveModule.hide(_withSlideAnimation);
	else
		this.mMainDialogModule.hide();

	this.mActiveModule = this.mCraftingDialogModule;

	if (_data !== undefined && _data !== null && typeof (_data) === 'object')
	{
		this.loadAssetData(_data.Assets);
		this.mCraftingDialogModule.loadFromData(_data);
	}

	this.mCraftingDialogModule.show(_withSlideAnimation);
};

CampScreen.prototype.showEnchanterDialog = function (/*_withSlideAnimation,*/ _data)
{
	var _withSlideAnimation = true;

	this.mContainer.addClass('display-block').removeClass('display-none');

	if(this.mActiveModule != null)
		this.mActiveModule.hide(_withSlideAnimation);
	else
		this.mMainDialogModule.hide();

	this.mActiveModule = this.mEnchanterDialogModule;

	if(_data !== undefined && _data !== null && typeof(_data) === 'object')
	{
		this.loadAssetData(_data.Assets);
		this.mEnchanterDialogModule.loadFromData(_data);
	}

	this.mEnchanterDialogModule.show(_withSlideAnimation);
};

CampScreen.prototype.showFletcherDialog = function (/*_withSlideAnimation,*/ _data)
{
	var _withSlideAnimation = true;

	this.mContainer.addClass('display-block').removeClass('display-none');

	if(this.mActiveModule != null)
		this.mActiveModule.hide(_withSlideAnimation);
	else
		this.mMainDialogModule.hide();

	this.mActiveModule = this.mFletcherDialogModule;

	if(_data !== undefined && _data !== null && typeof(_data) === 'object')
	{
		this.loadAssetData(_data.Assets);
		this.mFletcherDialogModule.loadFromData(_data);
	}

	this.mFletcherDialogModule.show(_withSlideAnimation);
};


CampScreen.prototype.showGathererDialog = function (/*_withSlideAnimation,*/ _data)
{
	var _withSlideAnimation = true;

	this.mContainer.addClass('display-block').removeClass('display-none');

	if(this.mActiveModule != null)
		this.mActiveModule.hide(_withSlideAnimation);
	else
		this.mMainDialogModule.hide();

	this.mActiveModule = this.mGathererDialogModule;

	if(_data !== undefined && _data !== null && typeof(_data) === 'object')
	{
		this.loadAssetData(_data.Assets);
		this.mGathererDialogModule.loadFromData(_data);
	}

	this.mGathererDialogModule.show(_withSlideAnimation);
};

CampScreen.prototype.showHealerDialog = function (/*_withSlideAnimation,*/ _data)
{
	var _withSlideAnimation = true;

	this.mContainer.addClass('display-block').removeClass('display-none');

	if(this.mActiveModule != null)
		this.mActiveModule.hide(_withSlideAnimation);
	else
		this.mMainDialogModule.hide();

	this.mActiveModule = this.mHealerDialogModule;

	if(_data !== undefined && _data !== null && typeof(_data) === 'object')
	{
		this.loadAssetData(_data.Assets);
		this.mHealerDialogModule.loadFromData(_data);
	}

	this.mHealerDialogModule.show(_withSlideAnimation);
};

CampScreen.prototype.showHunterDialog = function (/*_withSlideAnimation,*/ _data)
{
	var _withSlideAnimation = true;

	this.mContainer.addClass('display-block').removeClass('display-none');

	if(this.mActiveModule != null)
		this.mActiveModule.hide(_withSlideAnimation);
	else
		this.mMainDialogModule.hide();

	this.mActiveModule = this.mHunterDialogModule;

	if(_data !== undefined && _data !== null && typeof(_data) === 'object')
	{
		this.loadAssetData(_data.Assets);
		this.mHunterDialogModule.loadFromData(_data);
	}

	this.mHunterDialogModule.show(_withSlideAnimation);
};

CampScreen.prototype.showPainterDialog = function (/*_withSlideAnimation,*/ _data)
{
	var _withSlideAnimation = true;

	this.mContainer.addClass('display-block').removeClass('display-none');

	if(this.mActiveModule != null)
		this.mActiveModule.hide(_withSlideAnimation);
	else
		this.mMainDialogModule.hide();

	this.mActiveModule = this.mPainterDialogModule;

	if(_data !== undefined && _data !== null && typeof(_data) === 'object')
	{
		this.loadAssetData(_data.Assets);
		this.mPainterDialogModule.loadFromData(_data);
	}

	this.mPainterDialogModule.show(_withSlideAnimation);
};

CampScreen.prototype.showRepairDialog = function (/*_withSlideAnimation,*/ _data)
{
	var _withSlideAnimation = true;

	this.mContainer.addClass('display-block').removeClass('display-none');

	if(this.mActiveModule != null)
		this.mActiveModule.hide(_withSlideAnimation);
	else
		this.mMainDialogModule.hide();

	this.mActiveModule = this.mRepairDialogModule;

	if(_data !== undefined && _data !== null && typeof(_data) === 'object')
	{
		this.loadAssetData(_data.Assets);
		this.mRepairDialogModule.loadFromData(_data);
	}

	this.mRepairDialogModule.show(_withSlideAnimation);
};

CampScreen.prototype.showRestDialog = function (/*_withSlideAnimation,*/ _data)
{
	var _withSlideAnimation = true;

	this.mContainer.addClass('display-block').removeClass('display-none');

	if(this.mActiveModule != null)
		this.mActiveModule.hide(_withSlideAnimation);
	else
		this.mMainDialogModule.hide();

	this.mActiveModule = this.mRestDialogModule;

	if(_data !== undefined && _data !== null && typeof(_data) === 'object')
	{
		this.loadAssetData(_data.Assets);
		this.mRestDialogModule.loadFromData(_data);
	}

	this.mRestDialogModule.show(_withSlideAnimation);
};

CampScreen.prototype.showScoutDialog = function (/*_withSlideAnimation,*/ _data)
{
	var _withSlideAnimation = true;

	this.mContainer.addClass('display-block').removeClass('display-none');

	if(this.mActiveModule != null)
		this.mActiveModule.hide(_withSlideAnimation);
	else
		this.mMainDialogModule.hide();

	this.mActiveModule = this.mScoutDialogModule;

	if(_data !== undefined && _data !== null && typeof(_data) === 'object')
	{
		this.loadAssetData(_data.Assets);
		this.mScoutDialogModule.loadFromData(_data);
	}

	this.mScoutDialogModule.show(_withSlideAnimation);
};

CampScreen.prototype.showWorkshopDialog = function (/*_withSlideAnimation,*/ _data)
{
	var _withSlideAnimation = true;

	this.mContainer.addClass('display-block').removeClass('display-none');

	if(this.mActiveModule != null)
		this.mActiveModule.hide(_withSlideAnimation);
	else
		this.mMainDialogModule.hide();

	this.mActiveModule = this.mWorkshopDialogModule;

	if(_data !== undefined && _data !== null && typeof(_data) === 'object')
	{
		this.loadAssetData(_data.Assets);
		this.mWorkshopDialogModule.loadFromData(_data);
	}

	this.mWorkshopDialogModule.show(_withSlideAnimation);
};

CampScreen.prototype.loadAssetData = function (_data)
{
	if(_data !== undefined && _data !== null)
	{	 
		this.mMainDialogModule.updateAssets(_data);

		if(this.mActiveModule != null)
			this.mActiveModule.updateAssets(_data);

		this.mAssetValues = _data;
	}
};

CampScreen.prototype.getModule = function (_name)
{
	switch(_name)
	{
		case 'CampMainDialogModule': return this.mMainDialogModule;
		case 'CampCommanderDialogModule': return this.mCommanderDialogModule;
		case 'CampBarberDialogModule': return this.mBarberDialogModule;
		case 'CampCraftingDialogModule': return this.mCraftingDialogModule;
		case 'CampEnchanterDialogModule': return this.mEnchanterDialogModule;
		case 'CampFletcherDialogModule': return this.mFletcherDialogModule;
		case 'CampGathererDialogModule': return this.mGathererDialogModule;
		case 'CampHealerDialogModule': return this.mHealerDialogModule;
		case 'CampHunterDialogModule': return this.mHunterDialogModule;
		case 'CampPainterDialogModule': return this.mPainterDialogModule;
		case 'CampRepairDialogModule': return this.mRepairDialogModule;
		case 'CampRestDialogModule': return this.mRestDialogModule;
		case 'CampScoutDialogModule': return this.mScoutDialogModule;
		case 'CampTrainingDialogModule': return this.mTrainingDialogModule;
		case 'CampWorkshopDialogModule': return this.mWorkshopDialogModule;
		
		default: return null;
	}
};

CampScreen.prototype.getModules = function ()
{
	return [
		{ name: 'CampMainDialogModule', module: this.mMainDialogModule },
		{ name: 'CampCommanderDialogModule', module: this.mCommanderDialogModule },
		{ name:  'CampBarberDialogModule', module: this.mBarberDialogModule },
		{ name:  'CampCraftingDialogModule', module:  this.mCraftingDialogModule },
		{ name:  'CampEnchanterDialogModule', module: this.mEnchanterDialogModule },
		{ name:  'CampFletcherDialogModule', module:  this.mFletcherDialogModule },
		{ name:  'CampGathererDialogModule', module: this.mGathererDialogModule },
		{ name:  'CampHealerDialogModule', module: this.mHealerDialogModule },
		{ name:  'CampHunterDialogModule', module:  this.mHunterDialogModule },
		{ name:  'CampPainterDialogModule', module: this.mPainterDialogModule },
		{ name:  'CampRepairDialogModule', module:  this.mRepairDialogModule },
		{ name:  'CampRestDialogModule', module:  this.mRestDialogModule },
		{ name:  'CampScoutDialogModule', module:  this.mScoutDialogModule },
		{ name:  'CampTrainingDialogModule', module:  this.mTrainingDialogModule },
		{ name:  'CampWorkshopDialogModule', module:  this.mWorkshopDialogModule }
	];
};

CampScreen.prototype.notifyBackendOnConnected = function ()
{
	if(this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onScreenConnected');
	}
};

CampScreen.prototype.notifyBackendOnDisconnected = function ()
{
	if(this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onScreenDisconnected');
	}
};

CampScreen.prototype.notifyBackendOnShown = function ()
{
	if(this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onScreenShown');
	}
};

CampScreen.prototype.notifyBackendOnHidden = function ()
{
	if(this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onScreenHidden');
	}
};

CampScreen.prototype.notifyBackendOnAnimating = function ()
{
	if(this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onScreenAnimating');
	}
};

CampScreen.prototype.notifyBackendBrothersButtonPressed = function ()
{
	if(this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onBrothersButtonPressed');
	}
};

CampScreen.prototype.notifyBackendSlotClicked = function (_data)
{
	if(this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onSlotClicked', _data);
	}
};

CampScreen.prototype.notifyBackendContractClicked = function (_data)
{
	if(this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onContractClicked', _data);
	}
};

registerScreen("CampScreen", new CampScreen());