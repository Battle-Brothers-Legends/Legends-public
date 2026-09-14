/*
 *  @Project:		Battle Brothers
 *	@Company:		Overhype Studios
 *
 *	@Copyright:		(c) Overhype Studios | 2013 - 2020
 * 
 *  @Author:		Overhype Studios
 *  @Date:			26.05.2017 / Reworked: 26.11.2017
 *  @Description:	Character Right Panel Module JS
 */
"use strict";

var CharacterScreenRightPanelModule = function(_parent, _dataSource)
{
    this.mParent = _parent;
    this.mDataSource = _dataSource;

	// container
	this.mContainer = null;

	// modules
	this.mHeaderModule = null;
	this.mInventoryModule = null;
    this.mPerksModule = null;
    this.mProfessionModule = null;

    this.createModules();
};

CharacterScreenRightPanelModule.prototype.createDIV = function (_parentDiv)
{
	// create: container
	this.mContainer = $('<div class="right-panel-module"/>');
    _parentDiv.append(this.mContainer);
};

CharacterScreenRightPanelModule.prototype.destroyDIV = function ()
{
    this.mContainer.empty();
    this.mContainer.remove();
    this.mContainer = null;
};


CharacterScreenRightPanelModule.prototype.createModules = function()
{
	this.mHeaderModule = new CharacterScreenRightPanelHeaderModule(this, this.mDataSource);
	this.mInventoryModule = new CharacterScreenInventoryListModule(this, this.mDataSource);
    this.mPerksModule = new CharacterScreenPerksModule(this, this.mDataSource);
    this.mProfessionModule = new CharacterScreenProfessionModule(this, this.mDataSource);
};

CharacterScreenRightPanelModule.prototype.registerModules = function ()
{
    this.mHeaderModule.register(this.mContainer);
    this.mInventoryModule.register(this.mContainer);
    this.mPerksModule.register(this.mContainer);
    this.mProfessionModule.register(this.mContainer);

    this.setupEventHandler();
};

CharacterScreenRightPanelModule.prototype.unregisterModules = function ()
{
    this.removeEventHandler();

    this.mHeaderModule.unregister();
    this.mInventoryModule.unregister();
    this.mPerksModule.unregister();
    this.mProfessionModule.unregister();
};


CharacterScreenRightPanelModule.prototype.setupEventHandler = function ()
{
	this.removeEventHandler();

	this.mHeaderModule.setOnSwitchToInventoryCallback(jQuery.proxy(this.switchToInventory, this));
	this.mHeaderModule.setOnSwitchToPerksCallback(jQuery.proxy(this.switchToPerks, this));
    this.mHeaderModule.setOnSwitchToProfessionsCallback(jQuery.proxy(this.switchToProfessions, this));

	this.mHeaderModule.selectInventoryPanel();
};

CharacterScreenRightPanelModule.prototype.removeEventHandler = function ()
{
	this.mHeaderModule.setOnSwitchToInventoryCallback(null);
	this.mHeaderModule.setOnSwitchToPerksCallback(null);
    this.mHeaderModule.setOnSwitchToProfessionsCallback(null);
};


CharacterScreenRightPanelModule.prototype.create = function(_parentDiv)
{
    this.createDIV(_parentDiv);
    this.registerModules();
};

CharacterScreenRightPanelModule.prototype.destroy = function()
{
    this.unregisterModules();
    this.destroyDIV();
};


CharacterScreenRightPanelModule.prototype.register = function (_parentDiv)
{
    console.log('CharacterScreenRightPanelModule::REGISTER');

    if (this.mContainer !== null)
    {
        console.error('ERROR: Failed to register Right Panel Module. Reason: Module is already initialized.');
        return;
    }

    if (_parentDiv !== null && typeof(_parentDiv) == 'object')
    {
        this.create(_parentDiv);
    }
};

CharacterScreenRightPanelModule.prototype.unregister = function ()
{
    console.log('CharacterScreenRightPanelModule::UNREGISTER');

    if (this.mContainer === null)
    {
        console.error('ERROR: Failed to unregister Right Panel Module. Reason: Module is not initialized.');
        return;
    }

    this.destroy();
};


CharacterScreenRightPanelModule.prototype.isRegistered = function ()
{
	if (this.mContainer !== null)
	{
		return this.mContainer.parent().length !== 0;
	}

	return false;
};


/*
CharacterScreenRightPanelModule.prototype.toggleFilterPanel = function ()
{
	if (this.mInventoryModule.isVisible())
	{
		this.mInventoryModule.toggleFilterPanel();
	}
};
*/

CharacterScreenRightPanelModule.prototype.switchToInventory = function ()
{
	this.mPerksModule.hide();
    this.mProfessionModule.hide();
	this.mInventoryModule.show();
};

CharacterScreenRightPanelModule.prototype.switchToPerks = function ()
{
    this.mInventoryModule.hide();
    this.mProfessionModule.hide();
    this.mPerksModule.show();
};

CharacterScreenRightPanelModule.prototype.switchToProfessions = function ()
{
    this.mInventoryModule.hide();
    this.mPerksModule.hide();
    this.mProfessionModule.show();
};