::mods_hookExactClass("ui/screens/world/modules/world_town_screen/town_shop_dialog_module", function(o) {

	o.onRepairItem = function ( _itemIndex )
	{
		if (!this.m.Shop.isRepairOffered())
		{
			return null;
		}

		local item = ::Stash.getItemAtIndex(_itemIndex).item;

		if (item.getConditionMax() <= 1 || item.getRepair() >= item.getRepairMax())
		{
			return null;
		}

		local price = (item.getRepairMax() - item.getRepair()) * ::Const.World.Assets.CostToRepairPerPoint;
		local value = item.getRawValue() * (1.0 - item.getRepair() / item.getRepairMax()) * 0.2 * ::World.State.getCurrentTown().getPriceMult() * ::Const.Difficulty.SellPriceMult[::World.Assets.getEconomicDifficulty()];
		price = ::Math.max(price, value);

		if (::World.Assets.getMoney() < price)
		{
			return null;
		}

		::World.Assets.addMoney(-price);
		item.setCondition(item.getRepairMax());
		item.setToBeRepaired(false, 0);
		::Sound.play("sounds/ambience/buildings/blacksmith_hammering_0" + ::Math.rand(0, 6) + ".wav", 1.0);
		local result = {
			Item = this.UIDataHelper.convertItemToUIData(item, true, ::Const.UI.ItemOwner.Stash),
			Assets = this.m.Parent.queryAssetsInformation()
		};
		::World.Statistics.getFlags().increment("ItemsRepaired");
		return result;
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

		local result = {
			Result = 0,
			Assets = this.m.Parent.queryAssetsInformation(),
			Shop = [],
			Stash = this.UIDataHelper.convertStashToUIData(false, this.m.InventoryFilter),
			StashSpaceUsed = data.stash.getNumberOfFilledSlots(),
			StashSpaceMax = data.stash.getCapacity(),
			IsRepairOffered = this.m.Shop.isRepairOffered()
		};
		this.UIDataHelper.convertItemsToUIData(this.m.Shop.getStash().getItems(), result.Shop, ::Const.UI.ItemOwner.Shop);
		return result;
	}

	o.removeInventoryItemUpgrades <- function (_data) {
		local armor = ::Stash.getItemAtIndex(_data[0]).item;
		return this.removeAllUpgradesFromItem(armor)
	}

	o.removeAllUpgradesFromItem <- function (_item, _entity = null) {
		local isErrored = ::Legends.Inventory.removeAllUpgradesFromItem(_item, _entity);
		if (isErrored != null) {
			return isErrored;
		}
		return this.UIDataHelper.convertStashAndEntityToUIData(_entity, null, false, this.m.InventoryFilter);
	}

	o.onSwapItem = function ( _data )
	{
		local sourceItemIdx = _data[0];
		local sourceItemOwner = _data[1];
		local targetItemIdx = _data[2];
		local targetItemOwner = _data[3];
		local ownerPlayer = "world-town-screen-shop-dialog-module.stash";
		local ownerShop = "world-town-screen-shop-dialog-module.shop";

		if (_data[4] && sourceItemOwner == ownerPlayer && targetItemOwner == ownerPlayer) {
			return this.general_onUpgradeInventoryItem(_data);
		}

		if (targetItemOwner == null)
		{
			this.logError("onSwapItem #1");
			return null;
		}

		local shopStash = this.m.Shop.getStash();
		local currentMoney = ::World.Assets.getMoney();

		switch(sourceItemOwner)
		{
		case ownerPlayer:
			local sourceItem = ::Stash.getItemAtIndex(sourceItemIdx);

			if (sourceItem == null)
			{
				this.logError("onSwapItem(stash) #2");
				return null;
			}

			if (targetItemIdx != null)
			{
				if (sourceItemOwner == targetItemOwner)
				{
					if (::Stash.swap(sourceItemIdx, targetItemIdx))
					{
						sourceItem.item.playInventorySound(::Const.Items.InventoryEventType.PlacedInBag);
					}
					else
					{
						this.logError("onSwapItem(stash) #3");
						return null;
					}
				}
				else
				{
					this.logError("onSwapItem(stash) #3.1");
					return null;
				}
			}
			else if (sourceItemOwner == targetItemOwner)
			{
				if (!::Stash.isLastTakenSlot(sourceItemIdx))
				{
					local firstEmptySlotIdx = ::Stash.getFirstEmptySlot();

					if (firstEmptySlotIdx != null)
					{
						if (::Stash.swap(sourceItemIdx, firstEmptySlotIdx))
						{
							sourceItem.item.playInventorySound(::Const.Items.InventoryEventType.PlacedInBag);

							// if (sourceItem.item.isItemType(::Const.Items.ItemType.TradeGood))
							// {
							// 	::World.Statistics.getFlags().increment("TradeGoodsSold");
							// }
						}
						else
						{
							this.logError("onSwapItem(stash) #4");
							return null;
						}
					}
				}
			}
			else
			{
				local removedItem = ::Stash.removeByIndex(sourceItemIdx);

				if (removedItem != null)
				{
					removedItem.setTransactionPrice(removedItem.getSellPrice());
					::World.Assets.addMoney(removedItem.getSellPrice());
					removedItem.addSettlementToTradeHistory(this.m.Shop.getSettlement());
					shopStash.add(removedItem);
					removedItem.setSold(true);

					// if (removedItem.isItemType(::Const.Items.ItemType.TradeGood))
					// {
					// 	::World.Statistics.getFlags().increment("TradeGoodsSold");
					// }
				}
			}

			local result = {
				Result = 0,
				Assets = this.m.Parent.queryAssetsInformation(),
				Shop = [],
				Stash = [],
				StashSpaceUsed = ::Stash.getNumberOfFilledSlots(),
				StashSpaceMax = ::Stash.getCapacity(),
				IsRepairOffered = this.m.Shop.isRepairOffered()
			};
			this.UIDataHelper.convertItemsToUIData(this.m.Shop.getStash().getItems(), result.Shop, ::Const.UI.ItemOwner.Shop);
			result.Stash = this.UIDataHelper.convertStashToUIData(false, this.m.InventoryFilter);

			// if (::World.Statistics.getFlags().has("TradeGoodsSold") && ::World.Statistics.getFlags().get("TradeGoodsSold") >= 10)
			// {
			// 	this.updateAchievement("Trader", 1, 1);
			// }

			// if (::World.Statistics.getFlags().has("TradeGoodsSold") && ::World.Statistics.getFlags().get("TradeGoodsSold") >= 50)
			// {
			// 	this.updateAchievement("MasterTrader", 1, 1);
			// }

			return result;

		case ownerShop:
			local sourceItem = shopStash.getItemAtIndex(sourceItemIdx);

			if (sourceItem == null)
			{
				this.logError("onSwapItem(found loot) #2");
				return null;
			}

			if (currentMoney < sourceItem.item.getBuyPrice())
			{
				return {
					Result = ::Const.UI.Error.NotEnoughMoney
				};
			}

			if (targetItemIdx != null)
			{
				if (sourceItemOwner == targetItemOwner)
				{
					return null;
				}
				else
				{
					local targetItem = ::Stash.getItemAtIndex(targetItemIdx);

					if (targetItem != null && targetItem.item == null)
					{
						sourceItem.item.setTransactionPrice(sourceItem.item.getBuyPrice());
						::World.Assets.addMoney(-sourceItem.item.getBuyPrice());
						::Stash.insert(sourceItem.item, targetItemIdx);
						shopStash.removeByIndex(sourceItemIdx);
						sourceItem.item.setBought(true);

						// if (sourceItem.item.isItemType(::Const.Items.ItemType.TradeGood))
						// {
						// 	::World.Statistics.getFlags().increment("TradeGoodsBought");
						// }
					}
					else if (::Stash.hasEmptySlot())
					{
						sourceItem.item.setTransactionPrice(sourceItem.item.getBuyPrice());
						::World.Assets.addMoney(-sourceItem.item.getBuyPrice());
						::Stash.add(sourceItem.item);
						shopStash.removeByIndex(sourceItemIdx);
						sourceItem.item.setBought(true);

						// if (sourceItem.item.isItemType(::Const.Items.ItemType.TradeGood))
						// {
						// 	::World.Statistics.getFlags().increment("TradeGoodsBought");
						// }
					}
					else
					{
						return {
							Result = ::Const.UI.Error.NotEnoughStashSpace
						};
					}
				}
			}
			else if (sourceItemOwner != targetItemOwner)
			{
				if (::Stash.hasEmptySlot())
				{
					sourceItem.item.setTransactionPrice(sourceItem.item.getBuyPrice());
					::World.Assets.addMoney(-sourceItem.item.getBuyPrice());
					::Stash.add(sourceItem.item);
					shopStash.removeByIndex(sourceItemIdx);
					sourceItem.item.setBought(true);

					// if (sourceItem.item.isItemType(::Const.Items.ItemType.TradeGood))
					// {
					// 	::World.Statistics.getFlags().increment("TradeGoodsBought");
					// }
				}
				else
				{
					return {
						Result = ::Const.UI.Error.NotEnoughStashSpace
					};
				}
			}

			local result = {
				Result = 0,
				Assets = this.m.Parent.queryAssetsInformation(),
				Shop = [],
				Stash = [],
				StashSpaceUsed = ::Stash.getNumberOfFilledSlots(),
				StashSpaceMax = ::Stash.getCapacity(),
				IsRepairOffered = this.m.Shop.isRepairOffered()
			};
			this.UIDataHelper.convertItemsToUIData(this.m.Shop.getStash().getItems(), result.Shop, ::Const.UI.ItemOwner.Shop);
			result.Stash = this.UIDataHelper.convertStashToUIData(false, this.m.InventoryFilter);
			return result;
		}

		return null;
	}

	local onCanSwapItem = o.onCanSwapItem;
	o.onCanSwapItem = function (_data) {
		// if not town shop, use vanilla
		if (_data[1] != "world-town-screen-shop-dialog-module.stash")
			return onCanSwapItem(_data);

		local itemWrapper = ::Stash.getItemAtIndex(_data[0]);
		// if item null, use vanilla
		if (itemWrapper == null)
			return onCanSwapItem(_data);

		local ret = onCanSwapItem(_data);
		// if checked, add overlay data to draw a proper icon
		if (::Legends.Mod.ModSettings.getSetting("SellDialogNamed").getValue() && ret.Item != null) {
			ret.Item.slot <- itemWrapper.item.getSlotType();
			ret.Item.imageOverlayPath <- itemWrapper.item.getIconOverlay();
			ret.Item.upgrades <- itemWrapper.item.getUpgrades();
			return ret;
		}

		// little switcheroo to suppress named items in dialog checks
		local orgIsPrecious = itemWrapper.item.isPrecious;
		local orgIsUnique = itemWrapper.item.isUnique;

		itemWrapper.item.isPrecious = @() this.isItemType(::Const.Items.ItemType.Legendary) || this.isItemType(::Const.Items.ItemType.Quest) || this.m.IsPrecious;
		itemWrapper.item.isUnique = @() this.isItemType(::Const.Items.ItemType.Legendary) || this.isItemType(::Const.Items.ItemType.Quest) || this.m.IsUnique;

		itemWrapper.item.isPrecious = orgIsPrecious;
		itemWrapper.item.isUnique = orgIsUnique;

		return ret;
	}

	o.onSellAllButtonClicked <- function (_) {
        local shopStash = this.m.Shop.getStash();
        local stashItems = ::Stash.getItems();
        local itemsSold = 0;
		local totalGold = 0;

        for (local i = 0; i < stashItems.len(); i++) {
            local item = stashItems[i];
            
            if (item == null) {
                continue;
            }

            local state = ::Legends.Inventory.getCompositeAutomationState(item);

            if (state != 1 && state != 2) {
                continue;
            }

            if (state == 1 || (state == 2 && item.getRepair() >= item.getRepairMax())) {
                local removedItem = ::Stash.removeByIndex(i);

                if (removedItem != null) {
                    removedItem.setTransactionPrice(removedItem.getSellPrice());
                    totalGold += removedItem.getSellPrice();
                    removedItem.addSettlementToTradeHistory(this.m.Shop.getSettlement());
                    shopStash.add(removedItem);
                    removedItem.setSold(true);

                    /*if (removedItem.isItemType(::Const.Items.ItemType.TradeGood)) {
                        ::World.Statistics.getFlags().increment("TradeGoodsSold");
                    }*/
                    
                    itemsSold++;
                }
            }
        }

		if (totalGold > 0) {
			::World.Assets.addMoney(totalGold);
		}

        local result = {
            Result = 0,
            Assets = this.m.Parent.queryAssetsInformation(),
            Shop = [],
            Stash = [],
            StashSpaceUsed = ::Stash.getNumberOfFilledSlots(),
            StashSpaceMax = ::Stash.getCapacity(),
            IsRepairOffered = this.m.Shop.isRepairOffered()
        };

        ::UIDataHelper.convertItemsToUIData(shopStash.getItems(), result.Shop, ::Const.UI.ItemOwner.Shop);
        result.Stash = ::UIDataHelper.convertStashToUIData(false, this.m.InventoryFilter);

        if (itemsSold > 0) {
            if (::World.Statistics.getFlags().has("TradeGoodsSold") && ::World.Statistics.getFlags().get("TradeGoodsSold") >= 10) {
                this.updateAchievement("Trader", 1, 1);
            }

            if (::World.Statistics.getFlags().has("TradeGoodsSold") && ::World.Statistics.getFlags().get("TradeGoodsSold") >= 50) {
                this.updateAchievement("MasterTrader", 1, 1);
            }
        }

        return result;
    }
});
