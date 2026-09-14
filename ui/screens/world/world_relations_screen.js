/*
 *  @Project:		Battle Brothers
 *	@Company:		Overhype Studios
 *
 *	@Copyright:		(c) Overhype Studios | 2015
 * 
 *  @Author:		Overhype Studios
 *  @Date:			31.10.2017
 *  @Description:	World Relations Screen JS
 */
"use strict";

var WorldRelationsScreen = function (_parent) {
    this.mSQHandle = null;

    // generic containers
    this.mContainer = null;
    this.mDialogContainer = null;
    this.mListContainer = null;
    this.mListScrollContainer = null;
    this.mDetailsPanel = {
        Container: null,
        BannerImage: null,
        FactionName: null,
        FactionMotto: null,
        FactionTraits: null,
        FactionDescriptionTextContainer: null,
        FactionDescriptionTextScrollContainer: null,
        /*		FactionTypeImage: null,*/
        CharacterPanel: null
    };
    this.mBottomRow = null;

    // assets
    this.mRenownAsset = null;
    this.mReputationAsset = null;

    // buttons
    this.mLeaveButton = null;

    // generics
    this.mIsVisible = false;

    // selected entry
    this.mSelectedEntry = null;
};

WorldRelationsScreen.prototype.isConnected = function () {
    return this.mSQHandle !== null;
};

WorldRelationsScreen.prototype.onConnection = function (_handle) {
    this.mSQHandle = _handle;
    this.register($('.root-screen'));
};

WorldRelationsScreen.prototype.onDisconnection = function () {
    this.mSQHandle = null;
    this.unregister();
};

WorldRelationsScreen.prototype.getModule = function (_name) {
    switch (_name) {
        default: return null;
    }
};

WorldRelationsScreen.prototype.getModules = function () {
    return [];
};

WorldRelationsScreen.prototype.createDIV = function (_parentDiv) {
    var self = this;

    // create: containers (init hidden!)
    this.mContainer = $('<div class="world-relations-screen display-none opacity-none"/>');
    _parentDiv.append(this.mContainer);

    // create: containers (init hidden!)
    var dialogLayout = $('<div class="l-relations-dialog-container"/>');
    this.mContainer.append(dialogLayout);
    this.mDialogContainer = dialogLayout.createDialog('Factions & Relations', null, '', true, 'dialog-1024-768');

    // create tabs
    var tabButtonsContainer = $('<div class="l-tab-container"/>');
    this.mDialogContainer.findDialogTabContainer().append(tabButtonsContainer);

    // create assets
    this.mRenownAsset = this.createAssetDIV(tabButtonsContainer, Path.GFX + Asset.ICON_ASSET_BUSINESS_REPUTATION, 'is-business-reputation');
    this.mReputationAsset = this.createAssetDIV(tabButtonsContainer, Path.GFX + Asset.ICON_ASSET_MORAL_REPUTATION, 'is-moral-reputation');

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
    var detailsRow = $('<div class="row is-faction-container"/>');
    this.mDetailsPanel.Container.append(detailsRow);
    var detailsColumn = $('<div class="column is-banner-container"/>');
    detailsRow.append(detailsColumn);
    this.mDetailsPanel.BannerImage = detailsColumn.createImage(null, function (_image) {
        var offsetX = 0;
        var offsetY = 0;

        if (self.mSelectedEntry !== null) {
            var data = self.mSelectedEntry.data('entry');
            if ('ImageOffsetX' in data && data['ImageOffsetX'] !== null &&
                'ImageOffsetY' in data && data['ImageOffsetY'] !== null) {
                offsetX = data['ImageOffsetX'];
                offsetY = data['ImageOffsetY'];
            }
        }

        _image.centerImageWithinParent(offsetX, offsetY, 1.0);
        _image.removeClass('opacity-none');
    }, null, 'opacity-none');
    detailsColumn = $('<div class="column is-background-description-container"/>');
    detailsRow.append(detailsColumn);

    // details: background
    var backgroundRow = $('<div class="row is-top"/>');
    detailsColumn.append(backgroundRow);
    var backgroundRowBorder = $('<div class="row is-top border"/>');
    backgroundRow.append(backgroundRowBorder);

    //     this.mDetailsPanel.FactionTypeImage = $('<img />');
    //     detailsColumn.append(this.mDetailsPanel.FactionTypeImage);

    this.mDetailsPanel.FactionName = $('<div class="name title-font-normal font-bold font-bottom-shadow font-color-brother-name"/>');
    backgroundRow.append(this.mDetailsPanel.FactionName);

    this.mDetailsPanel.FactionMotto = $('<div class="motto description-font-medium font-bold font-bottom-shadow font-color-description"/>');
    backgroundRow.append(this.mDetailsPanel.FactionMotto);

    this.mDetailsPanel.FactionTraits = $('<div class="traits description-font-medium font-bold font-color-description"/>');
    backgroundRow.append(this.mDetailsPanel.FactionTraits);

    this.mBottomRow = $('<div class="row is-bottom"/>');
    detailsColumn.append(this.mBottomRow);
    this.mDetailsPanel.FactionDescriptionTextContainer = this.mBottomRow.createList(20, 'description-font-medium font-bottom-shadow font-color-description', true);
    this.mDetailsPanel.FactionDescriptionTextScrollContainer = this.mDetailsPanel.FactionDescriptionTextContainer.findListScrollContainer();

    this.mDetailsPanel.CharacterPanel = $('<div class="is-character-container"/>');
    detailsRow.append(this.mDetailsPanel.CharacterPanel);

    // create footer button bar
    var footerButtonBar = $('<div class="l-button-bar"/>');
    this.mDialogContainer.findDialogFooterContainer().append(footerButtonBar);

    // create: buttons
    var layout = $('<div class="l-leave-button"/>');
    footerButtonBar.append(layout);
    this.mLeaveButton = layout.createTextButton("Close", function () {
        self.notifyBackendCloseButtonPressed();
    }, '', 1);

    this.mIsVisible = false;
};

WorldRelationsScreen.prototype.destroyDIV = function () {
    //this.mAssets.destroyDIV();

    this.mSelectedEntry = null;

    this.mRenownAsset.remove();
    this.mRenownAsset = null;
    this.mReputationAsset.remove();
    this.mReputationAsset = null;

    this.mDetailsPanel.FactionDescriptionTextScrollContainer.empty();
    this.mDetailsPanel.FactionDescriptionTextScrollContainer = null;
    this.mDetailsPanel.FactionDescriptionTextContainer.destroyList();
    this.mDetailsPanel.FactionDescriptionTextContainer.remove();
    this.mDetailsPanel.FactionDescriptionTextContainer = null;

    this.mDetailsPanel.FactionName.empty();
    this.mDetailsPanel.FactionName.remove();
    this.mDetailsPanel.FactionName = null;

    this.mDetailsPanel.BannerImage.empty();
    this.mDetailsPanel.BannerImage.remove();
    this.mDetailsPanel.BannerImage = null;

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

    this.mBottomRow.empty();
    this.mBottomRow.remove()
    this.mBottomRow = null;

    this.mContainer.empty();
    this.mContainer.remove();
    this.mContainer = null;
};

WorldRelationsScreen.prototype.createAssetDIV = function (_parentDiv, _imagePath, _classExtra) {
    var layout = $('<div class="l-tab-asset"/>');
    layout.addClass(_classExtra);
    _parentDiv.append(layout);

    var image = $('<img/>');
    image.attr('src', _imagePath);
    layout.append(image);
    var text = $('<div class="label text-font-normal font-color-assets-positive-value"/>');
    layout.append(text);

    return layout;
};


WorldRelationsScreen.prototype.addListEntry = function (_data) {
    var result = $('<div class="l-row"/>');
    this.mListScrollContainer.append(result);

    var entry = $('<div class="ui-control list-entry"/>');
    result.append(entry);
    entry.data('entry', _data);
    entry.click(this, function (_event) {
        var self = _event.data;
        self.selectListEntry($(this));
    });

    // left column
    var column = $('<div class="column is-left"/>');
    entry.append(column);

    var imageOffsetX = ('ImageOffsetX' in _data ? _data['ImageOffsetX'] : 0);
    var imageOffsetY = ('ImageOffsetY' in _data ? _data['ImageOffsetY'] : 0);
    column.createImage(Path.GFX + _data['ImagePath'], function (_image) {
        _image.centerImageWithinParent(imageOffsetX, imageOffsetY, 0.5);
        _image.removeClass('opacity-none');
    }, null, 'opacity-none');

    // right column
    column = $('<div class="column is-right"/>');
    entry.append(column);

    // top row
    var row = $('<div class="row is-top"/>');
    column.append(row);

    // bind tooltip
    //image.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterBackgrounds.Generic, elementOwner: TooltipIdentifier.ElementOwner.HireScreen, entityId: _data[WorldTownScreenIdentifier.HireRosterEntry.Id] });

    var name = $('<div class="name title-font-normal font-bold font-color-brother-name">' + _data['Name'] + '</div>');
    row.append(name);

    // bottom row
    row = $('<div class="row is-bottom"/>');
    column.append(row);

    var assetsCenterContainer = $('<div class="l-assets-center-container"/>');
    row.append(assetsCenterContainer);

    // relation
    var assetsContainer = $('<div class="l-assets-container"/>');
    assetsCenterContainer.append(assetsContainer);

    var progressbarContainer = $('<div class="stats-progressbar-container ui-control-stats-progressbar-container-relations"></div>');
    assetsContainer.append(progressbarContainer);

    progressbarContainer.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.RelationsScreen.Relations, entityId: _data.ID });

    var progressbar = $('<div class="stats-progressbar ui-control-stats-progressbar relations"></div>');
    var newWidth = (_data.RelationNum / 100.0) * 100;
    progressbar.css('width', newWidth + '%');
    progressbarContainer.append(progressbar);

    var progressbarLabel = $('<div class="stats-progressbar-label text-font-small font-color-progressbar-label">' + _data['Relation'] + '</div>');
    progressbarContainer.append(progressbarLabel);
};

WorldRelationsScreen.prototype.selectListEntry = function (_element, _scrollToEntry) {
    if (_element !== null && _element.length > 0) {
        // check if this is already selected
        //if (_element.hasClass('is-selected') !== true)
        {
            this.mListContainer.deselectListEntries();
            _element.addClass('is-selected');

            // give the renderer some time to layout his shit...
            if (_scrollToEntry !== undefined && _scrollToEntry === true) {
                this.mListContainer.scrollListToElement(_element);
            }

            this.mSelectedEntry = _element;
            this.updateDetailsPanel(this.mSelectedEntry);
            //this.updateListEntryValues();
        }
    }
    else {
        this.mSelectedEntry = null;
        this.updateDetailsPanel(this.mSelectedEntry);
        //this.updateListEntryValues();
    }
};

WorldRelationsScreen.prototype.updateDetailsPanel = function (_element) {
    if (_element !== null && _element.length > 0) {
        var data = _element.data('entry');

        this.mDetailsPanel.BannerImage.attr('src', Path.GFX + data['ImagePath']);

        // retarded JS calls load callback after a significant delay only - so we call this here manually to position/resize an image that is completely loaded already anyway
        this.mDetailsPanel.BannerImage.centerImageWithinParent(0, 0, 1.0);

        this.mDetailsPanel.FactionName.html(data['Name']);
        var mottoText = data['Motto'];
        if (mottoText && mottoText.length > 0) {
            this.mBottomRow.removeClass('has-no-motto');
        } else {
            this.mBottomRow.addClass('has-no-motto');
        }
        this.mDetailsPanel.FactionMotto.html(data['Motto']);

        this.mDetailsPanel.FactionTraits.empty(); 
        var self = this;
        var traitsArray = data['Traits'];
        if (traitsArray && traitsArray.length > 0) {
            for (var i = 0; i < traitsArray.length; i++) {
                (function (_trait) {
                    var traitSpan = $('<span class="trait-item font-bold">' + _trait.Name + '</span>');
                    traitSpan.css('color', _trait.Color.replace(/#135213/gi, "#1e861e").replace(/#8f1e1e/gi, "#a22424").replace(/#000ec1/gi, "#2176c5"));
                    traitSpan.bindTooltip({
                        contentType: 'ui-element',
                        elementId: 'faction-trait-tooltip',
                        entityId: _trait.ID
                    });
                    self.mDetailsPanel.FactionTraits.append(traitSpan);
                })(traitsArray[i]);

                if (i < traitsArray.length - 1) {
                    this.mDetailsPanel.FactionTraits.append('<span class="font-color-description">, </span>');
                }
            }
            this.mDetailsPanel.FactionTraits.removeClass('display-none').addClass('display-block');
            this.mBottomRow.removeClass('has-no-traits');
        } else {
            this.mDetailsPanel.FactionTraits.removeClass('display-block').addClass('display-none');
            this.mBottomRow.addClass('has-no-traits');
        }

        /*        this.mDetailsPanel.FactionTypeImage.attr('src', Path.GFX + data['TypeImagePath']);*/
        this.mDetailsPanel.FactionDescriptionTextScrollContainer.html(data['Description']);

        this.mDetailsPanel.CharacterPanel.empty();
        for (var i = 0; i < data['Characters'].length; ++i) {
            var character = $('<div class="character' + i + '"/>');
            //var characterImage = character.createImage(Path.PROCEDURAL + data['Characters'][i].ImagePath, null, null, '');

            var characterImage = character.createImage(Path.PROCEDURAL + data['Characters'][i].ImagePath, function (_image) {
                _image.centerImageWithinParent(0, 0, 1.0);
                //_image.removeClass('opacity-none');
            }, null, ''/*'opacity-none'*/);

            characterImage.centerImageWithinParent(0, 0, 1.0);
            characterImage.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterNameAndTitles, entityId: data['Characters'][i].ID });

            this.mDetailsPanel.CharacterPanel.append(character);
        }

        // bin tooltips
        //this.mDetailsPanel.FactionTypeImage.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterBackgrounds.Generic, elementOwner: TooltipIdentifier.ElementOwner.HireScreen, entityId: data[WorldTownScreenIdentifier.HireRosterEntry.Id] });

        this.mDetailsPanel.Container.removeClass('display-none').addClass('display-block');
    }
    else {
        this.mDetailsPanel.Container.removeClass('display-block').addClass('display-none');
    }
};

// WorldRelationsScreen.prototype.updateListEntryValues = function()
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

WorldRelationsScreen.prototype.bindTooltips = function () {
    this.mRenownAsset.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.Assets.BusinessReputation });
    this.mReputationAsset.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.Assets.MoralReputation });

    //this.mAssets.bindTooltips();
    //this.mLeaveButton.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.WorldTownScreen.HireDialogModule.LeaveButton });
};

WorldRelationsScreen.prototype.unbindTooltips = function () {
    this.mRenownAsset.unbindTooltip();
    this.mReputationAsset.unbindTooltip();
    this.mDetailsPanel.FactionTraits.find('.trait-item').each(function () {
        $(this).unbindTooltip();
    });

    //this.mAssets.unbindTooltips();
    //this.mLeaveButton.unbindTooltip();
    //this.mDetailsPanel.FactionTypeImage.unbindTooltip();
};


WorldRelationsScreen.prototype.create = function (_parentDiv) {
    this.createDIV(_parentDiv);
    this.bindTooltips();
};

WorldRelationsScreen.prototype.destroy = function () {
    this.unbindTooltips();
    this.destroyDIV();
};


WorldRelationsScreen.prototype.register = function (_parentDiv) {
    console.log('WorldRelationsScreen::REGISTER');

    if (this.mContainer !== null) {
        console.error('ERROR: Failed to register Relations Screen. Reason: Already initialized.');
        return;
    }

    if (_parentDiv !== null && typeof (_parentDiv) == 'object') {
        this.create(_parentDiv);
    }
};

WorldRelationsScreen.prototype.unregister = function () {
    console.log('WorldRelationsScreen::UNREGISTER');

    if (this.mContainer === null) {
        console.error('ERROR: Failed to unregister Relations Screen. Reason: Not initialized.');
        return;
    }

    this.destroy();
};

WorldRelationsScreen.prototype.isRegistered = function () {
    if (this.mContainer !== null) {
        return this.mContainer.parent().length !== 0;
    }

    return false;
};


WorldRelationsScreen.prototype.show = function (_data) {
    this.loadFromData(_data);

    if (!this.mIsVisible) {
        var self = this;

        var withAnimation = true;//(_data !== undefined && _data['withSlideAnimation'] !== null) ? _data['withSlideAnimation'] : true;
        if (withAnimation === true) {
            var offset = -(this.mContainer.parent().width() + this.mContainer.width());
            this.mContainer.css({ 'left': offset });
            this.mContainer.velocity("finish", true).velocity({ opacity: 1, left: '0', right: '0' }, {
                duration: Constants.SCREEN_SLIDE_IN_OUT_DELAY,
                easing: 'swing',
                begin: function () {
                    $(this).removeClass('display-none').addClass('display-block');
                    self.notifyBackendOnAnimating();
                },
                complete: function () {
                    self.mIsVisible = true;
                    self.notifyBackendOnShown();
                }
            });
        }
        else {
            this.mContainer.css({ opacity: 0 });
            this.mContainer.velocity("finish", true).velocity({ opacity: 1 }, {
                duration: Constants.SCREEN_FADE_IN_OUT_DELAY,
                easing: 'swing',
                begin: function () {
                    $(this).removeClass('display-none').addClass('display-block');
                    self.notifyBackendOnAnimating();
                },
                complete: function () {
                    self.mIsVisible = true;
                    self.notifyBackendOnShown();
                }
            });
        }
    }
};

WorldRelationsScreen.prototype.hide = function (_withSlideAnimation) {
    var self = this;

    var withAnimation = true;//(_withSlideAnimation !== undefined && _withSlideAnimation !== null) ? _withSlideAnimation : true;
    if (withAnimation === true) {
        var offset = -(this.mContainer.parent().width() + this.mContainer.width());
        this.mContainer.velocity("finish", true).velocity({ opacity: 0, left: offset },
            {
                duration: Constants.SCREEN_SLIDE_IN_OUT_DELAY,
                easing: 'swing',
                begin: function () {
                    $(this).removeClass('is-center');
                    self.notifyBackendOnAnimating();
                },
                complete: function () {
                    self.mIsVisible = false;
                    self.mListScrollContainer.empty();
                    $(this).removeClass('display-block').addClass('display-none');
                    self.notifyBackendOnHidden();
                }
            });
    }
    else {
        this.mContainer.velocity("finish", true).velocity({ opacity: 0 },
            {
                duration: Constants.SCREEN_SLIDE_IN_OUT_DELAY,
                easing: 'swing',
                begin: function () {
                    $(this).removeClass('is-center');
                    self.notifyBackendOnAnimating();
                },
                complete: function () {
                    self.mIsVisible = false;
                    self.mListScrollContainer.empty();
                    $(this).removeClass('display-block').addClass('display-none');
                    self.notifyBackendOnHidden();
                }
            });
    }
};

WorldRelationsScreen.prototype.isVisible = function () {
    return this.mIsVisible;
};

// WorldRelationsScreen.prototype.updateAssets = function (_data)
// {
// 	this.mAssets.loadFromData(_data);
// 	this.updateListEntryValues();
// }

WorldRelationsScreen.prototype.loadFromData = function (_data) {
    if (_data === undefined || _data === null) {
        return;
    }

    if ('BusinessReputation' in _data && _data['BusinessReputation'] !== null) {
        var label = this.mRenownAsset.find('.label:first');

        if (label.length > 0)
            label.html(_data['BusinessReputation']);
    }

    if ('MoralReputation' in _data && _data['MoralReputation'] !== null) {
        var label = this.mReputationAsset.find('.label:first');

        if (label.length > 0)
            label.html(_data['MoralReputation']);
    }

    this.mListScrollContainer.empty();

    for (var i = 0; i < _data.Factions.length; ++i) {
        var entry = _data.Factions[i];
        this.addListEntry(entry);
    }

    this.selectListEntry(this.mListContainer.findListEntryByIndex(0), true);
};

WorldRelationsScreen.prototype.notifyBackendOnConnected = function () {
    if (this.mSQHandle !== null) {
        SQ.call(this.mSQHandle, 'onScreenConnected');
    }
};

WorldRelationsScreen.prototype.notifyBackendOnDisconnected = function () {
    if (this.mSQHandle !== null) {
        SQ.call(this.mSQHandle, 'onScreenDisconnected');
    }
};

WorldRelationsScreen.prototype.notifyBackendOnShown = function () {
    if (this.mSQHandle !== null) {
        SQ.call(this.mSQHandle, 'onScreenShown');
    }
};

WorldRelationsScreen.prototype.notifyBackendOnHidden = function () {
    if (this.mSQHandle !== null) {
        SQ.call(this.mSQHandle, 'onScreenHidden');
    }
};

WorldRelationsScreen.prototype.notifyBackendOnAnimating = function () {
    if (this.mSQHandle !== null) {
        SQ.call(this.mSQHandle, 'onScreenAnimating');
    }
};

WorldRelationsScreen.prototype.notifyBackendCloseButtonPressed = function (_buttonID) {
    if (this.mSQHandle !== null) {
        SQ.call(this.mSQHandle, 'onClose', _buttonID);
    }
};