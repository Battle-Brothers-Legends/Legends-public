/*
 *  @Project:		Battle Brothers
 *	@Company:		Overhype Studios
 *
 *	@Copyright:		(c) Overhype Studios | 2013 - 2020
 * 
 *  @Author:		Overhype Studios
 *  @Date:			24.01.2017 / Reworked: 26.11.2017
 *  @Description:	Character Screen JS
 */
"use strict";


var CharacterScreen = function(_isTacticalMode)
{
	this.mSQHandle = null;
	this.mDataSource = new CharacterScreenDatasource(_isTacticalMode);

	// generic containers
	this.mContainer = null;
	this.mBackgroundImage = null;
	this.mCharacterScreenStatuetes = null;
	this.mCharacterScreen = null;
	this.mLeftContentContainer = null;
	this.mRightContentContainer = null;

	// modules
	this.mCharacterPanelModule = null;
	this.mRightPanelModule = null;
	this.mBrothersModule = null;

	this.createModules();
	this.registerDatasourceListener();
};


CharacterScreen.prototype.isConnected = function ()
{
	return this.mSQHandle !== null;
};

CharacterScreen.prototype.onConnection = function (_handle)
{
	this.mSQHandle = _handle;
	this.mDataSource.onConnection(this.mSQHandle);

	this.register($('.root-screen'));
};

CharacterScreen.prototype.onDisconnection = function ()
{
	this.mSQHandle = null;
	this.mDataSource.onDisconnection();

	// remove from DOM as there is no link to a SQ object
	this.unregister();
};


CharacterScreen.prototype.onModuleOnConnectionCalled = function (_module)
{
	// check if every module is connected
	/*
	if ((this.mTooltipModule !== null && this.mTooltipModule.isConnected()) )
	{
		this.notifyBackendOnConnected();
	}
	*/
};

CharacterScreen.prototype.onModuleOnDisconnectionCalled = function (_module)
{
	// check if every module is disconnected
	/*
	if ((this.mTooltipModule === null && !this.mTooltipModule.isConnected()) )
	{
		this.notifyBackendOnDisconnected();
	}
	*/
};


CharacterScreen.prototype.createDIV = function (_parentDiv)
{
	// create: containers (init hidden!)
	this.mContainer = $('<div class="character-screen ui-control dialog-modal-background display-none opacity-none"/>');
	_parentDiv.append(this.mContainer);

	this.mBackgroundImage = this.mContainer.createImage(null, function (_image)
	{
		_image.removeClass('display-none').addClass('display-block');
		_image.fitImageToParent();
	}, function (_image)
	{
		_image.fitImageToParent();
	}, 'display-none');

	this.mCharacterScreenStatuetes = $('<div class="character-screen-statuetes"/>');
	this.mContainer.append(this.mCharacterScreenStatuetes);

	var parentWidth = this.mContainer.width();
	var parentHeight = this.mContainer.height();
	var width = this.mCharacterScreenStatuetes.width();
	var height = this.mCharacterScreenStatuetes.height();

	if (width > parentWidth)
	{	
		width = width + 32;
		var marginLeft = (parentWidth - width) / 2;

		this.mCharacterScreenStatuetes.css({ 'left': marginLeft, 'margin-left': 0, 'margin-right': 0 });
	}

	if (height > parentHeight)
	{
		height = height + 122;
		var marginTop = (parentHeight - height) / 2;

		this.mCharacterScreenStatuetes.css({ 'top': marginTop, 'margin-top': 0, 'margin_bottom': 0 });
	}

	this.mCharacterScreen = $('<div class="character-screen-container"/>');
	this.mCharacterScreenStatuetes.append(this.mCharacterScreen);

	this.mLeftContentContainer = $('<div class="l-left-content-container"/>');
	this.mCharacterScreen.append(this.mLeftContentContainer);
	this.mRightContentContainer = $('<div class="l-right-content-container"/>');
	this.mCharacterScreen.append(this.mRightContentContainer);
};

CharacterScreen.prototype.destroyDIV = function ()
{
	this.mRightContentContainer.empty();
	this.mRightContentContainer = null;
	this.mLeftContentContainer.empty();
	this.mLeftContentContainer = null;

	this.mCharacterScreen.empty();
	this.mCharacterScreen = null;

	this.mBackgroundImage.empty();
	this.mBackgroundImage = null;

	this.mContainer.empty();
	this.mContainer.remove();
	this.mContainer = null;
};



CharacterScreen.prototype.createModules = function()
{
	this.mCharacterPanelModule = new CharacterScreenLeftPanelModule(this, this.mDataSource);
	this.mRightPanelModule = new CharacterScreenRightPanelModule(this, this.mDataSource);
	this.mBrothersModule = new CharacterScreenBrothersListModule(this, this.mDataSource);
};

CharacterScreen.prototype.registerModules = function ()
{
	this.mCharacterPanelModule.register(this.mLeftContentContainer);
	this.mRightPanelModule.register(this.mRightContentContainer);
	this.mBrothersModule.register(this.mRightContentContainer);
};

CharacterScreen.prototype.unregisterModules = function ()
{
	this.mCharacterPanelModule.unregister();
	this.mRightPanelModule.unregister();
	this.mBrothersModule.unregister();
};


/*
CharacterScreen.prototype.setupEventHandler = function ()
{
	this.mCharacterPanelModule.setupEventHandler();
	this.mRightPanelModule.setupEventHandler();
	this.mBrothersModule.setupEventHandler();
};

CharacterScreen.prototype.removeEventHandler = function ()
{
	this.mCharacterPanelModule.removeEventHandler();
	this.mRightPanelModule.removeEventHandler();
	this.mBrothersModule.removeEventHandler();
};
*/

CharacterScreen.prototype.registerDatasourceListener = function()
{
	this.mDataSource.addListener(CharacterScreenDatasourceIdentifier.Inventory.ModeUpdated, jQuery.proxy(this.onInventoryModeUpdated, this));
};


CharacterScreen.prototype.create = function(_parentDiv)
{
	this.createDIV(_parentDiv);
	this.registerModules();
};

CharacterScreen.prototype.destroy = function()
{
	this.unregisterModules();
	this.destroyDIV();
};


CharacterScreen.prototype.register = function (_parentDiv)
{
	console.log('CharacterScreen::REGISTER');

	if (this.mContainer !== null)
	{
		console.error('ERROR: Failed to register Character Screen. Reason: Screen is already initialized.');
		return;
	}

	if (_parentDiv !== null && typeof(_parentDiv) == 'object')
	{
		this.create(_parentDiv);

		this.notifyBackendOnConnected();
	}
};

CharacterScreen.prototype.unregister = function ()
{
	console.log('CharacterScreen::UNREGISTER');

	if (this.mContainer === null)
	{
		console.error('ERROR: Failed to unregister Character Screen. Reason: Screen is not initialized.');
		return;
	}

	this.notifyBackendOnDisconnected();

	this.destroy();
};


CharacterScreen.prototype.showBackgroundImage = function ()
{
	// show background image - Only in Battle Preparation mode
	if (this.mDataSource.getInventoryMode() === CharacterScreenDatasourceIdentifier.InventoryMode.BattlePreparation)
	{
		//this.mBackgroundImage.attr('src', ''); // NOTE: Reset img src otherwise Chrome will use the cached one..
		this.mBackgroundImage.attr('src', Path.GFX + Asset.BACKGROUND_INVENTORY);
	}
	else
	{
		this.mBackgroundImage.attr('src', ''); // NOTE: Reset img src otherwise Chrome will use the cached one..
		this.mBackgroundImage.removeClass('display-block').addClass('display-none');
	}
};

CharacterScreen.prototype.show = function (_data)
{
	var self = this;

	if (_data !== undefined && _data !== null && typeof(_data) === 'object')
	{
		this.mDataSource.loadFromData(_data);
	}
	else
	{
		//this.mDataSource.loadPerkTreesOnce();
		this.mDataSource.loadBrothersList();
		this.mDataSource.loadStashList();
	}

	var parentWidth = this.mContainer.width();
	var parentHeight = this.mContainer.height();
	var width = this.mCharacterScreenStatuetes.width();
	var height = this.mCharacterScreenStatuetes.height();

	this.mContainer.velocity("finish", true).velocity({ opacity: 1 },
	{
		duration: Constants.SCREEN_FADE_IN_OUT_DELAY,
		easing: 'swing',
		begin: function()
		{
			$(this).removeClass('display-none').addClass('display-block');
			self.notifyBackendOnAnimating();
			self.showBackgroundImage();
		},
		complete: function()
		{
			self.notifyBackendOnShown();
		}
	});
};

CharacterScreen.prototype.hide = function ()
{
	var self = this;

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
			$(this).removeClass('display-block').addClass('display-none');
			self.notifyBackendOnHidden();
		}
	});
};


CharacterScreen.prototype.onInventoryModeUpdated = function (_dataSource, _inventoryMode)
{
	switch(_inventoryMode)
	{
		case CharacterScreenDatasourceIdentifier.InventoryMode.BattlePreparation:
		{
			this.mCharacterScreen.addClass('is-battle-preparation');
		} break;
		case CharacterScreenDatasourceIdentifier.InventoryMode.Stash:
		case CharacterScreenDatasourceIdentifier.InventoryMode.Ground:
		{
			this.mCharacterScreen.removeClass('is-battle-preparation');
		} break;
	}
};


CharacterScreen.prototype.getModule = function (_name)
{
	switch(_name)
	{
		case 'DataSource': return this.mDataSource;
		default: return null;
	}
};

CharacterScreen.prototype.getModules = function ()
{
	return [
		{ name: 'DataSource', module: this.mDataSource }
	];
};


CharacterScreen.prototype.notifyBackendOnConnected = function ()
{
	if (this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onScreenConnected');
	}
};

CharacterScreen.prototype.notifyBackendOnDisconnected = function ()
{
	if (this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onScreenDisconnected');
	}
};

CharacterScreen.prototype.notifyBackendOnShown = function ()
{
	if (this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onScreenShown');
	}
};

CharacterScreen.prototype.notifyBackendOnHidden = function ()
{
	if (this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onScreenHidden');
	}
};

CharacterScreen.prototype.notifyBackendOnAnimating = function ()
{
	if (this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onScreenAnimating');
	}
};