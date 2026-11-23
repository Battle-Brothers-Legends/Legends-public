/*
 *  @Project:		Battle Brothers
 *	@Company:		Overhype Studios
 *
 *	@Copyright:		(c) Overhype Studios | 2013 - 2015
 *
 *  @Author:		Overhype Studios
 *  @Date:			12.01.2015
 *  @Description:	Save Campaign Menu Module JS
 */
"use strict";

var SaveCampaignMenuModule = function(/*_dataSource*/)
{
	this.mSQHandle = null;
	//this.mDataSource = _dataSource;

	// event listener
	this.mEventListener = null;

	// generic containers
	this.mContainer = null;
	this.mDialogContainer = null;

	// scenario list container
	this.mListContainer = null;
	this.mListScrollContainer = null;
	this.mDescriptionContainer = null;
	this.mDescriptionScrollContainer = null;

	// buttons
	this.mSaveButton = null;
	this.mCancelButton = null;
	this.mDeleteButton = null;

	// current popup dialog
	this.mCurrentPopupDialog = null;
	this.mDeletePopupDialog = null;

	// generics
	this.mIsVisible = false;
	this.mIsNewSavegame = false;

	//this.registerDatasourceListener();
};


SaveCampaignMenuModule.prototype.isConnected = function ()
{
	return this.mSQHandle !== null;
};

SaveCampaignMenuModule.prototype.onConnection = function (_handle)
{
	//if (typeof(_handle) == 'string')
	{
		this.mSQHandle = _handle;

		// notify listener
		if (this.mEventListener !== null && ('onModuleOnConnectionCalled' in this.mEventListener)) {
			this.mEventListener.onModuleOnConnectionCalled(this);
		}
	}
};

SaveCampaignMenuModule.prototype.onDisconnection = function ()
{
	this.mSQHandle = null;

	// notify listener
	if (this.mEventListener !== null && ('onModuleOnDisconnectionCalled' in this.mEventListener)) {
		this.mEventListener.onModuleOnDisconnectionCalled(this);
	}
};


SaveCampaignMenuModule.prototype.createDIV = function (_parentDiv)
{
	var self = this;

	// create: dialog container
	this.mContainer = $('<div class="save-campaign-menu-module ui-control display-none"/>');
	_parentDiv.append(this.mContainer);
	this.mDialogContainer = this.mContainer.createDialog('Save Campaign', null, null, false, 'dialog-800-720-2');

	// create content
	var content = this.mContainer.findDialogContentContainer();
	var scenarioListContainerLayout = $('<div class="l-list-container"></div>');
	content.append(scenarioListContainerLayout);
	this.mListContainer = scenarioListContainerLayout.createList(2/*8*/);
	this.mListScrollContainer = this.mListContainer.findListScrollContainer();

	// create footer button bar
	var footerButtonBar = $('<div class="l-button-bar"></div>');
	this.mDialogContainer.findDialogFooterContainer().append(footerButtonBar);

	var layout = $('<div class="l-save-button"/>');
	footerButtonBar.append(layout);
	this.mSaveButton = layout.createTextButton("Save", function ()
	{
	   self.onSaveButtonPressed();
	}, '', 1);
	this.mSaveButton.enableButton(false);

	layout = $('<div class="l-cancel-button"/>');
	footerButtonBar.append(layout);
	this.mCancelButton = layout.createTextButton("Cancel", function ()
	{
		self.notifyBackendCancelButtonPressed();
	}, '', 1);

	layout = $('<div class="l-delete-button"/>');
	footerButtonBar.append(layout);
	this.mDeleteButton = layout.createTextButton("Delete", function ()
	{
		var selectedEntry = self.mListScrollContainer.find('.is-selected:first');

		if (selectedEntry.length == 0)
			return;

		self.mDeletePopupDialog = $('.save-campaign-menu-module').createPopupDialog('Delete', null, null, 'enter-save-name-dialog');
		self.mDeletePopupDialog.addPopupDialogOkButton(function (_dialog)
		{
			var selectedEntry = self.mListScrollContainer.find('.is-selected:first');
			if (selectedEntry.length > 0)
			{
				var campaignData = selectedEntry.data('campaign');
				if (CampaignMenuModulesIdentifier.Campaign.FileName in campaignData && campaignData[CampaignMenuModulesIdentifier.Campaign.FileName] !== null)
					self.notifyBackendDeleteButtonPressed(campaignData[CampaignMenuModulesIdentifier.Campaign.FileName]);
			}

			self.mDeletePopupDialog = null;
			_dialog.destroyPopupDialog();
		});

		self.mDeletePopupDialog.addPopupDialogCancelButton(function (_dialog)
		{
			self.mDeletePopupDialog = null;
			_dialog.destroyPopupDialog();
		});

		self.mDeletePopupDialog.addPopupDialogContent(self.createDeleteDialogContent(self.mDeletePopupDialog, selectedEntry.data('campaign').name));
	}, '', 1);
	this.mDeleteButton.enableButton(false);

	this.mIsVisible = false;
};

SaveCampaignMenuModule.prototype.destroyDIV = function ()
{
	if(this.mCurrentPopupDialog !== null)
		this.mCurrentPopupDialog.destroyPopupDialog();

	this.mCurrentPopupDialog = null;

	if (this.mDeletePopupDialog !== null)
		this.mDeletePopupDialog.destroyPopupDialog();

	this.mDeletePopupDialog = null;

	// scenario list container
	this.mListContainer.destroyList();
	this.mListContainer = null;
	this.mListScrollContainer = null;

	// buttons
	this.mSaveButton.remove();
	this.mSaveButton  = null;
	this.mCancelButton.remove();
	this.mCancelButton = null;
	this.mDeleteButton.remove();
	this.mDeleteButton  = null;

	this.mDialogContainer.empty();
	this.mDialogContainer.remove();
	this.mDialogContainer = null;

	this.mContainer.empty();
	this.mContainer.remove();
	this.mContainer = null;
};


SaveCampaignMenuModule.prototype.bindTooltips = function ()
{
	
};

SaveCampaignMenuModule.prototype.unbindTooltips = function ()
{
	
};


/*SaveCampaignMenuModule.prototype.registerDatasourceListener = function()
{
	this.mDataSource.addListener(CampaignMenuDatasourceIdentifier.Campaigns.Loaded, jQuery.proxy(this.onCampaignsLoaded, this));
};*/


SaveCampaignMenuModule.prototype.create = function(_parentDiv)
{
	this.createDIV(_parentDiv);
	this.bindTooltips();
};

SaveCampaignMenuModule.prototype.destroy = function()
{
	this.unbindTooltips();
	this.destroyDIV();
};


SaveCampaignMenuModule.prototype.register = function (_parentDiv)
{
	console.log('SaveCampaignMenuModule::REGISTER');

	if (this.mContainer !== null)
	{
		console.error('ERROR: Failed to register Save Campaign Menu Module. Reason: Module is already initialized.');
		return;
	}

	if (_parentDiv !== null && typeof(_parentDiv) == 'object')
	{
		this.create(_parentDiv);
	}
};

SaveCampaignMenuModule.prototype.unregister = function ()
{
	console.log('SaveCampaignMenuModule::UNREGISTER');

	if (this.mContainer === null)
	{
		console.error('ERROR: Failed to unregister Save Campaign Menu Module. Reason: Module is not initialized.');
		return;
	}

	this.destroy();
};

SaveCampaignMenuModule.prototype.isRegistered = function ()
{
	if (this.mContainer !== null)
	{
		return this.mContainer.parent().length !== 0;
	}

	return false;
};


SaveCampaignMenuModule.prototype.registerEventListener = function(_listener)
{
	this.mEventListener = _listener;
};


SaveCampaignMenuModule.prototype.show = function (_campaignData)
{
	this.addCampaignsToList(_campaignData);

	var self = this;
	var offset = -(this.mContainer.parent().width() + this.mContainer.width());
	this.mContainer.css({ 'left' : offset });
	this.mContainer.velocity("finish", true).velocity({ opacity: 1, left: '0', right: '0' },
	{
		duration: Constants.SCREEN_SLIDE_IN_OUT_DELAY,
		easing: 'swing',
		begin: function ()
		{
			//$(this).css({ 'left' : '', 'right' : '' });
			$(this).removeClass('display-none').addClass('display-block');
			self.notifyBackendModuleAnimating();
		},
		complete: function ()
		{
			self.mIsVisible = true;
			//$(this).addClass('is-center');
			self.notifyBackendModuleShown();
		}
	});
};

SaveCampaignMenuModule.prototype.hide = function ()
{
	var self = this;

	var offset = -(this.mContainer.parent().width() + this.mContainer.width());
	this.mContainer.velocity("finish", true).velocity({ opacity: 0, left: offset },
	{
		duration: Constants.SCREEN_SLIDE_IN_OUT_DELAY,
		easing: 'swing',
		begin: function ()
		{
			$(this).removeClass('is-center');
			self.notifyBackendModuleAnimating();
		},
		complete: function ()
		{
			self.mIsVisible = false;
			self.mListScrollContainer.empty();
			$(this).removeClass('display-block').addClass('display-none');
			self.notifyBackendModuleHidden();
		}
	});
};


SaveCampaignMenuModule.prototype.isVisible = function ()
{
	return this.mIsVisible;
};


SaveCampaignMenuModule.prototype.addNewSavegameEntryToList = function ()
{
	var self = this;

	var entry = this.mListScrollContainer.createListCampaign();
	entry.assignListCampaignName('New Savegame');
	entry.assignListImage('ui/banners/harddrive.png');

	entry.assignListCampaignClickHandler(function (_entry, _event)
	{
		// check if this is already selected
		if (_entry.hasClass('is-selected') !== true)
		{
			// deselect all entries first
			self.mListScrollContainer.find('.is-selected:first').each(function (index, el)
			{
				$(el).removeClass('is-selected');
			});

			_entry.addClass('is-selected');

			self.mIsNewSavegame = true;

			self.mSaveButton.enableButton(true);
			self.mDeleteButton.enableButton(false);
		}
	});

	/*entry.assignListCampaignDoubleClickHandler(function (_entry, _event) {
		// check if this is already selected
		if (_entry.hasClass('is-selected') === true)
		{
			self.onSaveButtonPressed();
		}
	});*/

};


SaveCampaignMenuModule.prototype.addCampaignEntryToList = function (_data)
{
	var self = this;

	var entry = this.mListScrollContainer.createListCampaign(_data);
	entry.assignListCampaignName(_data[CampaignMenuModulesIdentifier.Campaign.Name]);
	
	if (CampaignMenuModulesIdentifier.Campaign.Image in _data)
	{
		entry.assignListImage('ui/banners/' + _data[CampaignMenuModulesIdentifier.Campaign.Image] + '.png');
	}

	if (CampaignMenuModulesIdentifier.Campaign.GroupName in _data)
	{
		entry.assignListCampaignGroupName(_data[CampaignMenuModulesIdentifier.Campaign.GroupName]);
	}

	if (_data["isIncompatibleVersion"])
	{
		entry.assignListCampaignDayName("- Incompatible Version -");
		entry.addClass('is-disabled');
	}
	else
	{
		if (CampaignMenuModulesIdentifier.Campaign.DayName in _data)
		{
			entry.assignListCampaignDayName(_data[CampaignMenuModulesIdentifier.Campaign.DayName]);
		}
	}

	if (CampaignMenuModulesIdentifier.Campaign.LegendsVersion in _data)
	{
		entry.assignListCampaignLegendsVersion(_data[CampaignMenuModulesIdentifier.Campaign.LegendsVersion]);
	}

	if (CampaignMenuModulesIdentifier.Campaign.CreationDate in _data)
	{
		entry.assignListCampaignDateTime(_data[CampaignMenuModulesIdentifier.Campaign.CreationDate]);
	}

	entry.assignListCampaignClickHandler(function (_entry, _event)
	{
		// check if this is already selected
		if (_entry.hasClass('is-selected') !== true)
		{
			// deselect all entries first
			self.mListScrollContainer.find('.is-selected:first').each(function (index, el)
			{
				$(el).removeClass('is-selected');
			});

			_entry.addClass('is-selected');

			self.mIsNewSavegame = false;

			self.mSaveButton.enableButton(true);
			self.mDeleteButton.enableButton(true);
		}
	});

	/*entry.assignListCampaignClickHandler(function (_entry, _event) {
		// check if this is already selected
		if (_entry.hasClass('is-selected') === true)
		{
			// deselect all entries first
			self.mListScrollContainer.find('.is-selected:first').each(function(index, el) {
				$(el).removeClass('is-selected');
			});

			_entry.addClass('is-selected');

			self.mIsNewSavegame = false;

			self.mSaveButton.enableButton(true);
			self.mDeleteButton.enableButton(true);
		}

		self.onSaveButtonPressed();
	});*/
};

SaveCampaignMenuModule.prototype.addCampaignsToList = function (_campaigns)
{
	if (_campaigns !== null && jQuery.isArray(_campaigns))
	{
		this.mListScrollContainer.empty();
		this.mSaveButton.enableButton(false);
		this.mDeleteButton.enableButton(false);

		this.addNewSavegameEntryToList();

		for (var i = 0; i < _campaigns.length; ++i)
		{
			if (!(CampaignMenuModulesIdentifier.Campaign.Name in _campaigns[i]))
			{
				console.error('ERROR: Failed to find "name" field while interpreting campaign data.');
				continue;
			}

			if (!(CampaignMenuModulesIdentifier.Campaign.FileName in _campaigns[i]))
			{
				console.error('ERROR: Failed to find "FileName" field while interpreting campaign data. Name: ' + _campaigns[i][CampaignMenuModulesIdentifier.Campaign.Name]);
				continue;
			}

			if(_campaigns[i][CampaignMenuModulesIdentifier.Campaign.Name] == 'Autosave' || _campaigns[i][CampaignMenuModulesIdentifier.Campaign.Name] == 'autosave' || _campaigns[i][CampaignMenuModulesIdentifier.Campaign.Name] == 'quicksave' || _campaigns[i][CampaignMenuModulesIdentifier.Campaign.Name] == 'Quicksave')
				continue;

			this.addCampaignEntryToList(_campaigns[i]);
		}

		//this.selectFirstCampaign();
	}
};

/*
SaveCampaignMenuModule.prototype.selectFirstCampaign = function()
{
	// deselect all entries first
	this.mListScrollContainer.find('.is-selected').each(function(index, el) {
		$(el).removeClass('is-selected');
	});

	var firstEntry = this.mListScrollContainer.find('.l-row:first');
	if (firstEntry.length > 0)
	{
		var entry = firstEntry.find('.list-entry:first');
		entry.addClass('is-selected');
		//this.updateDescription(entry.data('scenario'));
		this.mSaveButton.enableButton(true);
	}
};
*/

SaveCampaignMenuModule.prototype.createDeleteDialogContent = function (_dialog, _name)
{
	var result = $('<div class="delete-campaign-container"/>');

	var row = $('<div class="row"/>');
	result.append(row);

	var label = $('<div class="text-font-normal font-color-label">Permanently delete the campaign <span class="text-font-normal font-color-label-warning">' + _name + '</span>?</div>');
	row.append(label);

	return result;
};

SaveCampaignMenuModule.prototype.createEnterNameDialogContent = function (_dialog)
{
   var result = $('<div class="enter-name-container"/>');

	// create & set name
	var row = $('<div class="row"/>');
	result.append(row);
	var label = $('<div class="label text-font-normal font-color-label font-bottom-shadow">Name:</div>');
	row.append(label);

	var inputLayout = $('<div class="l-input"/>');
	row.append(inputLayout);
	var inputField = inputLayout.createInput('', 0, 32, 1, function (_input)
	{
		_dialog.findPopupDialogOkButton().enableButton(_input.getInputTextLength() >= 1);
	}, 'title-font-big font-bold font-color-brother-name', function (_input)
	{
		var button = _dialog.findPopupDialogOkButton();
		if(button.isEnabled())
			button.click();
	});
   
	return result;
};


SaveCampaignMenuModule.prototype.onCampaignsLoaded = function (_datasource, _data)
{
	if (_data === undefined || _data === null || typeof(_data) !== "object")
	{
		console.error('ERROR: Failed to query campaigns data. Reason: Invalid result.');
		return;
	}

	this.addCampaignsToList(_data);
};

SaveCampaignMenuModule.prototype.onSaveButtonPressed = function ()
{
	if(this.mIsNewSavegame)
	{
		var self = this;

		//this.mDataSource.notifyBackendPopupDialogIsVisible(true);
		this.mCurrentPopupDialog = $('.save-campaign-menu-module').createPopupDialog('Enter Name', null, null, 'enter-save-name-dialog');
		this.mCurrentPopupDialog.addPopupDialogOkButton(function (_dialog)
		{
			var contentContainer = _dialog.findPopupDialogContentContainer();
			var inputFields = contentContainer.find('input');

			var name = $(inputFields[0]).getInputText();

			self.mCurrentPopupDialog = null;
			_dialog.destroyPopupDialog();

			//self.mDataSource.notifyBackendPopupDialogIsVisible(false);

			self.notifyBackendSaveButtonPressed(name);
		});
		this.mCurrentPopupDialog.findPopupDialogOkButton().enableButton(false);

		this.mCurrentPopupDialog.addPopupDialogCancelButton(function (_dialog)
		{
			self.mCurrentPopupDialog = null;
			_dialog.destroyPopupDialog();
			//self.mDataSource.notifyBackendPopupDialogIsVisible(false);
		});

		this.mCurrentPopupDialog.addPopupDialogContent(self.createEnterNameDialogContent(this.mCurrentPopupDialog));

		// focus!
		var inputFields = this.mCurrentPopupDialog.findPopupDialogContentContainer().find('input');
		$(inputFields[0]).focus();
	}
	else
	{
		// find current selected and save it
		var selectedEntry = this.mListScrollContainer.find('.is-selected:first');
		if(selectedEntry.length > 0)
		{
			var campaignData = selectedEntry.data('campaign');
			
			if(CampaignMenuModulesIdentifier.Campaign.FileName in campaignData && campaignData[CampaignMenuModulesIdentifier.Campaign.FileName] !== null)
			{
				this.notifyBackendSaveButtonPressed(campaignData[CampaignMenuModulesIdentifier.Campaign.Name]);
			}
		}
	}
};


SaveCampaignMenuModule.prototype.notifyBackendModuleShown = function ()
{
	if (this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onModuleShown');
	}
};

SaveCampaignMenuModule.prototype.notifyBackendModuleHidden = function ()
{
	if (this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onModuleHidden');
	}
};

SaveCampaignMenuModule.prototype.notifyBackendModuleAnimating = function ()
{
	if (this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onModuleAnimating');
	}
};

SaveCampaignMenuModule.prototype.notifyBackendSaveButtonPressed = function (_campaignFileName)
{
	if (this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onSaveButtonPressed', _campaignFileName);
	}
};

SaveCampaignMenuModule.prototype.notifyBackendCancelButtonPressed = function ()
{
	if (this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onCancelButtonPressed');
	}
};

SaveCampaignMenuModule.prototype.notifyBackendDeleteButtonPressed = function (_campaignFileName)
{
	if (this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onDeleteButtonPressed', _campaignFileName);
	}
};