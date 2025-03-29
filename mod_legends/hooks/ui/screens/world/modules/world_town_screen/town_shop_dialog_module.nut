::mods_hookExactClass("ui/screens/world/modules/world_town_screen/town_shop_dialog_module", function(o) {

	o.onRepairItem = function ( _itemIndex )
	{
		if (!this.m.Shop.isRepairOffered())
		{
			return null;
		}

		local item = this.Stash.getItemAtIndex(_itemIndex).item;

		if (item.getConditionMax() <= 1 || item.getRepair() >= item.getRepairMax())
		{
			return null;
		}

		local price = (item.getRepairMax() - item.getRepair()) * this.Const.World.Assets.CostToRepairPerPoint;
		local value = item.getRawValue() * (1.0 - item.getRepair() / item.getRepairMax()) * 0.2 * this.World.State.getCurrentTown().getPriceMult() * this.Const.Difficulty.SellPriceMult[this.World.Assets.getEconomicDifficulty()];
		price = this.Math.max(price, value);

		if (this.World.Assets.getMoney() < price)
		{
			return null;
		}

		this.World.Assets.addMoney(-price);
		item.setCondition(item.getRepairMax());
		item.setToBeRepaired(false, 0);
		this.Sound.play("sounds/ambience/buildings/blacksmith_hammering_0" + this.Math.rand(0, 6) + ".wav", 1.0);
		local result = {
			Item = this.UIDataHelper.convertItemToUIData(item, true, this.Const.UI.ItemOwner.Stash),
			Assets = this.m.Parent.queryAssetsInformation()
		};
		this.World.Statistics.getFlags().increment("ItemsRepaired");
		return result;
	}

	o.onSwapItem = function ( _data )
	{
		local sourceItemIdx = _data[0];
		local sourceItemOwner = _data[1];
		local targetItemIdx = _data[2];
		local targetItemOwner = _data[3];

		if (targetItemOwner == null)
		{
			this.logError("onSwapItem #1");
			return null;
		}

		local shopStash = this.m.Shop.getStash();
		local currentMoney = this.World.Assets.getMoney();

		switch(sourceItemOwner)
		{
		case "world-town-screen-shop-dialog-module.stash":
			local sourceItem = this.Stash.getItemAtIndex(sourceItemIdx);

			if (sourceItem == null)
			{
				this.logError("onSwapItem(stash) #2");
				return null;
			}

			if (targetItemIdx != null)
			{
				if (sourceItemOwner == targetItemOwner)
				{
					if (this.Stash.swap(sourceItemIdx, targetItemIdx))
					{
						sourceItem.item.playInventorySound(this.Const.Items.InventoryEventType.PlacedInBag);
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
				if (!this.Stash.isLastTakenSlot(sourceItemIdx))
				{
					local firstEmptySlotIdx = this.Stash.getFirstEmptySlot();

					if (firstEmptySlotIdx != null)
					{
						if (this.Stash.swap(sourceItemIdx, firstEmptySlotIdx))
						{
							sourceItem.item.playInventorySound(this.Const.Items.InventoryEventType.PlacedInBag);

							// if (sourceItem.item.isItemType(this.Const.Items.ItemType.TradeGood))
							// {
							// 	this.World.Statistics.getFlags().increment("TradeGoodsSold");
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
				local removedItem = this.Stash.removeByIndex(sourceItemIdx);

				if (removedItem != null)
				{
					removedItem.setTransactionPrice(removedItem.getSellPrice());
					this.World.Assets.addMoney(removedItem.getSellPrice());
					removedItem.addSettlementToTradeHistory(this.m.Shop.getSettlement());
					shopStash.add(removedItem);
					removedItem.setSold(true);

					// if (removedItem.isItemType(this.Const.Items.ItemType.TradeGood))
					// {
					// 	this.World.Statistics.getFlags().increment("TradeGoodsSold");
					// }
				}
			}

			local result = {
				Result = 0,
				Assets = this.m.Parent.queryAssetsInformation(),
				Shop = [],
				Stash = [],
				StashSpaceUsed = this.Stash.getNumberOfFilledSlots(),
				StashSpaceMax = this.Stash.getCapacity(),
				IsRepairOffered = this.m.Shop.isRepairOffered()
			};
			this.UIDataHelper.convertItemsToUIData(this.m.Shop.getStash().getItems(), result.Shop, this.Const.UI.ItemOwner.Shop);
			result.Stash = this.UIDataHelper.convertStashToUIData(false, this.m.InventoryFilter);

			// if (this.World.Statistics.getFlags().has("TradeGoodsSold") && this.World.Statistics.getFlags().get("TradeGoodsSold") >= 10)
			// {
			// 	this.updateAchievement("Trader", 1, 1);
			// }

			// if (this.World.Statistics.getFlags().has("TradeGoodsSold") && this.World.Statistics.getFlags().get("TradeGoodsSold") >= 50)
			// {
			// 	this.updateAchievement("MasterTrader", 1, 1);
			// }

			return result;

		case "world-town-screen-shop-dialog-module.shop":
			local sourceItem = shopStash.getItemAtIndex(sourceItemIdx);

			if (sourceItem == null)
			{
				this.logError("onSwapItem(found loot) #2");
				return null;
			}

			if (currentMoney < sourceItem.item.getBuyPrice())
			{
				return {
					Result = this.Const.UI.Error.NotEnoughMoney
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
					local targetItem = this.Stash.getItemAtIndex(targetItemIdx);

					if (targetItem != null && targetItem.item == null)
					{
						sourceItem.item.setTransactionPrice(sourceItem.item.getBuyPrice());
						this.World.Assets.addMoney(-sourceItem.item.getBuyPrice());
						this.Stash.insert(sourceItem.item, targetItemIdx);
						shopStash.removeByIndex(sourceItemIdx);
						sourceItem.item.setBought(true);

						// if (sourceItem.item.isItemType(this.Const.Items.ItemType.TradeGood))
						// {
						// 	this.World.Statistics.getFlags().increment("TradeGoodsBought");
						// }
					}
					else if (this.Stash.hasEmptySlot())
					{
						sourceItem.item.setTransactionPrice(sourceItem.item.getBuyPrice());
						this.World.Assets.addMoney(-sourceItem.item.getBuyPrice());
						this.Stash.add(sourceItem.item);
						shopStash.removeByIndex(sourceItemIdx);
						sourceItem.item.setBought(true);

						// if (sourceItem.item.isItemType(this.Const.Items.ItemType.TradeGood))
						// {
						// 	this.World.Statistics.getFlags().increment("TradeGoodsBought");
						// }
					}
					else
					{
						return {
							Result = this.Const.UI.Error.NotEnoughStashSpace
						};
					}
				}
			}
			else if (sourceItemOwner != targetItemOwner)
			{
				if (this.Stash.hasEmptySlot())
				{
					sourceItem.item.setTransactionPrice(sourceItem.item.getBuyPrice());
					this.World.Assets.addMoney(-sourceItem.item.getBuyPrice());
					this.Stash.add(sourceItem.item);
					shopStash.removeByIndex(sourceItemIdx);
					sourceItem.item.setBought(true);

					// if (sourceItem.item.isItemType(this.Const.Items.ItemType.TradeGood))
					// {
					// 	this.World.Statistics.getFlags().increment("TradeGoodsBought");
					// }
				}
				else
				{
					return {
						Result = this.Const.UI.Error.NotEnoughStashSpace
					};
				}
			}

			local result = {
				Result = 0,
				Assets = this.m.Parent.queryAssetsInformation(),
				Shop = [],
				Stash = [],
				StashSpaceUsed = this.Stash.getNumberOfFilledSlots(),
				StashSpaceMax = this.Stash.getCapacity(),
				IsRepairOffered = this.m.Shop.isRepairOffered()
			};
			this.UIDataHelper.convertItemsToUIData(this.m.Shop.getStash().getItems(), result.Shop, this.Const.UI.ItemOwner.Shop);
			result.Stash = this.UIDataHelper.convertStashToUIData(false, this.m.InventoryFilter);
			return result;
		}

		return null;
	}
});
