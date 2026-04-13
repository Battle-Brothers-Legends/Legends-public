WorldTownScreenTrainingDialogModule.prototype.mPopupDialog

WorldTownScreenTrainingDialogModule.prototype.openPopupDialog = function(_text)
{
	var self = this;

	this.mPopupDialog = $('.l-training-dialog-container').createPopupDialog('Notice', null, null, 'notice-popup-dialog');
	this.mPopupDialog.addPopupDialogOkButton(function(_dialog) {
		self.mPopupDialog = null;
		_dialog.destroyPopupDialog();
	});

	// make the content
	var result = $('<div class="notice-popup-container"/>');
	var row = $('<div class="row"/>');
		row.appendTo(result);

	var label = $('<div class="text-font-normal font-color-label"></div>');
		label.appendTo(row);

	var parsedText = XBBCODE.process({
		text: _text,
		removeMisalignedTags: false,
		addInLineBreaks: true
	});

	label.html(parsedText.html);
	// the end of the content

	this.mPopupDialog.addPopupDialogContent(result);
};

WorldTownScreenTrainingDialogModule.prototype.loadFromData = function (_data)
{
	if(_data === undefined || _data === null)
    {
        return;
    }

	if('Title' in _data && _data.Title !== null)
	{
		 this.mDialogContainer.findDialogTitle().html(_data.Title);
	}

	if('SubTitle' in _data && _data.SubTitle !== null)
	{
		 this.mDialogContainer.findDialogSubTitle().html(_data.SubTitle);
	}

	this.mRoster = _data.Roster;

    this.mListScrollContainer.empty();

    if (_data.Roster.length != 0)
    {
    	this.mNoInjuredLabel.addClass('display-none');

    	for (var i = 0; i < _data.Roster.length; ++i)
    	{
    		var entry = _data.Roster[i];
			if(entry.Training.length != 0)
    			this.addListEntry(entry);
    	}
    }
    else
    {
    	this.mNoInjuredLabel.removeClass('display-none');
    }

    this.selectListEntry(this.mListContainer.findListEntryByIndex(0), true);
};

WorldTownScreenTrainingDialogModule.prototype.removeRosterEntry = function (_entry)
{
	if (_entry !== null)
	{
		var data = _entry.data('entry');
		if (('ID' in data && data['ID'] !== null) || data.Training.length == 0)
		{
			var entry = _entry.parent(); // get the 'l-row' container
			var prevEntry = entry.prev();
			entry.remove();

			if (prevEntry.length > 0)
			{
				this.selectListEntry(prevEntry.find('.list-entry:first'), false/*true*/);
			}
			else
			{
				this.selectListEntry(this.mListContainer.findListEntryByIndex(0), true);
			}

			this.mRoster.splice(data.index, 1);
		}
		else
		{
			console.error('ERROR: Failed to update training roster. Invalid entry data.');
		}
	}
};

WorldTownScreenTrainingDialogModule.prototype.updateDetailsPanel = function(_element)
{
    if(_element !== null && _element.length > 0)
    {
        var currentMoney = this.mAssets.getValues().Money;
        var data = _element.data('entry');
        
		this.mDetailsPanel.CharacterImage.attr('src', Path.PROCEDURAL + data.ImagePath);     
        this.mDetailsPanel.CharacterImage.centerImageWithinParent(0, 0, 1.0); 
           
        this.mDetailsPanel.CharacterName.html(data['Name']);

        this.mDetailsPanel.ScrollContainerList.empty();

        if(data.Training.length != 0)
        {
        	for (var i = 0; i < data.Training.length; ++i)
        	{
        		this.createTrainingControlDIV(i, this.mDetailsPanel.ScrollContainerList, data.ID, data.Training[i], currentMoney);
        	}
			this.mDetailsPanel.Container.removeClass('display-none').addClass('display-block');
        }
        else
        {
        	var row = $('<div class="is-injury-row display-block text-font-medium font-bottom-shadow font-color-description display-none">No training options available at this time.</div>');
        	this.mDetailsPanel.ScrollContainerList.append(row);
			this.mDetailsPanel.Container.removeClass('display-block').addClass('display-none');
			this.removeRosterEntry(_element);
        }

        
    }
    else
    {
        this.mDetailsPanel.Container.removeClass('display-block').addClass('display-none');
    }
};