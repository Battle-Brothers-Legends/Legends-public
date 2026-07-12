"use strict";


var CharacterScreenProfessionModule = function (_parent, _dataSource) {
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

	// professions
	this.mProfessionTree = null;
	this.mProfessionRows = [];

	this.registerDatasourceListener();
};


CharacterScreenProfessionModule.prototype.createDIV = function (_parentDiv) {
	this.mContainer = $('<div class="professions-module opacity-none"/>');
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

	this.mListScrollContainer = this.mListContainer.findListScrollContainer();
	this.mHorizontalBar = this.mListContainer.find('.aciSb_bar_h:first');

	this.mLeftColumn = $('<div class="column"/>');
	this.mListScrollContainer.append(this.mLeftColumn);
};

CharacterScreenProfessionModule.prototype.destroyDIV = function () {
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


CharacterScreenProfessionModule.prototype.createProfessionTreeDIV = function (_professionTree, _parentDiv) {
	var self = this;
	var widetree = false;
	var lowestx = 0;

	for (var row = 0; row < _professionTree.length; ++row) {
		lowestx = Math.min(lowestx, ((660 - (40.0 * _professionTree[row].length)) / 2));
		if (_professionTree[row].length > 16) {
			widetree = true;
		}
	}

	for (var row = 0; row < _professionTree.length; ++row) {
		var rowDIV = $('<div class="row"/>');
		rowDIV.css({ 'left': 0, 'top': (row * 6.0) + 'rem' });
		_parentDiv.append(rowDIV);

		var centerDIV = $('<div class="center"/>');
		rowDIV.append(centerDIV);

		this.mProfessionRows[row] = rowDIV;

		for (var i = 0; i < _professionTree[row].length; ++i) {
			var profession = _professionTree[row][i];
			profession.Unlocked = false;

			profession.Container = $('<div class="l-profession-container"/>');
			centerDIV.append(profession.Container);

			var professionSelectionImage = $('<img class="selection-image-layer display-none"/>');
			professionSelectionImage.attr('src', Path.GFX + Asset.PERK_SELECTION_FRAME);
			profession.Container.append(professionSelectionImage);

			profession.Image = $('<img class="profession-image-layer"/>');
			profession.Image.attr('src', Path.GFX + profession.IconDisabled);
			profession.Container.append(profession.Image);
		}

		centerDIV.find(".l-profession-container").css({ 'width': '4.0rem' });
		centerDIV.css({ 'width': (4.0 * _professionTree[row].length) + 'rem' });
		centerDIV.css({ 'left': (((660 - centerDIV.width()) / 2) - lowestx) + 'px' });
	}
	if (widetree == true) {
		self.mHorizontalBar.css({ opacity: 1 });
	}
	else {
		self.mHorizontalBar.css({ opacity: 0 });
	}
};


CharacterScreenProfessionModule.prototype.resetProfessionTree = function (_professionTree) {
	if (_professionTree == null)
		return;

	this.mProfessionTree = _professionTree;

	for (var row = 0; row < this.mProfessionRows.length; ++row) {
		this.mProfessionRows[row].removeClass('is-unlocked').addClass('is-locked');
	}

	for (var row = 0; row < _professionTree.length; ++row) {
		for (var i = 0; i < _professionTree[row].length; ++i) {
			var profession = _professionTree[row][i];
			console.error(Object.keys(profession));
			profession.Unlocked = false;

			profession.Image.attr('src', Path.GFX + profession.IconDisabled);

			var selectionLayer = profession.Container.find('.selection-image-layer:first');
			selectionLayer.addClass('display-none').removeClass('display-block');
		}
	}
};

CharacterScreenProfessionModule.prototype.initProfessionTree = function (_professionTree, _professionsUnlocked) {
	var professionPointsSpent = this.mDataSource.getBrotherProfessionPointsSpent(this.mDataSource.getSelectedBrother());

	for (var row = 0; row < _professionTree.length; ++row) {
		for (var i = 0; i < _professionTree[row].length; ++i) {
			var profession = _professionTree[row][i];

			for (var j = 0; j < _professionsUnlocked.length; ++j) {
				if (_professionsUnlocked[j] == profession.ID) {
					profession.Unlocked = true;

					profession.Image.attr('src', Path.GFX + profession.Icon);

					var selectionLayer = profession.Container.find('.selection-image-layer:first');
					selectionLayer.removeClass('display-none').addClass('display-block');

					break;
				}
			}

			/*if(profession.Row <= professionPointsSpent)
			{
				var selectionLayer = profession.Container.find('.selection-image-layer:first');
				selectionLayer.removeClass('display-none').addClass('display-block');
			}*/
		}
	}

	for (var row = 0; row < this.mProfessionRows.length; ++row) {
		if (row <= professionPointsSpent) {
			this.mProfessionRows[row].addClass('is-unlocked').removeClass('is-locked');
		}
		else {
			break;
		}
	}
};

CharacterScreenProfessionModule.prototype.setupProfessionTreeTooltips = function (_professionTree, _brotherId) {
	for (var row = 0; row < _professionTree.length; ++row) {
		for (var i = 0; i < _professionTree[row].length; ++i) {
			var profession = _professionTree[row][i];
			profession.Image.unbindTooltip();
			profession.Image.bindTooltip({ contentType: 'ui-profession', entityId: _brotherId, professionId: profession.ID });
		}
	}
};

CharacterScreenProfessionModule.prototype.setupProfessionTree = function (_professionTree) {
	if (this.mProfessionTree !== null) {
		this.removeProfessionsEventHandlers()
	}
	this.mLeftColumn.empty();
	this.mProfessionTree = _professionTree;
	this.createProfessionTreeDIV(this.mProfessionTree, this.mLeftColumn);

	this.setupProfessionsEventHandlers(this.mProfessionTree);
};

CharacterScreenProfessionModule.prototype.updateProfessionTreeLayout = function (_inventoryMode) {
};

CharacterScreenProfessionModule.prototype.loadProfessionTreesWithBrotherData = function (_brother) {
	this.setupProfessionTree(_brother[CharacterScreenIdentifier.Profession.Tree]);

	if (CharacterScreenIdentifier.Profession.Key in _brother) {
		this.initProfessionTree(this.mProfessionTree, _brother[CharacterScreenIdentifier.Profession.Key]);
	}

	if (CharacterScreenIdentifier.Entity.Id in _brother) {
		this.setupProfessionTreeTooltips(this.mProfessionTree, _brother[CharacterScreenIdentifier.Entity.Id]);
	}
};

CharacterScreenProfessionModule.prototype.isProfessionUnlockable = function (_profession) {
	var _brother = this.mDataSource.getSelectedBrother();
	var character = _brother[CharacterScreenIdentifier.Entity.Character.Key];
	var level = character[CharacterScreenIdentifier.Entity.Character.Level];
	var professionPoints = this.mDataSource.getBrotherProfessionPoints(_brother);
	var professionPointsSpent = this.mDataSource.getBrotherProfessionPointsSpent(_brother);

	return professionPoints > 0 && professionPointsSpent >= _profession.Unlocks;
};

CharacterScreenProfessionModule.prototype.attachEventHandler = function (_profession) {
	var self = this;

	_profession.Container.on('mouseenter focus' + CharacterScreenIdentifier.KeyEvent.ProfessionsModuleNamespace, null, this, function (_event) {
		var selectable = !_profession.Unlocked && self.isProfessionUnlockable(_profession);

		if (selectable === true) {
			var selectionLayer = $(this).find('.selection-image-layer:first');
			selectionLayer.removeClass('display-none').addClass('display-block');
		}
	});

	_profession.Container.on('mouseleave blur' + CharacterScreenIdentifier.KeyEvent.ProfessionsModuleNamespace, null, this, function (_event) {
		var selectable = !_profession.Unlocked && self.isProfessionUnlockable(_profession);

		if (selectable === true) {
			var selectionLayer = $(this).find('.selection-image-layer:first');
			selectionLayer.removeClass('display-block').addClass('display-none');
		}
	});

	_profession.Container.click(this, function (_event) {
		var selectable = !_profession.Unlocked && self.isProfessionUnlockable(_profession);

		if (selectable == true && self.mDataSource.isInStashMode()) {
			self.showProfessionUnlockDialog(_profession);
		}
	});
}

CharacterScreenProfessionModule.prototype.removeProfessionsEventHandler = function (_professionTree) {
	for (var row = 0; row < _professionTree.length; ++row) {
		for (var i = 0; i < _professionTree[row].length; ++i) {
			var profession = _professionTree[row][i];

			profession.Container.off(CharacterScreenIdentifier.KeyEvent.ProfessionsModuleNamespace);
			profession.Container.unbind('click');
		}
	}
};

CharacterScreenProfessionModule.prototype.setupProfessionsEventHandlers = function (_professionTree) {
	for (var row = 0; row < _professionTree.length; ++row) {
		for (var i = 0; i < _professionTree[row].length; ++i) {
			var profession = _professionTree[row][i];
			this.attachEventHandler(profession);
		}
	}
};

CharacterScreenProfessionModule.prototype.removeProfessionsEventHandlers = function () {
	this.removeProfessionsEventHandler(this.mProfessionTree);
};


CharacterScreenProfessionModule.prototype.showProfessionUnlockDialog = function (_profession) {
	this.mDataSource.notifyBackendPopupDialogIsVisible(true);

	var self = this;
	var popupDialog = $('.character-screen').createPopupDialog('Unlock Profession', null, null, 'unlock-profession-popup');

	popupDialog.addPopupDialogContent(this.createProfessionUnlockDialogContent(_profession));

	popupDialog.addPopupDialogOkButton(jQuery.proxy(function (_dialog) {
		self.mDataSource.unlockProfession(null, _profession.ID);
		_dialog.destroyPopupDialog();
		self.mDataSource.notifyBackendPopupDialogIsVisible(false);
	}, this));

	popupDialog.addPopupDialogCancelButton(function (_dialog) {
		_dialog.destroyPopupDialog();
		self.mDataSource.notifyBackendPopupDialogIsVisible(false);
	});
};

CharacterScreenProfessionModule.prototype.createProfessionUnlockDialogContent = function (_profession) {
	var result = $('<div class="unlock-profession-popup-dialog-content-container"/>');

	var leftColumn = $('<div class="left-column"/>');
	result.append(leftColumn);

	var professionImage = $('<img/>');
	professionImage.attr('src', Path.GFX + _profession.Icon);
	leftColumn.append(professionImage);

	var rightColumn = $('<div class="right-column"/>');
	result.append(rightColumn);

	var professionNameLabel = $('<div class="name title-font-normal font-bold font-color-title">' + _profession.Name + '</div>');
	rightColumn.append(professionNameLabel);

	var descriptionText = _profession.Tooltip.replace(/#135213/gi, "#1e861e"); // positive values
	descriptionText = descriptionText.replace(/#8f1e1e/gi, "#a22424"); // negative values
	descriptionText = descriptionText.split("\n")[0];

	var parsedDescriptionText = XBBCODE.process({
		text: descriptionText,
		removeMisalignedTags: false,
		addInLineBreaks: true
	});

	var professionDescriptionLabel = $('<div class="description description-font-small font-style-italic font-color-description">' + parsedDescriptionText.html + '</div>');
	rightColumn.append(professionDescriptionLabel);

	return result;
};


CharacterScreenProfessionModule.prototype.registerDatasourceListener = function () {
	this.mDataSource.addListener(CharacterScreenDatasourceIdentifier.Inventory.ModeUpdated, jQuery.proxy(this.onInventoryModeUpdated, this));

	this.mDataSource.addListener(CharacterScreenDatasourceIdentifier.Professions.TreesLoaded, jQuery.proxy(this.onProfessionTreeLoaded, this));

	this.mDataSource.addListener(CharacterScreenDatasourceIdentifier.Brother.Updated, jQuery.proxy(this.onBrotherUpdated, this));
	this.mDataSource.addListener(CharacterScreenDatasourceIdentifier.Brother.Selected, jQuery.proxy(this.onBrotherSelected, this));
};


CharacterScreenProfessionModule.prototype.create = function (_parentDiv) {
	this.createDIV(_parentDiv);
};

CharacterScreenProfessionModule.prototype.destroy = function () {
	this.destroyDIV();
};


CharacterScreenProfessionModule.prototype.register = function (_parentDiv) {
	console.log('CharacterScreenProfessionModule::REGISTER');

	if (this.mContainer !== null) {
		console.error('ERROR: Failed to register Professions Module. Reason: Module is already initialized.');
		return;
	}

	if (_parentDiv !== null && typeof (_parentDiv) == 'object') {
		this.create(_parentDiv);
	}
};

CharacterScreenProfessionModule.prototype.unregister = function () {
	console.log('CharacterScreenProfessionModule::UNREGISTER');

	if (this.mContainer === null) {
		console.error('ERROR: Failed to unregister Professions Module. Reason: Module is not initialized.');
		return;
	}

	this.destroy();
};

CharacterScreenProfessionModule.prototype.isRegistered = function () {
	if (this.mContainer !== null) {
		return this.mContainer.parent().length !== 0;
	}

	return false;
};


CharacterScreenProfessionModule.prototype.show = function () {
	this.mContainer.removeClass('opacity-none').addClass('opacity-full');
};

CharacterScreenProfessionModule.prototype.hide = function () {
	this.mContainer.removeClass('opacity-full is-top').addClass('opacity-none');
};

CharacterScreenProfessionModule.prototype.isVisible = function () {
	return this.mContainer.hasClass('opacity-full');
};


CharacterScreenProfessionModule.prototype.onInventoryModeUpdated = function (_dataSource, _mode) {
	this.updateProfessionTreeLayout(_mode);
};

CharacterScreenProfessionModule.prototype.onProfessionTreeLoaded = function (_dataSource, _professionTree) {};

CharacterScreenProfessionModule.prototype.onBrotherUpdated = function (_dataSource, _brother) {
	if (_dataSource.isSelectedBrother(_brother)) {
		this.onBrotherSelected(_dataSource, _brother);
	}
};

CharacterScreenProfessionModule.prototype.onBrotherSelected = function (_dataSource, _brother) {
	if (_brother === null) {
		return;
	}

	this.loadProfessionTreesWithBrotherData(_brother);
};