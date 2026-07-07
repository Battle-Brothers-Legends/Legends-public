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
		local data = ::Legends.Inventory.queryStashItemDataByIndex(_data[0], _data[2]);

		if ("error" in data) {
			return data;
		}

		local isErrored = ::Legends.Inventory.onUpgradeInventoryItem (data);
		if (isErrored != null) {
			return isErrored;
		}

		return {
			stash = this.UIDataHelper.convertStashToUIData(true),
			foundLoot = this.UIDataHelper.convertCombatResultLootToUIData()
		};
	}

	o.removeInventoryItemUpgrades <- function (_data) {
		local armor = this.Stash.getItemAtIndex(_data[0]).item;
		return this.removeAllUpgradesFromItem(armor)
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

		if (_data[4] && sourceItemOwner == ownerPlayer && targetItemOwner == ownerPlayer) {
			return this.general_onUpgradeInventoryItem(_data);
		}

		return onSwapItem(_data);
	}

	o.applyAutomationStateEffectsOnLoot <- function(_itemWrapper) {
		if (_itemWrapper != null && _itemWrapper.item != null) {
			local item = _itemWrapper.item;
			::Legends.Inventory.applyAutomationStateEffects(item, 0, ::Legends.Inventory.getCompositeAutomationState(item));
		}
	}

	o.onValueLootItemsButtonPressed <- function () {
		::Sound.play("sounds/combat/armor_leather_impact_01.wav", ::Const.Sound.Volume.Inventory);

		local loot = ::Tactical.CombatResultLoot.getItems();
		local stash = ::Stash.getItems();

		// eat supplies
		for (local i = 0; i < loot.len(); i++) {
			local item = loot[i];
			if (item != null && item.isItemType(::Const.Items.ItemType.Supply))	{
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
			} else if (!item.isItemType(::Const.Items.ItemType.Food) && !item.isNamed()) {
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

		pool.sort(function (a, b) {
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
});
