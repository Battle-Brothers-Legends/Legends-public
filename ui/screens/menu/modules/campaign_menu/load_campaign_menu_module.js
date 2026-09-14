/*
 *  @Project:		Battle Brothers
 *	@Company:		Overhype Studios
 *
 *	@Copyright:		(c) Overhype Studios | 2013 - 2015
 *
 *  @Author:		Overhype Studios
 *  @Date:			12.01.2015
 *  @Description:	Load Campaign Menu Module JS
 */
"use strict";

var LoadCampaignMenuModule = function(/*_dataSource*/)
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
	this.mLoadButton = null;
	this.mCancelButton = null;
	this.mDeleteButton = null;

	// generics
	this.mIsVisible = false;

	// current popup dialog
	this.mDeletePopupDialog = null;

	//this.registerDatasourceListener();
};


LoadCampaignMenuModule.prototype.isConnected = function ()
{
	return this.mSQHandle !== null;
};

LoadCampaignMenuModule.prototype.onConnection = function (_handle)
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

LoadCampaignMenuModule.prototype.onDisconnection = function ()
{
	this.mSQHandle = null;

	// notify listener
	if (this.mEventListener !== null && ('onModuleOnDisconnectionCalled' in this.mEventListener)) {
		this.mEventListener.onModuleOnDisconnectionCalled(this);
	}
};


LoadCampaignMenuModule.prototype.createDIV = function (_parentDiv)
{
	var self = this;

	// create: dialog container
	this.mContainer = $('<div class="load-campaign-menu-module ui-control display-none"/>');
	_parentDiv.append(this.mContainer);
	this.mDialogContainer = this.mContainer.createDialog('Load Campaign', null, null, false, 'dialog-800-720-2');

	// create content
	var content = this.mContainer.findDialogContentContainer();
	var scenarioListContainerLayout = $('<div class="l-list-container"></div>');
	content.append(scenarioListContainerLayout);
	this.mListContainer = scenarioListContainerLayout.createList(2);
	this.mListScrollContainer = this.mListContainer.findListScrollContainer();

	// create footer button bar
	var footerButtonBar = $('<div class="l-button-bar"></div>');
	this.mDialogContainer.findDialogFooterContainer().append(footerButtonBar);

	var layout = $('<div class="l-load-button"/>');
	footerButtonBar.append(layout);
	this.mLoadButton = layout.createTextButton("Load", function ()
	{
		// find current selected and load it
		var selectedEntry = self.mListScrollContainer.find('.is-selected:first');
		if (selectedEntry.length > 0)
		{
			var campaignData = selectedEntry.data('campaign');
			if (CampaignMenuModulesIdentifier.Campaign.FileName in campaignData && campaignData[CampaignMenuModulesIdentifier.Campaign.FileName] !== null)
			self.notifyBackendLoadButtonPressed(campaignData[CampaignMenuModulesIdentifier.Campaign.FileName]);
		}
	}, '', 1);
	this.mLoadButton.enableButton(false);

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

		self.mDeletePopupDialog = self.mContainer.createPopupDialog('Delete', null, null, 'delete-save-dialog');
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

LoadCampaignMenuModule.prototype.destroyDIV = function ()
{
	if(this.mDeletePopupDialog !== null)
	{
		this.mDeletePopupDialog.destroyPopupDialog();
		this.mDeletePopupDialog = null;
	}

	// scenario list container
	this.mListContainer.destroyList();
	this.mListContainer = null;
	this.mListScrollContainer = null;

	// buttons
	this.mLoadButton.remove();
	this.mLoadButton  = null;
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


LoadCampaignMenuModule.prototype.bindTooltips = function ()
{
	
};

LoadCampaignMenuModule.prototype.unbindTooltips = function ()
{
	
};


/*LoadCampaignMenuModule.prototype.registerDatasourceListener = function()
{
	//this.mDataSource.addListener(CampaignMenuDatasourceIdentifier.Campaigns.Loaded, jQuery.proxy(this.onCampaignsLoaded, this));
};*/


LoadCampaignMenuModule.prototype.create = function(_parentDiv)
{
	this.createDIV(_parentDiv);
	this.bindTooltips();
};

LoadCampaignMenuModule.prototype.destroy = function()
{
	this.unbindTooltips();
	this.destroyDIV();
};


LoadCampaignMenuModule.prototype.register = function (_parentDiv)
{
	console.log('LoadCampaignMenuModule::REGISTER');

	if (this.mContainer !== null)
	{
		console.error('ERROR: Failed to register Load Campaign Menu Module. Reason: Module is already initialized.');
		return;
	}

	if (_parentDiv !== null && typeof(_parentDiv) == 'object')
	{
		this.create(_parentDiv);
	}
};

LoadCampaignMenuModule.prototype.unregister = function ()
{
	console.log('LoadCampaignMenuModule::UNREGISTER');

	if (this.mContainer === null)
	{
		console.error('ERROR: Failed to unregister Load Campaign Menu Module. Reason: Module is not initialized.');
		return;
	}

	this.destroy();
};

LoadCampaignMenuModule.prototype.isRegistered = function ()
{
	if (this.mContainer !== null)
	{
		return this.mContainer.parent().length !== 0;
	}

	return false;
};


LoadCampaignMenuModule.prototype.registerEventListener = function(_listener)
{
	this.mEventListener = _listener;
};


LoadCampaignMenuModule.prototype.show = function (_campaignData)
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

LoadCampaignMenuModule.prototype.hide = function ()
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

LoadCampaignMenuModule.prototype.isVisible = function ()
{
	return this.mIsVisible;
};


LoadCampaignMenuModule.prototype.addCampaignEntryToList = function (_data)
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

	if(_data["isIncompatibleVersion"])
	{
		entry.assignListCampaignDayName("- Incompatible Version or DLC Missing -");
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

			self.mLoadButton.enableButton(!_data["isIncompatibleVersion"]);
			self.mDeleteButton.enableButton(true);
		}
	});

	entry.assignListCampaignDoubleClickHandler(function (_entry, _event)
	{
		// check if this is already selected
		if (_entry.hasClass('is-selected') === true && !_data["isIncompatibleVersion"])
		{
			var campaignData = _entry.data('campaign');

			if(CampaignMenuModulesIdentifier.Campaign.FileName in campaignData && campaignData[CampaignMenuModulesIdentifier.Campaign.FileName] !== null)
				self.notifyBackendLoadButtonPressed(campaignData[CampaignMenuModulesIdentifier.Campaign.FileName]);
		}		
	});
};

LoadCampaignMenuModule.prototype.addCampaignsToList = function (_campaigns)
{
	if (_campaigns !== null && jQuery.isArray(_campaigns))
	{
		this.mListScrollContainer.empty();
		this.mLoadButton.enableButton(false);
		this.mDeleteButton.enableButton(false);

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

			this.addCampaignEntryToList(_campaigns[i]);
		}

		//this.selectFirstCampaign();
	}
};

LoadCampaignMenuModule.prototype.createDeleteDialogContent = function (_dialog, _name)
{
	var result = $('<div class="delete-campaign-container"/>');

	var row = $('<div class="row"/>');
	result.append(row);

	var label = $('<div class="text-font-normal font-color-label">Permanently delete the campaign <span class="text-font-normal font-color-label-warning">' + _name + '</span>?</div>');
	row.append(label);

	return result;
};

/*
LoadCampaignMenuModule.prototype.selectFirstCampaign = function()
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
		this.mLoadButton.enableButton(true);
	}
};
*/


/*LoadCampaignMenuModule.prototype.onCampaignsLoaded = function (_datasource, _data)
{
	if (_data === undefined || _data === null || typeof(_data) !== "object") {
		console.error('ERROR: Failed to query campaigns data. Reason: Invalid result.');
		return;
	}

	this.addCampaignsToList(_data);
};*/


LoadCampaignMenuModule.prototype.notifyBackendModuleShown = function ()
{
	if (this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onModuleShown');
	}
};

LoadCampaignMenuModule.prototype.notifyBackendModuleHidden = function ()
{
	if (this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onModuleHidden');
	}
};

LoadCampaignMenuModule.prototype.notifyBackendModuleAnimating = function ()
{
	if (this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onModuleAnimating');
	}
};

LoadCampaignMenuModule.prototype.notifyBackendLoadButtonPressed = function (_campaignFileName)
{
	if (this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onLoadButtonPressed', _campaignFileName);
	}
};

LoadCampaignMenuModule.prototype.notifyBackendCancelButtonPressed = function ()
{
	if (this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onCancelButtonPressed');
	}
};

LoadCampaignMenuModule.prototype.notifyBackendDeleteButtonPressed = function (_campaignFileName)
{
	if (this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onDeleteButtonPressed', _campaignFileName);
	}
};