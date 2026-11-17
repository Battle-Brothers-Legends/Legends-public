::Legends.Inventory <- {};

::Legends.Inventory.isItemLayered <- function (_item) {
	return ::isKindOf(_item, "legend_armor") || ::isKindOf(_item, "legend_helmet");
}

::Legends.Inventory.onUpgradeInventoryItem <- function (_data) {
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
			_item.playInventorySound(::Const.Items.InventoryEventType.Equipped);
		}
		foreach (idx in toRemove) {
			local upgrade = _item.getUpgrade(idx);
			upgrade.setTransactionPrice(null);
			if (upgrade.isDestroyedOnRemove()) {
				continue;
			}
			::Stash.add(_item.removeUpgrade(idx));
		}
		::Legends.Inventory.applyAutomationStateEffects(_item, 0, ::Legends.Inventory.getCompositeAutomationState(_item));
	}
	_item.setTransactionPrice(null);
	return null;
}

::Legends.Inventory.queryStashItemDataByIndex <- function (_sourceIndex, _targetIndex) {
	local stash = ("State" in ::Tactical && ::Tactical.State != null && ::Tactical.State.isScenarioMode()) ? ::Stash : ::World.Assets.getStash();
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

::Legends.Inventory.applyAutomationStateEffects <- function (_item, _idx, _state) {
	// 0 - nothing, 1 - sell, 2 - repair and sell, 3 - repair, 4 - salvage
	if ("State" in ::Tactical && ::Tactical.State != null && ::Tactical.State.isScenarioMode()) {
		return;
	}
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
	if ("State" in ::Tactical && ::Tactical.State != null && ::Tactical.State.isScenarioMode()) {
		return null;
	}
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

::Legends.Inventory.organizeLayeredItems <- function (_stripMismatched = false, _ignoreAutomation = false) {
	::Sound.play("sounds/inventory/armor_upgrade_use_01.wav", ::Const.Sound.Volume.Inventory);

	local stash = ::Stash.getItems();
	local bases = [];
	local upgrades = [];

	// create pools of bases and upgrades
	for (local i = 0; i < stash.len(); i++) {
		local item = stash[i];
		if (item == null) {
			continue;
		}

		if (::Legends.Inventory.isItemLayered(item)) {
			bases.push({
				item = item,
				state = ::World.Flags.getAsInt("AutoState_" + item.getID())
			});
		} else if (::isKindOf(item, "legend_armor_upgrade") || ::isKindOf(item, "legend_helmet_upgrade")) {
			upgrades.push({
				item = item,
				state = ::World.Flags.getAsInt("AutoState_" + item.getID())
			});
		}
	}

	// join/switch upgrades
	local i = 0;
	while (i < upgrades.len()) {
		local upgrade = upgrades[i];

		foreach (base_item in bases) {
			if (!_ignoreAutomation && (base_item.state != upgrade.state)) {
				continue;
			}

			if (::isKindOf(base_item.item, "legend_armor") && !::isKindOf(upgrade.item, "legend_armor_upgrade")) {
				continue;
			}
			if (::isKindOf(base_item.item, "legend_helmet") && !::isKindOf(upgrade.item, "legend_helmet_upgrade")) {
				continue;
			}
			if (base_item.item.m.Blocked[upgrade.item.getType()]) {
				continue;
			}

			local layer = upgrade.item.getType();
			if (::isKindOf(base_item.item, "legend_helmet") && layer == ::Const.Items.HelmetUpgrades.Vanity && base_item.item.m.Upgrades[layer] != null) {
				layer = ::Const.Items.HelmetUpgrades.ExtraVanity;
			}

			local equippedUpgrade = base_item.item.m.Upgrades[layer];
			if (equippedUpgrade != null) {
				if (!_ignoreAutomation || (::World.Flags.getAsInt("AutoState_" + equippedUpgrade.getID()) == base_item.state)) {
					continue;
				}
			}
			local result = base_item.item.setUpgrade(upgrade.item);

			if (typeof result == "table") {
				::Stash.removeByIndex(::Stash.getItemByInstanceID(upgrade.item.getInstanceID()).index);

				if (result.item != null) {
					::Stash.add(result.item);
					upgrades.push({
						item = result.item,
						state = ::World.Flags.getAsInt("AutoState_" + result.item.getID())
					});
				}
				break;
			}
		}
		i++;
	}

	// strip mismatched layers on 2nd button
	if (_stripMismatched) {
		foreach (base_item in bases) {
			foreach (slotIdx, upg in base_item.item.m.Upgrades) {
				if (upg != null) {
					local upgState = ::World.Flags.getAsInt("AutoState_" + upg.getID());
					if (upgState != base_item.state) {
						local removed = base_item.item.removeUpgrade(slotIdx);
						if (removed != null) {
							::Stash.add(removed);
						}
					}
				}
			}
		}
	}

	foreach (item in ::Stash.getItems()) {
		if (item != null) {
			::Legends.Inventory.applyAutomationStateEffects(item, 0, ::Legends.Inventory.getCompositeAutomationState(item));
		}
	}
}

// note that the functions below do not take reputation or situations into account
::Legends.Inventory.BasePricePerDurability <- 0.67; // the actual formula is armor_parts_item (m.Value * ::World.Assets.m.ArmorPartsPerArmor / m.Amount); and is set in asset_manager's create

::Legends.Inventory.getCurrentPricePerDurability <- @() ::Legends.Inventory.BasePricePerDurability * ::Const.Difficulty.BuyPriceMult[::World.Assets.getEconomicDifficulty()] * (1.0 - ::World.State.getPlayer().getHaggleMult()) * ::Legends.S.getToolEfficiency();

::Legends.Inventory.getMissingDurability <- @(_item)(_item.getRepairMax() - _item.getRepair());

::Legends.Inventory.getItemRepairCost <- @(_item) ::Legends.Inventory.getMissingDurability(_item) * ::Legends.Inventory.getCurrentPricePerDurability();

::Legends.Inventory.getItemPredictedSalePrice <- function (_item, _value) {
	local value = _value * ::Const.Difficulty.SellPriceMult[::World.Assets.getEconomicDifficulty()] * (1.0 + ::World.State.getPlayer().getHaggleMult());

	if (_item.isItemType(::Const.Items.ItemType.TradeGood)) {
		return value;
	} else if (_item.isItemType(::Const.Items.ItemType.Loot)) {
		return value * ::Const.World.Assets.BaseLootSellPrice;
	}

	return ::Math.floor(value * ::Const.World.Assets.BaseSellPrice);
}

::Legends.Inventory.getItemRepairValuePotential <- @(_item) ::Legends.Inventory.getItemPredictedSalePrice(_item, _item.getRawValue()) - ::Legends.Inventory.getItemRepairCost(_item);

::Legends.Inventory.getItemRepairGoldPerDurability <- @(_item) ::Legends.Inventory.getItemRepairValuePotential(_item) / ::Legends.Inventory.getMissingDurability(_item);

::Legends.Inventory.getItemSalvageToolsRecovered <- @(_item) _item.getRepair() / (::World.Retinue.hasFollower(::Legends.Camp.Upgrades[::Legends.Camp.CampBuildings.Workshop]) ? 10 : 20);

::Legends.Inventory.getItemSalvageValuePotential <- @(_item) ::Legends.Inventory.getItemSalvageToolsRecovered(_item) * ::Legends.Inventory.getCurrentPricePerDurability() / ::World.Assets.m.ArmorPartsPerArmor;

::Legends.Inventory.isItemWorthRepairing <- @(_item) ::Legends.Inventory.getMissingDurability(_item) != 0 && (::Legends.Inventory.getItemRepairGoldPerDurability(_item) >= ::World.Assets.m.RepairPotentialValue / 10);

::Legends.Inventory.isItemWorthSalvaging <- @(_item) _item.canBeSalvaged() && _item.getRepair() != 0 && ((::Legends.Inventory.getItemPredictedSalePrice(_item, _item.getValue()) / ::Legends.Inventory.getItemSalvageToolsRecovered(_item)) < ::World.Assets.m.SalvagePotentialValue);

::Legends.Inventory.getItemValuePotential <- @(_item) (::Legends.Inventory.isItemWorthRepairing(_item) ? ::Legends.Inventory.getItemRepairValuePotential(_item) : (::Legends.Inventory.isItemWorthSalvaging(_item) ? ::Legends.Inventory.getItemSalvageValuePotential(_item) : ::Legends.Inventory.getItemPredictedSalePrice(_item, _item.getValue())));