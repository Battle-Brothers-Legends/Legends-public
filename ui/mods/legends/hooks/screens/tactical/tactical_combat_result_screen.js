TacticalCombatResultScreen.prototype.createStashResizeHeader = function ()
{
	var label = "By continuing you would delete the last " + this.mDataSource.mStashData.deletedNum + " items in your stash.";
	var text = $('<div class="header-text text-font-normal font-style-italic font-bottom-shadow font-color-subtitle">' + label + '</div>');

	var result = $('<div class="resize-header"/>');
	result.append(text);
	return result;
};

TacticalCombatResultScreen.prototype.createDIV = function (_parentDiv)
{
	var self = this;

	// create: containers (init hidden!)
	this.mContainer = $('<div class="tactical-combat-result-screen ui-control dialog-modal-background display-none opacity-none"/>');
	_parentDiv.append(this.mContainer);

	// create: dialog container
	var dialogLayout = $('<div class="l-dialog-container"/>');
	this.mContainer.append(dialogLayout);
	this.mDialogContainer = dialogLayout.createDialog('Title', 'SubTitle', null /*Path.GFX + Asset.HEADER_COMBAT_RESULT_DIALOG*/, true, 'dialog-1024-768');

	// create tabs
	var tabButtonsContainer = $('<div class="l-tab-container"/>');
	this.mDialogContainer.findDialogTabContainer().append(tabButtonsContainer);

	var layout = $('<div class="l-tab-button"/>');
	tabButtonsContainer.append(layout);
	this.mSwitchToStatisticsButton = layout.createTabTextButton("Statistics", function()
	{
		self.mLeaveButton.changeButtonText("Continue");
		self.switchToStatisticsPanel();
	}, null, 'tab-button', 7);

	layout = $('<div class="l-tab-button"/>');
	tabButtonsContainer.append(layout);
	this.mSwitchToLootButton = layout.createTabTextButton("Loot", function ()
	{
		self.mLeaveButton.changeButtonText("Leave");
		self.switchToLootPanel();
	}, null, 'tab-button', 7);


	// create content


	// create footer button bar
	var footerButtonBar = $('<div class="l-button-bar"></div>');
	this.mDialogContainer.findDialogFooterContainer().append(footerButtonBar);

	// create: buttons
	var layout = $('<div class="l-leave-button"/>');
	footerButtonBar.append(layout);
	this.mLeaveButton = layout.createTextButton("Continue", function ()
	{

		if(self.mLootPanel.isVisible() || !self.mSwitchToLootButton.isEnabled())
		{
			if (self.mDataSource.mStashData.popup)
			{
			   self.mCurrentPopupDialog = $('.tactical-combat-result-screen').createPopupDialog('Stash Size Changed', null, null, 'stash-resize-popup');
				self.mCurrentPopupDialog.addPopupDialogOkButton(function (_dialog)
				{
					self.notifyBackendLeaveButtonPressed();
					self.mCurrentPopupDialog = null;
					_dialog.destroyPopupDialog();
				});

				self.mCurrentPopupDialog.addPopupDialogCancelButton(function (_dialog)
				{
					self.mCurrentPopupDialog = null;
					_dialog.destroyPopupDialog();
				});
				self.mCurrentPopupDialog.addPopupDialogContent(self.createStashResizeHeader());
			}
			else
			{
				self.notifyBackendLeaveButtonPressed();
			}
		}
		else
		{
			self.mSwitchToLootButton.click();
// 			self.mLeaveButton.changeButtonText("Leave");
// 			self.switchToLootPanel();
		}

	}, '', 1);
};
