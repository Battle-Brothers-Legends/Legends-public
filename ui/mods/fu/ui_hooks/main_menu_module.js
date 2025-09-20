var createMainMenuButtons = MainMenuModule.prototype.createMainMenuButtons;
MainMenuModule.prototype.createMainMenuButtons = function ()
{
	createMainMenuButtons.call(this);
	this.addModOptionsButton();
};

MainMenuModule.prototype.addModOptionsButton = function ()
{
	var self = this;

	var row = $('<div class="row"></div>');
	var temp = this.mButtonContainer.find('.divider');
	temp.before(row);
	var buttonLayout = $('<div class="l-center"></div>');
	row.append(buttonLayout);
	buttonLayout.createTextButton("Mod Options", function ()
	{
		self.notifyBackendModOptionsButtonPressed();
	}, '', 4);
};

Screens.MainMenuScreen.getModule("MainMenuModule").addModOptionsButton();

MainMenuModule.prototype.notifyBackendModOptionsButtonPressed = function()
{
	SQ.call(this.mSQHandle, 'onModOptionsButtonPressed');
};

var createWorldMapMenuButtons = MainMenuModule.prototype.createWorldMapMenuButtons;
MainMenuModule.prototype.createWorldMapMenuButtons = function (_isSavingAllowed, _seed)
{
	createWorldMapMenuButtons.call(this, _isSavingAllowed, _seed);
	this.addModOptionsButton();
};

var createTacticalMapMenuButtons = MainMenuModule.prototype.createTacticalMapMenuButtons;
MainMenuModule.prototype.createTacticalMapMenuButtons = function (_isRetreatAllowed, _isQuitAllowed, _quitText)
{
	createTacticalMapMenuButtons.call(this, _isRetreatAllowed, _isQuitAllowed, _quitText);
	this.addModOptionsButton();
};
