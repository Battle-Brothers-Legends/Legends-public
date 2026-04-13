
"use strict";

var WorldTownScreenBarberDialogModule = function(_parent)
{
	this.mSQHandle = null;
    this.mParent = _parent;

	this.mRoster = null;

    // event listener
    this.mEventListener = null;

	// generic containers
	this.mContainer = null;
    this.mDialogContainer = null;
    this.mListContainer = null;
    this.mListScrollContainer = null;
    this.mDetailsPanel = {
        Container: null,
        CharacterImage: null,
        CharacterName: null,
        HireButton: null
    };

	// controls
	this.mAppearanceOptions =
	{
		Hair:
		{
			DownButton: null,
			UpButton: null,
			LayerID: 'hair'
		},

		Beard:
		{
			DownButton: null,
			UpButton: null,
			LayerID: 'beard'
		},

		Color:
		{
			DownButton: null,
			UpButton: null,
			LayerID: 'color'
		},

		Head:
		{
			DownButton: null,
			UpButton: null,
			LayerID: 'head'
		},

		Body:
		{
			DownButton: null,
			UpButton: null,
			LayerID: 'body'
		},

		Tattoo:
		{
			DownButton: null,
			UpButton: null,
			LayerID: 'tattoo'
		},

        TattooHead:
		{
			DownButton: null,
			UpButton: null,
			LayerID: 'tattoo_head'
		}
	};

    // assets labels
	this.mAssets = new WorldTownScreenAssets(_parent);

    // buttons
    this.mLeaveButton = null;

    // generics
    this.mIsVisible = false;

    // selected entry
    this.mSelectedEntry = null;
};


WorldTownScreenBarberDialogModule.prototype.isConnected = function ()
{
    return this.mSQHandle !== null;
};

WorldTownScreenBarberDialogModule.prototype.onConnection = function (_handle)
{
	//if (typeof(_handle) == 'string')
	{
		this.mSQHandle = _handle;

        // notify listener
        if (this.mEventListener !== null && ('onModuleOnConnectionCalled' in this.mEventListener))
		{
            this.mEventListener.onModuleOnConnectionCalled(this);
        }
	}
};

WorldTownScreenBarberDialogModule.prototype.onDisconnection = function ()
{
	this.mSQHandle = null;

    // notify listener
    if (this.mEventListener !== null && ('onModuleOnDisconnectionCalled' in this.mEventListener))
	{
        this.mEventListener.onModuleOnDisconnectionCalled(this);
    }
};

WorldTownScreenBarberDialogModule.prototype.createDIV = function (_parentDiv)
{
    var self = this;

    // create: containers (init hidden!)
    this.mContainer = $('<div class="l-barber-dialog-container display-none opacity-none"/>');
    _parentDiv.append(this.mContainer);
    this.mDialogContainer = this.mContainer.createDialog('Barber', '', '', true, 'dialog-1024-768');

    // create tabs
    var tabButtonsContainer = $('<div class="l-tab-container"/>');
    this.mDialogContainer.findDialogTabContainer().append(tabButtonsContainer);

	// create assets
	this.mAssets.createDIV(tabButtonsContainer);

    // create content
    var content = this.mDialogContainer.findDialogContentContainer();

    // left column
    var column = $('<div class="column is-left"/>');
    content.append(column);
    var listContainerLayout = $('<div class="l-list-container"/>');
    column.append(listContainerLayout);
    this.mListContainer = listContainerLayout.createList(1.77/*8.85*/);
    this.mListScrollContainer = this.mListContainer.findListScrollContainer();

    // right column
    column = $('<div class="column is-right"/>');
    content.append(column);

    // details container
    var detailsFrame = $('<div class="l-details-frame"/>');
    column.append(detailsFrame);
    this.mDetailsPanel.Container = $('<div class="details-container display-none"/>');
    detailsFrame.append(this.mDetailsPanel.Container);

    // details: character container
    var detailsRow = $('<div class="row is-character-container"/>');
    this.mDetailsPanel.Container.append(detailsRow);
    var detailsColumn = $('<div class="column is-character-portrait-container"/>');
    detailsRow.append(detailsColumn);
    this.mDetailsPanel.CharacterImage = detailsColumn.createImage(null, function (_image)
	{
        var offsetX = 0;
        var offsetY = 0;

        if(self.mSelectedEntry !== null)
        {
            var data = self.mSelectedEntry.data('entry');
            if('ImageOffsetX' in data && data['ImageOffsetX'] !== null &&
                'ImageOffsetY' in data && data['ImageOffsetY'] !== null)
            {
                offsetX = data['ImageOffsetX'];
                offsetY = data['ImageOffsetY'];
            }
        }

        _image.centerImageWithinParent(offsetX, offsetY, 1.0, false);
        _image.removeClass('opacity-none');
    }, null, 'opacity-none');
    detailsColumn = $('<div class="column is-character-background-container"/>');
    detailsRow.append(detailsColumn);

    // details: background
    var backgroundRow = $('<div class="row is-top"/>');
    detailsColumn.append(backgroundRow);
	var backgroundRowBorder = $('<div class="row is-top border"/>');
	backgroundRow.append(backgroundRowBorder);

    this.mDetailsPanel.CharacterName = $('<div class="name title-font-normal font-bold font-color-brother-name"/>');
    backgroundRow.append(this.mDetailsPanel.CharacterName);
    backgroundRow = $('<div class="row is-bottom"/>');
    detailsColumn.append(backgroundRow);

	// details: controls
	var row = $('<div class="row"></div>');
	this.mDetailsPanel.Container.append(row);
	this.createAppearanceControlDIV("Hair Color", 'color-control', this.mAppearanceOptions.Color, row);

	var row = $('<div class="row"></div>');
	this.mDetailsPanel.Container.append(row);
	this.createAppearanceControlDIV("Head", 'Head-control', this.mAppearanceOptions.Head, row);

	var row = $('<div class="row"></div>');
	this.mDetailsPanel.Container.append(row);
	this.createAppearanceControlDIV("Hair", 'hair-control', this.mAppearanceOptions.Hair, row);

	var row = $('<div class="row"></div>');
	this.mDetailsPanel.Container.append(row);
	this.createAppearanceControlDIV("Beard", 'beard-control', this.mAppearanceOptions.Beard, row);

	var row = $('<div class="row"></div>');
	this.mDetailsPanel.Container.append(row);
	this.createAppearanceControlDIV("Body", 'body-control', this.mAppearanceOptions.Body, row);

	var row = $('<div class="row"></div>');
	this.mDetailsPanel.Container.append(row);
	this.createAppearanceControlDIV("Tattoo", 'tattoo-control', this.mAppearanceOptions.Tattoo, row);

    var row = $('<div class="row"></div>');
	this.mDetailsPanel.Container.append(row);
	this.createAppearanceControlDIV("Head Tattoo", 'tattoo-head-control', this.mAppearanceOptions.TattooHead, row);

    // details: buttons
    detailsRow = $('<div class="row is-button-container"/>');
    this.mDetailsPanel.Container.append(detailsRow);
    var hireButtonLayout = $('<div class="l-barber-button"/>');
    detailsRow.append(hireButtonLayout);
    this.mDetailsPanel.HireButton = hireButtonLayout.createTextButton("Accept", function()
	{
        if(self.mSelectedEntry !== null)
        {
            var data = self.mSelectedEntry.data('entry');
            if('ID' in data && data['ID'] !== null)
            {
                self.changeRosterEntry(data['ID']);
            }
        }
    }, '', 1);

    // create footer button bar
    var footerButtonBar = $('<div class="l-button-bar"/>');
    this.mDialogContainer.findDialogFooterContainer().append(footerButtonBar);

    // create: buttons
    var layout = $('<div class="l-leave-button"/>');
    footerButtonBar.append(layout);
    this.mLeaveButton = layout.createTextButton("Leave", function() {
        self.notifyBackendLeaveButtonPressed();
    }, '', 1);

    this.mIsVisible = false;
};

WorldTownScreenBarberDialogModule.prototype.destroyDIV = function ()
{
	this.mAssets.destroyDIV();

	this.mSelectedEntry = null;

    this.mDetailsPanel.HireButton.remove();
    this.mDetailsPanel.HireButton = null;

    this.mDetailsPanel.CharacterName.empty();
    this.mDetailsPanel.CharacterName.remove();
    this.mDetailsPanel.CharacterName = null;

    this.mDetailsPanel.CharacterImage.empty();
    this.mDetailsPanel.CharacterImage.remove();
    this.mDetailsPanel.CharacterImage = null;

    this.mDetailsPanel.Container.empty();
    this.mDetailsPanel.Container.remove();
    this.mDetailsPanel.Container = null;

    this.mListScrollContainer.empty();
    this.mListScrollContainer = null;
    this.mListContainer.destroyList();
    this.mListContainer.remove();
    this.mListContainer = null;

	this.mLeaveButton.remove();
    this.mLeaveButton = null;

    this.mDialogContainer.empty();
    this.mDialogContainer.remove();
    this.mDialogContainer = null;

    this.mContainer.empty();
    this.mContainer.remove();
    this.mContainer = null;
};

WorldTownScreenBarberDialogModule.prototype.createAppearanceControlDIV = function (_label, _class, _definition, _parentDiv)
{
    var self = this;

	var control = $('<div class="appearance-control ' + _class + '"></div>');
	_parentDiv.append(control);

    var layout = $('<div class="l-button"/>');
    control.append(layout);
    _definition.DownButton = layout.createImageButton(Path.GFX + Asset.BUTTON_ARROW_LEFT, function ()
	{
		var data = self.mSelectedEntry.data('entry');
		self.notifyBackendUpdateAppearance(data.ID, _definition.LayerID, -1, function(imagePath)
        {
            self.mDetailsPanel.CharacterImage.attr('src', Path.PROCEDURAL + imagePath);
        });
    }, '', 6);

    _definition.Label = $('<div class="ui-control text text-font-normal font-color-value font-bottom-shadow">' + _label + '</div>');
	control.append(_definition.Label);

    layout = $('<div class="l-button"/>');
    control.append(layout);
    _definition.UpButton = layout.createImageButton(Path.GFX + Asset.BUTTON_ARROW_RIGHT, function ()
	{
        var data = self.mSelectedEntry.data('entry');
        self.notifyBackendUpdateAppearance(data.ID, _definition.LayerID, 1, function (imagePath)
        {
            self.mDetailsPanel.CharacterImage.attr('src', Path.PROCEDURAL + imagePath);
        });
    }, '', 6);
};

WorldTownScreenBarberDialogModule.prototype.addListEntry = function (_data)
{
    var result = $('<div class="l-row"/>');
    this.mListScrollContainer.append(result);

    var entry = $('<div class="ui-control list-entry"/>');
    result.append(entry);
    entry.data('entry', _data);
    entry.click(this, function(_event)
	{
        var self = _event.data;
        self.selectListEntry($(this));
    });

    // left column
    var column = $('<div class="column is-left"/>');
    entry.append(column);

    var imageOffsetX = ('ImageOffsetX' in _data ? _data['ImageOffsetX'] : 0);
    var imageOffsetY = ('ImageOffsetY' in _data ? _data['ImageOffsetY'] : 0);
    column.createImage(Path.PROCEDURAL + _data['ImagePath'], function (_image)
	{
        _image.centerImageWithinParent(imageOffsetX, imageOffsetY, 0.64);
        _image.removeClass('opacity-none');
    }, null, 'opacity-none');

    // right column
    column = $('<div class="column is-right"/>');
    entry.append(column);

    // top row
    var row = $('<div class="row is-top"/>');
    column.append(row);

    var image = $('<img/>');
    image.attr('src', Path.GFX + _data['BackgroundImagePath']);
    row.append(image);

    // bind tooltip
    image.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterBackgrounds.Generic, elementOwner: TooltipIdentifier.ElementOwner.HireScreen, entityId: _data.ID });

    var name = $('<div class="name title-font-normal font-bold font-color-brother-name">' + _data[WorldTownScreenIdentifier.HireRosterEntry.Name] + '</div>');
    row.append(name);

	// bottom row
    row = $('<div class="row is-bottom"/>');
    column.append(row);

    var assetsCenterContainer = $('<div class="l-assets-center-container"/>');
    row.append(assetsCenterContainer);
};

WorldTownScreenBarberDialogModule.prototype.selectListEntry = function(_element, _scrollToEntry)
{
    if (_element !== null && _element.length > 0)
    {
        // check if this is already selected
        //if (_element.hasClass('is-selected') !== true)
        {
            this.mListContainer.deselectListEntries();
            _element.addClass('is-selected');

            // give the renderer some time to layout his shit...
            if (_scrollToEntry !== undefined && _scrollToEntry === true)
            {
                this.mListContainer.scrollListToElement(_element);
            }

            this.mSelectedEntry = _element;
            this.updateDetailsPanel(this.mSelectedEntry);
            //this.updateListEntryValues();
        }
    }
    else
    {
        this.mSelectedEntry = null;
        this.updateDetailsPanel(this.mSelectedEntry);
        //this.updateListEntryValues();
    }
};

WorldTownScreenBarberDialogModule.prototype.updateDetailsPanel = function(_element)
{
    if(_element !== null && _element.length > 0)
    {
        //var currentMoney = this.mAssets.getValues().Money;
        var data = _element.data('entry');
        //var initialMoneyCost = (data !== null && 'InitialMoneyCost' in data ? data['InitialMoneyCost'] : 0);
        
        var self = this;
		this.notifyBackendEntrySelected(data['ID'], function(imagePath)
        {
            self.mDetailsPanel.CharacterImage.attr('src', Path.PROCEDURAL + imagePath);     
           
            // retarded JS calls load callback after a significant delay only - so we call this here manually to position/resize an image that is completely loaded already anyway
            self.mDetailsPanel.CharacterImage.centerImageWithinParent(0, 0, 1.0); 
           
            self.mDetailsPanel.CharacterName.html(data['Name']);
    /*        this.mDetailsPanel.CharacterBackgroundImage.attr('src', Path.GFX + data['BackgroundImagePath']);*/
    /*        this.mDetailsPanel.InitialMoneyCostsText.html(Helper.numberWithCommas(data['InitialMoneyCost']));*/

            // bin tooltips
            //this.mDetailsPanel.CharacterBackgroundImage.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterBackgrounds.Generic, elementOwner: TooltipIdentifier.ElementOwner.HireScreen, entityId: data.ID });

            // special cases for not enough resources
           /* if((currentMoney - initialMoneyCost) < 0)
            {
                this.mDetailsPanel.InitialMoneyCostsText.removeClass('font-color-assets-value').addClass('font-color-assets-negative-value');
                //this.mDetailsPanel.HireButton.enableButton(false);
            }
            else
            {
                //this.mDetailsPanel.HireButton.enableButton(true);
                this.mDetailsPanel.InitialMoneyCostsText.removeClass('font-color-assets-negative-value').addClass('font-color-assets-value');*/
    /*        }*/

            self.mDetailsPanel.Container.removeClass('display-none').addClass('display-block');
        });
    }
    else
    {
        this.mDetailsPanel.Container.removeClass('display-block').addClass('display-none');
    }
};

// WorldTownScreenBarberDialogModule.prototype.updateListEntryValues = function()
// {
//     var currentMoney = this.mAssets.getValues().Money;
//     var container = this.mListContainer.findListScrollContainer();
//     container.find('.list-entry').each(function(index, element)
// 	{
//         var entry = $(element);
//         var initialMoneyCostElement = entry.find('.is-initial-money-cost');
//         var data = entry.data('entry');
//         var initialMoneyCost = (data !== null && 'InitialMoneyCost' in data ? data['InitialMoneyCost'] : 0);
//         if((currentMoney - initialMoneyCost) < 0)
//         {
//             initialMoneyCostElement.removeClass('font-color-assets-value').addClass('font-color-assets-negative-value');
//         }
//         else
//         {
//             initialMoneyCostElement.removeClass('font-color-assets-negative-value').addClass('font-color-assets-value');
//         }
//     });
// };

WorldTownScreenBarberDialogModule.prototype.bindTooltips = function ()
{
    this.mAssets.bindTooltips();
    this.mLeaveButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.WorldTownScreen.HireDialogModule.LeaveButton });
};

WorldTownScreenBarberDialogModule.prototype.unbindTooltips = function ()
{
	this.mAssets.unbindTooltips();
    this.mLeaveButton.unbindTooltip();
};


WorldTownScreenBarberDialogModule.prototype.create = function(_parentDiv)
{
    this.createDIV(_parentDiv);
    this.bindTooltips();
};

WorldTownScreenBarberDialogModule.prototype.destroy = function()
{
    this.unbindTooltips();
    this.destroyDIV();
};


WorldTownScreenBarberDialogModule.prototype.register = function (_parentDiv)
{
    console.log('WorldTownScreenBarberDialogModule::REGISTER');

    if (this.mContainer !== null)
    {
        console.error('ERROR: Failed to register World Town Screen Hire Dialog Module. Reason: World Town Screen Hire Dialog Module is already initialized.');
        return;
    }

    if (_parentDiv !== null && typeof(_parentDiv) == 'object')
    {
        this.create(_parentDiv);
    }
};

WorldTownScreenBarberDialogModule.prototype.unregister = function ()
{
    console.log('WorldTownScreenBarberDialogModule::UNREGISTER');

    if (this.mContainer === null)
    {
        console.error('ERROR: Failed to unregister World Town Screen Hire Dialog Module. Reason: World Town Screen Hire Dialog Module is not initialized.');
        return;
    }

    this.destroy();
};

WorldTownScreenBarberDialogModule.prototype.isRegistered = function ()
{
    if (this.mContainer !== null)
    {
        return this.mContainer.parent().length !== 0;
    }

    return false;
};


WorldTownScreenBarberDialogModule.prototype.registerEventListener = function(_listener)
{
    this.mEventListener = _listener;
};


WorldTownScreenBarberDialogModule.prototype.show = function (_withSlideAnimation)
{
    var self = this;

    var withAnimation = (_withSlideAnimation !== undefined && _withSlideAnimation !== null) ? _withSlideAnimation : true;
    if (withAnimation === true)
    {
        var offset = -(this.mContainer.parent().width() + this.mContainer.width());
        this.mContainer.css({ 'left': offset });
        this.mContainer.velocity("finish", true).velocity({ opacity: 1, left: '0', right: '0' }, {
            duration: Constants.SCREEN_SLIDE_IN_OUT_DELAY,
            easing: 'swing',
            begin: function () {
                $(this).removeClass('display-none').addClass('display-block');
                self.notifyBackendModuleAnimating();
            },
            complete: function () {
                self.mIsVisible = true;
                self.notifyBackendModuleShown();
            }
        });
    }
    else
    {
        this.mContainer.css({ opacity: 0 });
        this.mContainer.velocity("finish", true).velocity({ opacity: 1 }, {
            duration: Constants.SCREEN_FADE_IN_OUT_DELAY,
            easing: 'swing',
            begin: function() {
                $(this).removeClass('display-none').addClass('display-block');
                self.notifyBackendModuleAnimating();
            },
            complete: function() {
                self.mIsVisible = true;
                self.notifyBackendModuleShown();
            }
        });
    }
};

WorldTownScreenBarberDialogModule.prototype.hide = function ()
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

WorldTownScreenBarberDialogModule.prototype.isVisible = function ()
{
    return this.mIsVisible;
};

WorldTownScreenBarberDialogModule.prototype.updateAssets = function (_data)
{
	this.mAssets.loadFromData(_data);
	//this.updateListEntryValues();
}

WorldTownScreenBarberDialogModule.prototype.loadFromData = function (_data)
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

    for(var i = 0; i < _data.Roster.length; ++i)
    {
		var entry = _data.Roster[i];
        this.addListEntry(entry);
    }

    this.selectListEntry(this.mListContainer.findListEntryByIndex(0), true);
};

WorldTownScreenBarberDialogModule.prototype.changeRosterEntry = function (_entryID)
{
    var self = this;
    this.notifyBackendChangeAppearance(_entryID, function(imagePath)
    {
    	var result = self.mSelectedEntry.find('img:first');
        if(result.length > 0)
        {
           result.attr('src', Path.PROCEDURAL + imagePath);
        }
    });
};

WorldTownScreenBarberDialogModule.prototype.notifyBackendModuleShown = function ()
{
    SQ.call(this.mSQHandle, 'onModuleShown');
};

WorldTownScreenBarberDialogModule.prototype.notifyBackendModuleHidden = function ()
{
    SQ.call(this.mSQHandle, 'onModuleHidden');
};

WorldTownScreenBarberDialogModule.prototype.notifyBackendModuleAnimating = function ()
{
    SQ.call(this.mSQHandle, 'onModuleAnimating');
};

WorldTownScreenBarberDialogModule.prototype.notifyBackendLeaveButtonPressed = function ()
{
	SQ.call(this.mSQHandle, 'onLeaveButtonPressed');
};

WorldTownScreenBarberDialogModule.prototype.notifyBackendBrothersButtonPressed = function ()
{
    SQ.call(this.mSQHandle, 'onBrothersButtonPressed');
};

WorldTownScreenBarberDialogModule.prototype.notifyBackendChangeAppearance = function (_entryID, _callback)
{
    SQ.call(this.mSQHandle, 'onChangeAppearance', _entryID, _callback);
};


WorldTownScreenBarberDialogModule.prototype.notifyBackendEntrySelected = function (_entryID, _callback)
{
	SQ.call(this.mSQHandle, 'onEntrySelected', _entryID, _callback);
};


WorldTownScreenBarberDialogModule.prototype.notifyBackendUpdateAppearance = function (_entryID, _layerID, _change, _callback)
{
	SQ.call(this.mSQHandle, 'onUpdateAppearance', [ _entryID, _layerID, _change ], _callback);
};