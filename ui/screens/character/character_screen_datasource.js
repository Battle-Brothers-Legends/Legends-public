/*
 *  @Project:		Battle Brothers
 *	@Company:		Overhype Studios
 *
 *	@Copyright:		(c) Overhype Studios | 2013 - 2020
 *
 *  @Author:		Overhype Studios
 *  @Date:			24.01.2017 / Reworked: 26.11.2017
 *  @Description:	Character Screen Datasource JS
 */
"use strict";


var CharacterScreenDatasourceIdentifier =
{
	Brother:
	{
		ListLoaded: 'brothers.list-loaded',
		SettingsChanged: 'brothers.settings-changed',
		Updated: 'brother.updated',
		Selected: 'brother.selected'
	},

	Inventory:
	{
		ModeUpdated: 'inventory.mode-updated',
		StashLoaded: 'inventory.stash-loaded',
		StashItemUpdated:
		{
			Key: 'inventory.stash-item-updated',
			Flag:
			{
				Inserted: 'inserted',
				Removed: 'removed',
				Updated: 'updated'
			}
		},
		FormationIndex: 'inventory.formation-selected',
		FormationName: 'inventory.formation-name'
	},

	InventoryMode:
	{
		BattlePreparation: 'battle-preparation',
		Stash: 'stash',
		Ground: 'ground'
	},

	Perks:
	{
		TreesLoaded: 'perks.list-loaded'
	}
};


var CharacterScreenDatasource = function(_isTacticalMode)
{
	this.mSQHandle = null;

	// Event handling
	this.mEventListener = { };

	// Caches
	this.mBrothersList = null;
	this.mSelectedBrotherIndex = null;
	this.mStashList = null;
	this.mPerkTrees = null;

	this.mStashSpaceUsed = 0;
	this.mStashSpaceMax = 0;

	// States
	this.mInventoryMode = null;
	this.mIsTacticalMode = _isTacticalMode;

	// fucking bullshit
	this.mInventoryModule = null;
	this.mIsPopupOpen = false;

	this.mFormationIndex = 0;
	this.mFormationName = "";

	this.mMaxBrothers = 25;
	this.mFrontlineData = [25, 25];
	// init the datasource
	this.init();
};


CharacterScreenDatasource.prototype.setInventoryModule = function (_module)
{
	this.mInventoryModule = _module;
}

CharacterScreenDatasource.prototype.getInventoryModule = function ()
{
	return this.mInventoryModule;
}

CharacterScreenDatasource.prototype.onConnection = function (_handle)
{
	this.mSQHandle = _handle;
};

CharacterScreenDatasource.prototype.onDisconnection = function ()
{
	this.mSQHandle = null;
	this.reset();
};


CharacterScreenDatasource.prototype.addListener = function(_channel, _callback)
{
	if (_channel in this.mEventListener)
	{
		if (jQuery.inArray(_callback, this.mEventListener[_channel]) === -1)
		{
			this.mEventListener[_channel].push(_callback);
		}
	}
};

CharacterScreenDatasource.prototype.removeListener = function(_channel, _callback)
{
	if (_channel in this.mEventListener)
	{
		var idx = jQuery.inArray(_callback, this.mEventListener[_channel]);
		if (idx !== -1)
		{
			this.mEventListener[_channel].remove(idx);
		}
	}
};

CharacterScreenDatasource.prototype.removeListeners = function()
{
	this.createEventChannels();
};

CharacterScreenDatasource.prototype.notifyEventListener = function(_channel, _payload)
{
	if (_channel in this.mEventListener)
	{
		var listeners = this.mEventListener[_channel];
		for (var i = 0; i < listeners.length; ++i)
		{
			listeners[i](this, _payload);
		}
	}
};

CharacterScreenDatasource.prototype.createEventChannels = function()
{
	this.mEventListener[ErrorCode.Key] = [ ];

	this.mEventListener[CharacterScreenDatasourceIdentifier.Brother.ListLoaded] = [];
	this.mEventListener[CharacterScreenDatasourceIdentifier.Brother.SettingsChanged] = [];
	this.mEventListener[CharacterScreenDatasourceIdentifier.Brother.Updated] = [ ];
	this.mEventListener[CharacterScreenDatasourceIdentifier.Brother.Selected] = [ ];

	this.mEventListener[CharacterScreenDatasourceIdentifier.Inventory.ModeUpdated] = [ ];
	this.mEventListener[CharacterScreenDatasourceIdentifier.Inventory.StashLoaded] = [ ];
	this.mEventListener[CharacterScreenDatasourceIdentifier.Inventory.StashItemUpdated.Key] = [ ];
	this.mEventListener[CharacterScreenDatasourceIdentifier.Inventory.FormationIndex] = [ ];
	this.mEventListener[CharacterScreenDatasourceIdentifier.Inventory.FormationName] = [ ];

	this.mEventListener[CharacterScreenDatasourceIdentifier.Perks.TreesLoaded] = [ ];

};


CharacterScreenDatasource.prototype.init = function()
{
	this.createEventChannels();
};

CharacterScreenDatasource.prototype.reset = function()
{
	// Caches
	this.mBrothersList = null;
	this.mSelectedBrotherIndex = null;
	this.mStashList = null;
	this.mPerkTrees = null;

	// States
	this.mInventoryMode = null;
};


CharacterScreenDatasource.prototype.setInventoryMode = function(_mode)
{
	if (_mode === undefined || _mode === null || typeof(_mode) !== 'string')
	{
		console.error('ERROR: Failed to set inventory mode. Reason: Invalid mode.');
	}

	switch(_mode.toLowerCase())
	{
		case CharacterScreenDatasourceIdentifier.InventoryMode.Stash:
		{
			this.mInventoryMode = CharacterScreenDatasourceIdentifier.InventoryMode.Stash;
			this.notifyEventListener(CharacterScreenDatasourceIdentifier.Inventory.ModeUpdated, this.mInventoryMode);
		} break;
		case CharacterScreenDatasourceIdentifier.InventoryMode.Ground:
		{
			this.mInventoryMode = CharacterScreenDatasourceIdentifier.InventoryMode.Ground;
			this.notifyEventListener(CharacterScreenDatasourceIdentifier.Inventory.ModeUpdated, this.mInventoryMode);
		} break;
		case CharacterScreenDatasourceIdentifier.InventoryMode.BattlePreparation:
		{
			this.mInventoryMode = CharacterScreenDatasourceIdentifier.InventoryMode.BattlePreparation;
			this.notifyEventListener(CharacterScreenDatasourceIdentifier.Inventory.ModeUpdated, this.mInventoryMode);
		} break;
	}
};


CharacterScreenDatasource.prototype.getInventoryMode = function()
{
	return this.mInventoryMode;
};

CharacterScreenDatasource.prototype.isInStashMode = function()
{
	return this.mInventoryMode === CharacterScreenDatasourceIdentifier.InventoryMode.Stash || this.mInventoryMode === CharacterScreenDatasourceIdentifier.InventoryMode.BattlePreparation;
};

CharacterScreenDatasource.prototype.isInGroundMode = function()
{
	return this.mInventoryMode === CharacterScreenDatasourceIdentifier.InventoryMode.Ground;
};

CharacterScreenDatasource.prototype.isTacticalMode = function ()
{
	return this.mIsTacticalMode;
};

CharacterScreenDatasource.prototype.getBrothersList = function ()
{
	return this.mBrothersList;
};


CharacterScreenDatasource.prototype.getTooltipItemOwner = function()
{
	switch(this.mInventoryMode)
	{
		case CharacterScreenDatasourceIdentifier.InventoryMode.BattlePreparation:
		case CharacterScreenDatasourceIdentifier.InventoryMode.Stash:
		{
			return TooltipIdentifier.ItemOwner.Stash;
		} break;
		case CharacterScreenDatasourceIdentifier.InventoryMode.Ground:
		{
			return TooltipIdentifier.ItemOwner.Ground;
		} break;
	}

	return TooltipIdentifier.ItemOwner.Entity;
};


CharacterScreenDatasource.prototype.getFormationIndex = function ()
{
	return this.mFormationIndex;
};

CharacterScreenDatasource.prototype.getFormationName = function ()
{
	return this.mFormationName;
};

CharacterScreenDatasource.prototype.loadFromData = function(_data)
{

	if (_data === undefined || _data == null || typeof(_data) !== 'object')
	{
		console.error('ERROR: Failed to query character screen result data. Reason: Invalid result.');
		return;
	}

	if ('maxBrothers' in _data)
		this.mMaxBrothers = _data.maxBrothers;
	if ('frontlineData' in _data)
		this.mFrontlineData = _data.frontlineData;

	if ('stashSpaceUsed' in _data)
		this.mStashSpaceUsed = _data.stashSpaceUsed;

	if ('stashSpaceMax' in _data)
		this.mStashSpaceMax = _data.stashSpaceMax;

	// if (CharacterScreenIdentifier.QueryResult.PerkTrees in _data)
	// {
	//	 this.loadPerkTrees(_data[CharacterScreenIdentifier.QueryResult.PerkTrees]);
	// }

	if (CharacterScreenIdentifier.QueryResult.Brothers in _data)
	{
		this.loadBrothersList(_data[CharacterScreenIdentifier.QueryResult.Brothers]);
	}

	if (CharacterScreenIdentifier.QueryResult.Stash in _data)
	{
		this.loadStashList(_data[CharacterScreenIdentifier.QueryResult.Stash]);
	}

	if ('formationIndex' in _data)
	{
		this.mFormationIndex = _data.formationIndex;
		this.notifyEventListener(CharacterScreenDatasourceIdentifier.Inventory.FormationIndex, _data.formationIndex);
	}

	if ('formationName' in _data)
	{
		this.mFormationName = _data.formationName;
		this.notifyEventListener(CharacterScreenDatasourceIdentifier.Inventory.FormationName, _data.formationName);
	}
};


CharacterScreenDatasource.prototype.swapBrothers = function (_a, _b)
{
	var tmp = this.mBrothersList[_a];
	this.mBrothersList[_a] = this.mBrothersList[_b];
	this.mBrothersList[_b] = tmp;
}


CharacterScreenDatasource.prototype.loadBrothersList = function(_data, _withoutNotify)
{
	var data = _data;
	/*if (_data !== undefined && _data !== null && typeof(_data) === 'object')
	{
		var data = _data;
	}
	else
	{
		data = this.notifyBackendQueryBrothersList();
		if (data === null)
		{
			console.log('ERROR: Failed to query brothers list data. Reason: Invalid result.');
			return;
		}
	}*/

	if (this.mInventoryMode === null)
	{
		this.setInventoryMode(CharacterScreenDatasourceIdentifier.InventoryMode.Stash);
	}

	this.mSelectedBrotherIndex = null;
	this.mBrothersList = data;

	// find selected one
	if (this.mBrothersList !== null && jQuery.isArray(this.mBrothersList))
	{
		for (var i = 0; i < this.mBrothersList.length; ++i)
		{
			if (this.mBrothersList[i] !== null && CharacterScreenIdentifier.Entity.Flags in this.mBrothersList[i] && CharacterScreenIdentifier.EntityFlags.IsSelected in this.mBrothersList[i][CharacterScreenIdentifier.Entity.Flags])
			{
				if (this.mBrothersList[i][CharacterScreenIdentifier.Entity.Flags][CharacterScreenIdentifier.EntityFlags.IsSelected] === true)
				{
					this.mSelectedBrotherIndex = i;
					break;
				}
			}
		}

		// no selected found - use the first usable as default
		if (this.mSelectedBrotherIndex === null && this.mBrothersList.length > 0)
		{
			for (var i = 0; i < this.mBrothersList.length; ++i)
			{
				if(this.mBrothersList[i] != null)
				{
					this.mSelectedBrotherIndex = i;
					break;
				}
			}
		}
	}

	// notify every listener
	if (_withoutNotify === undefined || _withoutNotify !== true)
	{
		this.notifyEventListener(CharacterScreenDatasourceIdentifier.Brother.ListLoaded, this.mBrothersList);
		this.notifyEventListener(CharacterScreenDatasourceIdentifier.Brother.Selected, this.getSelectedBrother());
	}

	return this.mBrothersList;
};


CharacterScreenDatasource.prototype.getBrothersList = function()
{
	if (this.mBrothersList === null)
	{
		this.mBrothersList = this.loadBrothersList(null, true);
	}

	return this.mBrothersList;
};

CharacterScreenDatasource.prototype.getNumBrothers = function ()
{
	var num = 0;

	for (var i = 0; i != this.mBrothersList.length; ++i)
	{
		if(this.mBrothersList[i] !== null)
			++num;
	}

	return num;
};

CharacterScreenDatasource.prototype.getSelectedBrother = function()
{
	if (this.mSelectedBrotherIndex !== null && this.mBrothersList !== null && this.mSelectedBrotherIndex < this.mBrothersList.length)
	{
		return this.mBrothersList[this.mSelectedBrotherIndex];
	}
	return null;
};

CharacterScreenDatasource.prototype.getSelectedBrotherIndex = function ()
{
	return this.mSelectedBrotherIndex;
};

CharacterScreenDatasource.prototype.setSelectedBrotherIndex = function (_rosterPosition, _withoutNotify)
{
	this.mSelectedBrotherIndex = _rosterPosition;

	// notify every listener
	if (_withoutNotify === undefined || _withoutNotify !== true)
	{
		this.notifyEventListener(CharacterScreenDatasourceIdentifier.Brother.ListLoaded, this.mBrothersList);
		this.notifyEventListener(CharacterScreenDatasourceIdentifier.Brother.Selected, this.getSelectedBrother());
	}
};

function isStudentPerkUnlocked(_perksUnlocked) {
	return _perksUnlocked.indexOf('perk.student') !== -1
}


CharacterScreenDatasource.prototype.getBrotherPerkPoints = function(_brother)
{
	if (_brother === null || !(CharacterScreenIdentifier.Entity.Character.Key in _brother))
	{
		return 0;
	}

	var character = _brother[CharacterScreenIdentifier.Entity.Character.Key];
	if (character === null)
	{
		return 0;
	}

	if (CharacterScreenIdentifier.Entity.Character.PerkPoints in character)
	{
		var perkPoints = character[CharacterScreenIdentifier.Entity.Character.PerkPoints];
		if (perkPoints !== null && typeof(perkPoints) == 'number')
		{
			return perkPoints;
		}
	}

	return 0;
};


CharacterScreenDatasource.prototype.getBrotherPerkPointsSpent = function (_brother)
{
	if (_brother === null || !(CharacterScreenIdentifier.Entity.Character.Key in _brother))
	{
		return 0;
	}

	var character = _brother[CharacterScreenIdentifier.Entity.Character.Key];
	if (character === null)
	{
		return 0;
	}

	if (CharacterScreenIdentifier.Entity.Character.PerkPoints in character)
	{
		var perkPoints = character[CharacterScreenIdentifier.Entity.Character.PerkPointsSpent];
		if (perkPoints !== null && typeof (perkPoints) == 'number')
		{
			return perkPoints;
		}
	}

	return 0;
};


CharacterScreenDatasource.prototype.isSelectedBrother = function(_brother)
{
	var selectedBrother = this.getSelectedBrother();
	return selectedBrother !== null && CharacterScreenIdentifier.Entity.Id in selectedBrother &&
			_brother !== null && CharacterScreenIdentifier.Entity.Id in _brother &&
			selectedBrother[CharacterScreenIdentifier.Entity.Id] === _brother[CharacterScreenIdentifier.Entity.Id];
};

CharacterScreenDatasource.prototype.switchToPreviousBrother = function(_withoutNotify)
{
	if (this.mBrothersList == null || this.mIsPopupOpen)
		return;

	var currentIndex = this.mSelectedBrotherIndex;

	for (var i = this.mSelectedBrotherIndex - 1; i >= 0; --i)
	{
		if (this.mBrothersList[i] !== null)
		{
			this.mSelectedBrotherIndex = i;
			break;
		}
	}

	if (this.mSelectedBrotherIndex == currentIndex)
	{
		for (var i = this.mBrothersList.length - 1; i > currentIndex; --i)
		{
			if (this.mBrothersList[i] !== null)
			{
				this.mSelectedBrotherIndex = i;
				break;
			}
		}
	}

	// notify every listener
	if (_withoutNotify === undefined || _withoutNotify !== true)
	{
		this.notifyEventListener(CharacterScreenDatasourceIdentifier.Brother.Selected, this.getSelectedBrother());
	}
};

CharacterScreenDatasource.prototype.switchToNextBrother = function(_withoutNotify)
{
	if (this.mBrothersList == null || this.mIsPopupOpen)
		return;

	var currentIndex = this.mSelectedBrotherIndex;

	for (var i = this.mSelectedBrotherIndex + 1; i < this.mBrothersList.length; ++i)
	{
		if (this.mBrothersList[i] !== null)
		{
			this.mSelectedBrotherIndex = i;
			break;
		}
	}

	if(this.mSelectedBrotherIndex == currentIndex)
	{
		for (var i = 0; i < this.mSelectedBrotherIndex; ++i)
		{
			if (this.mBrothersList[i] !== null)
			{
				this.mSelectedBrotherIndex = i;
				break;
			}
		}
	}

	// notify every listener
	if (_withoutNotify === undefined || _withoutNotify !== true)
	{
		this.notifyEventListener(CharacterScreenDatasourceIdentifier.Brother.Selected, this.getSelectedBrother());
	}
};


CharacterScreenDatasource.prototype.toggleBrotherReserves = function(_withoutNotify)
{
	if (this.mBrothersList == null || this.mIsPopupOpen)
		return;

	this.notifyBackendToggleReservesCharacter();
};

CharacterScreenDatasource.prototype.selectedBrotherById = function(_brotherId, _withoutNotify)
{
	if (this.mSelectedBrotherIndex !== null && this.mBrothersList !== null)
	{
		var hasChanged = false;
		for (var i = 0; i < this.mBrothersList.length; ++i)
		{
			if (this.mBrothersList[i] != null && CharacterScreenIdentifier.Entity.Id in this.mBrothersList[i])
			{
				if (this.mBrothersList[i][CharacterScreenIdentifier.Entity.Id] === _brotherId && this.mSelectedBrotherIndex !== i)
				{

					hasChanged = true;
					this.mSelectedBrotherIndex = i;
					break;
				}
			}
		}

		// notify every listener
		if ((_withoutNotify === undefined || _withoutNotify !== true) && hasChanged === true)
		{
			this.notifyEventListener(CharacterScreenDatasourceIdentifier.Brother.Selected, this.getSelectedBrother());
		}
	}
};

CharacterScreenDatasource.prototype.setRosterLimit = function(_data, _withoutNotify)
{
	// notify every listener
	if (_withoutNotify === undefined || _withoutNotify !== true)
	{
		this.notifyEventListener(CharacterScreenDatasourceIdentifier.Brother.SettingsChanged, _data);
	}
};


CharacterScreenDatasource.prototype.loadStashList = function(_data, _withoutNotify)
{
	var data = _data;
	this.mStashList = data;

	// notify every listener
	if (_withoutNotify === undefined || _withoutNotify !== true)
	{
		this.notifyEventListener(CharacterScreenDatasourceIdentifier.Inventory.StashLoaded, this.mStashList);
	}

	return this.mStashList;
};

CharacterScreenDatasource.prototype.getStashList = function()
{
	if (this.mStashList === null)
	{
		this.mStashList = this.loadStashList(null, true);
	}

	return this.mStashList;
};

CharacterScreenDatasource.prototype.isStashSpaceLeft = function (_howMuch)
{
	if (_howMuch !== undefined && _howMuch !== null)
	{
		var usedSpace = 0;
		for (var i = 0; i < this.mStashList.length; ++i)
		{
			if (this.mStashList[i] !== null)
			{
				++usedSpace;
			}

			if (usedSpace >= _howMuch)
			{
				return true;
			}
		}
	}
	else
	{
		for (var i = 0; i < this.mStashList.length; ++i)
		{
			if (this.mStashList[i] === null)
			{
				return true;
			}
		}
	}

	return false;
};

CharacterScreenDatasource.prototype.isBagSpaceLeft = function (_howMuch)
{
	var selectedBrother = this.getSelectedBrother();
	if (selectedBrother === null || !(CharacterScreenIdentifier.Entity.Id in selectedBrother))
	{
		console.error('ERROR: Failed to get bag space. No entity selected.');
		return 0;
	}

	if (CharacterScreenIdentifier.Paperdoll.Bag in selectedBrother && selectedBrother[CharacterScreenIdentifier.Paperdoll.Bag] !== null)
	{
		var bag = selectedBrother[CharacterScreenIdentifier.Paperdoll.Bag];
		if (_howMuch !== undefined && _howMuch !== null)
		{
			var usedSpace = 0;
			for (var i = 0; i < bag.length; ++i)
			{
				if (bag[i] !== null)
				{
					++usedSpace;
				}
			}

			if ((bag.length - usedSpace) >= _howMuch)
			{
				return true;
			}
		}
		else
		{
			for (var i = 0; i < bag.length; ++i)
			{
				if (bag[i] === null)
				{
					return true;
				}
			}
		}
	}

	return false;
};

CharacterScreenDatasource.prototype.getStashStatistics = function ()
{
	/*var usedSpace = 0;
	for (var i = 0; i < this.mStashList.length; ++i)
	{
		if (this.mStashList[i] !== null)
		{
			++usedSpace;
		}
	}*/

	return { size: this.mStashSpaceMax, used: this.mStashSpaceUsed };
};

CharacterScreenDatasource.prototype.getGroundStatistics = function ()
{
	var selectedBrother = this.getSelectedBrother();
	if (selectedBrother === null || !(CharacterScreenIdentifier.Entity.Id in selectedBrother))
	{
		console.error('ERROR: Failed to get ground statistics. No entity selected.');
		return 0;
	}

	if (CharacterScreenIdentifier.Entity.Ground in selectedBrother && selectedBrother[CharacterScreenIdentifier.Entity.Ground] !== null)
	{
		var ground = selectedBrother[CharacterScreenIdentifier.Entity.Ground];
		var groundItems = 0;
		for (var i = 0; i < ground.length; ++i)
		{
			if (ground[i] !== null)
			{
				++groundItems;
			}
		}
		return { size: groundItems };
	}

	return 0;
};

CharacterScreenDatasource.prototype.hasItemEquipped = function (_slotType)
{
	var selectedBrother = this.getSelectedBrother();
	if (selectedBrother === null || !(CharacterScreenIdentifier.Entity.Id in selectedBrother))
	{
		console.error('ERROR: Failed to item equipment state. No entity selected.');
		return false;
	}

	if (CharacterScreenIdentifier.Paperdoll.Equipment in selectedBrother &&
		selectedBrother[CharacterScreenIdentifier.Paperdoll.Equipment] !== null)
	{
		var equipment = selectedBrother[CharacterScreenIdentifier.Paperdoll.Equipment];
		if (_slotType !== undefined && _slotType !== null && _slotType in equipment && equipment[_slotType] !== null)
		{
			return (CharacterScreenIdentifier.Item.Id in equipment[_slotType] && equipment[_slotType][CharacterScreenIdentifier.Item.Id] !== null);
		}
	}

	return false;
};

CharacterScreenDatasource.prototype.hasEnoughAPToEquip = function ()
{
	var selectedBrother = this.getSelectedBrother();
	if (selectedBrother === null || !(CharacterScreenIdentifier.Entity.Id in selectedBrother))
	{
		console.error('ERROR: Failed to check Action Points. No entity selected.');
		return false;
	}

	if (this.isInStashMode() === true)
	{
		return true;
	}

	if (CharacterScreenIdentifier.Entity.Stats in selectedBrother &&
		selectedBrother[CharacterScreenIdentifier.Entity.Stats] !== null)
	{
		var stats = selectedBrother[CharacterScreenIdentifier.Entity.Stats];
		return (ProgressbarValueIdentifier.ActionPoints in stats && stats[ProgressbarValueIdentifier.ActionPoints] !== null && stats[ProgressbarValueIdentifier.ActionPoints] >= 0/*Constants.Game.MIN_ACTION_POINTS_NEEDED_TO_SWAP_ITEMS*/);
	}

	return false;
};


CharacterScreenDatasource.prototype.swapInventoryItem = function (_sourceItemIdx, _targetItemIdx, tryToUpgrade)
{
	var self = this;
	this.notifyBackendSwapInventoryItem(_sourceItemIdx, _targetItemIdx, tryToUpgrade, function (data)
	{
		if (data === undefined || data == null || typeof (data) !== 'object')
		{
			console.error('ERROR: Failed to swap item. Invalid data result.');
			return;
		}

		// check if we have an error
		if (ErrorCode.Key in data)
		{
			self.notifyEventListener(ErrorCode.Key, data[ErrorCode.Key]);
		}
		else
		{
			if ('stashSpaceUsed' in data)
				self.mStashSpaceUsed = data.stashSpaceUsed;

			if ('stashSpaceMax' in data)
				self.mStashSpaceMax = data.stashSpaceMax;

			self.mInventoryModule.updateSlotsLabel();

			if (CharacterScreenIdentifier.QueryResult.Stash in data)
			{
				var stashData = data[CharacterScreenIdentifier.QueryResult.Stash];
				if(tryToUpgrade === true){
					stashData.forceUpdate = _targetItemIdx;
				}
				if (stashData !== null && jQuery.isArray(stashData))
				{
					self.updateStash(stashData);
				}
				else
				{
					console.error('ERROR: Failed to swap item. Invalid stash data result.');
				}
			}

			if (CharacterScreenIdentifier.QueryResult.Brother in data)
			{
				var brotherData = data[CharacterScreenIdentifier.QueryResult.Brother];
				if (CharacterScreenIdentifier.Entity.Id in brotherData)
				{
					self.updateBrother(brotherData);
				}
				else
				{
					console.error('ERROR: Failed to swap item. Invalid brother data result.');
				}
			}
		}
	});
};

CharacterScreenDatasource.prototype.destroyInventoryItem = function(_brotherId, _itemId)
{
	// if the _brotherId is null, this means we are trying to equip a stash item which is NOT brother bound
	// thus we have to use the current selected one
	var brotherId = _brotherId;
	if (brotherId === null)
	{
		var selectedBrother = this.getSelectedBrother();
		if (selectedBrother === null || !(CharacterScreenIdentifier.Entity.Id in selectedBrother))
		{
			console.error('ERROR: Failed to equip inventory item. No entity selected.');
			return;
		}

		brotherId = selectedBrother[CharacterScreenIdentifier.Entity.Id];
	}

	var data = this.notifyBackendDestroyInventoryItem(brotherId, _itemId);
	if (data === undefined || data == null || typeof(data) !== 'object')
	{
		console.error('ERROR: Failed to destroy inventory item. Invalid data result.');
		return;
	}

	// check if we have an error
	if (ErrorCode.Key in data)
	{
		this.notifyEventListener(ErrorCode.Key, data[ErrorCode.Key]);
	}
	else
	{
		if ('stashSpaceUsed' in data)
			this.mStashSpaceUsed = data.stashSpaceUsed;

		if ('stashSpaceMax' in data)
			this.mStashSpaceMax = data.stashSpaceMax;

		this.mInventoryModule.updateSlotsLabel();

		if (CharacterScreenIdentifier.QueryResult.Stash in data)
		{
			var stashData = data[CharacterScreenIdentifier.QueryResult.Stash];
			if (stashData !== null && jQuery.isArray(stashData))
			{
				this.updateStash(stashData);
			}
			else
			{
				console.error('ERROR: Failed to destroy inventory item. Invalid stash data result.');
			}
		}

		if (CharacterScreenIdentifier.QueryResult.Brother in data)
		{
			var brotherData = data[CharacterScreenIdentifier.QueryResult.Brother];
			if (CharacterScreenIdentifier.Entity.Id in brotherData)
			{
				this.updateBrother(brotherData);
			}
			else
			{
				console.error('ERROR: Failed to destroy inventory item. Invalid brother data result.');
			}
		}
	}
};

CharacterScreenDatasource.prototype.toggleInventoryItem = function(_itemId, _entityId, _callback)
{
   this.notifyBackendToggleInventoryItem(_itemId, _entityId, _callback);
};


CharacterScreenDatasource.prototype.equipInventoryItem = function(_brotherId, _sourceItemId, _sourceItemIdx)
{
	// if the _brotherId is null, this means we are trying to equip a stash item which is NOT brother bound
	// thus we have to use the current selected one
	var brotherId = _brotherId;
	if (brotherId === null)
	{
		var selectedBrother = this.getSelectedBrother();
		if (selectedBrother === null || !(CharacterScreenIdentifier.Entity.Id in selectedBrother))
		{
			console.error('ERROR: Failed to equip inventory item. No entity selected.');
			return;
		}

		brotherId = selectedBrother[CharacterScreenIdentifier.Entity.Id];
	}

	var self = this;
	this.notifyBackendEquipInventoryItem(brotherId, _sourceItemId, _sourceItemIdx, function (data)
	{
		if (data === undefined || data == null || typeof (data) !== 'object')
		{
			console.error('ERROR: Failed to equip inventory item. Invalid data result.');
			return;
		}

		// check if we have an error
		if (ErrorCode.Key in data)
		{
			self.notifyEventListener(ErrorCode.Key, data[ErrorCode.Key]);
		}
		else
		{
			if ('stashSpaceUsed' in data)
				self.mStashSpaceUsed = data.stashSpaceUsed;

			if ('stashSpaceMax' in data)
				self.mStashSpaceMax = data.stashSpaceMax;

			self.mInventoryModule.updateSlotsLabel();

			if (CharacterScreenIdentifier.QueryResult.Stash in data)
			{
				var stashData = data[CharacterScreenIdentifier.QueryResult.Stash];
				if (stashData !== null && jQuery.isArray(stashData))
				{
					self.updateStash(stashData);
				}
				else
				{
					console.error('ERROR: Failed to equip inventory item. Invalid stash data result.');
				}
			}

			if (CharacterScreenIdentifier.QueryResult.Brother in data)
			{
				var brotherData = data[CharacterScreenIdentifier.QueryResult.Brother];
				if (CharacterScreenIdentifier.Entity.Id in brotherData)
				{
					self.updateBrother(brotherData);
				}
				else
				{
					console.error('ERROR: Failed to equip inventory item. Invalid brother data result.');
				}
			}
		}
	});
};

CharacterScreenDatasource.prototype.addLayerToItem = function(_brotherId, _sourceItemId, _sourceItemIdx)
{
	// if the _brotherId is null, this means we are trying to equip a stash item which is NOT brother bound
	// thus we have to use the current selected one
	var brotherId = _brotherId;
	if (brotherId === null)
	{
		var selectedBrother = this.getSelectedBrother();
		if (selectedBrother === null || !(CharacterScreenIdentifier.Entity.Id in selectedBrother))
		{
			console.error('ERROR: Failed to equip inventory item. No entity selected.');
			return;
		}

		brotherId = selectedBrother[CharacterScreenIdentifier.Entity.Id];
	}

	var self = this;
	this.notifyBackendEquipInventoryItem(brotherId, _sourceItemId, _sourceItemIdx, function (data)
	{
		if (data === undefined || data == null || typeof (data) !== 'object')
		{
			console.error('ERROR: Failed to equip inventory item. Invalid data result.');
			return;
		}

		// check if we have an error
		if (ErrorCode.Key in data)
		{
			self.notifyEventListener(ErrorCode.Key, data[ErrorCode.Key]);
		}
		else
		{
			if ('stashSpaceUsed' in data)
				self.mStashSpaceUsed = data.stashSpaceUsed;

			if ('stashSpaceMax' in data)
				self.mStashSpaceMax = data.stashSpaceMax;

			self.mInventoryModule.updateSlotsLabel();

			if (CharacterScreenIdentifier.QueryResult.Stash in data)
			{
				var stashData = data[CharacterScreenIdentifier.QueryResult.Stash];
				if (stashData !== null && jQuery.isArray(stashData))
				{
					self.updateStash(stashData);
				}
				else
				{
					console.error('ERROR: Failed to equip inventory item. Invalid stash data result.');
				}
			}

			if (CharacterScreenIdentifier.QueryResult.Brother in data)
			{
				var brotherData = data[CharacterScreenIdentifier.QueryResult.Brother];
				if (CharacterScreenIdentifier.Entity.Id in brotherData)
				{
					self.updateBrother(brotherData);
				}
				else
				{
					console.error('ERROR: Failed to equip inventory item. Invalid brother data result.');
				}
			}
		}
	});
};

CharacterScreenDatasource.prototype.dropInventoryItemIntoBag = function(_brotherId, _sourceItemId, _sourceItemIdx, _targetItemIdx)
{
	// if the _brotherId is null, this means we are trying to equip a stash item which is NOT brother bound
	// thus we have to use the current selected one
	var brotherId = _brotherId;
	if (brotherId === null)
	{
		var selectedBrother = this.getSelectedBrother();
		if (selectedBrother === null || !(CharacterScreenIdentifier.Entity.Id in selectedBrother))
		{
			console.error('ERROR: Failed to drop inventory item into bag. No entity selected.');
			return;
		}

		brotherId = selectedBrother[CharacterScreenIdentifier.Entity.Id];
	}

	var self = this;
	this.notifyBackendDropInventoryItemIntoBag(brotherId, _sourceItemId, _sourceItemIdx, _targetItemIdx, function (data)
	{
		if (data === undefined || data == null || typeof (data) !== 'object')
		{
			console.error('ERROR: Failed to drop inventory item into bag. Invalid data result.');
			return;
		}

		// check if we have an error
		if (ErrorCode.Key in data)
		{
			self.notifyEventListener(ErrorCode.Key, data[ErrorCode.Key]);
		}
		else
		{
			if ('stashSpaceUsed' in data)
				self.mStashSpaceUsed = data.stashSpaceUsed;

			if ('stashSpaceMax' in data)
				self.mStashSpaceMax = data.stashSpaceMax;

			self.mInventoryModule.updateSlotsLabel();

			if (CharacterScreenIdentifier.QueryResult.Stash in data)
			{
				var stashData = data[CharacterScreenIdentifier.QueryResult.Stash];
				if (stashData !== null && jQuery.isArray(stashData))
				{
					self.updateStash(stashData);
				}
				else
				{
					console.error('ERROR: Failed to drop inventory item into bag. Invalid stash data result.');
				}
			}

			if (CharacterScreenIdentifier.QueryResult.Brother in data)
			{
				var brotherData = data[CharacterScreenIdentifier.QueryResult.Brother];
				if (CharacterScreenIdentifier.Entity.Id in brotherData)
				{
					self.updateBrother(brotherData);
				}
				else
				{
					console.error('ERROR: Failed to drop inventory item into bag. Invalid brother data result.');
				}
			}
		}
	});
};

CharacterScreenDatasource.prototype.equipBagItem = function(_brotherId, _sourceItemId, _sourceItemIdx)
{
	// if the _brotherId is null, this means we are trying to equip a stash item which is NOT brother bound
	// thus we have to use the current selected one
	var brotherId = _brotherId;
	if (brotherId === null)
	{
		var selectedBrother = this.getSelectedBrother();
		if (selectedBrother === null || !(CharacterScreenIdentifier.Entity.Id in selectedBrother))
		{
			console.error('ERROR: Failed to equip bag item. No entity selected.');
			return;
		}

		brotherId = selectedBrother[CharacterScreenIdentifier.Entity.Id];
	}

	var self = this;
	this.notifyBackendEquipBagItem(brotherId, _sourceItemId, _sourceItemIdx, function (data)
	{
		if (data === undefined || data == null || typeof (data) !== 'object')
		{
			console.error('ERROR: Failed to equip bag item. Invalid data result.');
			return;
		}

		// check if we have an error
		if (ErrorCode.Key in data)
		{
			self.notifyEventListener(ErrorCode.Key, data[ErrorCode.Key]);
		}
		else
		{
			if (CharacterScreenIdentifier.QueryResult.Stash in data)
			{
				var stashData = data[CharacterScreenIdentifier.QueryResult.Stash];
				if (stashData !== null && jQuery.isArray(stashData))
				{
					self.updateStash(stashData);
				}
				else
				{
					console.error('ERROR: Failed to drop inventory item into bag. Invalid stash data result.');
				}
			}

			if (CharacterScreenIdentifier.QueryResult.Brother in data)
			{
				var brotherData = data[CharacterScreenIdentifier.QueryResult.Brother];
				if (CharacterScreenIdentifier.Entity.Id in brotherData)
				{
					self.updateBrother(brotherData);
				}
				else
				{
					console.error('ERROR: Failed to drop inventory item into bag. Invalid brother data result.');
				}
			}
		}
	});
};

CharacterScreenDatasource.prototype.swapBagItem = function (_brotherId, _sourceItemIdx, _targetItemIdx)
{
	// if the _brotherId is null, this means we are trying to equip a stash item which is NOT brother bound
	// thus we have to use the current selected one
	var brotherId = _brotherId;
	if (brotherId === null)
	{
		var selectedBrother = this.getSelectedBrother();
		if (selectedBrother === null || !(CharacterScreenIdentifier.Entity.Id in selectedBrother))
		{
			console.error('ERROR: Failed to equip bag item. No entity selected.');
			return;
		}

		brotherId = selectedBrother[CharacterScreenIdentifier.Entity.Id];
	}

	var self = this;
	this.notifyBackendSwapBagItem(brotherId, _sourceItemIdx, _targetItemIdx, function (data)
	{
		if (data === undefined || data == null || typeof (data) !== 'object')
		{
			console.error('ERROR: Failed to swap bag item. Invalid data result.');
			return;
		}

		// check if we have an error
		if (ErrorCode.Key in data)
		{
			self.notifyEventListener(ErrorCode.Key, data[ErrorCode.Key]);
		}
		else
		{
			if (CharacterScreenIdentifier.QueryResult.Stash in data)
			{
				var stashData = data[CharacterScreenIdentifier.QueryResult.Stash];
				if (stashData !== null && jQuery.isArray(stashData))
				{
					self.updateStash(stashData);
				}
				else
				{
					console.error('ERROR: Failed to swap bag item. Invalid stash data result.');
				}
			}

			if (CharacterScreenIdentifier.QueryResult.Brother in data)
			{
				var brotherData = data[CharacterScreenIdentifier.QueryResult.Brother];
				if (CharacterScreenIdentifier.Entity.Id in brotherData)
				{
					self.updateBrother(brotherData);
				}
				else
				{
					console.error('ERROR: Failed to swap bag item. Invalid brother data result.');
				}
			}
		}
	});
};

CharacterScreenDatasource.prototype.dropBagItemIntoInventory = function(_brotherId, _sourceItemId, _sourceItemIdx, _targetItemIdx)
{
	// if the _brotherId is null, this means we are trying to equip a stash item which is NOT brother bound
	// thus we have to use the current selected one
	var brotherId = _brotherId;
	if (brotherId === null)
	{
		var selectedBrother = this.getSelectedBrother();
		if (selectedBrother === null || !(CharacterScreenIdentifier.Entity.Id in selectedBrother))
		{
			console.error('ERROR: Failed to drop bag item into inventory. No entity selected.');
			return;
		}

		brotherId = selectedBrother[CharacterScreenIdentifier.Entity.Id];
	}

	var self = this;
	this.notifyBackendDropBagItemIntoInventory(brotherId, _sourceItemId, _sourceItemIdx, _targetItemIdx, function (data)
	{
		if (data === undefined || data == null || typeof (data) !== 'object')
		{
			console.error('ERROR: Failed to drop bag item into inventory. Invalid data result.');
			return;
		}

		// check if we have an error
		if (ErrorCode.Key in data)
		{
			self.notifyEventListener(ErrorCode.Key, data[ErrorCode.Key]);
		}
		else
		{
			if ('stashSpaceUsed' in data)
				self.mStashSpaceUsed = data.stashSpaceUsed;

			if ('stashSpaceMax' in data)
				self.mStashSpaceMax = data.stashSpaceMax;

			self.mInventoryModule.updateSlotsLabel();

			if (CharacterScreenIdentifier.QueryResult.Stash in data)
			{
				var stashData = data[CharacterScreenIdentifier.QueryResult.Stash];
				if (stashData !== null && jQuery.isArray(stashData))
				{
					self.updateStash(stashData);
				}
				else
				{
					console.error('ERROR: Failed to drop bag item into inventory. Invalid stash data result.');
				}
			}

			if (CharacterScreenIdentifier.QueryResult.Brother in data)
			{
				var brotherData = data[CharacterScreenIdentifier.QueryResult.Brother];
				if (CharacterScreenIdentifier.Entity.Id in brotherData)
				{
					self.updateBrother(brotherData);
				}
				else
				{
					console.error('ERROR: Failed to drop bag item into inventory. Invalid brother data result.');
				}
			}
		}
	});
};

CharacterScreenDatasource.prototype.dropPaperdollItem = function(_brotherId, _sourceItemId, _targetItemIdx)
{
	// if the _brotherId is null, this means we are trying to equip a stash item which is NOT brother bound
	// thus we have to use the current selected one
	var brotherId = _brotherId;
	if (brotherId === null)
	{
		var selectedBrother = this.getSelectedBrother();
		if (selectedBrother === null || !(CharacterScreenIdentifier.Entity.Id in selectedBrother))
		{
			console.error('ERROR: Failed to drop paperdoll item. No entity selected.');
			return;
		}

		brotherId = selectedBrother[CharacterScreenIdentifier.Entity.Id];
	}

	var self = this;
	this.notifyBackendDropPaperdollItem(brotherId, _sourceItemId, _targetItemIdx, function (data)
	{
		if (data === undefined || data == null || typeof (data) !== 'object')
		{
			console.error('ERROR: Failed to drop paperdoll item. Invalid data result.');
			return;
		}

		// check if we have an error
		if (ErrorCode.Key in data)
		{
			self.notifyEventListener(ErrorCode.Key, data[ErrorCode.Key]);
		}
		else
		{
			if ('stashSpaceUsed' in data)
				self.mStashSpaceUsed = data.stashSpaceUsed;

			if ('stashSpaceMax' in data)
				self.mStashSpaceMax = data.stashSpaceMax;

			self.mInventoryModule.updateSlotsLabel();

			if (CharacterScreenIdentifier.QueryResult.Stash in data)
			{
				var stashData = data[CharacterScreenIdentifier.QueryResult.Stash];
				if (stashData !== null && jQuery.isArray(stashData))
				{
					self.updateStash(stashData);
				}
				else
				{
					console.error('ERROR: Failed to equip inventory item. Invalid stash data result.');
				}
			}

			if (CharacterScreenIdentifier.QueryResult.Brother in data)
			{
				var brotherData = data[CharacterScreenIdentifier.QueryResult.Brother];
				if (CharacterScreenIdentifier.Entity.Id in brotherData)
				{
					self.updateBrother(brotherData);
				}
				else
				{
					console.error('ERROR: Failed to equip inventory item. Invalid brother data result.');
				}
			}
		}
	});
};

CharacterScreenDatasource.prototype.dropPaperdollItemIntoBag = function(_brotherId, _sourceItemId, _targetItemIdx)
{
	// if the _brotherId is null, this means we are trying to equip a stash item which is NOT brother bound
	// thus we have to use the current selected one
	var brotherId = _brotherId;
	if (brotherId === null)
	{
		var selectedBrother = this.getSelectedBrother();
		if (selectedBrother === null || !(CharacterScreenIdentifier.Entity.Id in selectedBrother))
		{
			console.error('ERROR: Failed to drop paperdoll item into bag. No entity selected.');
			return;
		}

		brotherId = selectedBrother[CharacterScreenIdentifier.Entity.Id];
	}

	var self = this;
	this.notifyBackendDropPaperdollItemIntoBag(brotherId, _sourceItemId, _targetItemIdx, function (data)
	{
		if (data === undefined || data == null || typeof (data) !== 'object')
		{
			console.error('ERROR: Failed to drop paperdoll item into bag. Invalid data result.');
			return;
		}

		// check if we have an error
		if (ErrorCode.Key in data)
		{
			self.notifyEventListener(ErrorCode.Key, data[ErrorCode.Key]);
		}
		else
		{
			if (CharacterScreenIdentifier.QueryResult.Stash in data)
			{
				var stashData = data[CharacterScreenIdentifier.QueryResult.Stash];
				if (stashData !== null && jQuery.isArray(stashData))
				{
					self.updateStash(stashData);
				}
				else
				{
					console.error('ERROR: Failed to drop paperdoll item into bag. Invalid stash data result.');
				}
			}

			if (CharacterScreenIdentifier.QueryResult.Brother in data)
			{
				var brotherData = data[CharacterScreenIdentifier.QueryResult.Brother];
				if (CharacterScreenIdentifier.Entity.Id in brotherData)
				{
					self.updateBrother(brotherData);
				}
				else
				{
					console.error('ERROR: Failed to drop paperdoll item into bag. Invalid brother data result.');
				}
			}
			/*
			// find the brother and update him
			if (CharacterScreenIdentifier.Entity.Id in data)
			{
				this.updateBrother(data);
			}
			else
			{
				console.error('ERROR: Failed to drop paperdoll item into bag. Invalid data result.');
			}
			*/
		}
	});
};


CharacterScreenDatasource.prototype.loadPerkTrees = function(_data, _withoutNotify)
{
	this.mPerkTrees = _data;

	// notify every listener
	if (_withoutNotify === undefined || _withoutNotify !== true)
	{
		this.notifyEventListener(CharacterScreenDatasourceIdentifier.Perks.TreesLoaded, this.mPerkTrees);
	}

	return this.mPerkTrees;
};

CharacterScreenDatasource.prototype.loadPerkTreesOnce = function(_data, _withoutNotify)
{
	if (this.mPerkTrees === null)
	{
		this.loadPerkTrees(_data, _withoutNotify);
	}
};

CharacterScreenDatasource.prototype.getPerkTrees = function()
{
	if (this.mPerkTrees === null)
	{
		this.loadPerkTrees(null, true);
	}

	return this.mPerkTrees;
};

CharacterScreenDatasource.prototype.unlockPerk = function(_brotherId, _perkId)
{
	var brotherId = _brotherId;
	if (brotherId === null)
	{
		var selectedBrother = this.getSelectedBrother();
		if (selectedBrother === null || !(CharacterScreenIdentifier.Entity.Id in selectedBrother))
		{
			console.error('ERROR: Failed to unlock perk. No entity selected.');
			return;
		}

		brotherId = selectedBrother[CharacterScreenIdentifier.Entity.Id];
	}

	var self = this;
	this.notifyBackendUnlockPerk(brotherId, _perkId, function (data)
	{
		if (data === undefined || data === null || typeof (data) !== 'object')
		{
			console.error('ERROR: Failed to unlock perk. Invalid data result.');
			return;
		}

		// check if we have an error
		if (ErrorCode.Key in data)
		{
			self.notifyEventListener(ErrorCode.Key, data[ErrorCode.Key]);
		}
		else
		{
			// find the brother and update him
			if (CharacterScreenIdentifier.Entity.Id in data)
			{
				self.updateBrother(data);
			}
			else
			{
				console.error('ERROR: Failed to unlock perk. Invalid data result.');
			}
		}
	});
};

CharacterScreenDatasource.prototype.queryPerkInformation = function(_perkId, _background, _callback)
{
	this.notifyBackendQueryPerkInformation(_perkId, _background, _callback);
};


CharacterScreenDatasource.prototype.updateBrother = function (_data)
{
	if (_data === null || typeof(_data) !== 'object')
	{
		console.error('ERROR: Failed to updated brother. Invalid data.');
		return;
	}

	for (var i = 0; i < this.mBrothersList.length; ++i)
	{
		if (this.mBrothersList[i] != null && this.mBrothersList[i][CharacterScreenIdentifier.Entity.Id] === _data[CharacterScreenIdentifier.Entity.Id])
		{
			this.mBrothersList[i] = _data;
			this.notifyEventListener(CharacterScreenDatasourceIdentifier.Brother.Updated, this.mBrothersList[i]);
			return;
		}
	}
};


CharacterScreenDatasource.prototype.updateStash = function (_data)
{
	if (_data === null || !jQuery.isArray(_data))
	{
		console.error('ERROR: Failed to updated stash. Invalid data.');
		return;
	}

	if (this.mStashList === null || !jQuery.isArray(this.mStashList))
	{
		this.mStashList = _data;
		return;
	}


	if (this.mStashList.length !== _data.length)
	{
		this.mStashList = _data;
		this.setInventoryMode(this.mInventoryMode);
		return;
	}

	// stash size changed .. shouldn't happen..
	var numItems = this.mStashList.length;
	if (this.mStashList.length < _data.length)
	{
		// console.error('ERROR: Failed to updated stash. Stash dataset changed in size.');
		//this.loadStashList(_data, true)
		numItems = _data.length;
		//this.mStashList = _data;
		// return;
	}
	var forceUpdateSlot = -1;
	if (_data["forceUpdate"] != null){
		forceUpdateSlot = _data["forceUpdate"]
	}

	// check stash for changes
	for (var i = 0; i < numItems; ++i)
	{
		var sourceItem = this.mStashList[i];
		var targetItem = _data[i];

		// item added to stash slot
		if (sourceItem === null && targetItem !== null)
		{
			if (CharacterScreenIdentifier.Item.Id in targetItem)
			{
				//console.log('STASH: Item inserted (Index: ' + i + ')');
				this.mStashList[i] = targetItem;
				this.notifyEventListener(CharacterScreenDatasourceIdentifier.Inventory.StashItemUpdated.Key, { item: targetItem, index: i, flag: CharacterScreenDatasourceIdentifier.Inventory.StashItemUpdated.Flag.Inserted });
			}
		}
		// item removed from stash slot
		else if (sourceItem !== null && targetItem === null)
		{
			//console.log('STASH: Item removed (Index: ' + i + ')');
			this.mStashList[i] = targetItem;
			this.notifyEventListener(CharacterScreenDatasourceIdentifier.Inventory.StashItemUpdated.Key, { item: sourceItem, index: i, flag: CharacterScreenDatasourceIdentifier.Inventory.StashItemUpdated.Flag.Removed });
		}
		else if(i == forceUpdateSlot)
		{
			this.notifyEventListener(CharacterScreenDatasourceIdentifier.Inventory.StashItemUpdated.Key, { item: targetItem, index: i, flag: CharacterScreenDatasourceIdentifier.Inventory.StashItemUpdated.Flag.Updated });
		}
		// item might have changed within stash slot
		else
		{
			if ((sourceItem !== null && targetItem !== null) &&
				(CharacterScreenIdentifier.Item.Id in sourceItem && CharacterScreenIdentifier.Item.Id in targetItem) &&
				(sourceItem[CharacterScreenIdentifier.Item.Id] !== targetItem[CharacterScreenIdentifier.Item.Id])
				)
			{
/*
				console.info('STASH: Item updated srcType: ' + sourceItem[CharacterScreenIdentifier.Item.Slot]);
				console.info('STASH: Item updated trgType: ' + targetItem[CharacterScreenIdentifier.Item.Slot]);
*/
				//console.log('STASH: Item updated (Index: ' + i + ')');

				this.mStashList[i] = targetItem;
				this.notifyEventListener(CharacterScreenDatasourceIdentifier.Inventory.StashItemUpdated.Key, { item: targetItem, index: i, flag: CharacterScreenDatasourceIdentifier.Inventory.StashItemUpdated.Flag.Updated });
			}
		}
	}

};

CharacterScreenDatasource.prototype.updateNameAndTitle = function(_brotherId, _name, _title)
{
	var brotherId = _brotherId;
	if (brotherId === null)
	{
		var selectedBrother = this.getSelectedBrother();
		if (selectedBrother === null || !(CharacterScreenIdentifier.Entity.Id in selectedBrother))
		{
			console.error('ERROR: Failed to update name & title. No entity selected.');
			return;
		}

		brotherId = selectedBrother[CharacterScreenIdentifier.Entity.Id];
	}

	var self = this;
	this.notifyBackendUpdateNameAndTitle(brotherId, _name, _title, function (data)
	{
		if (data === undefined || data === null || typeof (data) !== 'object')
		{
			console.error('ERROR: Failed to update name & title. Invalid data result.');
			return;
		}

		// check if we have an error
		if (ErrorCode.Key in data)
		{
			self.notifyEventListener(ErrorCode.Key, data[ErrorCode.Key]);
		}
		else
		{
			// find the brother and update him
			if (CharacterScreenIdentifier.Entity.Id in data)
			{
				self.updateBrother(data);
			}
			else
			{
				console.error('ERROR: Failed to update name & title. Invalid data result.');
			}
		}
	});
};

CharacterScreenDatasource.prototype.commitLevelUpStats = function(_brotherId, _statsIncreaseValues)
{
	var brotherId = _brotherId;
	if (brotherId === null)
	{
		var selectedBrother = this.getSelectedBrother();
		if (selectedBrother === null || !(CharacterScreenIdentifier.Entity.Id in selectedBrother))
		{
			console.error('ERROR: Failed to commit level up stat increase values. No entity selected.');
			return;
		}

		brotherId = selectedBrother[CharacterScreenIdentifier.Entity.Id];
	}

	//console.info(_statsIncreaseValues);

	var self = this;
	this.notifyBackendCommitStatIncreaseValues(brotherId, _statsIncreaseValues, function (data)
	{
		if (data === undefined || data === null || typeof (data) !== 'object')
		{
			console.error('ERROR: Failed to commit level up stat increase values. Invalid data result.');
			return;
		}

		// check if we have an error
		if (ErrorCode.Key in data)
		{
			self.notifyEventListener(ErrorCode.Key, data[ErrorCode.Key]);
		}
		else
		{
			// find the brother and update him
			if (CharacterScreenIdentifier.Entity.Id in data)
			{
				self.updateBrother(data);
			}
			else
			{
				console.error('ERROR: Failed to commit level up stat increase values. Invalid data result.');
			}
		}
	});
};

CharacterScreenDatasource.prototype.updateFormationName = function(_src, _name)
{
	var self = this;
	this.notifyBackendUpdateFormationName(_name, function (data)
	{
		if (data === undefined || data === null)
		{
			console.error('ERROR: Failed to update formation name. Invalid data result.');
			return;
		}

		self.mFormationName = data;
		self.notifyEventListener(CharacterScreenDatasourceIdentifier.Inventory.FormationName,  self.mFormationName);
	});
};

CharacterScreenDatasource.prototype.getMaxBrothers = function ()
{
	return this.mMaxBrothers;
}

CharacterScreenDatasource.prototype.getFrontlineData = function()
{
	return this.mFrontlineData;
}

/*CharacterScreenDatasource.prototype.notifyBackendQueryBrothersList = function ()
{
	if (this.mSQHandle !== null)
	{
		return SQ.call(this.mSQHandle, 'onQueryBrothersList');
	}
	return null;
};*/

CharacterScreenDatasource.prototype.notifyBackendSortButtonClicked = function ()
{
	SQ.call(this.mSQHandle, 'onSortButtonClicked');
}

/*CharacterScreenDatasource.prototype.notifyBackendQueryStashList = function ()
{
	if (this.mSQHandle !== null)
	{
		return SQ.call(this.mSQHandle, 'onQueryStashList');
	}
	return null;
};*/

/*CharacterScreenDatasource.prototype.notifyBackendQueryPerkTrees = function ()
{
	if (this.mSQHandle !== null)
	{
		return SQ.call(this.mSQHandle, 'onQueryPerkTrees');
	}
	return null;
};*/

CharacterScreenDatasource.prototype.notifyBackendQueryPerkInformation = function (_perkId, _background, _callback)
{
	SQ.call(this.mSQHandle, 'onQueryPerkInformation', [_perkId, _background], _callback);
};

CharacterScreenDatasource.prototype.notifyBackendUnlockPerk = function (_brotherId, _perkId, _callback)
{
	SQ.call(this.mSQHandle, 'onUnlockPerk', [_brotherId, _perkId], _callback);
};

CharacterScreenDatasource.prototype.notifyBackendUpdateNameAndTitle = function (_brotherId, _name, _title, _callback)
{
	SQ.call(this.mSQHandle, 'onUpdateNameAndTitle', [_brotherId, _name, _title], _callback);
};

CharacterScreenDatasource.prototype.notifyBackendUpdateFormationName = function (_name, _callback)
{
	SQ.call(this.mSQHandle, 'onUpdateFormationName', [_name], _callback);
};

CharacterScreenDatasource.prototype.notifyBackendCommitStatIncreaseValues = function (_brotherId, _statsIncreaseValues, _callback)
{
	// NOTE: (js) Convert Object to array..as we cannot deliver objects with a function call to the backend... thanks Awesomium...
	var increaseValues = [];
	increaseValues.push(_statsIncreaseValues[CharacterScreenIdentifier.Entity.Character.LevelUp.HitpointsIncrease]);
	increaseValues.push(_statsIncreaseValues[CharacterScreenIdentifier.Entity.Character.LevelUp.BraveryIncrease]);
	increaseValues.push(_statsIncreaseValues[CharacterScreenIdentifier.Entity.Character.LevelUp.FatigueIncrease]);
	increaseValues.push(_statsIncreaseValues[CharacterScreenIdentifier.Entity.Character.LevelUp.InitiativeIncrease]);
	increaseValues.push(_statsIncreaseValues[CharacterScreenIdentifier.Entity.Character.LevelUp.MeleeSkillIncrease]);
	increaseValues.push(_statsIncreaseValues[CharacterScreenIdentifier.Entity.Character.LevelUp.RangeSkillIncrease]);
	increaseValues.push(_statsIncreaseValues[CharacterScreenIdentifier.Entity.Character.LevelUp.MeleeDefenseIncrease]);
	increaseValues.push(_statsIncreaseValues[CharacterScreenIdentifier.Entity.Character.LevelUp.RangeDefenseIncrease]);

	SQ.call(this.mSQHandle, 'onCommitStatsIncreaseValues', [_brotherId, increaseValues], _callback);
};

CharacterScreenDatasource.prototype.notifyBackendSwapInventoryItem = function (_sourceItemIdx, _targetItemIdx, tryToUpgrade, _callback)
{
	SQ.call(this.mSQHandle, 'onSwapInventoryItem', [_sourceItemIdx, _targetItemIdx, tryToUpgrade], _callback);
};

/*CharacterScreenDatasource.prototype.notifyBackendDestroyInventoryItem = function (_brotherId, _sourceItemId)
{
	if (this.mSQHandle !== null)
	{
		return SQ.call(this.mSQHandle, 'onDestroyInventoryItem', [_brotherId, _sourceItemId]);
	}
	return null;
};*/

CharacterScreenDatasource.prototype.notifyBackendToggleInventoryItem = function (_sourceItemId, _entityId, _callback)
{
	SQ.call(this.mSQHandle, 'onToggleInventoryItem', [_sourceItemId, _entityId], _callback);
};

CharacterScreenDatasource.prototype.notifyBackendEquipInventoryItem = function (_brotherId, _sourceItemId, _sourceItemIdx, _callback)
{
	SQ.call(this.mSQHandle, 'onEquipInventoryItem', [_brotherId, _sourceItemId, _sourceItemIdx], _callback);
};

CharacterScreenDatasource.prototype.notifyBackendDropInventoryItemIntoBag = function (_brotherId, _sourceItemId, _sourceItemIdx, _targetItemIdx, _callback)
{
	SQ.call(this.mSQHandle, 'onDropInventoryItemIntoBag', [_brotherId, _sourceItemId, _sourceItemIdx, _targetItemIdx], _callback);
};

CharacterScreenDatasource.prototype.notifyBackendDropBagItemIntoInventory = function (_brotherId, _sourceItemId, _sourceItemIdx, _targetItemIdx, _callback)
{
	SQ.call(this.mSQHandle, 'onDropBagItemIntoInventory', [_brotherId, _sourceItemId, _sourceItemIdx, _targetItemIdx], _callback);
};

CharacterScreenDatasource.prototype.notifyBackendEquipBagItem = function (_brotherId, _sourceItemId, _sourceItemIdx, _callback)
{
	SQ.call(this.mSQHandle, 'onEquipBagItem', [_brotherId, _sourceItemId, _sourceItemIdx], _callback);
};

CharacterScreenDatasource.prototype.notifyBackendSwapBagItem = function (_brotherId, _sourceItemIdx, _targetItemIdx, _callback)
{
	SQ.call(this.mSQHandle, 'onSwapBagItem', [_brotherId, _sourceItemIdx, _targetItemIdx], _callback);
};

CharacterScreenDatasource.prototype.notifyBackendDropPaperdollItem = function (_brotherId, _sourceItemId, _targetItemIdx, _callback)
{
	SQ.call(this.mSQHandle, 'onDropPaperdollItem', [_brotherId, _sourceItemId, _targetItemIdx], _callback);
};

CharacterScreenDatasource.prototype.notifyBackendDropPaperdollItemIntoBag = function (_brotherId, _sourceItemId, _targetItemIdx, _callback)
{
	SQ.call(this.mSQHandle, 'onDropPaperdollItemIntoBag', [_brotherId, _sourceItemId, _targetItemIdx], _callback);
};

CharacterScreenDatasource.prototype.notifyBackendStartBattleButtonClicked = function ()
{
	SQ.call(this.mSQHandle, 'onStartBattleButtonClicked');
};

CharacterScreenDatasource.prototype.notifyBackendCloseButtonClicked = function ()
{
	SQ.call(this.mSQHandle, 'onCloseButtonClicked');
};

CharacterScreenDatasource.prototype.notifyBackendPopupDialogIsVisible = function (_visible)
{
	this.mIsPopupOpen = _visible;
	SQ.call(this.mSQHandle, 'onPopupDialogIsVisible', [_visible]);
};

CharacterScreenDatasource.prototype.notifyBackendDismissCharacter = function (_payCompensation)
{
	var activeCharacterID = this.mBrothersList[this.mSelectedBrotherIndex]['id'];
	SQ.call(this.mSQHandle, 'onDismissCharacter', [ activeCharacterID, _payCompensation ]);
};

CharacterScreenDatasource.prototype.notifyBackendToggleReservesCharacter = function ()
{
	var self = this;
	var activeCharacterID = this.mBrothersList[this.mSelectedBrotherIndex]['id'];
	SQ.call(this.mSQHandle, 'onToggleReserveCharacter', activeCharacterID, function (_data) {
		self.updateBrother(_data);
	});
};

CharacterScreenDatasource.prototype.notifyBackendFilterAllButtonClicked = function ()
{
	SQ.call(this.mSQHandle, 'onFilterAll');
};

CharacterScreenDatasource.prototype.notifyBackendFilterWeaponsButtonClicked = function ()
{
	SQ.call(this.mSQHandle, 'onFilterWeapons');
};

CharacterScreenDatasource.prototype.notifyBackendFilterArmorButtonClicked = function ()
{
	SQ.call(this.mSQHandle, 'onFilterArmor');
};

CharacterScreenDatasource.prototype.notifyBackendFilterMiscButtonClicked = function ()
{
	SQ.call(this.mSQHandle, 'onFilterMisc');
};

CharacterScreenDatasource.prototype.notifyBackendFilterUsableButtonClicked = function () {
	SQ.call(this.mSQHandle, 'onFilterUsable');
};

CharacterScreenDatasource.prototype.notifyBackendDiceThrow = function ()
{
	SQ.call(this.mSQHandle, 'onDiceThrow');
};

CharacterScreenDatasource.prototype.notifyBackendUpdateRosterPosition = function (_id, _pos)
{
	SQ.call(this.mSQHandle, 'onUpdateRosterPosition', [ _id, _pos ]);
};

CharacterScreenDatasource.prototype.notifyBackendFormationClicked = function (_formationIndex) {
	SQ.call(this.mSQHandle, 'onFormationChanged', [_formationIndex]);
};

CharacterScreenDatasource.prototype.notifyBackendClearFormationButtonClicked = function (_formationIndex) {
	SQ.call(this.mSQHandle, 'onFormationClear', [_formationIndex]);
};
CharacterScreenDatasource.prototype.notifyBackendRemoveInventoryItemUpgrades = function (_slot)
{
	var self = this;
	SQ.call(this.mSQHandle, 'removeInventoryItemUpgrades', [_slot], function (data) {
		if (data === undefined || data == null || typeof (data) !== 'object')
		{
			console.error('ERROR: Failed to drop paperdoll item into bag. Invalid data result.');
			return;
		}

		// check if we have an error
		if (ErrorCode.Key in data)
		{
			self.notifyEventListener(ErrorCode.Key, data[ErrorCode.Key]);
		}

		//Still try to do the rest as error can be no stash space when removing multiple layers
		if ('stashSpaceUsed' in data)
			self.mStashSpaceUsed = data.stashSpaceUsed;

		if ('stashSpaceMax' in data)
			self.mStashSpaceMax = data.stashSpaceMax;

		self.mInventoryModule.updateSlotsLabel();

		if (CharacterScreenIdentifier.QueryResult.Stash in data)
		{
			var stashData = data[CharacterScreenIdentifier.QueryResult.Stash];
			if (stashData !== null && jQuery.isArray(stashData))
			{
				stashData.forceUpdate = _slot;
				self.updateStash(stashData);
			}
			else
			{
				console.error('ERROR: Failed to equip inventory item. Invalid stash data result.');
			}
		}

	});
};
CharacterScreenDatasource.prototype.notifyBackendRemovePaperdollItemUpgrades = function (_brotherId, _sourceItemId)
{
	var brotherId = _brotherId;
	if (brotherId === null)
	{
		var selectedBrother = this.getSelectedBrother();
		if (selectedBrother === null || !(CharacterScreenIdentifier.Entity.Id in selectedBrother))
		{
			console.error('ERROR: Failed to remove paperdoll item layers. No entity selected.');
			return;
		}

		brotherId = selectedBrother[CharacterScreenIdentifier.Entity.Id];
	}

	var self = this;

	SQ.call(this.mSQHandle, 'removePaperdollItemUpgrades', [brotherId, _sourceItemId], function (data) {
		if (data === undefined || data == null || typeof (data) !== 'object')
		{
			console.error('ERROR: Failed to remove Paperdoll Item Upgrades. Invalid data result.');
			return;
		}

		//Still try to do the rest as error can be no stash space when removing multiple layers
		if (ErrorCode.Key in data)
		{
			self.notifyEventListener(ErrorCode.Key, data[ErrorCode.Key]);
		}
		if ('stashSpaceUsed' in data)
			self.mStashSpaceUsed = data.stashSpaceUsed;

		if ('stashSpaceMax' in data)
			self.mStashSpaceMax = data.stashSpaceMax;

		self.mInventoryModule.updateSlotsLabel();

		if (CharacterScreenIdentifier.QueryResult.Stash in data)
		{
			var stashData = data[CharacterScreenIdentifier.QueryResult.Stash];
			if (stashData !== null && jQuery.isArray(stashData))
			{
				self.updateStash(stashData);
			}
		}
		if (CharacterScreenIdentifier.QueryResult.Brother in data)
		{
			var brotherData = data[CharacterScreenIdentifier.QueryResult.Brother];
			if (CharacterScreenIdentifier.Entity.Id in brotherData)
			{
				self.updateBrother(brotherData);
			}
		}
	});
};

CharacterScreenDatasource.prototype.notifyBackendRemoveUpgrade = function (_type, _slot)
{
	var self = this;
	var activeCharacterID = this.mBrothersList[this.mSelectedBrotherIndex]['id'];
	SQ.call(this.mSQHandle, 'onRemoveUpgrade', [_slot, activeCharacterID, _type], function (data) {
		if (data === undefined || data == null || typeof (data) !== 'object')
		{
			console.error('ERROR: Failed to remove upgrade. Invalid data result.');
			return;
		}

		// check if we have an error
		if (ErrorCode.Key in data)
		{
			self.notifyEventListener(ErrorCode.Key, data[ErrorCode.Key]);
		}
		else
		{
			if ('stashSpaceUsed' in data)
				self.mStashSpaceUsed = data.stashSpaceUsed;

			if ('stashSpaceMax' in data)
				self.mStashSpaceMax = data.stashSpaceMax;

			self.mInventoryModule.updateSlotsLabel();

			if (CharacterScreenIdentifier.QueryResult.Stash in data)
			{
				var stashData = data[CharacterScreenIdentifier.QueryResult.Stash];
				if (stashData !== null && jQuery.isArray(stashData))
				{
					self.updateStash(stashData);
				}
				else
				{
					console.error('ERROR: Failed to equip inventory item. Invalid stash data result.');
				}
			}

			if (CharacterScreenIdentifier.QueryResult.Brother in data)
			{
				var brotherData = data[CharacterScreenIdentifier.QueryResult.Brother];
				if (CharacterScreenIdentifier.Entity.Id in brotherData)
				{
					self.updateBrother(brotherData);
				}
				else
				{
					console.error('ERROR: Failed to equip inventory item. Invalid brother data result.');
				}
			}
		}
	});
};

CharacterScreenDatasource.prototype.notifyBackendToggleUpgradeVisible = function (_type, _slot)
{
	var self = this;
	var activeCharacterID = this.mBrothersList[this.mSelectedBrotherIndex]['id'];
	SQ.call(this.mSQHandle, 'onToggleUpgradeVisibility', [_slot, activeCharacterID, _type], function (data) {

		if (data === undefined || data == null || typeof (data) !== 'object')
		{
			console.error('ERROR: Failed to toggle visibility of Paperdoll Item Upgrade. Invalid data result.');
			return;
		}

		// check if we have an error
		if (ErrorCode.Key in data)
		{
			self.notifyEventListener(ErrorCode.Key, data[ErrorCode.Key]);
		}
		else
		{

			if (CharacterScreenIdentifier.QueryResult.Brother in data)
			{
				var brotherData = data[CharacterScreenIdentifier.QueryResult.Brother];
				if (CharacterScreenIdentifier.Entity.Id in brotherData)
				{
					self.updateBrother(brotherData);
				}
				else
				{
					console.error('ERROR: Failed to toggle visibility of Paperdoll Item Upgrade. Invalid brother data result.');
				}
			}
		}
	});
};


CharacterScreenDatasource.prototype.notifyBackendAssignRider = function (_rider, _horse, _callback)
{
	SQ.call(this.mSQHandle, 'onAssignRider', [ _rider, _horse ], _callback);
};
