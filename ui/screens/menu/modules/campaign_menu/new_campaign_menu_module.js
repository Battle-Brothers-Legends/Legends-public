/*
 *  @Project:		Battle Brothers
 *	@Company:		Overhype Studios
 *
 *	@Copyright:		(c) Overhype Studios | 2015
 * 
 *  @Author:		Overhype Studios
 *  @Date:			03.03.2015
 *  @Description:	New Campaign Menu Module JS
 */
"use strict";

var NewCampaignMenuModule = function()
{
    this.mSQHandle = null;

    // event listener
    this.mEventListener = null;

    // generic containers
    this.mContainer = null;
    this.mDialogContainer = null;

    this.mFirstPanel = null;
	this.mSecondPanel = null;
	this.mMapPanel = null;

	// controls
	this.mDifficultyEasyCheckbox = null;
	this.mDifficultyEasyLabel = null;
	this.mDifficultyNormalCheckbox = null;
	this.mDifficultyNormalLabel = null;
	this.mDifficultyHardCheckbox = null;
	this.mDifficultyHardLabel = null;

	this.mEconomicDifficultyEasyCheckbox = null;
	this.mEconomicDifficultyEasyLabel = null;
	this.mEconomicDifficultyNormalCheckbox = null;
	this.mEconomicDifficultyNormalLabel = null;
	this.mEconomicDifficultyHardCheckbox = null;
	this.mEconomicDifficultyHardLabel = null;

	this.mBudgetDifficultyEasyCheckbox = null;
	this.mBudgetDifficultyEasyLabel = null;
	this.mBudgetDifficultyNormalCheckbox = null;
	this.mBudgetDifficultyNormalLabel = null;
	this.mBudgetDifficultyHardCheckbox = null;
	this.mBudgetDifficultyHardLabel = null;

	this.mIronmanCheckbox = null;
	this.mIronmanCheckboxLabel = null;
	this.mCompanyName = null;

	this.mEvilRandomCheckbox = null;
	this.mEvilRandomLabel = null;
	this.mEvilWarCheckbox = null;
	this.mEvilWarLabel = null;
	this.mEvilGreenskinsCheckbox = null;
	this.mEvilGreenskinsLabel = null;
	this.mEvilUndeadCheckbox = null;
	this.mEvilUndeadLabel = null;
	this.mEvilNoneCheckbox = null;
	this.mEvilNoneLabel = null;
	this.mEvilNoDesctructionCheckbox = null;
	this.mEvilPermanentDestructionLabel = null;

	this.mPrevBannerButton = null;
	this.mNextBannerButton = null;
	this.mBannerImage = null;

	this.mSeed = null;

    // buttons
    this.mStartButton = null;
    this.mCancelButton = null;

	// banners
	this.mBanners = null;
	this.mCurrentBannerIndex = 0;

	// difficulty
	this.mDifficulty = 0;
	this.mEconomicDifficulty = 0;
	this.mBudgetDifficulty = 0;
	this.mEvil = 0;


	// controls
	this.mMapOptions = {
		Width: {
			Control: null,
			OptionsKey: 'map.width',
			Min: 50,
			Max: 300,
			Value: 140,
			Step: 1
		},
		Height: {
			Control: null,
			OptionsKey: 'map.height',
			Min: 50,
			Max: 300,
			Value: 140,
			Step: 1
		},
		LandMassMult: {
			Control: null,
			OptionsKey: 'map.landmassmult',
			Min: 0,
			Max: 20,
			Value: 14,
			Step: 1
		},
		WaterConnectivity: {
			Control: null,
			OptionsKey: 'map.waterconnectivity',
			Min: 0,
			Max: 100,
			Value: 38,
			Step: 1
		},
		MinLandToWaterRatio: {
			Control: null,
			OptionsKey: 'map.minlandtowaterratio',
			Min: 0,
			Max: 20,
			Value: 14,
			Step: 1
		},
		Snowline: {
			Control: null,
			OptionsKey: 'map.snowline',
			Min: 0,
			Max: 100,
			Value: 90,
			Step: 1
		},
		Vision: {
			Control: null,
			OptionsKey: 'map.vision',
			Min: 0,
			Max: 5000,
			Value: 500,
			Step: 100,
		},		
		NumSettlements: {
			Control: null,
			OptionsKey: 'map.settlements',
			Min: 1,
			Max: 60,
			Value: 19,
			Step: 1
		},
		NumFactions: {
			Control: null,
			OptionsKey: 'map.factions',
			Min: 1,
			Max: 6,
			Value: 3,
			Step: 1
		}
	};
	this.mFogofWarCheckbox = null;
    // generics
    this.mIsVisible = false;
};


NewCampaignMenuModule.prototype.isConnected = function ()
{
    return this.mSQHandle !== null;
};

NewCampaignMenuModule.prototype.onConnection = function (_handle)
{
	this.mSQHandle = _handle;

    // notify listener
	if (this.mEventListener !== null && ('onModuleOnConnectionCalled' in this.mEventListener))
	{
        this.mEventListener.onModuleOnConnectionCalled(this);
    }
};

NewCampaignMenuModule.prototype.onDisconnection = function ()
{
	this.mSQHandle = null;

    // notify listener
	if (this.mEventListener !== null && ('onModuleOnDisconnectionCalled' in this.mEventListener))
	{
        this.mEventListener.onModuleOnDisconnectionCalled(this);
    }
};


NewCampaignMenuModule.prototype.createDIV = function (_parentDiv)
{
    var self = this;

    // create: dialog container
    this.mContainer = $('<div class="new-campaign-menu-module display-none"/>');
    _parentDiv.append(this.mContainer);
    this.mDialogContainer = this.mContainer.createDialog('New Campaign', null, null /*Path.GFX + Asset.HEADER_TACTICAL_COMBAT_DIALOG*/, false, 'dialog-800-720-2');

	// create: content
	var contentContainer = this.mDialogContainer.findDialogContentContainer();

	this.mFirstPanel = $('<div class="display-block"/>');
	contentContainer.append(this.mFirstPanel);
	{
		var leftColumn = $('<div class="column"/>');
		this.mFirstPanel.append(leftColumn);
		var rightColumn = $('<div class="column"/>');
		this.mFirstPanel.append(rightColumn);

		// name
		var row = $('<div class="row" />');
		leftColumn.append(row);
		var title = $('<div class="title title-font-big font-color-title">Company Name</div>');
		row.append(title);

		var inputLayout = $('<div class="l-input"/>');
		row.append(inputLayout);
		this.mCompanyName = inputLayout.createInput('Battle Brothers', 0, 32, 1, function (_input)
		{
			if(self.mStartButton !== null) self.mStartButton.enableButton(_input.getInputTextLength() >= 1);
		}, 'title-font-big font-bold font-color-brother-name'); 
		this.mCompanyName.setInputText('Battle Brothers');

		// greater evil
		var row = $('<div class="row" />');
		leftColumn.append(row);
		var title = $('<div class="title title-font-big font-color-title">Late Game Crisis</div>');
		row.append(title);
		
		/*var evilNoneControl = $('<div class="control"></div>');
		row.append(evilNoneControl);
		this.mEvilNoneCheckbox = $('<input type="radio" id="cb-evil-none" name="evil"/>');
		evilNoneControl.append(this.mEvilNoneCheckbox);
		this.mEvilNoneLabel = $('<label class="text-font-normal font-color-subtitle" for="cb-evil-none">None</label>');
		evilNoneControl.append(this.mEvilNoneLabel);
		this.mEvilNoneCheckbox.iCheck({
			checkboxClass: 'icheckbox_flat-orange',
			radioClass: 'iradio_flat-orange',
			increaseArea: '30%'
		});
		this.mEvilNoneCheckbox.on('ifChecked', null, this, function (_event)
		{
			var self = _event.data;
			self.mEvil = 255;
		});*/

		var evilRandomControl = $('<div class="control"></div>');
		row.append(evilRandomControl);
		this.mEvilRandomCheckbox = $('<input type="radio" id="cb-evil-random" name="evil" checked />');
		evilRandomControl.append(this.mEvilRandomCheckbox);
		this.mEvilRandomLabel = $('<label class="text-font-normal font-color-subtitle" for="cb-evil-random">Random</label>');
		evilRandomControl.append(this.mEvilRandomLabel);
		this.mEvilRandomCheckbox.iCheck({
			checkboxClass: 'icheckbox_flat-orange',
			radioClass: 'iradio_flat-orange',
			increaseArea: '30%'
		});
		this.mEvilRandomCheckbox.on('ifChecked', null, this, function (_event)
		{
			var self = _event.data;
			self.mEvil = 0;
		});

		var evilWarControl = $('<div class="control"></div>');
		row.append(evilWarControl);
		this.mEvilWarCheckbox = $('<input type="radio" id="cb-evil-war" name="evil"/>');
		evilWarControl.append(this.mEvilWarCheckbox);
		this.mEvilWarLabel = $('<label class="text-font-normal font-color-subtitle" for="cb-evil-war">War</label>');
		evilWarControl.append(this.mEvilWarLabel);
		this.mEvilWarCheckbox.iCheck({
			checkboxClass: 'icheckbox_flat-orange',
			radioClass: 'iradio_flat-orange',
			increaseArea: '30%'
		});
		this.mEvilWarCheckbox.on('ifChecked', null, this, function (_event)
		{
			var self = _event.data;
			self.mEvil = 1;
		});

		var evilGreenskinsControl = $('<div class="control"></div>');
		row.append(evilGreenskinsControl);
		this.mEvilGreenskinsCheckbox = $('<input type="radio" id="cb-evil-greenskins" name="evil"/>');
		evilGreenskinsControl.append(this.mEvilGreenskinsCheckbox);
		this.mEvilGreenskinsLabel = $('<label class="text-font-normal font-color-subtitle" for="cb-evil-greenskins">Greenskin Invasion</label>');
		evilGreenskinsControl.append(this.mEvilGreenskinsLabel);
		this.mEvilGreenskinsCheckbox.iCheck({
			checkboxClass: 'icheckbox_flat-orange',
			radioClass: 'iradio_flat-orange',
			increaseArea: '30%'
		});
		this.mEvilGreenskinsCheckbox.on('ifChecked', null, this, function (_event)
		{
			var self = _event.data;
			self.mEvil = 2;
		});

		var evilUndeadControl = $('<div class="control"></div>');
		row.append(evilUndeadControl);
		this.mEvilUndeadCheckbox = $('<input type="radio" id="cb-evil-undead" name="evil"/>');
		evilUndeadControl.append(this.mEvilUndeadCheckbox);
		this.mEvilUndeadLabel = $('<label class="text-font-normal font-color-subtitle" for="cb-evil-undead">Undead Scourge</label>');
		evilUndeadControl.append(this.mEvilUndeadLabel);
		this.mEvilUndeadCheckbox.iCheck({
			checkboxClass: 'icheckbox_flat-orange',
			radioClass: 'iradio_flat-orange',
			increaseArea: '30%'
		});
		this.mEvilUndeadCheckbox.on('ifChecked', null, this, function (_event)
		{
			var self = _event.data;
			self.mEvil = 3;
		});

		var extraLateControl = $('<div class="control permanent-destruction-control"/>');
		row.append(extraLateControl);
		this.mEvilPermanentDestructionCheckbox = $('<input type="checkbox" id="cb-extra-late" checked/>');
		extraLateControl.append(this.mEvilPermanentDestructionCheckbox);
		this.mEvilPermanentDestructionLabel = $('<label class="text-font-normal font-color-subtitle" for="cb-extra-late">Permanent Destruction</label>');
		extraLateControl.append(this.mEvilPermanentDestructionLabel);
		this.mEvilPermanentDestructionCheckbox.iCheck({
			checkboxClass: 'icheckbox_flat-orange',
			radioClass: 'iradio_flat-orange',
			increaseArea: '30%'
		});

		// banner
		var row = $('<div class="row" />');
		rightColumn.append(row);
		//var title = $('<div class="title title-font-big font-color-title">Banner</div>');
		//row.append(title);

		var bannerContainer = $('<div class="banner-container" />');
		row.append(bannerContainer);

		var table = $('<table width="100%" height="100%"><tr><td width="10%"><div class="l-button prev-banner-button" /></td><td width="80%" class="banner-image-container"></td><td width="10%"><div class="l-button next-banner-button" /></td></tr></table>');
		bannerContainer.append(table);

		var prevBanner = table.find('.prev-banner-button:first');
		this.mPrevBannerButton = prevBanner.createImageButton(Path.GFX + Asset.BUTTON_PREVIOUS_BANNER, function ()
		{
			self.onPreviousBannerClicked();
		}, '', 6);

		var nextBanner = table.find('.next-banner-button:first');
		this.mNextBannerButton = nextBanner.createImageButton(Path.GFX + Asset.BUTTON_NEXT_BANNER, function ()
		{
			self.onNextBannerClicked();
		}, '', 6);

		var bannerImage = table.find('.banner-image-container:first');
		this.mBannerImage = bannerImage.createImage(Path.GFX + 'ui/banners/banner_01.png', function (_image)
		{
			_image.removeClass('display-none').addClass('display-block');
			//_image.centerImageWithinParent();
		}, null, 'display-none banner-image');

		// seed
		var row = $('<div class="row map-seed-control" />');
		leftColumn.append(row);
		var title = $('<div class="title title-font-big font-color-title">Map Seed</div>');
		row.append(title);

		var inputLayout = $('<div class="l-input"/>');
		row.append(inputLayout);
		this.mSeed = inputLayout.createInput('', 0, 10, 1, null, 'title-font-big font-bold font-color-brother-name');
	}
	
	this.mSecondPanel = $('<div class="display-none"/>');
	contentContainer.append(this.mSecondPanel);
	{
		var leftColumn = $('<div class="column"/>');
		this.mSecondPanel.append(leftColumn);
		var rightColumn = $('<div class="column"/>');
		this.mSecondPanel.append(rightColumn);

		// economic difficulty
		var row = $('<div class="row" />');
		leftColumn.append(row);
		var title = $('<div class="title title-font-big font-color-title">Economic Difficulty</div>');
		row.append(title);

		var easyDifficultyControl = $('<div class="control"></div>');
		row.append(easyDifficultyControl);
		this.mEconomicDifficultyEasyCheckbox = $('<input type="radio" id="cb-economic-difficulty-easy" name="economic-difficulty" checked />');
		easyDifficultyControl.append(this.mEconomicDifficultyEasyCheckbox);
		this.mEconomicDifficultyEasyLabel = $('<label class="text-font-normal font-color-subtitle" for="cb-economic-difficulty-easy">Beginner</label>');
		easyDifficultyControl.append(this.mEconomicDifficultyEasyLabel);
		this.mEconomicDifficultyEasyCheckbox.iCheck({
			checkboxClass: 'icheckbox_flat-orange',
			radioClass: 'iradio_flat-orange',
			increaseArea: '30%'
		});
		this.mEconomicDifficultyEasyCheckbox.on('ifChecked', null, this, function (_event)
		{
			var self = _event.data;
			self.mEconomicDifficulty = 0;
		});

		var normalDifficultyControl = $('<div class="control"></div>');
		row.append(normalDifficultyControl);
		this.mEconomicDifficultyNormalCheckbox = $('<input type="radio" id="cb-economic-difficulty-normal" name="economic-difficulty" />');
		normalDifficultyControl.append(this.mEconomicDifficultyNormalCheckbox);
		this.mEconomicDifficultyNormalLabel = $('<label class="text-font-normal font-color-subtitle" for="cb-economic-difficulty-normal">Veteran</label>');
		normalDifficultyControl.append(this.mEconomicDifficultyNormalLabel);
		this.mEconomicDifficultyNormalCheckbox.iCheck({
			checkboxClass: 'icheckbox_flat-orange',
			radioClass: 'iradio_flat-orange',
			increaseArea: '30%'
		});
		this.mEconomicDifficultyNormalCheckbox.on('ifChecked', null, this, function (_event)
		{
			var self = _event.data;
			self.mEconomicDifficulty = 1;
		});

		var hardDifficultyControl = $('<div class="control"></div>');
		row.append(hardDifficultyControl);
		this.mEconomicDifficultyHardCheckbox = $('<input type="radio" id="cb-economic-difficulty-hard" name="economic-difficulty" />');
		hardDifficultyControl.append(this.mEconomicDifficultyHardCheckbox);
		this.mEconomicDifficultyHardLabel = $('<label class="text-font-normal font-color-subtitle" for="cb-economic-difficulty-hard">Expert</label>');
		hardDifficultyControl.append(this.mEconomicDifficultyHardLabel);
		this.mEconomicDifficultyHardCheckbox.iCheck({
			checkboxClass: 'icheckbox_flat-orange',
			radioClass: 'iradio_flat-orange',
			increaseArea: '30%'
		});
		this.mEconomicDifficultyHardCheckbox.on('ifChecked', null, this, function (_event)
		{
			var self = _event.data;
			self.mEconomicDifficulty = 2;
		});

		// starting budget difficulty
		var row = $('<div class="row" />');
		leftColumn.append(row);
		var title = $('<div class="title title-font-big font-color-title">Starting Funds</div>');
		row.append(title);

		var easyDifficultyControl = $('<div class="control"></div>');
		row.append(easyDifficultyControl);
		this.mBudgetDifficultyEasyCheckbox = $('<input type="radio" id="cb-budget-difficulty-easy" name="budget-difficulty" checked />');
		easyDifficultyControl.append(this.mBudgetDifficultyEasyCheckbox);
		this.mBudgetDifficultyEasyLabel = $('<label class="text-font-normal font-color-subtitle" for="cb-budget-difficulty-easy">High</label>');
		easyDifficultyControl.append(this.mBudgetDifficultyEasyLabel);
		this.mBudgetDifficultyEasyCheckbox.iCheck({
			checkboxClass: 'icheckbox_flat-orange',
			radioClass: 'iradio_flat-orange',
			increaseArea: '30%'
		});
		this.mBudgetDifficultyEasyCheckbox.on('ifChecked', null, this, function (_event)
		{
			var self = _event.data;
			self.mBudgetDifficulty = 0;
		});

		var normalDifficultyControl = $('<div class="control"></div>');
		row.append(normalDifficultyControl);
		this.mBudgetDifficultyNormalCheckbox = $('<input type="radio" id="cb-budget-difficulty-normal" name="budget-difficulty" />');
		normalDifficultyControl.append(this.mBudgetDifficultyNormalCheckbox);
		this.mBudgetDifficultyNormalLabel = $('<label class="text-font-normal font-color-subtitle" for="cb-budget-difficulty-normal">Medium</label>');
		normalDifficultyControl.append(this.mBudgetDifficultyNormalLabel);
		this.mBudgetDifficultyNormalCheckbox.iCheck({
			checkboxClass: 'icheckbox_flat-orange',
			radioClass: 'iradio_flat-orange',
			increaseArea: '30%'
		});
		this.mBudgetDifficultyNormalCheckbox.on('ifChecked', null, this, function (_event)
		{
			var self = _event.data;
			self.mBudgetDifficulty = 1;
		});

		var hardDifficultyControl = $('<div class="control"></div>');
		row.append(hardDifficultyControl);
		this.mBudgetDifficultyHardCheckbox = $('<input type="radio" id="cb-budget-difficulty-hard" name="budget-difficulty" />');
		hardDifficultyControl.append(this.mBudgetDifficultyHardCheckbox);
		this.mBudgetDifficultyHardLabel = $('<label class="text-font-normal font-color-subtitle" for="cb-budget-difficulty-hard">Low</label>');
		hardDifficultyControl.append(this.mBudgetDifficultyHardLabel);
		this.mBudgetDifficultyHardCheckbox.iCheck({
			checkboxClass: 'icheckbox_flat-orange',
			radioClass: 'iradio_flat-orange',
			increaseArea: '30%'
		});
		this.mBudgetDifficultyHardCheckbox.on('ifChecked', null, this, function (_event)
		{
			var self = _event.data;
			self.mBudgetDifficulty = 2;
		});

		// combat difficulty
		var row = $('<div class="row" />');
		rightColumn.append(row);
		var title = $('<div class="title title-font-big font-color-title">Combat Difficulty</div>');
		row.append(title);

		var easyDifficultyControl = $('<div class="control"></div>');
		row.append(easyDifficultyControl);
		this.mDifficultyEasyCheckbox = $('<input type="radio" id="cb-difficulty-easy" name="difficulty" checked />');
		easyDifficultyControl.append(this.mDifficultyEasyCheckbox);
		this.mDifficultyEasyLabel = $('<label class="text-font-normal font-color-subtitle" for="cb-difficulty-easy">Beginner</label>');
		easyDifficultyControl.append(this.mDifficultyEasyLabel);
		this.mDifficultyEasyCheckbox.iCheck({
			checkboxClass: 'icheckbox_flat-orange',
			radioClass: 'iradio_flat-orange',
			increaseArea: '30%'
		});
		this.mDifficultyEasyCheckbox.on('ifChecked', null, this, function (_event)
		{
			var self = _event.data;
			self.mDifficulty = 0;
		});

		var normalDifficultyControl = $('<div class="control"></div>');
		row.append(normalDifficultyControl);
		this.mDifficultyNormalCheckbox = $('<input type="radio" id="cb-difficulty-normal" name="difficulty" />');
		normalDifficultyControl.append(this.mDifficultyNormalCheckbox);
		this.mDifficultyNormalLabel = $('<label class="text-font-normal font-color-subtitle" for="cb-difficulty-normal">Veteran</label>');
		normalDifficultyControl.append(this.mDifficultyNormalLabel);
		this.mDifficultyNormalCheckbox.iCheck({
			checkboxClass: 'icheckbox_flat-orange',
			radioClass: 'iradio_flat-orange',
			increaseArea: '30%'
		});
		this.mDifficultyNormalCheckbox.on('ifChecked', null, this, function (_event)
		{
			var self = _event.data;
			self.mDifficulty = 1;
		});

		var hardDifficultyControl = $('<div class="control"></div>');
		row.append(hardDifficultyControl);
		this.mDifficultyHardCheckbox = $('<input type="radio" id="cb-difficulty-hard" name="difficulty" />');
		hardDifficultyControl.append(this.mDifficultyHardCheckbox);
		this.mDifficultyHardLabel = $('<label class="text-font-normal font-color-subtitle" for="cb-difficulty-hard">Expert</label>');
		hardDifficultyControl.append(this.mDifficultyHardLabel);
		this.mDifficultyHardCheckbox.iCheck({
			checkboxClass: 'icheckbox_flat-orange',
			radioClass: 'iradio_flat-orange',
			increaseArea: '30%'
		});
		this.mDifficultyHardCheckbox.on('ifChecked', null, this, function (_event)
		{
			var self = _event.data;
			self.mDifficulty = 2;
		});

		// combat difficulty
		var row = $('<div class="row" />');
		rightColumn.append(row);
		var title = $('<div class="title title-font-big font-color-title">Ironman Mode</div>');
		row.append(title);

		var ironmanControl = $('<div class="control ironman-control"/>');
		row.append(ironmanControl);
		this.mIronmanCheckbox = $('<input type="checkbox" id="cb-iron-man"/>');
		ironmanControl.append(this.mIronmanCheckbox);
		this.mIronmanCheckboxLabel = $('<label class="text-font-normal font-color-subtitle" for="cb-iron-man">Ironman</label>');
		ironmanControl.append(this.mIronmanCheckboxLabel);
		this.mIronmanCheckbox.iCheck({
			checkboxClass: 'icheckbox_flat-orange',
			radioClass: 'iradio_flat-orange',
			increaseArea: '30%'
		});

	}

	this.mMapPanel = $('<div class="display-none"/>');
	contentContainer.append(this.mMapPanel);
	{
	
		var leftColumn = $('<div class="column"></div>');
		this.mMapPanel.append(leftColumn);
		var rightColumn = $('<div class="column"></div>');
		this.mMapPanel.append(rightColumn);
	
		//
		this.createSliderControlDIV(this.mMapOptions.Width, 'Map Width', leftColumn);	
		this.createSliderControlDIV(this.mMapOptions.Height, 'Map Height', leftColumn);
		this.createSliderControlDIV(this.mMapOptions.LandMassMult, 'Land Mass', leftColumn);	
		this.createSliderControlDIV(this.mMapOptions.WaterConnectivity, 'Water Connectivity', leftColumn);
		this.createSliderControlDIV(this.mMapOptions.MinLandToWaterRatio, 'Land To Water Ratio', leftColumn);
		this.createSliderControlDIV(this.mMapOptions.Snowline, 'Snowline', rightColumn);
		this.createSliderControlDIV(this.mMapOptions.NumSettlements, 'Settlements', rightColumn);
		this.createSliderControlDIV(this.mMapOptions.NumFactions, 'Factions', rightColumn);
		//this.createSliderControlDIV(this.mMapOptions.Vision, 'Vision', rightColumn);

		var row = $('<div class="row"></div>');
		rightColumn.append(row);

		var control = $('<div class="control"/>');
		row.append(control);
		this.mFogofWarCheckbox = $('<input type="checkbox" id="cb-fog-of-war"/>');
		control.append(this.mFogofWarCheckbox);
		var label = $('<label class="text-font-normal font-color-subtitle" for="cb-fog-of-war">Fog of War</label>');
		control.append(label);
		this.mFogofWarCheckbox.iCheck({
			checkboxClass: 'icheckbox_flat-orange',
			radioClass: 'iradio_flat-orange',
			increaseArea: '30%'
		});

	}

    // create footer button bar
    var footerButtonBar = $('<div class="l-button-bar"></div>');
    this.mDialogContainer.findDialogFooterContainer().append(footerButtonBar);

    var layout = $('<div class="l-ok-button"/>');
    footerButtonBar.append(layout);
    this.mStartButton = layout.createTextButton("Next", function ()
    {
    	if(self.mFirstPanel.hasClass('display-block'))
    	{
    		self.mFirstPanel.removeClass('display-block').addClass('display-none');
			self.mSecondPanel.addClass('display-block').removeClass('display-none');
			self.mMapPanel.removeClass('display-block').addClass('display-none')
    		self.mStartButton.changeButtonText("Next");
    		self.mCancelButton.changeButtonText("Previous");
    	}
    	else if (self.mSecondPanel.hasClass('display-block'))
    	{
			self.mFirstPanel.removeClass('display-block').addClass('display-none');
			self.mSecondPanel.removeClass('display-block').addClass('display-none');
			self.mMapPanel.addClass('display-block').removeClass('display-none')
    		self.mStartButton.changeButtonText("Start");
			self.mCancelButton.changeButtonText("Previous");			
		}
		else
		{
    		self.notifyBackendStartButtonPressed();
		}
    }, '', 1);

    layout = $('<div class="l-cancel-button"/>');
    footerButtonBar.append(layout);
    this.mCancelButton = layout.createTextButton("Cancel", function ()
    {
    	if (self.mFirstPanel.hasClass('display-block'))
    	{
    		self.notifyBackendCancelButtonPressed();
		}
		else if (self.mSecondPanel.hasClass('display-block'))
    	{
			self.mFirstPanel.addClass('display-block').removeClass('display-none');
			self.mSecondPanel.removeClass('display-block').addClass('display-none');
			self.mMapPanel.removeClass('display-block').addClass('display-none')
    		self.mStartButton.changeButtonText("Next");
			self.mCancelButton.changeButtonText("Cancel");			
		}
    	else
    	{
			self.mFirstPanel.removeClass('display-block').addClass('display-none');
			self.mSecondPanel.addClass('display-block').removeClass('display-none');
			self.mMapPanel.removeClass('display-block').addClass('display-none')
			self.mStartButton.changeButtonText("Next");
    		self.mCancelButton.changeButtonText("Previous");
    	}
    }, '', 1);

    this.mIsVisible = false;
};

NewCampaignMenuModule.prototype.createSliderControlDIV = function (_definition, _label, _parentDiv)
{
    var self = this;
	var row = $('<div class="row"></div>');
	_parentDiv.append(row);
	var scalingTile = $('<div class="title title-font-big font-bold font-color-title">' + _label + '</div>');
	row.append(scalingTile);

	var control = $('<div class="scale-control"></div>');
	row.append(control);

	_definition.Control = $('<input class="scale-slider" type="range"/>');
	_definition.Control.attr('min', _definition.Min);
	_definition.Control.attr('max', _definition.Max);
	_definition.Control.attr('step', _definition.Step);
	_definition.Control.val(_definition.Value);
	control.append(_definition.Control);

	_definition.Control.on("change", function ()
	{
		_definition.Value = parseInt(_definition.Control.val());
		label.text('' + _definition.Value);
	});

	var label = $('<div class="scale-label text-font-normal font-color-subtitle">' +_definition.Value + '</div>');
	control.append(label);

};


NewCampaignMenuModule.prototype.destroyDIV = function ()
{
    // controls
	this.mDifficultyEasyCheckbox.remove();
	this.mDifficultyEasyCheckbox = null;
	this.mDifficultyEasyLabel.remove();
	this.mDifficultyEasyLabel = null;
	this.mDifficultyNormalCheckbox.remove();
	this.mDifficultyNormalCheckbox = null;
	this.mDifficultyNormalLabel.remove();
	this.mDifficultyNormalLabel = null;
	this.mDifficultyHardCheckbox.remove();
	this.mDifficultyHardCheckbox = null;
	this.mDifficultyHardLabel.remove();
	this.mDifficultyHardLabel = null;
	this.mCompanyName.remove();
	this.mCompanyName = null;

	this.mPrevBannerButton.remove();
	this.mPrevBannerButton = null;
	this.mNextBannerButton.remove();
	this.mNextBannerButton = null;
	this.mBannerImage.remove();
	this.mBannerImage = null;

	this.mSeed.remove();
	this.mSeed = null;

	// buttons
    this.mStartButton.remove();
    this.mStartButton = null;
    this.mCancelButton.remove();
    this.mCancelButton = null;

    this.mFirstPanel.empty();
    this.mFirstPanel.remove();
    this.mFirstPanel = null;

    this.mSecondPanel.empty();
    this.mSecondPanel.remove();
    this.mSecondPanel = null;

	this.mMapPanel.empty();
    this.mMapPanel.remove();
	this.mMapPanel = null;
	
    this.mDialogContainer.empty();
    this.mDialogContainer.remove();
    this.mDialogContainer = null;

    this.mContainer.empty();
    this.mContainer.remove();
    this.mContainer = null;
};


NewCampaignMenuModule.prototype.bindTooltips = function ()
{
	this.mCompanyName.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.MenuScreen.NewCampaign.CompanyName });
	this.mSeed.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.MenuScreen.NewCampaign.Seed });

	this.mDifficultyEasyLabel.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.MenuScreen.NewCampaign.DifficultyEasy });
	this.mDifficultyEasyCheckbox.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.MenuScreen.NewCampaign.DifficultyEasy });

	this.mDifficultyNormalLabel.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.MenuScreen.NewCampaign.DifficultyNormal });
	this.mDifficultyNormalCheckbox.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.MenuScreen.NewCampaign.DifficultyNormal });

	this.mDifficultyHardLabel.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.MenuScreen.NewCampaign.DifficultyHard });
	this.mDifficultyHardCheckbox.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.MenuScreen.NewCampaign.DifficultyHard });

	this.mIronmanCheckboxLabel.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.MenuScreen.NewCampaign.Ironman });
	this.mIronmanCheckbox.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.MenuScreen.NewCampaign.Ironman });

	this.mEconomicDifficultyEasyLabel.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.MenuScreen.NewCampaign.EconomicDifficultyEasy });
	this.mEconomicDifficultyEasyCheckbox.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.MenuScreen.NewCampaign.EconomicDifficultyEasy });

	this.mEconomicDifficultyNormalLabel.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.MenuScreen.NewCampaign.EconomicDifficultyNormal });
	this.mEconomicDifficultyNormalCheckbox.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.MenuScreen.NewCampaign.EconomicDifficultyNormal });

	this.mEconomicDifficultyHardLabel.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.MenuScreen.NewCampaign.EconomicDifficultyHard });
	this.mEconomicDifficultyHardCheckbox.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.MenuScreen.NewCampaign.EconomicDifficultyHard });

	this.mBudgetDifficultyEasyLabel.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.MenuScreen.NewCampaign.BudgetDifficultyEasy });
	this.mBudgetDifficultyEasyCheckbox.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.MenuScreen.NewCampaign.BudgetDifficultyEasy });

	this.mBudgetDifficultyNormalLabel.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.MenuScreen.NewCampaign.BudgetDifficultyNormal });
	this.mBudgetDifficultyNormalCheckbox.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.MenuScreen.NewCampaign.BudgetDifficultyNormal });

	this.mBudgetDifficultyHardLabel.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.MenuScreen.NewCampaign.BudgetDifficultyHard });
	this.mBudgetDifficultyHardCheckbox.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.MenuScreen.NewCampaign.BudgetDifficultyHard });

	this.mEvilRandomLabel.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.MenuScreen.NewCampaign.EvilRandom });
	this.mEvilRandomCheckbox.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.MenuScreen.NewCampaign.EvilRandom });

	/*this.mEvilNoneLabel.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.MenuScreen.NewCampaign.EvilNone });
	this.mEvilNoneCheckbox.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.MenuScreen.NewCampaign.EvilNone });*/

	this.mEvilWarLabel.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.MenuScreen.NewCampaign.EvilWar });
	this.mEvilWarCheckbox.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.MenuScreen.NewCampaign.EvilWar });

	this.mEvilGreenskinsLabel.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.MenuScreen.NewCampaign.EvilGreenskins });
	this.mEvilGreenskinsCheckbox.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.MenuScreen.NewCampaign.EvilGreenskins });

	this.mEvilUndeadLabel.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.MenuScreen.NewCampaign.EvilUndead });
	this.mEvilUndeadCheckbox.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.MenuScreen.NewCampaign.EvilUndead });

	this.mEvilPermanentDestructionLabel.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.MenuScreen.NewCampaign.EvilPermanentDestruction });
	this.mEvilPermanentDestructionCheckbox.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.MenuScreen.NewCampaign.EvilPermanentDestruction });
};

NewCampaignMenuModule.prototype.unbindTooltips = function ()
{
	this.mCompanyName.unbindTooltip();
	this.mSeed.unbindTooltip();

	this.mDifficultyEasyLabel.unbindTooltip();
	this.mDifficultyEasyCheckbox.unbindTooltip();

	this.mDifficultyNormalLabel.unbindTooltip();
	this.mDifficultyNormalCheckbox.unbindTooltip();

	this.mDifficultyHardLabel.unbindTooltip();
	this.mDifficultyHardCheckbox.unbindTooltip();

	this.mEconomicDifficultyEasyLabel.unbindTooltip();
	this.mEconomicDifficultyEasyCheckbox.unbindTooltip();

	this.mEconomicDifficultyNormalLabel.unbindTooltip();
	this.mEconomicDifficultyNormalCheckbox.unbindTooltip();

	this.mEconomicDifficultyHardLabel.unbindTooltip();
	this.mEconomicDifficultyHardCheckbox.unbindTooltip();

	this.mBudgetDifficultyEasyLabel.unbindTooltip();
	this.mBudgetDifficultyEasyCheckbox.unbindTooltip();

	this.mBudgetDifficultyNormalLabel.unbindTooltip();
	this.mBudgetDifficultyNormalCheckbox.unbindTooltip();

	this.mBudgetDifficultyHardLabel.unbindTooltip();
	this.mBudgetDifficultyHardCheckbox.unbindTooltip();

	this.mIronmanCheckboxLabel.unbindTooltip();
	this.mIronmanCheckbox.unbindTooltip();

	this.mEvilRandomLabel.unbindTooltip();
	this.mEvilRandomCheckbox.unbindTooltip();

	/*this.mEvilNoneLabel.unbindTooltip();
	this.mEvilNoneCheckbox.unbindTooltip();*/

	this.mEvilWarLabel.unbindTooltip();
	this.mEvilWarCheckbox.unbindTooltip();

	this.mEvilGreenskinsLabel.unbindTooltip();
	this.mEvilGreenskinsCheckbox.unbindTooltip();

	this.mEvilUndeadLabel.unbindTooltip();
	this.mEvilUndeadCheckbox.unbindTooltip();

	this.mEvilPermanentDestructionLabel.unbindTooltip();
	this.mEvilPermanentDestructionCheckbox.unbindTooltip();
};


NewCampaignMenuModule.prototype.create = function(_parentDiv)
{
    this.createDIV(_parentDiv);
    this.bindTooltips();
};

NewCampaignMenuModule.prototype.destroy = function()
{
    this.unbindTooltips();
    this.destroyDIV();
};


NewCampaignMenuModule.prototype.register = function (_parentDiv)
{
    console.log('NewCampaignMenuModule::REGISTER');

    if (this.mContainer !== null)
    {
        console.error('ERROR: Failed to register New Campaign Menu Module. Reason: New Campaign Menu Module is already initialized.');
        return;
    }

    if (_parentDiv !== null && typeof(_parentDiv) == 'object')
    {
        this.create(_parentDiv);
    }
};

NewCampaignMenuModule.prototype.unregister = function ()
{
    console.log('NewCampaignMenuModule::UNREGISTER');

    if (this.mContainer === null)
    {
        console.error('ERROR: Failed to unregister New Campaign Menu Module. Reason: New Campaign Menu Module is not initialized.');
        return;
    }

    this.destroy();
};

NewCampaignMenuModule.prototype.isRegistered = function ()
{
    if (this.mContainer !== null)
    {
        return this.mContainer.parent().length !== 0;
    }

    return false;
};


NewCampaignMenuModule.prototype.registerEventListener = function(_listener)
{
    this.mEventListener = _listener;
};


NewCampaignMenuModule.prototype.show = function ()
{
	// reseed
	//this.mSeed.setInputText(Math.round(Math.random() * 9999999).toString(16));

    var seed = "";
    var characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

    for(var i = 0; i < 10; i++)
        seed += characters.charAt(Math.floor(Math.random() * characters.length));

    this.mSeed.setInputText(seed);

	// reset panels
	this.mFirstPanel.addClass('display-block').removeClass('display-none');
	this.mSecondPanel.removeClass('display-block').addClass('display-none');
	this.mMapPanel.removeClass('display-block').addClass('display-none');
	this.mStartButton.changeButtonText("Next");
	this.mCancelButton.changeButtonText("Cancel");

	var self = this;

    var offset = -(this.mContainer.parent().width() + this.mContainer.width());
    this.mContainer.css({ 'left' : offset });
    this.mContainer.velocity("finish", true).velocity({ opacity: 1, left: '0', right: '0' },
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
};

NewCampaignMenuModule.prototype.hide = function ()
{
    var self = this;

    var offset = -(this.mContainer.parent().width() + this.mContainer.width());
    this.mContainer.velocity("finish", true).velocity({ opacity: 0, left: offset },
	{
        duration: Constants.SCREEN_SLIDE_IN_OUT_DELAY,
        easing: 'swing',
        begin: function ()
        {
            self.notifyBackendModuleAnimating();
        },
        complete: function ()
        {
            self.mIsVisible = false;
            $(this).removeClass('display-block').addClass('display-none');
            self.notifyBackendModuleHidden();
        }
    });
};

NewCampaignMenuModule.prototype.isVisible = function ()
{
    return this.mIsVisible;
};


NewCampaignMenuModule.prototype.onPreviousBannerClicked = function()
{
	--this.mCurrentBannerIndex;

	if(this.mCurrentBannerIndex < 0)
		this.mCurrentBannerIndex = this.mBanners.length - 1;

	this.mBannerImage.attr('src', Path.GFX + 'ui/banners/' + this.mBanners[this.mCurrentBannerIndex] + '.png');
};


NewCampaignMenuModule.prototype.onNextBannerClicked = function()
{
	++this.mCurrentBannerIndex;

	if(this.mCurrentBannerIndex >= this.mBanners.length)
		this.mCurrentBannerIndex = 0;

	this.mBannerImage.attr('src', Path.GFX + 'ui/banners/' + this.mBanners[this.mCurrentBannerIndex] + '.png');
};


NewCampaignMenuModule.prototype.setBanners = function(_data)
{
	if(_data !== null && jQuery.isArray(_data))
	{
		this.mBanners = _data;
		this.mCurrentBannerIndex = Math.floor(Math.random() * _data.length);

		this.mBannerImage.attr('src', Path.GFX + 'ui/banners/' + _data[this.mCurrentBannerIndex] + '.png');
	}
	else
	{
		console.error('ERROR: No banners specified for NewCampaignMenu::setBanners');
	}
}

NewCampaignMenuModule.prototype.setMapConfig = function(_data)
{
	if(_data !== null && jQuery.isArray(_data))
	{
		this.mBanners = _data;
		this.mCurrentBannerIndex = Math.floor(Math.random() * _data.length);

		this.mBannerImage.attr('src', Path.GFX + 'ui/banners/' + _data[this.mCurrentBannerIndex] + '.png');
	}
	else
	{
		console.error('ERROR: No banners specified for NewCampaignMenu::setBanners');
	}
}

NewCampaignMenuModule.prototype.collectSettings = function()
{
	var settings = [];

	// company name
	settings.push(this.mCompanyName.getInputText());

	// banner
	settings.push(this.mBanners[this.mCurrentBannerIndex]);

	// difficulty
	settings.push(this.mDifficulty);
	settings.push(this.mEconomicDifficulty);
	settings.push(this.mBudgetDifficulty);
	settings.push(this.mIronmanCheckbox.is(':checked'));
	settings.push(this.mEvil);
	settings.push(this.mEvilPermanentDestructionCheckbox.is(':checked'));
	settings.push(this.mSeed.getInputText());
	settings.push(this.mMapOptions.Width.Value);	
	settings.push(this.mMapOptions.Height.Value);	
	settings.push(this.mMapOptions.LandMassMult.Value);	
	settings.push(this.mMapOptions.WaterConnectivity.Value);	
	settings.push(this.mMapOptions.MinLandToWaterRatio.Value);	
	settings.push(this.mMapOptions.Snowline.Value);	
	settings.push(this.mMapOptions.NumSettlements.Value);	
	settings.push(this.mMapOptions.NumFactions.Value);
	// settings.push(this.mMapOptions.Vision.Value);	
	settings.push(this.mFogofWarCheckbox.is(':checked'));	

	return settings;
}


NewCampaignMenuModule.prototype.notifyBackendModuleShown = function ()
{
    if (this.mSQHandle !== null)
    {
        SQ.call(this.mSQHandle, 'onModuleShown');
    }
};

NewCampaignMenuModule.prototype.notifyBackendModuleHidden = function ()
{
    if (this.mSQHandle !== null)
    {
        SQ.call(this.mSQHandle, 'onModuleHidden');
    }
};

NewCampaignMenuModule.prototype.notifyBackendModuleAnimating = function ()
{
    if (this.mSQHandle !== null)
    {
        SQ.call(this.mSQHandle, 'onModuleAnimating');
    }
};

NewCampaignMenuModule.prototype.notifyBackendStartButtonPressed = function ()
{
	if (this.mSQHandle !== null)
	{
		var settings = this.collectSettings();
		SQ.call(this.mSQHandle, 'onStartButtonPressed', settings);
	}
};

NewCampaignMenuModule.prototype.notifyBackendCancelButtonPressed = function ()
{
    if (this.mSQHandle !== null)
    {
        SQ.call(this.mSQHandle, 'onCancelButtonPressed');
    }
};