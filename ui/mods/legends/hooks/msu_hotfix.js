MainMenuScreen.prototype.showNewCampaignModule = function ()
{
	this.mNewCampaignModule.show();
	this.mNewCampaignModule.mOriginSelectionPanel.removeClass('display-block').addClass('display-none');
	this.mNewCampaignModule.mCompanyCrisisSelectionPanel.removeClass('display-block').addClass('display-none');
	this.mNewCampaignModule.mDifficultySelectionPanel.addClass('display-block').removeClass('display-none');
	this.mNewCampaignModule.mCancelButton.changeButtonText("Previous");
	this.mNewCampaignModule.mStartButton.changeButtonText("Start");
};
