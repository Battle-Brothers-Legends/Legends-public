MainMenuScreen.prototype.showMainMenuModule = function ()
{
	this.mMainMenuModule.show();
};

MainMenuScreen.prototype.hideMainMenuModule = function ()
{
	this.mMainMenuModule.hide();
};

MainMenuScreen.prototype.hideNewCampaignModule = function ()
{
	this.mNewCampaignModule.hide();
};

MainMenuScreen.prototype.showNewCampaignModule = function ()
{
    if (!this.mNewCampaignModule) { return; }
    this.mNewCampaignModule.show();
    if (this.mNewCampaignModule.mFirstPanel) {
        this.mNewCampaignModule.mFirstPanel.removeClass('display-block').addClass('display-none');
    }
    if (this.mNewCampaignModule.mSecondPanel) {
        this.mNewCampaignModule.mSecondPanel.removeClass('display-block').addClass('display-none');
    }
    if (this.mNewCampaignModule.mThirdPanel) {
        this.mNewCampaignModule.mThirdPanel.addClass('display-block').removeClass('display-none');
    }
    if (this.mNewCampaignModule.mCancelButton) {
        this.mNewCampaignModule.mCancelButton.changeButtonText("Previous");
    }
    if (this.mNewCampaignModule.mStartButton) {
        this.mNewCampaignModule.mStartButton.changeButtonText("Start");
    }
};
