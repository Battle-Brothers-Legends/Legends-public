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

var NewCampaignMenuModule = function ()
{
	this.mSQHandle = null;

	// event listener
	this.mEventListener = null;

	// generic containers
	this.mContainer = null;
	this.mDialogContainer = null;

	this.mOriginSelectionPanel = null;
	this.mCompanyCrisisSelectionPanel = null;
	this.mDifficultySelectionPanel = null;

	// controls
	this.mDifficultyEasyCheckbox = null;
	this.mDifficultyEasyLabel = null;
	this.mDifficultyNormalCheckbox = null;
	this.mDifficultyNormalLabel = null;
	this.mDifficultyHardCheckbox = null;
	this.mDifficultyHardLabel = null;
	this.mDifficultyLegendaryCheckbox = null;
	this.mDifficultyLegendaryLabel = null;

	this.mEconomicDifficultyEasyCheckbox = null;
	this.mEconomicDifficultyEasyLabel = null;
	this.mEconomicDifficultyNormalCheckbox = null;
	this.mEconomicDifficultyNormalLabel = null;
	this.mEconomicDifficultyHardCheckbox = null;
	this.mEconomicDifficultyHardLabel = null;
	this.mEconomicDifficultyLegendaryCheckbox = null;
	this.mEconomicDifficultyLegendaryLabel = null;

	this.mBudgetDifficultyEasyCheckbox = null;
	this.mBudgetDifficultyEasyLabel = null;
	this.mBudgetDifficultyNormalCheckbox = null;
	this.mBudgetDifficultyNormalLabel = null;
	this.mBudgetDifficultyHardCheckbox = null;
	this.mBudgetDifficultyHardLabel = null;
	this.mBudgetDifficultyLegendaryCheckbox = null;
	this.mBudgetDifficultyLegendaryLabel = null;

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
	this.mEvilCrusadeCheckbox = null;
	this.mEvilCrusadeLabel = null;
	this.mEvilCrusadeControl = null;
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

	// scenario
	this.mScenarios = null;
	this.mSelectedScenario = 0;
	this.mScenariosRow = null;

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

	this.mCompanyCrisisSelectionPanel = $('<div class="display-block"/>');
	contentContainer.append(this.mCompanyCrisisSelectionPanel);

		var leftColumn = $('<div class="column"/>');
		this.mCompanyCrisisSelectionPanel.append(leftColumn);
		var rightColumn = $('<div class="column"/>');
		this.mCompanyCrisisSelectionPanel.append(rightColumn);

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
		this.mEvilWarLabel = $('<label class="text-font-normal font-color-subtitle" for="cb-evil-war">Nobles at War</label>');
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

		this.mEvilCrusadeControl = $('<div class="control"></div>');
		row.append(this.mEvilCrusadeControl);
		this.mEvilCrusadeCheckbox = $('<input type="radio" id="cb-evil-crusade" name="evil"/>');
		this.mEvilCrusadeControl.append(this.mEvilCrusadeCheckbox);
		this.mEvilCrusadeLabel = $('<label class="text-font-normal font-color-subtitle" for="cb-evil-crusade">Holy War</label>');
		this.mEvilCrusadeControl.append(this.mEvilCrusadeLabel);
		this.mEvilCrusadeCheckbox.iCheck({
			checkboxClass: 'icheckbox_flat-orange',
			radioClass: 'iradio_flat-orange',
			increaseArea: '30%'
		});
		this.mEvilCrusadeCheckbox.on('ifChecked', null, this, function (_event)
		{
			var self = _event.data;
			self.mEvil = 4;
		});

		var space = $('<div class="control permanent-destruction-control"/>');
		row.append(space);

		var extraLateControl = $('<div class="control permanent-destruction-control"/>');
		row.append(extraLateControl);
		this.mEvilPermanentDestructionCheckbox = $('<input type="checkbox" id="cb-extra-late"/>');
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

	this.mDifficultySelectionPanel = $('<div class="display-none"/>');
	contentContainer.append(this.mDifficultySelectionPanel);

		var leftColumn = $('<div class="column"/>');
		this.mDifficultySelectionPanel.append(leftColumn);
		var rightColumn = $('<div class="column"/>');
		this.mDifficultySelectionPanel.append(rightColumn);

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

		var LegendaryDifficultyControl = $('<div class="control"></div>');
		row.append(LegendaryDifficultyControl);
		this.mEconomicDifficultyLegendaryCheckbox = $('<input type="radio" id="cb-economic-difficulty-Legendary" name="economic-difficulty" />');
		LegendaryDifficultyControl.append(this.mEconomicDifficultyLegendaryCheckbox);
		this.mEconomicDifficultyLegendaryLabel = $('<label class="text-font-normal font-color-subtitle" for="cb-economic-difficulty-Legendary">Legendary</label>');
		LegendaryDifficultyControl.append(this.mEconomicDifficultyLegendaryLabel);
		this.mEconomicDifficultyLegendaryCheckbox.iCheck({
			checkboxClass: 'icheckbox_flat-orange',
			radioClass: 'iradio_flat-orange',
			increaseArea: '30%'
		});
		this.mEconomicDifficultyLegendaryCheckbox.on('ifChecked', null, this, function (_event) {
			var self = _event.data;
			self.mEconomicDifficulty = 3;
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

		var LegendaryDifficultyControl = $('<div class="control"></div>');
		row.append(LegendaryDifficultyControl);
		this.mBudgetDifficultyLegendaryCheckbox = $('<input type="radio" id="cb-budget-difficulty-Legendary" name="budget-difficulty" />');
		LegendaryDifficultyControl.append(this.mBudgetDifficultyLegendaryCheckbox);
		this.mBudgetDifficultyLegendaryLabel = $('<label class="text-font-normal font-color-subtitle" for="cb-budget-difficulty-Legendary">None</label>');
		LegendaryDifficultyControl.append(this.mBudgetDifficultyLegendaryLabel);
		this.mBudgetDifficultyLegendaryCheckbox.iCheck({
			checkboxClass: 'icheckbox_flat-orange',
			radioClass: 'iradio_flat-orange',
			increaseArea: '30%'
		});
		this.mBudgetDifficultyLegendaryCheckbox.on('ifChecked', null, this, function (_event) {
			var self = _event.data;
			self.mBudgetDifficulty = 3;
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

		var LegendaryDifficultyControl = $('<div class="control"></div>');
		row.append(LegendaryDifficultyControl);
		this.mDifficultyLegendaryCheckbox = $('<input type="radio" id="cb-difficulty-Legendary" name="difficulty" />');
		LegendaryDifficultyControl.append(this.mDifficultyLegendaryCheckbox);
		this.mDifficultyLegendaryLabel = $('<label class="text-font-normal font-color-subtitle" for="cb-difficulty-Legendary">Legendary</label>');
		LegendaryDifficultyControl.append(this.mDifficultyLegendaryLabel);
		this.mDifficultyLegendaryCheckbox.iCheck({
			checkboxClass: 'icheckbox_flat-orange',
			radioClass: 'iradio_flat-orange',
			increaseArea: '30%'
		});
		this.mDifficultyLegendaryCheckbox.on('ifChecked', null, this, function (_event) {
			var self = _event.data;
			self.mDifficulty = 3;
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

		var explorationControl = $('<div class="control unexplored-map-control"/>');
		row.append(explorationControl);
		this.mExplorationCheckbox = $('<input type="checkbox" id="cb-exploration"/>');
		explorationControl.append(this.mExplorationCheckbox);
		this.mExplorationCheckboxLabel = $('<label class="text-font-normal font-color-subtitle" for="cb-exploration">Unexplored Map</label>');
		explorationControl.append(this.mExplorationCheckboxLabel);
		this.mExplorationCheckbox.iCheck({
			checkboxClass: 'icheckbox_flat-orange',
			radioClass: 'iradio_flat-orange',
			increaseArea: '30%'
		});

		// seed
		var row = $('<div class="row map-seed-control" />');
		leftColumn.append(row);
		var title = $('<div class="title title-font-big font-color-title">Map Seed</div>');
		row.append(title);

		var inputLayout = $('<div class="l-input"/>');
		row.append(inputLayout);
		this.mSeed = inputLayout.createInput('', 0, 10, 1, null, 'title-font-big font-bold font-color-brother-name');

	this.mOriginSelectionPanel = $('<div class="display-none"/>');
	contentContainer.append(this.mOriginSelectionPanel);

		var leftColumn = $('<div class="column2"/>');
		this.mOriginSelectionPanel.append(leftColumn);
		var rightColumn = $('<div class="column3"/>');
		this.mOriginSelectionPanel.append(rightColumn);

		// starting scenario
		var row = $('<div class="row" />');
		leftColumn.append(row);
		var title = $('<div class="title title-font-big font-color-title">Company Origin</div>');
		row.append(title);

		var listContainerLayout = $('<div class="l-list-container"/>');
		row.append(listContainerLayout);
		this.mScenarioListContainer = listContainerLayout.createList(5, null, true);
		this.mScenarioListScrollContainer = this.mScenarioListContainer.findListScrollContainer();

		var row = $('<div class="row4" />');
		this.mScenarioListScrollContainer.append(row);
		this.mScenariosRow = row;

		var row = $('<div class="row3" />');
		rightColumn.append(row);
		this.mScenariosDesc = row.createList(10, 'text-font-medium font-color-description').findListScrollContainer();

		this.mScenariosDifficulty = row.createImage('', function (_image) { _image.removeClass('display-none').addClass('display-block'); }, null, 'display-none difficulty');
		rightColumn.append(this.mScenariosDifficulty);

	// create footer button bar
	var footerButtonBar = $('<div class="l-button-bar"></div>');
	this.mDialogContainer.findDialogFooterContainer().append(footerButtonBar);

	var layout = $('<div class="l-ok-button"/>');
	footerButtonBar.append(layout);
	this.mStartButton = layout.createTextButton("Next", function ()
	{
		if(self.mOriginSelectionPanel.hasClass('display-block'))
		{
			self.mOriginSelectionPanel.removeClass('display-block').addClass('display-none');
			self.mCompanyCrisisSelectionPanel.addClass('display-block').removeClass('display-none');
			self.mCancelButton.changeButtonText("Previous");
			self.mStartButton.enableButton(self.mCompanyName.getInputTextLength() >= 1);
		}
		else if(self.mCompanyCrisisSelectionPanel.hasClass('display-block'))
		{
			self.mCompanyCrisisSelectionPanel.removeClass('display-block').addClass('display-none');
			self.mDifficultySelectionPanel.addClass('display-block').removeClass('display-none');
			self.mStartButton.changeButtonText("Start");
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
		if(self.mOriginSelectionPanel.hasClass('display-block'))
		{
			self.notifyBackendCancelButtonPressed();
		}
		else if(self.mDifficultySelectionPanel.hasClass('display-block'))
		{
			self.mCompanyCrisisSelectionPanel.addClass('display-block').removeClass('display-none');
			self.mDifficultySelectionPanel.removeClass('display-block').addClass('display-none');
			self.mStartButton.changeButtonText("Next");
			self.mCancelButton.changeButtonText("Previous");
		}
		else
		{
			self.mOriginSelectionPanel.addClass('display-block').removeClass('display-none');
			self.mCompanyCrisisSelectionPanel.removeClass('display-block').addClass('display-none');
			self.mStartButton.changeButtonText("Next");
			self.mCancelButton.changeButtonText("Cancel");
			self.mStartButton.enableButton(true);
		}
	}, '', 1);

	this.mIsVisible = false;
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
	this.mDifficultyLegendaryCheckbox.remove();
	this.mDifficultyLegendaryCheckbox = null;
	this.mDifficultyLegendaryLabel.remove();
	this.mDifficultyLegendaryLabel = null;
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

	this.mOriginSelectionPanel.empty();
	this.mOriginSelectionPanel.remove();
	this.mOriginSelectionPanel = null;

	this.mCompanyCrisisSelectionPanel.empty();
	this.mCompanyCrisisSelectionPanel.remove();
	this.mCompanyCrisisSelectionPanel = null;

	this.mDifficultySelectionPanel.empty();
	this.mDifficultySelectionPanel.remove();
	this.mDifficultySelectionPanel = null;

	this.mDialogContainer.empty();
	this.mDialogContainer.remove();
	this.mDialogContainer = null;

	this.mContainer.empty();
	this.mContainer.remove();
	this.mContainer = null;
};


NewCampaignMenuModule.prototype.bindTooltips = function ()
{
	// Legends
	this.mDifficultyLegendaryLabel.bindTooltip({
		contentType: 'ui-element',
		elementId: TooltipIdentifier.MenuScreen.NewCampaign.DifficultyLegendary
	});
	this.mDifficultyLegendaryCheckbox.bindTooltip({
		contentType: 'ui-element',
		elementId: TooltipIdentifier.MenuScreen.NewCampaign.DifficultyLegendary
	});

	this.mEconomicDifficultyLegendaryLabel.bindTooltip({
		contentType: 'ui-element',
		elementId: TooltipIdentifier.MenuScreen.NewCampaign.EconomicDifficultyLegendary
	});
	this.mEconomicDifficultyLegendaryCheckbox.bindTooltip({
		contentType: 'ui-element',
		elementId: TooltipIdentifier.MenuScreen.NewCampaign.EconomicDifficultyLegendary
	});

	this.mBudgetDifficultyLegendaryLabel.bindTooltip({
		contentType: 'ui-element',
		elementId: TooltipIdentifier.MenuScreen.NewCampaign.BudgetDifficultyLegendary
	});
	this.mBudgetDifficultyLegendaryCheckbox.bindTooltip({
		contentType: 'ui-element',
		elementId: TooltipIdentifier.MenuScreen.NewCampaign.BudgetDifficultyLegendary
	});

	// Vanilla
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

	this.mExplorationCheckboxLabel.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.MenuScreen.NewCampaign.Exploration });
	this.mExplorationCheckbox.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.MenuScreen.NewCampaign.Exploration });

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

	this.mEvilCrusadeLabel.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.MenuScreen.NewCampaign.EvilCrusade });
	this.mEvilCrusadeCheckbox.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.MenuScreen.NewCampaign.EvilCrusade });

	this.mEvilPermanentDestructionLabel.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.MenuScreen.NewCampaign.EvilPermanentDestruction });
	this.mEvilPermanentDestructionCheckbox.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.MenuScreen.NewCampaign.EvilPermanentDestruction });
};

NewCampaignMenuModule.prototype.unbindTooltips = function ()
{
	// Legends
	this.mDifficultyLegendaryLabel.unbindTooltip();
	this.mDifficultyLegendaryCheckbox.unbindTooltip();

	this.mEconomicDifficultyLegendaryLabel.unbindTooltip();
	this.mEconomicDifficultyLegendaryCheckbox.unbindTooltip();

	this.mBudgetDifficultyLegendaryLabel.unbindTooltip();
	this.mBudgetDifficultyLegendaryCheckbox.unbindTooltip();

	// Vanilla
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

	this.mExplorationCheckboxLabel.unbindTooltip();
	this.mExplorationCheckbox.unbindTooltip();

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

	this.mEvilCrusadeLabel.unbindTooltip();
	this.mEvilCrusadeCheckbox.unbindTooltip();

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
	this.mOriginSelectionPanel.addClass('display-block').removeClass('display-none');
	this.mCompanyCrisisSelectionPanel.removeClass('display-block').addClass('display-none');
	this.mDifficultySelectionPanel.removeClass('display-block').addClass('display-none');
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


NewCampaignMenuModule.prototype.setStartingScenarios = function (_data)
{
	if (_data !== null && jQuery.isArray(_data))
	{
		this.mScenarios = _data;

		for (var i = 0; i < _data.length; ++i)
		{
			this.addStartingScenario(i, _data[i], this.mScenariosRow);
		}
	}
}


NewCampaignMenuModule.prototype.setCrusadeCampaignVisible = function (_data)
{
	if(_data)
	{
		this.mEvilCrusadeControl.addClass('display-block').removeClass('display-none');
	}
	else
	{
		this.mEvilCrusadeControl.removeClass('display-block').addClass('display-none');
	}
}


NewCampaignMenuModule.prototype.addStartingScenario = function (_index, _data, _row)
{
	var self = this;

	var control = $('<div class="control"></div>');
	this.mScenariosRow.append(control);

	var radioButton = $('<input type="radio" id="cb-scenario-' + _index + '" name="scenario" ' + (_index == 0 ? 'checked' : '') + '/>');
	control.append(radioButton);

	var label = $('<label class="text-font-normal font-color-subtitle" for="cb-scenario-' + _index + '">' + _data.Name + '</label>');
	control.append(label);

	label.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.MenuScreen.NewCampaign.StartingScenario });

	radioButton.iCheck(
	{
		checkboxClass: 'icheckbox_flat-orange',
		radioClass: 'iradio_flat-orange',
		increaseArea: '30%'
	});

	radioButton.on('ifChecked', null, this, function (_event)
	{
		var self = _event.data;
		self.mSelectedScenario = _index;
		self.updateStartingScenarioDescription(_data.Description, _data.Difficulty);
	});

	if(_index == 0)
		this.updateStartingScenarioDescription(_data.Description, _data.Difficulty);
}


NewCampaignMenuModule.prototype.updateStartingScenarioDescription = function (_desc, _difficulty)
{
	var parsedText = XBBCODE.process(
	{
		text: _desc,
		removeMisalignedTags: false,
		addInLineBreaks: true
	});

	this.mScenariosDesc.html(parsedText.html);
	this.mScenariosDifficulty.attr('src', Path.GFX + 'ui/images/' + _difficulty + '.png');
};


NewCampaignMenuModule.prototype.collectSettings = function()
{
	var settings = {};

	settings.companyName			= this.mCompanyName.getInputText();

	settings.banner					= this.mBanners[this.mCurrentBannerIndex];

	settings.combatDifficulty		= this.mDifficulty;
	settings.economicDifficulty		= this.mEconomicDifficulty;
	settings.budgetDifficulty		= this.mBudgetDifficulty;
	settings.ironman				= this.mIronmanCheckbox.is(':checked');
	settings.explorationDifficulty	= this.mExplorationCheckbox.is(':checked');
	settings.lateGameCrisis			= this.mEvil;
	settings.permanentDestruction	= this.mEvilPermanentDestructionCheckbox.is(':checked');
	settings.seed					= this.mSeed.getInputText();

	settings.origin					= this.mScenarios[this.mSelectedScenario].ID;
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
