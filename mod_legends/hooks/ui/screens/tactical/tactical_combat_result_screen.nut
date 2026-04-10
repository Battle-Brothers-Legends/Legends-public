::mods_hookExactClass("ui/screens/tactical/tactical_combat_result_screen", function(o) {

	o.getStashChangeData <- function ()
	{
		local ret = {
			popup = false,
			deletedNum = 0
		};
		local capacity = this.Stash.getCapacity();
		local current = "State" in ::World ? this.World.State.getPlayer().calculateStashModifier(false) : capacity;

		if (capacity > current)
		{
			for (local i = current - 1 ; i < capacity - 1; i = ++i)
			{
				if (this.Stash.getItemAtIndex(i).item != null)
				{
					ret.deletedNum += 1;
				}
			}
			ret.popup = ret.deletedNum != 0;
		}

		return ret;
	}

	o.onSortButtonClicked <- function() {
		this.Stash.sort();
		this.loadStashList();
	}

	
	o.general_onUpgradeInventoryItem <- function (_data) {
		local data = this.helper_queryStashItemDataByIndex(_data[0], _data[2]);
		if ("error" in data) {
			return data;
		}
		local upgrade = data.stash.upgrade(data.sourceIndex, data.targetIndex);
		
		if (upgrade) {
			//only remove item if it wasn't switched out for another upgrade
			if (typeof upgrade == "table") {
				data.stash.removeByIndex(upgrade.index);
				if (upgrade.item != null) {
					this.World.Assets.getStash().insert(upgrade.item, upgrade.index);
				}
			} else {
				data.stash.removeByIndex(data.sourceIndex);
			}			
		} else {
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToAcquireStash);
		}
		local result = {
			stash = this.UIDataHelper.convertStashToUIData(true),
			foundLoot = this.UIDataHelper.convertCombatResultLootToUIData()
		};
		return result;
	}

	o.removeInventoryItemUpgrades <- function (_data) {
		local armor = this.Stash.getItemAtIndex(_data[0]).item;
		return this.removeAllUpgradesFromItem(armor)
	}

	o.removeAllUpgradesFromItem <- function (_item, _entity = null) {
		if (_item != null) {
			local toRemove = [];
			foreach (idx, value in _item.getUpgrades()) {
				if (value != 1 && value != 2 && value != 3) {
					continue;
				}
				toRemove.push(idx);
			}
			if (this.Stash.getNumberOfEmptySlots() < toRemove.len()) {
				return {
					error = this.Const.UI.Error.NotEnoughStashSpace,
					code = this.Const.UI.Error.NotEnoughStashSpace
				};
			}
			if(toRemove.len() > 0) {
				_item.playInventorySound(this.Const.Items.InventoryEventType.Equipped);
			}
			foreach (idx in toRemove) {
				local upgrade = _item.getUpgrade(idx);
				if (upgrade.isDestroyedOnRemove()) {
					continue;
				}
				this.Stash.add(_item.removeUpgrade(idx));
			}
		}
		return this.UIDataHelper.convertStashToUIData(true);
	}

	local onSwapItem = o.onSwapItem;
	o.onSwapItem = function (_data) {
		local ownerPlayer = "tactical-combat-result-screen.stash";

		if (_data[4] && _data[1] == ownerPlayer && _data[3] == ownerPlayer) {
			return this.general_onUpgradeInventoryItem(_data);
		}

		return onSwapItem(_data);
	}

	function helper_queryStashItemDataByIndex( _sourceIndex, _targetIndex )	{
		local stash = this.World.Assets.getStash();
		if (stash == null) {
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToAcquireStash);
		}

		local sourceItem = stash.getItemAtIndex(_sourceIndex);

		if (sourceItem == null) {
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToEquipStashItem);
		}

		local targetItem;

		if (_targetIndex != null) {
			targetItem = stash.getItemAtIndex(_targetIndex);
		}

		return {
			stash = stash,
			sourceItem = sourceItem.item,
			sourceIndex = _sourceIndex,
			targetItem = targetItem,
			targetIndex = _targetIndex
		};
	}

	function helper_convertErrorToUIData( _errorCode ) {
		local errorString = "Undefined error.";

		switch(_errorCode) {
		case this.Const.CharacterScreen.ErrorCode.FailedToAcquireStash:
			errorString = "Failed to acquire stash.";
			break;

		case this.Const.CharacterScreen.ErrorCode.FailedToEquipStashItem:
			errorString = "Failed to equip stash item.";
			break;
		}

		return {
			error = errorString,
			code = _errorCode
		};
	}
});
