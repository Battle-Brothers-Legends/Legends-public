/*
 *  @Project:		Battle Brothers
 *	@Company:		Overhype Studios
 *  @Description:	Perks Module JS
 */
"use strict";


var CharacterScreenFormationsModule = function (_parent, _dataSource) {
	this.mParent = _parent;
	this.mDataSource = _dataSource;

	// container
	this.mContainer = null;

	this.mTopListContainer = null;
	this.mTopBroListContainer = null;
	this.mBottomListContainer = null;
	this.mBottomBroListConatainer = null;
	this.mSlots = null;
	this.mNumActive = 0;

	this.mSlotCountPanel = null;

	this.mFormationsPanel = null;
	this.mFormationsSortInventoryButton = null;
	this.mFormationsClearFormationButton = null;
	this.mFormationNameContainer = null;
	this._formBtns = [
		Path.GFX + 'ui/buttons/1.png',
		Path.GFX + 'ui/buttons/2.png',
		Path.GFX + 'ui/buttons/3.png',
		Path.GFX + 'ui/buttons/4.png',
		Path.GFX + 'ui/buttons/5.png',
		Path.GFX + 'ui/buttons/6.png'
		// Path.GFX + 'ui/buttons/7.png',
		// Path.GFX + 'ui/buttons/8.png',
	];
	this.mFormationsButtons = [];

	this.registerDatasourceListener();
};

CharacterScreenFormationsModule.prototype.createDIV = function (_parentDiv) {
	this.mFormationsButtons = [];
	var self = this;
	// create: containers (init hidden!)
	this.mContainer = $('<div class="formations-module opacity-none"/>');
	_parentDiv.append(this.mContainer);

	var row = $('<div class="title-row title-label title-font-big font-bold font-color-title"/>');
	row.html("Stables")
	this.mContainer.append(row);

	var row = $('<div class="top-row"></div>');
	this.mContainer.append(row);
	this.mTopListContainer = $('<div class="l-list-container"/>');
	row.append(this.mTopListContainer);

	var row = $('<div class="top-row-bro"></div>');
	this.mContainer.append(row);
	this.mTopBroListContainer = $('<div class="l-list-container"/>');
	row.append(this.mTopBroListContainer);

	var row = $('<div class="bottom-row"></div>');
	this.mContainer.append(row);
	this.mBottomListContainer = $('<div class="l-list-container"/>');
	row.append(this.mBottomListContainer);

	var row = $('<div class="bottom-row-bro"></div>');
	this.mContainer.append(row);
	this.mBottomBroListContainer = $('<div class="l-list-container"/>');
	row.append(this.mBottomBroListContainer);


	this.mSlots = [];
	for (var i = 0; i < 9 * 4; i++) {
		this.mSlots.push(null)
	}
	// create empty slots
	this.createStableSlots(this.mTopListContainer, 9 * 0, 9 * 1, false);
	this.createStableSlots(this.mTopBroListContainer, 9 * 1, 9 * 2, true);
	this.createStableSlots(this.mBottomListContainer, 9 * 2, 9 * 3, false);
	this.createStableSlots(this.mBottomBroListContainer, 9 * 3, 9 * 4, true);


	this.mSlotCountPanel = $('<div class="slot-count-panel"/>');
	this.mContainer.append(this.mSlotCountPanel);

	//formations
	this.mFormationsPanel = $('<div class="formations-panel"/>');
	this.mSlotCountPanel.append(this.mFormationsPanel);

	this._formBtns.forEach(function (_img, _index) {
		var layout = $('<div class="l-button is-formation-' + _index + '"/>');
		self.mFormationsPanel.append(layout);
		var index = _index;
		var fBtn = layout.createImageButton(_img, function () {
			self.onFormationSelected(null, _index);
			self.mDataSource.notifyBackendFormationClicked(index);

		}, '', 3);

		self.mFormationsButtons.push(fBtn);
	})

	var layout = $('<div class="l-button formation-panel-btn is-formation-6"/>');
	this.mFormationsPanel.append(layout);

	var layout = $('<div class="l-button is-formation-7"/>');
	this.mFormationsPanel.append(layout);
	this.mFormationsClearFormationButton = layout.createImageButton(Path.GFX + 'ui/skin/icon_cross.png', function () {
		self.mDataSource.notifyBackendClearFormationButtonClicked();
	}, '', 3);

	this.mFormationNameContainer = $('<div class="formation-name"/>');
	this.mFormationsPanel.append(this.mFormationNameContainer);
	//var editNameimage = $('<img class="display-none"/>');
	///editNameimage.attr('src', Path.GFX + Asset.ICON_EDIT_NAME_AND_TITLE);
	//this.mNameContainer.append(editNameimage);

	var nameLabel = $('<div class="label title-font-normal font-bold font-color-brother-name"></div>');
	this.mFormationNameContainer.append(nameLabel);
	this.mFormationNameContainer.click(function () {
		if ($(this).hasClass('is-clickable') === false) {
			return false;
		}

		self.mDataSource.notifyBackendPopupDialogIsVisible(true);
		self.mCurrentPopupDialog = $('.character-screen').createPopupDialog('Change Formation Name', null, null, 'change-formation-name-popup');

		self.mCurrentPopupDialog.addPopupDialogOkButton(function (_dialog) {
			self.updateFormationName(_dialog);
			self.mCurrentPopupDialog = null;
			_dialog.destroyPopupDialog();
			self.mDataSource.notifyBackendPopupDialogIsVisible(false);
		});

		self.mCurrentPopupDialog.addPopupDialogCancelButton(function (_dialog) {
			self.mCurrentPopupDialog = null;
			_dialog.destroyPopupDialog();
			self.mDataSource.notifyBackendPopupDialogIsVisible(false);
		});

		self.mCurrentPopupDialog.addPopupDialogContent(self.createChangeFormationNameDialogContent(self.mCurrentPopupDialog));

		// focus!
		var inputFields = self.mCurrentPopupDialog.findPopupDialogContentContainer().find('input');
		$(inputFields[0]).focus();
	});

	this.mFormationNameContainer.addClass('is-clickable');

	this.onFormationSelected(null, this.mDataSource.getFormationIndex());
	this.onSetFormationName(null, this.mDataSource.getFormationName());
};

CharacterScreenFormationsModule.prototype.destroyDIV = function () {

	this.mTopListContainer.empty();
	this.mTopListContainer.remove();
	this.mTopListContainer = null;
	this.mTopBroListContainer.empty();
	this.mTopBroListContainer.remove();
	this.mTopBroListContainer = null;
	this.mBottomListContainer.empty();
	this.mBottomListContainer.remove();
	this.mBottomListContainer = null;
	this.mBottomBroListContainer.empty();
	this.mBottomBroListContainer.remove();
	this.mBottomBroListContainer = null;
	this.mSlotCountPanel.empty()
	this.mSlotCountPanel.remove()
	this.mSlotCountPanel = null;

	this.mContainer.empty();
	this.mContainer.remove();
	this.mContainer = null;
};

CharacterScreenFormationsModule.prototype.updateFormationName = function (_dialog) {
	var contentContainer = _dialog.findPopupDialogContentContainer();
	var inputFields = contentContainer.find('input');
	this.mDataSource.updateFormationName(null, $(inputFields[0]).getInputText());
};

CharacterScreenFormationsModule.prototype.createChangeFormationNameDialogContent = function (_dialog) {
	var data = this.mDataSource.getFormationName();
	var result = $('<div class="change-formation-name-container"/>');

	// create & set name
	var row = $('<div class="row"/>');
	result.append(row);
	var label = $('<div class="label text-font-normal font-color-label font-bottom-shadow">Name</div>');
	row.append(label);

	var self = this;

	var inputLayout = $('<div class="l-input"/>');
	row.append(inputLayout);
	var inputField = inputLayout.createInput('', 0, Constants.Game.MAX_BROTHER_NAME_LENGTH, 1, function (_input) {
		_dialog.findPopupDialogOkButton().enableButton(_input.getInputTextLength() >= Constants.Game.MIN_BROTHER_NAME_LENGTH);
	}, 'title-font-big font-bold font-color-brother-name', function (_input) {
		var button = _dialog.findPopupDialogOkButton();
		if (button.isEnabled()) {
			button.click();
		}
	});

	inputField.setInputText(data);

	return result;
};

CharacterScreenFormationsModule.prototype.registerDatasourceListener = function () {
	this.mDataSource.addListener(CharacterScreenDatasourceIdentifier.Brother.ListLoaded, jQuery.proxy(this.onBrothersListLoaded, this));
	this.mDataSource.addListener(CharacterScreenDatasourceIdentifier.Brother.Updated, jQuery.proxy(this.onBrotherUpdated, this));
	this.mDataSource.addListener(CharacterScreenDatasourceIdentifier.Brother.Selected, jQuery.proxy(this.onBrotherSelected, this));
	this.mDataSource.addListener(CharacterScreenDatasourceIdentifier.Inventory.FormationIndex, jQuery.proxy(this.onFormationSelected, this));
	this.mDataSource.addListener(CharacterScreenDatasourceIdentifier.Inventory.FormationName, jQuery.proxy(this.onSetFormationName, this));
};

CharacterScreenFormationsModule.prototype.bindTooltips = function () {
	this.mFormationsClearFormationButton.bindTooltip({
		contentType: 'ui-element',
		elementId: TooltipIdentifier.CharacterScreen.RightPanelHeaderModule.ClearFormationButton
	});
	this.mFormationsButtons.forEach(function (btn) {
		btn.bindTooltip({
			contentType: 'ui-element',
			elementId: TooltipIdentifier.CharacterScreen.RightPanelHeaderModule.ChangeFormationButton
		});
	});
	if (this.mDataSource.isTacticalMode() !== true) {
		this.mFormationNameContainer.bindTooltip({
			contentType: 'ui-element',
			elementId: TooltipIdentifier.CharacterScreen.RightPanelHeaderModule.ChangeFormationName
		});
	}
};

CharacterScreenFormationsModule.prototype.unbindTooltips = function () {
	this.mFormationsClearFormationButton.unbindTooltip();
	this.mFormationsButtons.forEach(function (btn) {
		btn.unbindTooltip();
	});
	if (this.mDataSource.isTacticalMode() !== true) {
		this.mFormationNameContainer.unbindTooltip();
	}
};

CharacterScreenFormationsModule.prototype.onFormationSelected = function (_dataSource, _index) {
	this.mFormationsButtons.forEach(function (_b, _i) {
		_b.removeClass('is-active');
		if (_i === _index) {
			_b.addClass('is-active');
		}
	});
};

CharacterScreenFormationsModule.prototype.onSetFormationName = function (_dataSource, _name) {
	if (_name == null || _name == undefined) {
		return;
	}
	var label = this.mFormationNameContainer.find('.label:first');
	if (label.length > 0) {
		label.html(_name);
	}

	/*var image = this.mNameContainer.find('img:first');
	if (image.length > 0)
	{*/
	if (this.mDataSource.isTacticalMode() !== true) {
		this.mFormationNameContainer.addClass('is-clickable');
		//image.removeClass('display-none').addClass('display-block');
	} else {
		this.mFormationNameContainer.removeClass('is-clickable');
		//image.removeClass('display-block').addClass('display-none');
	}
	// }
};

CharacterScreenFormationsModule.prototype.create = function (_parentDiv) {
	this.createDIV(_parentDiv);
	this.bindTooltips();
};

CharacterScreenFormationsModule.prototype.destroy = function () {
	this.unbindTooltips();
	this.destroyDIV();
};


CharacterScreenFormationsModule.prototype.register = function (_parentDiv) {
	console.log('CharacterScreenFormationsModule::REGISTER');

	if (this.mContainer !== null) {
		console.error('ERROR: Failed to register Perks Module. Reason: Module is already initialized.');
		return;
	}

	if (_parentDiv !== null && typeof (_parentDiv) == 'object') {
		this.create(_parentDiv);
	}
};

CharacterScreenFormationsModule.prototype.unregister = function () {
	console.log('CharacterScreenFormationsModule::UNREGISTER');

	if (this.mContainer === null) {
		console.error('ERROR: Failed to unregister Perks Module. Reason: Module is not initialized.');
		return;
	}

	this.destroy();
};

CharacterScreenFormationsModule.prototype.isRegistered = function () {
	if (this.mContainer !== null) {
		return this.mContainer.parent().length !== 0;
	}

	return false;
};


CharacterScreenFormationsModule.prototype.show = function () {
	// NOTE: (js) HACK which prevents relayouting..
	this.mContainer.removeClass('opacity-none no-pointer-events').addClass('opacity-full');
	//this.mContainer.removeClass('display-none').addClass('display-block');
};

CharacterScreenFormationsModule.prototype.hide = function () {
	// NOTE: (js) HACK which prevents relayouting..
	this.mContainer.removeClass('opacity-full is-top').addClass('opacity-none no-pointer-events');
	//this.mContainer.removeClass('display-block is-top').addClass('display-none');
};

CharacterScreenFormationsModule.prototype.isVisible = function () {
	return this.mContainer.hasClass('opacity-full');
	//return this.mContainer.hasClass('display-block');
};

CharacterScreenFormationsModule.prototype.onBrotherUpdated = function (_dataSource, _brother) {
	if (_dataSource.isSelectedBrother(_brother)) {
		this.onBrotherSelected(_dataSource, _brother);
	}
};

CharacterScreenFormationsModule.prototype.onBrotherSelected = function (_dataSource, _brother) {
	if (_brother === null) {
		return;
	}
};

CharacterScreenFormationsModule.prototype.createStableSlots = function (_parentDiv, _start, _stop, _isBro) {
	var self = this;

	var dropHandler = function (ev, dd) {
		var drag = $(dd.drag);
		var drop = $(dd.drop);

		if (drop === undefined || drop.data('idx') === undefined || drop.data('stable') === 1) {
			return false;
		}

		var dropSlot = drop.data('idx');
		var horse = self.mSlots[dropSlot - 9];
		if (horse.data('child') === null) {
			return false;
		}

		drag.removeClass('is-dragged');
		// do the swapping
		self.mDataSource.notifyBackendAssignRider(drag.data("ID"), horse.data('child').data('ID'), function (_data) {
			self.onBrothersListLoaded(null, _data);
		})
		return true
	};

	for (var i = _start; i < _stop; ++i) {
		if (!_isBro) {
			this.mSlots[i] = $('<div class="ui-control is-brother-slot is-horse-slot"/>');
			this.mSlots[i].drop("end", null);
			this.mSlots[i].data('stable', 1);
		} else {
			this.mSlots[i] = $('<div class="ui-control is-brother-slot is-rider-slot"/>');
			this.mSlots[i].drop("end", dropHandler);
			this.mSlots[i].data('stable', 0);
		}

		_parentDiv.append(this.mSlots[i]);
		//this.mSlots[i].removeClass('display-block').addClass('display-none');
		this.mSlots[i].data('idx', i);
		this.mSlots[i].data('child', null);
	}

	/*$('.is-brother-slot')
	  .drop("start", function ()
	  {
		  $(this).addClass("is-active-slot");
	  })
	  .drop("end", function ()
	  {
		  $(this).removeClass("is-active-slot");
	  });*/
}

CharacterScreenFormationsModule.prototype.clearBrothersList = function () {
	for (var i = 0; i != this.mSlots.length; ++i) {
		this.mSlots[i].empty();
		this.mSlots[i].data('child', null);
	}

	this.mNumActive = 0;
};

CharacterScreenFormationsModule.prototype.addBrotherSlotDIV = function (_parentDiv, _data, _index, _allowReordering) {
	var self = this;
	var screen = $('.character-screen');
	_parentDiv.removeClass('display-none').addClass('display-block');
	this.mSlots[9 + _index + 9 * Math.floor(_index / 9)].removeClass('display-none').addClass('display-block');
	// create: slot & background layer
	var result = _parentDiv.createListBrother(_data[CharacterScreenIdentifier.Entity.Id]);
	result.attr('id', 'slot-index_' + _data[CharacterScreenIdentifier.Entity.Id]);
	result.data('ID', _data[CharacterScreenIdentifier.Entity.Id]);
	result.data('idx', _index);
	result.data('inReserves', _data['inReserves']);

	this.mSlots[_index].data('child', result);

	++this.mNumActive;

	// drag handler
	if (_allowReordering) {
		result.drag("start", function (ev, dd) {
			// dont allow drag if this is an empty slot
			/*var data = $(this).data('item');
			if (data.isEmpty === true)
			{
				return false;
			}*/

			// build proxy
			var proxy = $('<div class="ui-control brother is-proxy"/>');
			proxy.appendTo(document.body);
			proxy.data('idx', _index);

			var imageLayer = result.find('.image-layer:first');
			if (imageLayer.length > 0) {
				imageLayer = imageLayer.clone();
				proxy.append(imageLayer);
			}

			$(dd.drag).addClass('is-dragged');

			return proxy;
		}, {
			distance: 3
		});

		result.drag(function (ev, dd) {
			$(dd.proxy).css({
				top: dd.offsetY,
				left: dd.offsetX
			});
		}, {
			relative: false,
			distance: 3
		});

		result.drag("end", function (ev, dd) {
			var drag = $(dd.drag);
			var drop = $(dd.drop);
			var proxy = $(dd.proxy);

			var allowDragEnd = true; // TODO: check what we're dropping onto

			// not dropped into anything?
			if (drop.length === 0 || allowDragEnd === false) {
				proxy.velocity("finish", true).velocity({
					top: dd.originalY,
					left: dd.originalX
				}, {
					duration: 300,
					complete: function () {
						proxy.remove();
						drag.removeClass('is-dragged');
					}
				});
			} else {
				proxy.remove();
			}
		}, {
			drop: '.is-brother-slot'
		});
	}

	// update image & name
	var character = _data[CharacterScreenIdentifier.Entity.Character.Key];
	var imageOffsetX = (CharacterScreenIdentifier.Entity.Character.ImageOffsetX in character ? character[CharacterScreenIdentifier.Entity.Character.ImageOffsetX] : 0);
	var imageOffsetY = (CharacterScreenIdentifier.Entity.Character.ImageOffsetY in character ? character[CharacterScreenIdentifier.Entity.Character.ImageOffsetY] : 0);

	result.assignListBrotherImage(Path.PROCEDURAL + character[CharacterScreenIdentifier.Entity.Character.ImagePath], imageOffsetX, imageOffsetY, 0.66);
	//result.assignListBrotherName(character[CharacterScreenIdentifier.Entity.Character.Name]);
	//result.assignListBrotherDailyMoneyCost(character[CharacterScreenIdentifier.Entity.Character.DailyMoneyCost]);

	if (CharacterScreenIdentifier.Entity.Character.LeveledUp in character && character[CharacterScreenIdentifier.Entity.Character.LeveledUp] === true) {
		result.assignListBrotherLeveledUp();
	}

	/*if(CharacterScreenIdentifier.Entity.Character.DaysWounded in character && character[CharacterScreenIdentifier.Entity.Character.DaysWounded] === true)
	{
		result.assignListBrotherDaysWounded();
	}*/

	if ('inReserves' in character && character['inReserves'] && this.mDataSource.getInventoryMode() == CharacterScreenDatasourceIdentifier.InventoryMode.Stash) {
		result.showListBrotherMoodImage(true, 'ui/buttons/mood_heal.png');
	} else if ('moodIcon' in character && this.mDataSource.getInventoryMode() == CharacterScreenDatasourceIdentifier.InventoryMode.Stash) {
		result.showListBrotherMoodImage(this.IsMoodVisible, character['moodIcon']);
	}

	for (var i = 0; i != _data['injuries'].length && i < 3; ++i) {
		result.assignListBrotherStatusEffect(_data['injuries'][i].imagePath, _data[CharacterScreenIdentifier.Entity.Id], _data['injuries'][i].id)
	}

	if (_data['injuries'].length <= 2 && _data['stats'].hitpoints < _data['stats'].hitpointsMax) {
		result.assignListBrotherDaysWounded();
	}

	result.assignListBrotherClickHandler(function (_brother, _event) {
		var data = _brother.data('brother');
		self.mDataSource.selectedBrotherById(data.id);
	});
};

CharacterScreenFormationsModule.prototype.onBrothersListLoaded = function (_dataSource, _brothers) {
	this.clearBrothersList();

	if (_brothers === null || !jQuery.isArray(_brothers) || _brothers.length === 0) {
		return;
	}

	var stableMap = {};
	var toAdd = [];

	for (var i = 0; i < _brothers.length; ++i) {
		var brother = _brothers[i];

		if (brother === null || brother === undefined) {
			continue
		}

		if (brother[CharacterScreenIdentifier.Entity.Character.Key].stabled) {
			var slotNum = this.mNumActive + 9 * Math.floor(this.mNumActive / 9);
			this.addBrotherSlotDIV(this.mSlots[slotNum], brother, this.mNumActive, false);

			if (brother[CharacterScreenIdentifier.Entity.Character.Key].riderID !== '') {
				stableMap[brother[CharacterScreenIdentifier.Entity.Character.Key].riderID] = slotNum;
			}
			continue
		}

		if (brother[CharacterScreenIdentifier.Entity.Character.Key].riderID !== '') {
			toAdd.push(i);
		}
	}

	for (var i = 0; i < toAdd.length; ++i) {
		var riderID = _brothers[toAdd[i]][CharacterScreenIdentifier.Entity.Character.Key].riderID
		var slotNum = stableMap[riderID]
		if (slotNum === undefined) {
			continue
		}
		this.addBrotherSlotDIV(this.mSlots[slotNum + 9], _brothers[toAdd[i]], this.mNumActive, true);
	}

};