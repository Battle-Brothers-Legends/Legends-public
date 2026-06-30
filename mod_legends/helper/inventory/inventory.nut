::Legends.Inventory <- {};

::Legends.Inventory.isItemLayered <- function (_item) {
	return ::isKindOf(_item, "legend_armor") || ::isKindOf(_item, "legend_helmet");
}

::Legends.Inventory.onUpgradeInventoryItem  <- function (_data) {
	local upgrade = _data.stash.upgrade(_data.sourceIndex, _data.targetIndex);

	if (upgrade) {
		//only remove item if it wasn't switched out for another upgrade
		if (typeof upgrade == "table") {
			_data.stash.removeByIndex(upgrade.index);
			if (upgrade.item != null) {
				_data.stash.insert(upgrade.item, upgrade.index);
			}
		} else {
			_data.stash.removeByIndex(_data.sourceIndex);
		}
		local targetItem = _data.stash.getItemAtIndex(_data.targetIndex).item;
		if (targetItem != null) {
			::Legends.Inventory.applyAutomationStateEffects(targetItem, _data.targetIndex, ::Legends.Inventory.getCompositeAutomationState(targetItem));
		}
	} else {
		return {
				error = "Failed to acquire stash."
				code = ::Const.CharacterScreen.Error.FailedToAcquireStash
			};
	}
	return null;
};

::Legends.Inventory.removeAllUpgradesFromItem <- function (_item, _entity = null) {
	if (_item != null) {
		local toRemove = [];
		foreach (idx, value in _item.getUpgrades()) {
			if (value != 1 && value != 2 && value != 3) {
				continue;
			}
			toRemove.push(idx);
		}
		if (::Stash.getNumberOfEmptySlots() < toRemove.len()) {
			return {
				error = "Not enough stash space.",
				code = ::Const.UI.Error.NotEnoughStashSpace
			};
		}
		if (toRemove.len() > 0) {
			_item.playInventorySound(this.Const.Items.InventoryEventType.Equipped);
		}
		foreach (idx in toRemove) {
			local upgrade = _item.getUpgrade(idx);
			upgrade.setTransactionPrice(null);
			if (upgrade.isDestroyedOnRemove()) {
				continue;
			}
			this.Stash.add(_item.removeUpgrade(idx));
		}
		::Legends.Inventory.applyAutomationStateEffects(_item, 0, ::Legends.Inventory.getCompositeAutomationState(_item));
	}
	_item.setTransactionPrice(null);
	return null;
}

::Legends.Inventory.queryStashItemDataByIndex <- function (_sourceIndex, _targetIndex) {
	local stash = ::World.Assets.getStash();
	if (stash == null) {
		return {
				error = "Failed to acquire stash."
				code = ::Const.CharacterScreen.Error.FailedToAcquireStash
			};
	}

	local sourceItem = stash.getItemAtIndex(_sourceIndex);
	if (sourceItem == null) {
		return {
				error = "Failed to equip stash item."
				code = ::Const.CharacterScreen.Error.FailedToEquipStashItem
			};
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
};

::Legends.Inventory.applyAutomationStateEffects <- function (_item, _idx, _state) {	// 0 - nothing, 1 - sell, 2 - repair and sell, 3 - repair, 4 - salvage
	if (_state == 2 || _state == 3) {
		_item.setToBeRepaired(true, _idx);
		_item.setToBeSalvaged(false, 0);
	} else if (_state == 4) {
		_item.setToBeRepaired(false, 0);
		_item.setToBeSalvaged(true, _idx);
	} else {
		_item.setToBeRepaired(false, 0);
		_item.setToBeSalvaged(false, 0);
	}
}

::Legends.Inventory.getCompositeAutomationState <- function (_item, _state = null) {
	local state = _state != null ? _state : ::World.Flags.getAsInt("AutoState_" + _item.getID());
	if (::Legends.Inventory.isItemLayered(_item)) {
		foreach (upg in _item.m.Upgrades) {
			if (upg != null && ::World.Flags.getAsInt("AutoState_" + upg.getID()) != state) {
				state = 0;
				break;
			}
		}
	}
	return state;
}
