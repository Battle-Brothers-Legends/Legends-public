/*
 *  @Project:	   Battle Brothers
 *  @Company:	   Overhype Studios
 *
 *  @Copyright:	 (c) Overhype Studios | 2013 - 2020
 * 
 *  @Author:		Overhype Studios
 *  @Date:		  24.01.2017 / Reworked: 26.11.2017
 *  @Description:   Brothers List Module JS
 */
"use strict";


var CharacterScreenBrothersListModule = function(_parent, _dataSource)
{
	this.mParent = _parent;
	this.mDataSource = _dataSource;

	// container
	this.mContainer					 = null;
	this.mListContainer				 = null;
	this.mListScrollContainer		   = null;

	this.mFrontlineCountLabel		   = null
	this.mFrontlineCountContainer	   = null;

	this.mRosterCountLabel			  = null;
	this.mRosterCountContainer		  = null;

	this.mStartBattleButton			 = null;
	this.mStartBattleButtonContainer	= null;

	this.mSlots						 = null;
	this.mNumActive					 = 0;
	this.mNumActiveMax				  = 27;

	this.IsMoodVisible					= true;

	this.registerDatasourceListener();
};


CharacterScreenBrothersListModule.prototype.createDIV = function (_parentDiv)
{
	var self = this;

	// create: containers
	this.mContainer = $('<div class="brothers-list-module"/>');
	_parentDiv.append(this.mContainer);

	var listContainerLayout = $('<div class="l-list-container"/>');
	this.mContainer.append(listContainerLayout);
	this.mListScrollContainer = listContainerLayout;


	this.mFrontlineCountContainer = $('<div class = "frontline-count-container"/>');
	this.mContainer.append(this.mFrontlineCountContainer);
	var frontlineSizeImage = $('<img/>');
	frontlineSizeImage.attr('src', Path.GFX + Legends.ICON_ASSET_FRONTLINE);
	this.mFrontlineCountContainer.append(frontlineSizeImage);
	this.mFrontlineCountLabel = $('<div class="label text-font-small font-bold font-color-value"/>');
	this.mFrontlineCountContainer.append(this.mFrontlineCountLabel);
	this.mFrontlineCountContainer.bindTooltip({ contentType: 'ui-element', elementId: "stash.CurrentRoster" });

	this.mRosterCountContainer = $('<div class="roster-count-container"/>');
	this.mContainer.append(this.mRosterCountContainer);
	var rosterSizeImage = $('<img/>');
	rosterSizeImage.attr('src', Path.GFX + Asset.ICON_ASSET_BROTHERS); // ICON_DAMAGE_DEALT
	this.mRosterCountContainer.append(rosterSizeImage);
	this.mRosterCountLabel = $('<div class="label text-font-small font-bold font-color-value"/>');
	this.mRosterCountContainer.append(this.mRosterCountLabel);
	this.mRosterCountContainer.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.Stash.ActiveRoster });

	// create empty slots
	this.createBrotherSlots(this.mListScrollContainer);

	// start battle
	this.mStartBattleButtonContainer = $('<div class="l-start-battle-button"/>');
	this.mContainer.append(this.mStartBattleButtonContainer);
	this.mStartBattleButton = this.mStartBattleButtonContainer.createTextButton("Start Battle", function ()
	{
		self.mDataSource.notifyBackendStartBattleButtonClicked();
	}, '', 1);
};

CharacterScreenBrothersListModule.prototype.destroyDIV = function ()
{
	this.mListScrollContainer.empty();
	this.mListScrollContainer = null;
	/*this.mListContainer.destroyList();
	this.mListContainer = null;*/

	this.mSlots = null;

	this.mContainer.empty();
	this.mContainer.remove();
	this.mContainer = null;
};


CharacterScreenBrothersListModule.prototype.toggleMoodVisibility = function ()
{
	this.IsMoodVisible = !this.IsMoodVisible;

	for(var i = 0; i < this.mSlots.length; ++i)
	{
		if(this.mSlots[i].data('child') != null)
		{
			if ((this.mSlots[i]).data('child').data('inReserves'))
			{
				this.mSlots[i].data('child').showListBrotherMoodImage(true, 'ui/buttons/mood_heal.png');
			}
			else 
			{
				this.mSlots[i].data('child').showListBrotherMoodImage(this.IsMoodVisible);
			}
		}
	}

	return this.IsMoodVisible;
};


CharacterScreenBrothersListModule.prototype.createBrotherSlots = function (_parentDiv)
{
	var self = this;

	this.mSlots = [null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null ];

	var dropHandler = function (ev, dd)
	{
		var drag = $(dd.drag);
		var drop = $(dd.drop);
		var proxy = $(dd.proxy);

		if (proxy === undefined || proxy.data('idx') === undefined || drop === undefined || drop.data('idx') === undefined)
		{
			return false;
		}

		drag.removeClass('is-dragged');

		if (drag.data('idx') == drop.data('idx'))
		{
			return false;
		}

		// number in formation is limited
		if (self.mNumActive >= self.mNumActiveMax && drag.data('idx') > 27 && drop.data('idx') <= 27 && self.mSlots[drop.data('idx')].data('child') == null)
		{
			return false;
		}

		// always keep at least 1 in formation
		if (self.mNumActive == 1 && drag.data('idx') <= 27 && drop.data('idx') > 27 && self.mSlots[drop.data('idx')].data('child') == null)
		{
			return false;
		}

		// do the swapping
		self.swapSlots(drag.data('idx'), drop.data('idx'));
	};

	for (var i = 0; i < 27; ++i)
	{
		if(i < 27)
			this.mSlots[i] = $('<div class="ui-control is-brother-slot is-roster-slot"/>');
		else
			this.mSlots[i] = $('<div class="ui-control is-brother-slot is-reserve-slot"/>');

		_parentDiv.append(this.mSlots[i]);

		this.mSlots[i].data('idx', i);
		this.mSlots[i].data('child', null);
		this.mSlots[i].drop("end", dropHandler);
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


CharacterScreenBrothersListModule.prototype.addBrotherSlotDIV = function (_parentDiv, _data, _index, _allowReordering)
{
	var self = this;
	var screen = $('.character-screen');

	// create: slot & background layer
	var result = _parentDiv.createListBrother(_data[CharacterScreenIdentifier.Entity.Id]);
	result.attr('id', 'slot-index_' + _data[CharacterScreenIdentifier.Entity.Id]);
	result.data('ID', _data[CharacterScreenIdentifier.Entity.Id]);
	result.data('idx', _index);
	result.data('inReserves', _data['inReserves']);

	this.mSlots[_index].data('child', result);

	if (_index <= 27)
		++this.mNumActive;

	// drag handler
	if (_allowReordering)
	{
		result.drag("start", function (ev, dd)
		{
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
			if (imageLayer.length > 0)
			{
				imageLayer = imageLayer.clone();
				proxy.append(imageLayer);
			}

			$(dd.drag).addClass('is-dragged');

			return proxy;
		}, { distance: 3 });

		result.drag(function (ev, dd)
		{
			$(dd.proxy).css({ top: dd.offsetY, left: dd.offsetX });
		}, { relative: false, distance: 3 });

		result.drag("end", function (ev, dd)
		{
			var drag = $(dd.drag);
			var drop = $(dd.drop);
			var proxy = $(dd.proxy);

			var allowDragEnd = true; // TODO: check what we're dropping onto

			// not dropped into anything?
			if (drop.length === 0 || allowDragEnd === false)
			{
				proxy.velocity("finish", true).velocity({ top: dd.originalY, left: dd.originalX },
				{
					duration: 300,
					complete: function ()
					{
						proxy.remove();
						drag.removeClass('is-dragged');
					}
				});
			}
			else
			{
				proxy.remove();
			}
		}, { drop: '.is-brother-slot' });
	}

	// update image & name
	var character = _data[CharacterScreenIdentifier.Entity.Character.Key];
	var imageOffsetX = (CharacterScreenIdentifier.Entity.Character.ImageOffsetX in character ? character[CharacterScreenIdentifier.Entity.Character.ImageOffsetX] : 0);
	var imageOffsetY = (CharacterScreenIdentifier.Entity.Character.ImageOffsetY in character ? character[CharacterScreenIdentifier.Entity.Character.ImageOffsetY] : 0);

	result.assignListBrotherImage(Path.PROCEDURAL + character[CharacterScreenIdentifier.Entity.Character.ImagePath], imageOffsetX, imageOffsetY, 0.66);
	//result.assignListBrotherName(character[CharacterScreenIdentifier.Entity.Character.Name]);
	//result.assignListBrotherDailyMoneyCost(character[CharacterScreenIdentifier.Entity.Character.DailyMoneyCost]);

	if(CharacterScreenIdentifier.Entity.Character.LeveledUp in character && character[CharacterScreenIdentifier.Entity.Character.LeveledUp] === true)
	{
		result.assignListBrotherLeveledUp();
	}

	/*if(CharacterScreenIdentifier.Entity.Character.DaysWounded in character && character[CharacterScreenIdentifier.Entity.Character.DaysWounded] === true)
	{
		result.assignListBrotherDaysWounded();
	}*/

	if('inReserves' in character && character['inReserves'] && this.mDataSource.getInventoryMode() == CharacterScreenDatasourceIdentifier.InventoryMode.Stash)
	{
		result.showListBrotherMoodImage(true, 'ui/buttons/mood_heal.png');
	}
	else if('moodIcon' in character && this.mDataSource.getInventoryMode() == CharacterScreenDatasourceIdentifier.InventoryMode.Stash)
	{
		result.showListBrotherMoodImage(this.IsMoodVisible, character['moodIcon']);
	}

	for(var i = 0; i != _data['injuries'].length && i < 3; ++i)
	{
		result.assignListBrotherStatusEffect(_data['injuries'][i].imagePath, _data[CharacterScreenIdentifier.Entity.Id], _data['injuries'][i].id)
	}

	if(_data['injuries'].length <= 2 && _data['stats'].hitpoints < _data['stats'].hitpointsMax)
	{
		result.assignListBrotherDaysWounded();
	}

	result.assignListBrotherClickHandler(function (_brother, _event)
	{
		var data = _brother.data('brother');
		self.mDataSource.selectedBrotherById(data.id);
	});
};


CharacterScreenBrothersListModule.prototype.updateRosterLabel = function (_data)
{
	if (_data === undefined)
	{
		this.mRosterCountLabel.html('' + this.mNumActive + '/' + this.mDataSource.getMaxBrothers());
		this.mFrontlineCountLabel.html('' + this.mDataSource.getFrontlineData()[0] + '/' + this.mDataSource.getFrontlineData()[1])
	}
	else
	{
		this.mRosterCountLabel.html('' + _data.brothers + '/' + _data.brothersMax);
		this.mFrontlineCountLabel.html('' + _data.brothersInCombat + '/' + _data.brothersMaxInCombat);
		if (_data.shake)
		{
			this.mFrontlineCountLabel.shakeLeftRight();
		}
	}
};


CharacterScreenBrothersListModule.prototype.bindTooltips = function ()
{
	
};

CharacterScreenBrothersListModule.prototype.unbindTooltips = function ()
{
	
};


CharacterScreenBrothersListModule.prototype.registerDatasourceListener = function()
{
	//this.mDataSource.addListener(ErrorCode.Key, jQuery.proxy(this.onDataSourceError, this));

	this.mDataSource.addListener(CharacterScreenDatasourceIdentifier.Brother.ListLoaded, jQuery.proxy(this.onBrothersListLoaded, this));
	this.mDataSource.addListener(CharacterScreenDatasourceIdentifier.Brother.SettingsChanged, jQuery.proxy(this.onBrothersSettingsChanged, this));
	this.mDataSource.addListener(CharacterScreenDatasourceIdentifier.Brother.Updated, jQuery.proxy(this.onBrotherUpdated, this));
	this.mDataSource.addListener(CharacterScreenDatasourceIdentifier.Brother.Selected, jQuery.proxy(this.onBrotherSelected, this));

	this.mDataSource.addListener(CharacterScreenDatasourceIdentifier.Inventory.ModeUpdated, jQuery.proxy(this.onInventoryModeUpdated, this));
};


CharacterScreenBrothersListModule.prototype.create = function(_parentDiv)
{
	this.createDIV(_parentDiv);
	this.bindTooltips();
};

CharacterScreenBrothersListModule.prototype.destroy = function()
{
	this.unbindTooltips();
	this.destroyDIV();
};


CharacterScreenBrothersListModule.prototype.register = function (_parentDiv)
{
	console.log('CharacterScreenBrothersListModule::REGISTER');

	if (this.mContainer !== null)
	{
		console.error('ERROR: Failed to register Brothers Module. Reason: Module is already initialized.');
		return;
	}

	if (_parentDiv !== null && typeof(_parentDiv) == 'object')
	{
		this.create(_parentDiv);
	}
};

CharacterScreenBrothersListModule.prototype.unregister = function ()
{
	console.log('CharacterScreenBrothersListModule::UNREGISTER');

	if (this.mContainer === null)
	{
		console.error('ERROR: Failed to unregister Brothers Module. Reason: Module is not initialized.');
		return;
	}

	this.destroy();
};

CharacterScreenBrothersListModule.prototype.isRegistered = function ()
{
	if (this.mContainer !== null)
	{
		return this.mContainer.parent().length !== 0;
	}

	return false;
};


CharacterScreenBrothersListModule.prototype.show = function ()
{
	this.mContainer.removeClass('display-none').addClass('display-block');
};

CharacterScreenBrothersListModule.prototype.hide = function ()
{
	this.mContainer.removeClass('display-block').addClass('display-none');
};

CharacterScreenBrothersListModule.prototype.isVisible = function ()
{
	return this.mContainer.hasClass('display-block');
};


CharacterScreenBrothersListModule.prototype.swapSlots = function (_a, _b)
{
	// dragging into empty slot
	if(this.mSlots[_b].data('child') == null)
	{
		var A = this.mSlots[_a].data('child');

		A.data('idx', _b);
		A.appendTo(this.mSlots[_b]);

		this.mSlots[_b].data('child', A);
		this.mSlots[_a].data('child', null);

		if (_a <= 27 && _b > 27)
			--this.mNumActive;
		else if (_a > 27 && _b <= 27)
			++this.mNumActive;

		this.updateBlockedSlots();

		this.mDataSource.swapBrothers(_a, _b);
		this.mDataSource.notifyBackendUpdateRosterPosition(A.data('ID'), _b);

		if(this.mDataSource.getSelectedBrotherIndex() == _a)
		{
			this.mDataSource.setSelectedBrotherIndex(_b, true);
		}
	}

	// swapping two full slots
	else
	{
		var A = this.mSlots[_a].data('child');
		var B = this.mSlots[_b].data('child');

		A.data('idx', _b);
		B.data('idx', _a);

		B.detach();

		A.appendTo(this.mSlots[_b]);
		this.mSlots[_b].data('child', A);

		B.appendTo(this.mSlots[_a]);
		this.mSlots[_a].data('child', B);

		this.mDataSource.swapBrothers(_a, _b);
		this.mDataSource.notifyBackendUpdateRosterPosition(A.data('ID'), _b);
		this.mDataSource.notifyBackendUpdateRosterPosition(B.data('ID'), _a);

		if (this.mDataSource.getSelectedBrotherIndex() == _a)
		{
			this.mDataSource.setSelectedBrotherIndex(_b, true);
		}
		else if (this.mDataSource.getSelectedBrotherIndex() == _b)
		{
			this.mDataSource.setSelectedBrotherIndex(_a, true);
		}
	}

	this.updateRosterLabel();
}


CharacterScreenBrothersListModule.prototype.updateBlockedSlots = function ()
{
	var self = this;

	this.mListScrollContainer.find('.is-blocked-slot').each(function (index, element)
	{
		var slot = $(element);
		slot.removeClass('is-blocked-slot');
	});
	   
	this.mListScrollContainer.find('.is-roster-slot').each(function (index, element)
	{
		var slot = $(element);

		if (slot.data('child') != null || self.mNumActive >= self.mNumActiveMax)
		{
		   // slot.addClass('is-blocked-slot');
		}
	});

	this.mListScrollContainer.find('.is-reserve-slot').each(function (index, element)
	{
		var slot = $(element);

		if (slot.data('child') != null)
		{
		   // slot.addClass('is-blocked-slot');
		}
	});
}


CharacterScreenBrothersListModule.prototype.clearBrothersList = function ()
{
	for(var i=0; i != this.mSlots.length; ++i)
	{
		this.mSlots[i].empty();
		this.mSlots[i].data('child', null);
	}

	this.mNumActive = 0;
};

CharacterScreenBrothersListModule.prototype.removeCurrentBrotherSlotSelection = function ()
{
	this.mListScrollContainer.find('.is-selected').each(function (index, element)
	{
		var slot = $(element);
		slot.removeClass('is-selected');
	});
};

CharacterScreenBrothersListModule.prototype.selectBrotherSlot = function (_brotherId)
{
	var slot = this.mListScrollContainer.find('#slot-index_' + _brotherId + ':first');
	if (slot.length > 0)
	{
		slot.addClass('is-selected');
	
		//this.mListScrollContainer.trigger('scroll', { element: slot });
		//this.mListContainer.scrollListToElement(slot);
	}
};


CharacterScreenBrothersListModule.prototype.setBrotherSlotActive = function (_brother)
{
	if (_brother === null || !(CharacterScreenIdentifier.Entity.Id in _brother))
	{
		return;
	}

	this.removeCurrentBrotherSlotSelection();
	this.selectBrotherSlot(_brother[CharacterScreenIdentifier.Entity.Id]);
};


CharacterScreenBrothersListModule.prototype.updateBrotherSlot = function (_data)
{
	var slot = this.mListScrollContainer.find('#slot-index_' + _data[CharacterScreenIdentifier.Entity.Id] + ':first');
	if (slot.length === 0)
	{
		return;
	}

	// update image & name
	var character = _data[CharacterScreenIdentifier.Entity.Character.Key];
	var imageOffsetX = (CharacterScreenIdentifier.Entity.Character.ImageOffsetX in character ? character[CharacterScreenIdentifier.Entity.Character.ImageOffsetX] : 0);
	var imageOffsetY = (CharacterScreenIdentifier.Entity.Character.ImageOffsetY in character ? character[CharacterScreenIdentifier.Entity.Character.ImageOffsetY] : 0);

	slot.assignListBrotherImage(Path.PROCEDURAL + character[CharacterScreenIdentifier.Entity.Character.ImagePath], imageOffsetX, imageOffsetY, 0.66);
	slot.assignListBrotherName(character[CharacterScreenIdentifier.Entity.Character.Name]);
	slot.assignListBrotherDailyMoneyCost(character[CharacterScreenIdentifier.Entity.Character.DailyMoneyCost]);

	if(this.mDataSource.getInventoryMode() == CharacterScreenDatasourceIdentifier.InventoryMode.Stash)
	{
		if(character['inReserves'])
		{
			slot.showListBrotherMoodImage(true, 'ui/buttons/mood_heal.png');
		}
		else
		{
			slot.showListBrotherMoodImage(this.IsMoodVisible, character['moodIcon']);
		}
	}

	slot.removeListBrotherStatusEffects();

	for (var i = 0; i != _data['injuries'].length && i < 6; ++i)
	{
		slot.assignListBrotherStatusEffect(_data['injuries'][i].imagePath, character[CharacterScreenIdentifier.Entity.Id], _data['injuries'][i].id)
	}

	if (_data['injuries'].length <= 2 && _data['stats'].hitpoints < _data['stats'].hitpointsMax)
	{
		slot.assignListBrotherDaysWounded();
	}

	if (CharacterScreenIdentifier.Entity.Character.LeveledUp in character && character[CharacterScreenIdentifier.Entity.Character.LeveledUp] === false)
	{
		slot.removeListBrotherLeveledUp();
	}

	/*
	var imageContainer = slot.find('.l-brother-slot-image:first');
	if (imageContainer.length > 0)
	{
		var image = imageContainer.find('img:first');
		if (image.length > 0)
		{
			image.attr('src', Path.PROCEDURAL + _brother.character.imagePath);
		}
	}

	// update text
	var textContainer = slot.find('.l-brother-slot-text:first');
	if (textContainer.length > 0)
	{
		textContainer.html(_brother.character.name);
	}
	*/
};

CharacterScreenBrothersListModule.prototype.showBrotherSlotLock = function(_brotherId, _showLock)
{
	var slot = this.mListScrollContainer.find('#slot-index_' + _brotherId + ':first');
	if (slot.length === 0)
	{
		return;
	}

	slot.showListBrotherLockImage(_showLock);
};

CharacterScreenBrothersListModule.prototype.updateBrotherSlotLocks = function(_inventoryMode)
{
	switch(_inventoryMode)
	{
		case CharacterScreenDatasourceIdentifier.InventoryMode.BattlePreparation:
		case CharacterScreenDatasourceIdentifier.InventoryMode.Stash:
		{
			var brothersList = this.mDataSource.getBrothersList();
			if (brothersList === null || !jQuery.isArray(brothersList))
			{
				return;
			}

			for (var i = 0; i < brothersList.length; ++i)
			{
				var brother = brothersList[i];
				if (brother !== null && CharacterScreenIdentifier.Entity.Id in brother)
				{
					this.showBrotherSlotLock(brother[CharacterScreenIdentifier.Entity.Id], false);
				}
			}

		} break;
		case CharacterScreenDatasourceIdentifier.InventoryMode.Ground:
		{
			var brothersList = this.mDataSource.getBrothersList();
			if (brothersList === null || !jQuery.isArray(brothersList))
			{
				return;
			}

			for (var i = 0; i < brothersList.length; ++i)
			{
				var brother = brothersList[i];
				this.showBrotherSlotLock(brother[CharacterScreenIdentifier.Entity.Id], !this.mDataSource.isSelectedBrother(brother));
			}
		} break;
	}

	// start battle button
	switch (_inventoryMode)
	{
		case CharacterScreenDatasourceIdentifier.InventoryMode.BattlePreparation:
		{
			this.mStartBattleButtonContainer.removeClass('display-none').addClass('display-block');
			break;
		} 
		case CharacterScreenDatasourceIdentifier.InventoryMode.Stash:
		case CharacterScreenDatasourceIdentifier.InventoryMode.Ground:
		{
			this.mStartBattleButtonContainer.removeClass('display-block').addClass('display-none');
			break;
		} 
	}
};

CharacterScreenBrothersListModule.prototype.onBrothersSettingsChanged = function (_dataSource, _data)
{
	this.updateRosterLabel(_data);
};

CharacterScreenBrothersListModule.prototype.onBrothersListLoaded = function (_dataSource, _brothers)
{
	this.clearBrothersList();

	if (_brothers === null || !jQuery.isArray(_brothers) || _brothers.length === 0)
	{
		return;
	}

	var allowReordering = this.mDataSource.getInventoryMode() == CharacterScreenDatasourceIdentifier.InventoryMode.Stash;

	for (var i = 0; i < _brothers.length; ++i)
	{
		var brother = _brothers[i];

		if (brother !== null)
		{
			this.addBrotherSlotDIV(this.mSlots[i], brother, i, allowReordering);
		}
	}

	if (!allowReordering)
	{
		this.mListScrollContainer.find('.is-brother-slot').each(function (index, element)
		{
			var slot = $(element);

			if (slot.data('child') == null)
			{
				slot.removeClass('display-block');
				slot.addClass('display-none');
			}
			else
			{
				slot.addClass('is-blocked-slot');
			}
		});
	}
	else
	{
		this.updateBlockedSlots();
	}

	var inventoryMode  = _dataSource.getInventoryMode();
	this.updateBrotherSlotLocks(inventoryMode);

	if (inventoryMode === CharacterScreenDatasourceIdentifier.InventoryMode.Ground)
	{
		this.setBrotherSlotActive(_dataSource.getSelectedBrother());
	}

	this.updateRosterLabel();
};

CharacterScreenBrothersListModule.prototype.onBrotherUpdated = function (_dataSource, _brother)
{
	if (_brother !== null &&
		CharacterScreenIdentifier.Entity.Id in _brother &&
		CharacterScreenIdentifier.Entity.Character.Key in _brother &&
		CharacterScreenIdentifier.Entity.Character.Name in _brother[CharacterScreenIdentifier.Entity.Character.Key] &&
		CharacterScreenIdentifier.Entity.Character.ImagePath in _brother[CharacterScreenIdentifier.Entity.Character.Key])
	{
		this.updateBrotherSlot(_brother);
	}
};

CharacterScreenBrothersListModule.prototype.onBrotherSelected = function (_dataSource, _brother)
{
	if (_brother !== null && CharacterScreenIdentifier.Entity.Id in _brother)
	{
		this.removeCurrentBrotherSlotSelection();
		this.selectBrotherSlot(_brother[CharacterScreenIdentifier.Entity.Id]);
	}
};

CharacterScreenBrothersListModule.prototype.onInventoryModeUpdated = function (_dataSource, _mode)
{
	this.updateBrotherSlotLocks(_mode);
};