::mods_hookExactClass("ui/screens/tactical/tactical_combat_result_screen", function (o) {

	o.getStashChangeData <- function () {
		local ret = {
			popup = false,
			deletedNum = 0
		};
		local capacity = ::Stash.getCapacity();
		local current = "State" in ::World ? ::World.State.getPlayer().calculateStashModifier(false) : capacity;

		if (capacity > current) {
			for (local i = current - 1; i < capacity - 1; i++) {
				if (::Stash.getItemAtIndex(i).item != null) {
					ret.deletedNum += 1;
				}
			}
			ret.popup = ret.deletedNum != 0;
		}

		return ret;
	}

	o.onSortButtonClicked <- function () {
		::Stash.sort();
		this.loadStashList();
	}

	o.general_onUpgradeInventoryItem <- function (_data) {
		local data = ::Legends.Inventory.queryStashItemDataByIndex(_data[0], _data[2]);

		if ("error" in data) {
			return data;
		}

		local isErrored = ::Legends.Inventory.onUpgradeInventoryItem(data);
		if (isErrored != null) {
			return isErrored;
		}

		return {
			stash = this.UIDataHelper.convertStashToUIData(true),
			foundLoot = this.UIDataHelper.convertCombatResultLootToUIData()
		};
	}

	o.removeInventoryItemUpgrades <- function (_data) {
		local armor = ::Stash.getItemAtIndex(_data[0]).item;
		return this.removeAllUpgradesFromItem(armor);
	}

	o.removeAllUpgradesFromItem <- function (_item, _entity = null) {
		local isErrored = ::Legends.Inventory.removeAllUpgradesFromItem(_item, _entity);
		if (isErrored != null) {
			return isErrored;
		}
		return this.UIDataHelper.convertStashToUIData(true);
	}

	local onLootAllItemsButtonPressed = o.onLootAllItemsButtonPressed;
	o.onLootAllItemsButtonPressed = function () {
		local loot = ::Tactical.CombatResultLoot.getItems();

		// eat supplies
		::World.Assets.refillAmmo();
		for (local i = 0; i < loot.len(); i++) {
			local item = loot[i];
			if (item != null && item.isItemType(::Const.Items.ItemType.Supply)) {
				item.consume();
				loot[i] = null;
			}
		}

		foreach (idx, _ in loot) {
			this.applyAutomationStateEffectsOnLoot(::Tactical.CombatResultLoot.getItemAtIndex(idx));
		}
		return onLootAllItemsButtonPressed();
	}

	local onSwapItem = o.onSwapItem;
	o.onSwapItem = function (_data) {
		local sourceItemOwner = _data[1];
		local targetItemOwner = _data[3];
		local ownerPlayer = "tactical-combat-result-screen.stash";
		local ownerLoot = "tactical-combat-result-screen.found-loot";
		local sourceItemIdx = _data[0];
		local targetItemIdx = _data[2];

		if (_data[4] && sourceItemOwner == ownerPlayer && targetItemOwner == ownerPlayer) {
			return this.general_onUpgradeInventoryItem(_data);
		}

		// eat supplies
		if (sourceItemOwner == ownerLoot && (targetItemIdx == null || targetItemOwner == ownerPlayer)) {
			local sourceItem = ::Tactical.CombatResultLoot.getItemAtIndex(sourceItemIdx).item;
			if (sourceItem.isItemType(::Const.Items.ItemType.Supply)) {
				::World.Assets.refillAmmo();
				sourceItem.consume();
				::Tactical.CombatResultLoot.removeByIndex(sourceItemIdx);
				if (sourceItem.getID() != "supplies.money") {
					sourceItem.playInventorySound(::Const.Items.InventoryEventType.PlacedInBag);
				}
				return {
					stash = ::UIDataHelper.convertStashToUIData(true),
					foundLoot = ::UIDataHelper.convertCombatResultLootToUIData()
				};
			}
		} else if (targetItemOwner == ownerLoot && targetItemIdx != null && sourceItemOwner == ownerPlayer) {
			local targetItem = ::Tactical.CombatResultLoot.getItemAtIndex(targetItemIdx).item;
			if (targetItem.isItemType(::Const.Items.ItemType.Supply)) {
				::World.Assets.refillAmmo();
				targetItem.consume();
				local sourceItem = ::Stash.getItemAtIndex(sourceItemIdx).item;
				::Tactical.CombatResultLoot.insert(sourceItem, targetItemIdx);
				::Stash.removeByIndex(sourceItemIdx);
				sourceItem.playInventorySound(::Const.Items.InventoryEventType.PlacedInBag);
				return {
					stash = ::UIDataHelper.convertStashToUIData(true),
					foundLoot = ::UIDataHelper.convertCombatResultLootToUIData()
				};
			}
		}

		return onSwapItem(_data);
	}

	o.applyAutomationStateEffectsOnLoot <- function (_itemWrapper) {
		if (_itemWrapper != null && _itemWrapper.item != null) {
			local item = _itemWrapper.item;
			::Legends.Inventory.applyAutomationStateEffects(item, 0, ::Legends.Inventory.getCompositeAutomationState(item));
		}
	}

	o.sortByValueForLoot <- function (_array) {
		_array.sort(function (a, b) {
			if (a.isNamed && !b.isNamed) {
				return -1;
			}
			if (!a.isNamed && b.isNamed) {
				return 1;
			}
			if (a.val > b.val) {
				return -1;
			}
			if (a.val < b.val) {
				return 1;
			}
			return 0;
		});
	}

	o.onValueLootItemsButtonPressed <- function () {
		::Sound.play("sounds/combat/armor_leather_impact_01.wav", ::Const.Sound.Volume.Inventory);

		local loot = ::Tactical.CombatResultLoot.getItems();
		local stash = ::Stash.getItems();

		// eat supplies
		::World.Assets.refillAmmo();
		for (local i = 0; i < loot.len(); i++) {
			local item = loot[i];
			if (item != null && item.isItemType(::Const.Items.ItemType.Supply)) {
				item.consume();
				loot[i] = null;
			}
		}

		local stashSlots = [];
		local pool = [];

		// create the combined loot pool
		for (local i = 0; i < stash.len(); i++) {
			local item = stash[i];
			if (item == null) {
				stashSlots.push(i);
			} else if (!item.isItemType(::Const.Items.ItemType.Food) && !item.isNamed() && !item.isItemType(::Const.Items.ItemType.Quest)) {
				stashSlots.push(i);
				pool.push({
					item = item,
					isLoot = false,
					stashIdx = i,
					isNamed = false,
					val = item.getValue()
				});
			}
		}

		for (local i = 0; i < loot.len(); i++) {
			local item = loot[i];
			if (item != null && !item.isItemType(::Const.Items.ItemType.Food)) {
				pool.push({
					item = item,
					isLoot = true,
					lootIdx = i,
					isNamed = item.isNamed(),
					val = item.getValue()
				});
			}
		}

		this.sortByValueForLoot(pool);

		// move items
		for (local i = pool.len() - 1; i >= 0; i--) {
			local item = pool[i];
			if (i >= stashSlots.len()) {
				if (!item.isLoot) {
					loot.push(item.item);
					stash[item.stashIdx] = null;
				}
			} else {
				if (item.isLoot) {
					::Stash.add(item.item);
					loot[item.lootIdx] = null;
				}
			}
		}

		::Tactical.CombatResultLoot.shrink();

		return {
			stash = ::UIDataHelper.convertStashToUIData(true),
			foundLoot = ::UIDataHelper.convertCombatResultLootToUIData()
		};
	}

	// unlocks the inventory temporarily, dumps the loot inside, unlayers, sorts by named and value potential, layers most expensive on most expensive, removes surplus back to loot, locks inventory back | owned food and quest stuff stays untouched
	o.onPotentialValueLootItemsButtonPressed <- function () {
		::Sound.play("sounds/combat/armor_leather_impact_01.wav", ::Const.Sound.Volume.Inventory);

		local loot = ::Tactical.CombatResultLoot.getItems();
		local stash = ::Stash.getItems();

		// eat supplies
		::World.Assets.refillAmmo();
		for (local i = 0; i < loot.len(); i++) {
			local item = loot[i];
			if (item != null && item.isItemType(::Const.Items.ItemType.Supply)) {
				item.consume();
				loot[i] = null;
			}
		}

		::Stash.setResizable(true);

		// dump all but food into stash
		for (local i = 0; i < loot.len(); i++) {
			local item = loot[i];
			if (item != null && !item.isItemType(::Const.Items.ItemType.Food)) {
				::Stash.add(item);
				loot[i] = null;
			}
		}
		::Tactical.CombatResultLoot.shrink();

		// unlayer everything
		for (local i = 0; i < stash.len(); i++) {
			local item = stash[i];
			if (item != null && ::Legends.Inventory.isItemLayered(item)) {
				foreach (slotIdx, upg in item.m.Upgrades) {
					if (upg != null) {
						local removed = item.removeUpgrade(slotIdx, true);
						if (removed != null) {
							::Stash.add(removed);
						}
					}
				}
			}
		}

		// food and quest into illegal, the rest into the pool
		local illegal = [];
		local pool = [];

		for (local i = 0; i < stash.len(); i++) {
			local item = stash[i];
			if (item == null) {
				continue;
			}

			if (item.isItemType(::Const.Items.ItemType.Food) || item.isItemType(::Const.Items.ItemType.Quest)) {
				illegal.push(item);
			} else {
				pool.push({
					item = item,
					isNamed = item.isNamed(),
					val = ::Legends.Inventory.getItemValuePotential(item)
				});
			}
			stash[i] = null;
		}

		// put illegal on top, the rest below ordered by value for loot, then layer (the most expensive on the most expensive)
		this.sortByValueForLoot(pool);
		foreach (item in illegal) {
			::Stash.add(item);
		}
		foreach (item in pool) {
			::Stash.add(item.item);
		}
		::Legends.Inventory.organizeLayeredItems(false, true);

		// sort by value again now that stuff was combined to see what's what fr
		local finalPool = [];
		for (local i = 0; i < stash.len(); i++) {
			local item = stash[i];
			if (item == null || item.isItemType(::Const.Items.ItemType.Food) || item.isNamed() || item.isItemType(::Const.Items.ItemType.Quest)) {
				continue;
			}

			finalPool.push({
				item = item,
				isNamed = false,
				val = ::Legends.Inventory.getItemValuePotential(item)
			});

			stash[i] = null;
		}

		this.sortByValueForLoot(finalPool);

		local stashCount = 0;
		foreach (item in stash) {
			if (item != null) {
				stashCount++;
			}
		}
		local availableSlots = ::Legends.Stash.getSize() - stashCount;

		for (local i = 0; i < finalPool.len(); i++) {
			if (i < availableSlots) {
				::Stash.add(finalPool[i].item);
			} else {
				::Tactical.CombatResultLoot.add(finalPool[i].item);
			}
		}

		::Stash.setResizable(false);
		::Legends.Stash.resize();

		return {
			stash = ::UIDataHelper.convertStashToUIData(true),
			foundLoot = ::UIDataHelper.convertCombatResultLootToUIData()
		};
	}

	o.onOrganizeLayeredItems <- function () {
		::Legends.Inventory.organizeLayeredItems();

		return {
			stash = ::UIDataHelper.convertStashToUIData(true),
			foundLoot = ::UIDataHelper.convertCombatResultLootToUIData()
		};
	}
});
