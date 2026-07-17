/*
 *  @Project:		Battle Brothers
 *	@Company:		Overhype Studios
 *  @Description:	Perks Module JS
 */
"use strict";


var CharacterScreenPerksModule = function(_parent, _dataSource)
{
    this.mParent = _parent;
    this.mDataSource = _dataSource;

	// container
	this.mContainer = null;
    this.mListContainer = null;
    this.mListScrollContainer = null;
	this.mHorizontalBar = null;

    this.mLeftColumn = null;
    this.mMiddleColumn = null;
    this.mRightColumn = null;

    // perks
    this.mPerkTree = null;
    this.mPerkRows = [];

	this.mStatusBar = null;
    this.mPlanLabels = {
        Planned: null,
        Tentative: null,
        Books: null,
        Scrolls: null
    };

    this.registerDatasourceListener();
};


CharacterScreenPerksModule.prototype.createDIV = function (_parentDiv)
{
	// create: containers (init hidden!)
	this.mContainer = $('<div class="perks-module opacity-none"/>');
	_parentDiv.append(this.mContainer);
	
	this.mListContainer = $('<div class="ui-control list has-frame"/>');
	var scrollContainer = $('<div class="scroll-container"/>');
    this.mListContainer.append(scrollContainer);
	this.mContainer.append(this.mListContainer);
    this.mListContainer.aciScrollBar({
         delta: 1.0,
         lineDelay: 0,
         lineTimer: 0,
         pageDelay: 0,
         pageTimer: 0,
         bindKeyboard: false,
         resizable: false,
         smoothScroll: false,
		 verticalBar: 'none',
    });
    //this.mListContainer = this.mContainer.createList(1.0/*8.85*/);
    this.mListScrollContainer = this.mListContainer.findListScrollContainer();
	//this.mListContainer.showListScrollbar(false);
	this.mHorizontalBar = this.mListContainer.find('.aciSb_bar_h:first');
/*     if (this.mHorizontalBar.length > 0)
    {
        console.error('foundit');
		var _container = this.mHorizontalBar.find('.aciSb_cnt:first');
		_container.css({ 'left' : '-30px' });
		//horizbar.css({ 'bottom': '-30px' });
    }  */
    // create rows
    this.mLeftColumn = $('<div class="column"/>');
    this.mListScrollContainer.append(this.mLeftColumn);

	this.mStatusBar = $('<div class="perk-plan-status-bar"/>');
    this.mContainer.append(this.mStatusBar);

    var createStatusItem = function(_iconPath, _tooltipId) {
        var item = $('<div class="status-item"/>');
        var img = $('<img/>').attr('src', Path.GFX + _iconPath);
        var label = $('<div class="status-label text-font-small font-bold font-color-value"/>');
        
        item.append(img);
        item.append(label);
        
        item.bindTooltip({ contentType: 'ui-element', elementId: _tooltipId });

        return { container: item, label: label, img: img };
    };

    this.mPlanLabels.Books = createStatusItem(Asset.PLAN_BOOK, TooltipIdentifier.CharacterScreen.RightPanelHeaderModule.PerkPlanScreenBooks);
    this.mPlanLabels.Scrolls = createStatusItem(Asset.PLAN_SCROLL, TooltipIdentifier.CharacterScreen.RightPanelHeaderModule.PerkPlanScreenScrolls);
    this.mPlanLabels.Planned = createStatusItem(Asset.PLAN_LEVEL_COUNT, TooltipIdentifier.CharacterScreen.RightPanelHeaderModule.PerkPlanScreenPlanned);
    this.mPlanLabels.Tentative = createStatusItem(Asset.PLAN_TENTATIVE_COUNT, TooltipIdentifier.CharacterScreen.RightPanelHeaderModule.PerkPlanScreenTentative); 

    this.mStatusBar.append(this.mPlanLabels.Books.container);
    this.mStatusBar.append(this.mPlanLabels.Scrolls.container);
    this.mStatusBar.append(this.mPlanLabels.Planned.container);
    this.mStatusBar.append(this.mPlanLabels.Tentative.container);
};

CharacterScreenPerksModule.prototype.destroyDIV = function ()
{
    this.mLeftColumn.empty();
    this.mLeftColumn.remove();
    this.mLeftColumn = null;

    this.mListScrollContainer.empty();
    this.mListScrollContainer = null;
    this.mListContainer.destroyList();
    this.mListContainer.remove();
    this.mListContainer = null;
	
    this.mContainer.empty();
    this.mContainer.remove();
    this.mContainer = null;
};


CharacterScreenPerksModule.prototype.createPerkTreeDIV = function (_perkTree, _parentDiv)
{
	var self = this;
	var widetree = false;
	var lowestx = 0;

	for (var row = 0; row < _perkTree.length; ++row)
	{
		lowestx = Math.min(lowestx, ((660 - (40.0 * _perkTree[row].length)) / 2));
		if (_perkTree[row].length > 16)
		{
			widetree = true;
		}
	}
	//console.error('lowestx = ' + lowestx);
	
	for (var row = 0; row < _perkTree.length; ++row)
	{
		var rowDIV = $('<div class="row"/>');
		rowDIV.css({ 'left' : 0, 'top': (row * 6.0) + 'rem' }); // css is retarded?
		_parentDiv.append(rowDIV);

		var centerDIV = $('<div class="center"/>');
		rowDIV.append(centerDIV);

		this.mPerkRows[row] = rowDIV;
		
		for (var i = 0; i < _perkTree[row].length; ++i)
		{
			var perk = _perkTree[row][i];
			perk.Unlocked = false;

			perk.Container = $('<div class="l-perk-container"/>');
			centerDIV.append(perk.Container);

			var perkSelectionImage = $('<img class="selection-image-layer display-none"/>');
			perkSelectionImage.attr('src', Path.GFX + Asset.PERK_SELECTION_FRAME);
			perk.Container.append(perkSelectionImage);

			perk.Image = $('<img class="perk-image-layer"/>');
			perk.Image.attr('src', Path.GFX + perk.IconDisabled);
			perk.Container.append(perk.Image);

			perk.PlanImage = $('<img class="plan-image-layer display-none"/>');
            perk.Container.append(perk.PlanImage);
		}
		
		centerDIV.find(".l-perk-container").css({ 'width': '4.0rem' });
		centerDIV.css({ 'width': (4.0 * _perkTree[row].length) + 'rem' });
		centerDIV.css({ 'left': (((660 - centerDIV.width()) / 2) - lowestx) + 'px' });
	}
	if (widetree == true)
	{
		self.mHorizontalBar.css({ opacity : 1 });
		//self.mHorizontalBar.css({ 'z-index' : '10' });
	}
	else
	{
		self.mHorizontalBar.css({ opacity : 0 });
/* 		var zet = this.mListContainer.find('.aciScrollBar:first');
		zet.css({ 'z-index' : '-10' }); */
		//console.error('forbidden lowestx = ' + lowestx);
	}
};


CharacterScreenPerksModule.prototype.resetPerkTree = function(_perkTree)
{
	if (_perkTree == null)
		return;
	
	this.mPerkTree = _perkTree;

	for (var row = 0; row < this.mPerkRows.length; ++row)
	{
		this.mPerkRows[row].removeClass('is-unlocked').addClass('is-locked');
	}

	for (var row = 0; row < _perkTree.length; ++row)
	{
		for (var i = 0; i < _perkTree[row].length; ++i)
		{
			var perk = _perkTree[row][i];
			console.error(Object.keys(perk));
			perk.Unlocked = false;

			perk.Image.attr('src', Path.GFX + perk.IconDisabled);

			var selectionLayer = perk.Container.find('.selection-image-layer:first');
			selectionLayer.addClass('display-none').removeClass('display-block');
		}
	}
};

CharacterScreenPerksModule.prototype.initPerkTree = function (_perkTree, _perksUnlocked)
{
	var perkPointsSpent = this.mDataSource.getBrotherPerkPointsSpent(this.mDataSource.getSelectedBrother());

	for (var row = 0; row < _perkTree.length; ++row)
	{
		for (var i = 0; i < _perkTree[row].length; ++i)
		{
			var perk = _perkTree[row][i];

			for (var j = 0; j < _perksUnlocked.length; ++j)
			{
				if(_perksUnlocked[j] == perk.ID)
				{
					perk.Unlocked = true;

					perk.Image.attr('src', Path.GFX + perk.Icon);

					var selectionLayer = perk.Container.find('.selection-image-layer:first');
					selectionLayer.removeClass('display-none').addClass('display-block');

					break;
				}
			}

			/*if(perk.Row <= perkPointsSpent)
			{
				var selectionLayer = perk.Container.find('.selection-image-layer:first');
				selectionLayer.removeClass('display-none').addClass('display-block');
			}*/
		}
	}
	
	for (var row = 0; row < this.mPerkRows.length; ++row)
	{
		if (row <= perkPointsSpent)
		{
			this.mPerkRows[row].addClass('is-unlocked').removeClass('is-locked');
		}
		else
		{
			break;
		}
	}
};

CharacterScreenPerksModule.prototype.setupPerkTreeTooltips = function(_perkTree, _brotherId)
{
	for (var row = 0; row < _perkTree.length; ++row)
	{
		for (var i = 0; i < _perkTree[row].length; ++i)
		{
			var perk = _perkTree[row][i];
			perk.Image.unbindTooltip();
			perk.Image.bindTooltip({ contentType: 'ui-perk', entityId: _brotherId, perkId: perk.ID });
		}
	}
};

CharacterScreenPerksModule.prototype.setupPerkTree = function (_perkTree)
{
	if (this.mPerkTree !== null) {
		this.removePerksEventHandlers()
	}
	this.mLeftColumn.empty();
	this.mPerkTree = _perkTree;
    this.createPerkTreeDIV(this.mPerkTree, this.mLeftColumn);

    this.setupPerksEventHandlers(this.mPerkTree);
};

CharacterScreenPerksModule.prototype.updatePerkTreeLayout = function (_inventoryMode)
{
};

CharacterScreenPerksModule.prototype.loadPerkTreesWithBrotherData = function (_brother)
{
    this.setupPerkTree(_brother[CharacterScreenIdentifier.Perk.Tree]);

    if (CharacterScreenIdentifier.Perk.Key in _brother)
    {
        this.initPerkTree(this.mPerkTree, _brother[CharacterScreenIdentifier.Perk.Key]);
    }

    if (CharacterScreenIdentifier.Entity.Id in _brother)
    {
        this.setupPerkTreeTooltips(this.mPerkTree, _brother[CharacterScreenIdentifier.Entity.Id]);
    }

	this.updatePerkPlanVisuals(_brother);
};

CharacterScreenPerksModule.prototype.isPerkUnlockable = function (_perk)
{
	var _brother = this.mDataSource.getSelectedBrother();
	var character = _brother[CharacterScreenIdentifier.Entity.Character.Key];
	var level = character[CharacterScreenIdentifier.Entity.Character.Level];
	var perkPoints = this.mDataSource.getBrotherPerkPoints(_brother);
	var perkPointsSpent = this.mDataSource.getBrotherPerkPointsSpent(_brother);
	
	if(level >= 13 && _perk.ID === 'perk.student') {
		return false;
	}
	return perkPoints > 0 && perkPointsSpent >= _perk.Unlocks;
};

CharacterScreenPerksModule.prototype.updatePerkPlanVisuals = function (_brother) {
    var plan = _brother.PerksPlan || {};
    
    for (var row = 0; row < this.mPerkTree.length; ++row) {
        for (var i = 0; i < this.mPerkTree[row].length; ++i) {
            var perk = this.mPerkTree[row][i];
            var state = plan[perk.ID] || 0;
            
            if (state === 0 || perk.Unlocked) {
                perk.PlanImage.removeClass('display-block').addClass('display-none');
            } else {
                perk.PlanImage.removeClass('display-none').addClass('display-block');
                
                if (state === 1) perk.PlanImage.attr('src', Path.GFX + Asset.PLAN_PLANNED);
                else if (state === 2) perk.PlanImage.attr('src', Path.GFX + Asset.PLAN_TENTATIVE);
                else if (state === 3) perk.PlanImage.attr('src', Path.GFX + Asset.PLAN_EXCLUDED);
            }
        }
    }
    
    if (CharacterScreenIdentifier.Entity.Character.Level in _brother[CharacterScreenIdentifier.Entity.Character.Key]) {
        this.mPlanLabels.Books.label.text(_brother.BooksRead || "0 / 1");
        this.mPlanLabels.Scrolls.label.text(_brother.ScrollsRead || "0 / 1");
        this.mPlanLabels.Planned.label.text(_brother.PlannedLevelRequired || 0);
        this.mPlanLabels.Tentative.label.text(_brother.TentativePerksCount || 0);
    }
};

CharacterScreenPerksModule.prototype.attachEventHandler = function(_perk)
{
	var self = this;

	_perk.Container.on('mouseenter focus' + CharacterScreenIdentifier.KeyEvent.PerksModuleNamespace, null, this, function (_event)
	{
		var selectable = !_perk.Unlocked && self.isPerkUnlockable(_perk);

		if (selectable === true)
		{
			var selectionLayer = $(this).find('.selection-image-layer:first');
			selectionLayer.removeClass('display-none').addClass('display-block');
		}
	});

	_perk.Container.on('mouseleave blur' + CharacterScreenIdentifier.KeyEvent.PerksModuleNamespace, null, this, function (_event)
	{
		var selectable = !_perk.Unlocked && self.isPerkUnlockable(_perk);

		if (selectable === true)
		{
			var selectionLayer = $(this).find('.selection-image-layer:first');
			selectionLayer.removeClass('display-block').addClass('display-none');
		}
	});

	_perk.Container.click(this, function (_event)
	{
		var selectable = !_perk.Unlocked && self.isPerkUnlockable(_perk);

		if (selectable == true && self.mDataSource.isInStashMode())
		{
			self.showPerkUnlockDialog(_perk);
		}
	});

	_perk.Container.on('mousedown' + CharacterScreenIdentifier.KeyEvent.PerksModuleNamespace, null, this, function (_event) {
		if (_event.which === 3) {
			_event.preventDefault();
			if (_perk.Unlocked) return false;
			self.mDataSource.notifyBackendCyclePerkPlan([self.mDataSource.getSelectedBrother()[CharacterScreenIdentifier.Entity.Id], _perk.ID]);
			return false;
		}
    });
}

CharacterScreenPerksModule.prototype.removePerksEventHandler = function (_perkTree)
{
	for (var row = 0; row < _perkTree.length; ++row)
	{
		for (var i = 0; i < _perkTree[row].length; ++i)
		{
			var perk = _perkTree[row][i];

			perk.Container.off(CharacterScreenIdentifier.KeyEvent.PerksModuleNamespace);
			perk.Container.unbind('click');
		}
	}
};

CharacterScreenPerksModule.prototype.setupPerksEventHandlers = function(_perkTree)
{
	//this.removePerksEventHandlers();

	for (var row = 0; row < _perkTree.length; ++row)
	{
		for (var i = 0; i < _perkTree[row].length; ++i)
		{
			var perk = _perkTree[row][i];
			this.attachEventHandler(perk);
		}
	}
};

CharacterScreenPerksModule.prototype.removePerksEventHandlers = function()
{
    this.removePerksEventHandler(this.mPerkTree);
};


CharacterScreenPerksModule.prototype.showPerkUnlockDialog = function(_perk)
{
    this.mDataSource.notifyBackendPopupDialogIsVisible(true);

    var self = this;
    var popupDialog = $('.character-screen').createPopupDialog('Unlock Perk', null, null, 'unlock-perk-popup');
    
    popupDialog.addPopupDialogContent(this.createPerkUnlockDialogContent(_perk));

    popupDialog.addPopupDialogOkButton(jQuery.proxy(function (_dialog)
    {
    	self.mDataSource.unlockPerk(null, _perk.ID);
        _dialog.destroyPopupDialog();
        self.mDataSource.notifyBackendPopupDialogIsVisible(false);
    }, this));

    popupDialog.addPopupDialogCancelButton(function (_dialog)
    {
        _dialog.destroyPopupDialog();
        self.mDataSource.notifyBackendPopupDialogIsVisible(false);
    });
};

CharacterScreenPerksModule.prototype.createPerkUnlockDialogContent = function (_perk)
{
	var result = $('<div class="unlock-perk-popup-dialog-content-container"/>');

    var leftColumn = $('<div class="left-column"/>');
    result.append(leftColumn);

    var perkImage = $('<img/>');
    perkImage.attr('src', Path.GFX + _perk.Icon);
    leftColumn.append(perkImage);

    var rightColumn = $('<div class="right-column"/>');
    result.append(rightColumn);
    
    var perkNameLabel = $('<div class="name title-font-normal font-bold font-color-title">' + _perk.Name + '</div>');
    rightColumn.append(perkNameLabel);

    var descriptionText = _perk.Tooltip.replace(/#135213/gi, "#1e861e"); // positive values
    //descriptionText = descriptionText.replace(/#8f1e1e/gi, "#a22424"); // negative values
	descriptionText = descriptionText.split("\n")[0];

    var parsedDescriptionText = XBBCODE.process({
    	text: descriptionText,
        removeMisalignedTags: false,
        addInLineBreaks: true
    });

    var perkDescriptionLabel = $('<div class="description description-font-small font-style-italic font-color-description">' + parsedDescriptionText.html + '</div>');
    rightColumn.append(perkDescriptionLabel);

    return result;
};


CharacterScreenPerksModule.prototype.registerDatasourceListener = function()
{
    this.mDataSource.addListener(CharacterScreenDatasourceIdentifier.Inventory.ModeUpdated, jQuery.proxy(this.onInventoryModeUpdated, this));

    this.mDataSource.addListener(CharacterScreenDatasourceIdentifier.Perks.TreesLoaded, jQuery.proxy(this.onPerkTreeLoaded, this));

    this.mDataSource.addListener(CharacterScreenDatasourceIdentifier.Brother.Updated, jQuery.proxy(this.onBrotherUpdated, this));
	this.mDataSource.addListener(CharacterScreenDatasourceIdentifier.Brother.Selected, jQuery.proxy(this.onBrotherSelected, this));
};


CharacterScreenPerksModule.prototype.create = function(_parentDiv)
{
    this.createDIV(_parentDiv);
};

CharacterScreenPerksModule.prototype.destroy = function()
{
    this.destroyDIV();
};


CharacterScreenPerksModule.prototype.register = function (_parentDiv)
{
    console.log('CharacterScreenPerksModule::REGISTER');

    if (this.mContainer !== null)
    {
        console.error('ERROR: Failed to register Perks Module. Reason: Module is already initialized.');
        return;
    }

    if (_parentDiv !== null && typeof(_parentDiv) == 'object')
    {
        this.create(_parentDiv);
    }
};

CharacterScreenPerksModule.prototype.unregister = function ()
{
    console.log('CharacterScreenPerksModule::UNREGISTER');

    if (this.mContainer === null)
    {
        console.error('ERROR: Failed to unregister Perks Module. Reason: Module is not initialized.');
        return;
    }

    this.destroy();
};

CharacterScreenPerksModule.prototype.isRegistered = function ()
{
	if (this.mContainer !== null)
	{
		return this.mContainer.parent().length !== 0;
	}

	return false;
};


CharacterScreenPerksModule.prototype.show = function ()
{
    // NOTE: (js) HACK which prevents relayouting..
	this.mContainer.removeClass('opacity-none').addClass('opacity-full');
	//this.mContainer.removeClass('display-none').addClass('display-block');
};

CharacterScreenPerksModule.prototype.hide = function ()
{
    // NOTE: (js) HACK which prevents relayouting..
	this.mContainer.removeClass('opacity-full is-top').addClass('opacity-none');
	//this.mContainer.removeClass('display-block is-top').addClass('display-none');
};

CharacterScreenPerksModule.prototype.isVisible = function ()
{
	return this.mContainer.hasClass('opacity-full');
	//return this.mContainer.hasClass('display-block');
};


CharacterScreenPerksModule.prototype.onInventoryModeUpdated = function (_dataSource, _mode)
{
    this.updatePerkTreeLayout(_mode);
};

CharacterScreenPerksModule.prototype.onPerkTreeLoaded = function (_dataSource, _perkTree)
{
    // if (_perkTree !== null)
    // {
    // 	this.mPerkTree = _perkTree;
    //     this.setupPerkTree();
    // }
};

CharacterScreenPerksModule.prototype.onBrotherUpdated = function (_dataSource, _brother)
{
	if (_dataSource.isSelectedBrother(_brother))
	{
		this.onBrotherSelected(_dataSource, _brother);
	}
};

CharacterScreenPerksModule.prototype.onBrotherSelected = function (_dataSource, _brother)
{
	if (_brother === null)
	{
		return;
	}

    this.loadPerkTreesWithBrotherData(_brother);
};