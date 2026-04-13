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
				Result = 0,
				Assets = this.m.Parent.queryAssetsInformation(),
				Shop = [],
				Stash = this.UIDataHelper.convertStashToUIData(false, this.m.InventoryFilter),
				StashSpaceUsed = data.stash.getNumberOfFilledSlots(),
				StashSpaceMax = data.stash.getCapacity(),
				IsRepairOffered = this.m.Shop.isRepairOffered()
			};
			this.UIDataHelper.convertItemsToUIData(this.m.Shop.getStash().getItems(), result.Shop, this.Const.UI.ItemOwner.Shop);
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
		local currentMoney = this.World.Assets.getMoney();

		switch(sourceItemOwner)
		{
		case ownerPlayer:
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

	local onCanSwapItem = o.onCanSwapItem;
	o.onCanSwapItem = function (_data) {
		// if not town shop, use vanilla
		if (_data[1] != "world-town-screen-shop-dialog-module.stash")
			return onCanSwapItem(_data);

		local itemWrapper = this.Stash.getItemAtIndex(_data[0]);
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

		itemWrapper.item.isPrecious = @() this.isItemType(this.Const.Items.ItemType.Legendary) || this.isItemType(this.Const.Items.ItemType.Quest) || this.m.IsPrecious;
		itemWrapper.item.isUnique = @() this.isItemType(this.Const.Items.ItemType.Legendary) || this.isItemType(this.Const.Items.ItemType.Quest) || this.m.IsUnique;

		itemWrapper.item.isPrecious = orgIsPrecious;
		itemWrapper.item.isUnique = orgIsUnique;

		return ret;
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
