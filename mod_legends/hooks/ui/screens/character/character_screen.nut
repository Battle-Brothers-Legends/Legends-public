::mods_hookExactClass("ui/screens/character/character_screen", function (o) {
	o.m.SelectedBrotherID <- null;

	o.onApplyArmorFilter <- function (_filter) {
		// used by armor filter
		m.InventoryFilter = ::Const.Items.ItemFilter.Armor;
		::Sound.play("sounds/coins_02.wav", ::Const.Sound.Volume.Actor);

		if (m.JSDataSourceHandle == null) {
			return;
		}

		if (_filter.Armor.len() == ::Const.Items.ArmorUpgrades.COUNT + 1
			&& _filter.Helmet.len() == ::Const.Items.HelmetUpgrades.COUNT)
		{
			::UIDataHelper.m.ArmorFilter = null;
			loadStashList();
		} else {
			::UIDataHelper.m.ArmorFilter = _filter;
			m.JSDataSourceHandle.asyncCall("loadStashList", ::UIDataHelper.filterArmorFromStashToUIData());
		}
	}

	o.show = function () {
		this.setRosterLimit();

		if (this.m.JSHandle != null) {
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("show", this.queryData());
		}
	}

	o.toggleBrotherReserves <- function () {
		this.Tooltip.hide();
		this.m.JSDataSourceHandle.asyncCall("toggleBrotherReserves", null);
	}

	o.setRosterLimit = function (_shake = false) {
		if (this.m.JSDataSourceHandle != null) {
			this.m.JSDataSourceHandle.asyncCall("setRosterLimit", this.queryRosterSizeData(_shake));
		}
	}

	o.onDismissCharacter = function (_data) {
		local bro = this.Tactical.getEntityByID(_data[0]);
		local payCompensation = _data[1];

		if (bro != null) {
			bro.getSkills().onDismiss();
			this.World.Statistics.getFlags().increment("BrosDismissed");

			if (bro.getSkills().hasSkillOfType(this.Const.SkillType.PermanentInjury)
				&& (bro.getBackground().getID() != "background.slave" || this.World.Assets.getOrigin().getID() == "scenario.legend_escaped_slaves"))
			{
				this.World.Statistics.getFlags().increment("BrosWithPermanentInjuryDismissed");
			}

			if (payCompensation) {
				this.World.Assets.addMoney(-10 * this.Math.max(1, bro.getDaysWithCompany()));

				if (bro.getBackground().getID() == "background.slave") {
					local playerRoster = this.World.getPlayerRoster().getAll();

					foreach (other in playerRoster) {
						if (bro.getID() == other.getID()) {
							continue;
						}

						if (other.getBackground().getID() == "background.slave") {
							other.improveMood(this.Const.MoodChange.SlaveCompensated, "Glad to see " + bro.getName() + " get reparations for his time");
						}
					}
				}
			} else if (bro.getBackground().getID() == "background.slave") {
			} else if (bro.getLevel() >= 11
				&& !this.World.Statistics.hasNews("dismiss_legend")
				&& this.World.getPlayerRoster().getSize() > 1)
			{
				local news = this.World.Statistics.createNews();
				news.set("Name", bro.getName());
				this.World.Statistics.addNews("dismiss_legend", news);
			} else if (bro.getDaysWithCompany() >= 50
				&& !this.World.Statistics.hasNews("dismiss_veteran")
				&& this.World.getPlayerRoster().getSize() > 1
				&& this.Math.rand(1, 100) <= 33)
			{
				local news = this.World.Statistics.createNews();
				news.set("Name", bro.getName());
				this.World.Statistics.addNews("dismiss_veteran", news);
			} else if (bro.getLevel() >= 3
				&& bro.getSkills().hasSkillOfType(this.Const.SkillType.PermanentInjury)
				&& !this.World.Statistics.hasNews("dismiss_injured")
				&& this.World.getPlayerRoster().getSize() > 1
				&& this.Math.rand(1, 100) <= 33)
			{
				local news = this.World.Statistics.createNews();
				news.set("Name", bro.getName());
				this.World.Statistics.addNews("dismiss_injured", news);
			} else if (bro.getDaysWithCompany() >= 7) {
				local playerRoster = this.World.getPlayerRoster().getAll();

				foreach (other in playerRoster) {
					if (bro.getID() == other.getID()) {
						continue;
					}

					if (bro.getDaysWithCompany() >= 50) {
						other.worsenMood(this.Const.MoodChange.VeteranDismissed, "Dismissed " + bro.getName());
					} else {
						other.worsenMood(this.Const.MoodChange.BrotherDismissed, "Dismissed " + bro.getName());
					}
				}
			}
		
			if (("State" in this.World)
				&& this.World.State != null
				&& this.World.Assets.getOrigin().getID() == "scenario.manhunters")
			{
				local playerRoster = this.World.getPlayerRoster().getAll();
				local indebted = 0;
				local nonIndebted = [];

				foreach (bro in playerRoster) {
					if (bro.getBackground().getID() == "background.slave") {
						indebted++;
					} else {
						nonIndebted.push(bro);
					}
				}

				this.World.Statistics.getFlags().set("ManhunterIndebted", indebted);
				this.World.Statistics.getFlags().set("ManhunterNonIndebted", nonIndebted.len());
			}

			bro.getItems().transferToStash(this.World.Assets.getStash());
			this.World.getPlayerRoster().remove(bro);
			if (this.World.State.getPlayer() != null) {
				this.World.State.getPlayer().calculateModifiers();
			}
			this.loadData();
			this.World.State.updateTopbarAssets();

			local addToObituary = (_data.len() > 2 && _data[2] != null) ? _data[2] : false;

			local backgroundID = bro.getBackground().getID();
			if (addToObituary) {
				// Get Background specific messages from config
				local backgroundMessages = ::Legends.Obituary.FateText.BackgroundMessages;
				local positiveMessages = ::Legends.Obituary.FateText.PositiveMessages;
				local negativeMessages = ::Legends.Obituary.FateText.NegativeMessages;
				local backgroundspecificchance = ::Legends.Mod.ModSettings.getSetting("Backgroundspecific").getValue();

				local message = null;

				if (payCompensation) {
					// Use background-specific positive message if it exists and passes the chance roll
					if ((backgroundID in backgroundMessages)
						&& (backgroundMessages[backgroundID].pos != "")
						&& (this.Math.rand(1, 100) < backgroundspecificchance))
					{
						message = backgroundMessages[backgroundID].pos;
					} else {
						// Fall back to generic positive message
						message = positiveMessages[this.Math.rand(0, positiveMessages.len() - 1)];
					}
				} else {
					// Use background-specific negative message if it exists and passes the chance roll
					if ((backgroundID in backgroundMessages)
						&& (backgroundMessages[backgroundID].neg != "")
						&& (this.Math.rand(1, 100) < backgroundspecificchance))
					{
						message = backgroundMessages[backgroundID].neg;
					} else {
						// Fall back to generic negative message
						message = negativeMessages[this.Math.rand(0, negativeMessages.len() - 1)];
					}
				}

				::Legends.addFallen(bro, message);
			}
		}
	}

	o.onToggleReserveCharacter <- function (_id) {
		local bro = this.Tactical.getEntityByID(_id);
		if (bro != null
			&& (this.World.State.getBrothersInFrontline() < this.World.Assets.getBrothersMaxInCombat() || !bro.isInReserves()))
		{
			bro.setInReserves(!bro.isInReserves());
			this.setRosterLimit();
		} else {
			this.setRosterLimit(true);
		}
		return this.UIDataHelper.convertEntityToUIData(bro, null);
	}
	
	o.queryRosterSizeData <- function (_shake = false)
	{
		local brosInCombat = 18;
		// try/catch, so getBrothersInFrontline() after quitting game to menu and starting a scenario doesn't crash - Narkh 2026/03/01
		try { brosInCombat = ::World.State.getBrothersInFrontline();} catch(e) {}
		local result = {
			brothersInCombat = brosInCombat,
			brothersMaxInCombat = 27,
			brothers = this.World.getPlayerRoster().getSize(),
			brothersMax = 27,
			shake = _shake,
		};

		if (("Assets" in this.World) && this.World.Assets != null) {
			result.brothersMaxInCombat = this.World.Assets.getBrothersMaxInCombat();
			result.brothersMax = this.World.Assets.getBrothersMax();
		}

		return result;
	}
	
	o.queryData = function () {
		local result = {
			brothers = this.onQueryBrothersList()
		};

		if (("Assets" in this.World) && this.World.Assets != null) {
			result.formationIndex <- this.World.Assets.getFormationIndex();
			result.formationName <- this.World.Assets.getFormationName();
			result.maxBrothers <- this.World.Assets.getBrothersMax();
			result.frontlineData <- [
				this.World.State.getBrothersInFrontline(),
				this.World.Assets.getBrothersMaxInCombat()
			];
		}

		if (this.m.InventoryMode != this.Const.CharacterScreen.InventoryMode.Ground) {
			result.stash <- this.onQueryStashList();
			result.stashSpaceUsed <- this.Stash.getNumberOfFilledSlots();
			result.stashSpaceMax <- this.Stash.getCapacity();
		}

		if (this.m.PerkTreesLoaded == false) {
			this.m.PerkTreesLoaded = true;
			result.perkTrees <- this.onQueryPerkTrees();
		}
		if ("stashSpaceUsed" in result) {
			this.logDebug("Generating stash list info :" + result.stashSpaceUsed + " : " + result.stashSpaceMax);
		}

		return result;
	}
	
	o.onSwapInventoryItem = function (_data) {
		if (_data[2]) {
			return this.general_onUpgradeInventoryItem(_data);
		}
		return this.general_onSwapInventoryItem(_data);
	}

	o.general_onUpgradeInventoryItem <- function (_data) {
		local data = this.helper_queryStashItemDataByIndex(_data[0], _data[1]);

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
			return this.UIDataHelper.convertStashAndEntityToUIData(null, null, false, this.m.InventoryFilter);
		} else {
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToAcquireStash);
		}

		return this.UIDataHelper.convertStashAndEntityToUIData(null, null, false, this.m.InventoryFilter);
	}

	o.onToggleInventoryItem <- function (_data) {
		local result = {
			repair = false,
			salvage = false
		};

		local itemId = _data[0];
		local entityId = _data[1];

		if (this.Tactical.isActive()) {
			return result;
		}

		local obj = null;
		local item = null;
		local index = 0;
		if (entityId != null) {
			obj = this.Tactical.getEntityByID(entityId).getItems().getItemByInstanceID(itemId);
			if (obj != null) {
				item = obj;
			}
		} else {
			obj = this.Stash.getItemByInstanceID(itemId);
			if (obj != null) {
				item = obj.item;
				index = obj.index;
			}
		}

		if (item == null) {
			return result;
		}

		if (item.isIndestructible() || entityId != null) {
			item.setToBeRepaired(!item.isToBeRepaired(), index);
			item.setToBeSalvaged(false, 0);
		} else if (!item.isToBeRepaired() && !item.isToBeSalvaged()) {
			if (item.setToBeRepaired(true, index)) {
				item.setToBeSalvaged(false, 0);
			} else if (item.canBeSalvaged()) {
				item.setToBeSalvaged(true, index);
			}

		} else if (item.isToBeRepaired() && item.canBeSalvaged()) {
			item.setToBeRepaired(false, 0);
			item.setToBeSalvaged(true, index);
		} else {
			item.setToBeRepaired(false, 0);
			item.setToBeSalvaged(false, 0);
		}

		return {
			repair = item.isToBeRepaired(),
			salvage = item.isToBeSalvaged()
		};
	}

	o.onRepairInventoryItem = function (_data) {}

	o.general_onQueryPerkInformation = function (_data) {
		return this.UIDataHelper.convertPerkToUIData(_data[0], _data[1]);
	}

	o.general_onEquipStashItem = function (_data) {
		local data = this.helper_queryStashItemData(_data);

		if ("error" in data) {
			return data;
		}

		local targetItems = this.helper_queryEquipmentTargetItems(data.inventory, data.sourceItem);
		local allowed = this.helper_isActionAllowed(data.entity, [
			data.sourceItem,
			targetItems.firstItem,
			targetItems.secondItem
		], false);

		if (allowed != null) {
			return allowed;
		}

		if (!this.Tactical.isActive() && data.sourceItem.isUsable()) {
			local result = data.sourceItem.onUse(data.inventory.getActor());
			if (result) {
				if (typeof result == "table") {
					data.stash.removeByIndex(result.index);
					if (result.item != null) {
						this.World.Assets.getStash().insert(result.item, result.index);
					}
				} else {
					data.stash.removeByIndex(data.sourceIndex);
				}
				data.inventory.getActor().getSkills().update();
				return this.UIDataHelper.convertStashAndEntityToUIData(data.entity, null, false, this.m.InventoryFilter);
			} else {
				return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToEquipStashItem);
			}
		}

		if (!data.stash.isResizable()
			&& data.stash.getNumberOfEmptySlots() < targetItems.slotsNeeded - 1)
		{
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.NotEnoughStashSpace);
		}

		if (targetItems.firstItem != null) {
			if (!targetItems.firstItem.isInBag()
				&& !data.inventory.unequip(targetItems.firstItem)
				|| targetItems.firstItem.isInBag()
				&& !data.inventory.removeFromBag(targetItems.firstItem))
			{
				return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToRemoveItemFromTargetSlot);
			}

			if (targetItems.secondItem != null) {
				if (data.inventory.unequip(targetItems.secondItem) == false) {
					data.inventory.equip(targetItems.firstItem);
					return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToRemoveItemFromTargetSlot);
				}
			}
		}

		if (data.stash.removeByIndex(data.sourceIndex) == null) {
			if (targetItems != null && targetItems.firstItem != null) {
				data.inventory.equip(targetItems.firstItem);

				if (targetItems.secondItem != null) {
					data.inventory.equip(targetItems.secondItem);
				}
			}
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToRemoveItemFromSourceSlot);
		}

		if (data.inventory.equip(data.sourceItem) == false) {
			data.stash.insert(data.sourceItem, data.sourceIndex);

			if (targetItems != null && targetItems.firstItem != null) {
				data.inventory.equip(targetItems.firstItem);

				if (targetItems.secondItem != null) {
					data.inventory.equip(targetItems.secondItem);
				}
			}
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToEquipBagItem);
		}

		if (targetItems != null && targetItems.firstItem != null) {
			local firstItemIdx = data.sourceIndex;

			if (data.swapItem == true) {
				data.stash.insert(targetItems.firstItem, data.sourceIndex);
			} else {
				firstItemIdx = data.stash.add(targetItems.firstItem);

				if (firstItemIdx == null) {
					data.inventory.unequip(data.sourceItem);
					data.stash.insert(data.sourceItem, data.sourceIndex);
					data.inventory.equip(targetItems.firstItem);

					if (targetItems.secondItem != null) {
						data.inventory.equip(targetItems.secondItem);
					}
					return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToPutItemIntoBag);
				}
			}

			local secondItemIdx = data.stash.add(targetItems.secondItem);

			if (targetItems.secondItem != null && secondItemIdx == null) {
				data.stash.removeByIndex(firstItemIdx);
				data.inventory.unequip(data.sourceItem);
				data.stash.insert(data.sourceItem, data.sourceIndex);
				data.inventory.equip(targetItems.firstItem);

				if (targetItems.secondItem != null) {
					data.inventory.equip(targetItems.secondItem);
				}
				return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToPutItemIntoBag);
			}
		}

		data.sourceItem.playInventorySound(this.Const.Items.InventoryEventType.Equipped);
		this.helper_payForAction(data.entity, [
			data.sourceItem,
			targetItems.firstItem,
			targetItems.secondItem
		]);

		if (this.Tactical.isActive()) {
			return this.UIDataHelper.convertStashAndEntityToUIData(data.entity, this.Tactical.TurnSequenceBar.getActiveEntity(), false, this.m.InventoryFilter);
		} else {
			return this.UIDataHelper.convertStashAndEntityToUIData(data.entity, null, false, this.m.InventoryFilter);
		}
	}

	o.helper_dropItemIntoStash = function (_data) {

		if (_data.targetItemIdx == null
			&& _data.stash.hasEmptySlot() == false
			&& !_data.stash.isResizable())
		{
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.NotEnoughStashSpace);
		}

		local slotType = _data.sourceItem.getCurrentSlotType();

		if (slotType == this.Const.ItemSlot.None) {
			return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.ItemIsNotAssignedToAnySlot);
		}

		if (_data.sourceItem.getCurrentSlotType() == this.Const.ItemSlot.Bag) {
			if (_data.inventory.removeFromBag(_data.sourceItem) == false) {
				return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToRemoveItemFromBag);
			}

			local result = _data.stash.add(_data.sourceItem);

			if (result == null) {
				_data.inventory.addToBag(_data.sourceItem);
				return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.NotEnoughStashSpace);
			}
		} else if (_data.targetItemIdx != null) {
			if (_data.targetItem != null) {
				if (_data.sourceItem.getSlotType() == this.Const.ItemSlot.Mainhand
					|| _data.sourceItem.getSlotType() == this.Const.ItemSlot.Offhand)
				{
					if (_data.sourceItem.getSlotType() == this.Const.ItemSlot.Mainhand) {
						local sourceItemIsBlockingOffhand = _data.sourceItem.getBlockedSlotType() != null
							&& _data.sourceItem.getBlockedSlotType() == this.Const.ItemSlot.Offhand;
						local targetItemIsBlockingOffhand = _data.targetItem.getBlockedSlotType() != null
							&& _data.targetItem.getBlockedSlotType() == this.Const.ItemSlot.Offhand;

						if ((sourceItemIsBlockingOffhand == false && _data.inventory.getItemAtSlot(this.Const.ItemSlot.Offhand) != null)
							&& _data.targetItem.getSlotType() == this.Const.ItemSlot.Mainhand
							&& targetItemIsBlockingOffhand == true)
						{
							return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToRemoveItemFromSourceSlot);
						}

						if (_data.sourceItem.getSlotType() != _data.targetItem.getSlotType()
							&& !(_data.sourceItem.getSlotType() == this.Const.ItemSlot.Mainhand && sourceItemIsBlockingOffhand && _data.targetItem.getSlotType() == this.Const.ItemSlot.Offhand))
						{
							return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToRemoveItemFromSourceSlot);
						}
					} else if (_data.targetItem.getSlotType() != this.Const.ItemSlot.Offhand) {
						return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToRemoveItemFromSourceSlot);
					}
				} else if (_data.sourceItem.getSlotType() != _data.targetItem.getSlotType()) {
					return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToRemoveItemFromSourceSlot);
				} else if (::mods_isClass(_data.targetItem, "legend_armor_upgrade") != null
					|| ::mods_isClass(_data.targetItem, "legend_helmet_upgrade") != null)
				{
					return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToRemoveItemFromSourceSlot);
				}

				if (_data.inventory.unequip(_data.sourceItem) == false) {
					return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToRemoveItemFromSourceSlot);
				}

				local result = _data.stash.insert(_data.sourceItem, _data.targetItemIdx);

				if (result != null) {
					_data.inventory.equip(_data.targetItem);
				}
			} else {
				if (_data.inventory.unequip(_data.sourceItem) == false) {
					return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToRemoveItemFromSourceSlot);
				}

				_data.stash.insert(_data.sourceItem, _data.targetItemIdx);
			}
		} else {
			if (_data.inventory.unequip(_data.sourceItem) == false) {
				return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.FailedToRemoveItemFromSourceSlot);
			}

			local result = _data.stash.add(_data.sourceItem);

			if (result == null) {
				_data.inventory.equip(_data.sourceItem);
				return this.helper_convertErrorToUIData(this.Const.CharacterScreen.ErrorCode.NotEnoughStashSpace);
			}
		}

		_data.sourceItem.playInventorySound(this.Const.Items.InventoryEventType.PlacedInStash);
		this.helper_payForAction(_data.entity, [
			_data.sourceItem,
			_data.targetItem
		]);
		return null;
	}

	o.tactical_onQueryBrothersList = function () {
		local entities = this.Tactical.Entities.getInstancesOfFaction(this.Const.Faction.Player);

		if (entities != null && entities.len() > 0) {
			local activeEntity = this.Tactical.TurnSequenceBar.getActiveEntity();
			local result = [];

			foreach (entity in entities) {
				if (entity.isSummoned()) {
					continue;
				}
				result.push(this.UIDataHelper.convertEntityToUIData(entity, activeEntity));
			}

			return result;
		}

		return null;
	}

	o.onFormationChanged <- function (_data) {
		local index = _data[0];
		this.World.Assets.changeFormation(index);
		this.loadData();
	}

	o.onFormationClear <- function (_data) {
		this.World.Assets.clearFormation();
		this.loadData();
	}

	o.removeInventoryItemUpgrades <- function (_data) {
		local armor = this.Stash.getItemAtIndex(_data[0]).item;
		return this.removeAllUpgradesFromItem(armor)
	}

	o.removePaperdollItemUpgrades <- function (_data) {
		local bro = this.Tactical.getEntityByID(_data[0]);
		local item = bro.m.Items.getItemByInstanceID(_data[1]);
		return this.removeAllUpgradesFromItem(item, bro)
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

	o.onRemoveUpgrade <- function (_data) {
		if (this.Stash.getNumberOfEmptySlots() <= 0) {
			return {
				error = this.Const.UI.Error.NotEnoughStashSpace,
				code = this.Const.UI.Error.NotEnoughStashSpace
			};
		}
		local bro = this.Tactical.getEntityByID(_data[1]);
		local upgrade = bro.removeArmorUpgrade(_data[2] == "body"
			? this.Const.ItemSlot.Body
			: this.Const.ItemSlot.Head, _data[0]);
		if (upgrade != null && !upgrade.isDestroyedOnRemove()) {
			this.World.Assets.getStash().add(upgrade);
			bro.getSkills().update();
			return this.UIDataHelper.convertStashAndEntityToUIData(bro, null, false, this.m.InventoryFilter);
		}
	}

	o.onToggleUpgradeVisibility <- function (_data) {
		local bro = this.Tactical.getEntityByID(_data[1]);
		local slot;
		switch (_data[2]) {
			case "head":
				slot = this.Const.ItemSlot.Head;
				break;
			case "body":
				slot = this.Const.ItemSlot.Body;
				break;
			case "accessory":
				slot = this.Const.ItemSlot.Accessory;
				break;
			default:
				::logError("Unknown slot type: " + _data[2]);
				return;
		}

		local item = bro.getItems().getItemAtSlot(slot);
		if (slot == this.Const.ItemSlot.Accessory) {
			// Some items are not visible, like dogs.
			if (item.m.ShowOnCharacter) {
				item.toggleAccessoryVisible();
			}
		} else {
			local upgrade = item.getUpgrade(_data[0]);
			local result = upgrade.toggleVisible();
		}
		return this.UIDataHelper.convertStashAndEntityToUIData(bro, null, false, this.m.InventoryFilter);
	}

	o.onUpdateFormationName <- function (_data) {
		local name = _data[0];
		this.World.Assets.changeFormationName(name);
		return this.World.Assets.getFormationName();
	}

	o.onAssignRider <- function (_data) {
		local riderID = _data[0];
		local horseID = _data[1];

		local rider = this.Tactical.getEntityByID(_data[0]);
		local horse = this.Tactical.getEntityByID(_data[1]);

		if (rider == null && horse == null) {
			return this.onQueryBrothersList();
		}

		//assign a bro to a horse
		if (horse != null && rider != null) {
			horse.setRiderID(_data[0]);
			rider.setRiderID(_data[0]);
			return this.onQueryBrothersList();
		}

		//Removing bro from horse
		if (horse != null) {
			horse.setRiderID("");
		}

		//Removing horse from bro
		if (rider != null) {
			rider.setRiderID("");
		}

		return this.onQueryBrothersList()
	}

	o.onBrotherSelected <- function (_data) {
		this.m.SelectedBrotherID = _data;
	}

	o.getSelectedActor <- function () {
		if (this.m.SelectedBrotherID == null) {
			return null;
		}
		local entity = ::Tactical.getEntityByID(this.m.SelectedBrotherID);
		foreach (bro in ::World.getPlayerRoster().getAll()) {
			if (bro.getID() == entity.getID()) {
				return bro;
			}
		}
		return null;
	}

	local general_onEquipStashItem = o.general_onEquipStashItem;
	o.general_onEquipStashItem = function (_data) {
		local entity = this.Tactical.getEntityByID(_data[0]);
		if (entity == null || !entity.isPlayerControlled()) {
			return general_onEquipStashItem(_data);
		}

		if (this.Stash == null) {
			return general_onEquipStashItem(_data);
		}

		local sourceItem = this.Stash.getItemByInstanceID(_data[1]);
		if (sourceItem == null) {
			return general_onEquipStashItem(_data);
		}
		sourceItem = sourceItem.item;

		// Proceed only if this is a 1h main hand weapon
		if (sourceItem.getSlotType() != this.Const.ItemSlot.Mainhand
			|| sourceItem.getBlockedSlotType() != null)
		{
			return general_onEquipStashItem(_data);
		}

		local inventory = entity.getItems();
		local mh = inventory.getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local oh = inventory.getItemAtSlot(this.Const.ItemSlot.Offhand);
		local ohBlocked = inventory.hasBlockedSlot(this.Const.ItemSlot.Offhand);

		local targetSlot = null;
		if (typeof _data == "array" && _data.len() >= 4 && _data[3] == "offhand") {
			targetSlot = this.Const.ItemSlot.Offhand;
		}

		// Equipping to offhand
		if (targetSlot == this.Const.ItemSlot.Offhand
			&& !ohBlocked
			&& inventory.canDualWield(entity, sourceItem))
		{

			local originalSlotType = sourceItem.m.SlotType;
			sourceItem.m.SlotType = this.Const.ItemSlot.Offhand;

			general_onEquipStashItem(_data);
			sourceItem.m.SlotType = originalSlotType;

			this.dualWieldRefresh(entity, this.Const.ItemSlot.Offhand);

			entity.getSkills().update();
			return this.UIDataHelper.convertStashAndEntityToUIData(entity, null, false, this.m.InventoryFilter);
		}

		// Equipping to mainhand while offhand has a dw weapon
		if (oh != null && oh.getSlotType() == this.Const.ItemSlot.Mainhand) {

			general_onEquipStashItem(_data);

			this.dualWieldRefresh(entity, this.Const.ItemSlot.Mainhand);

			entity.getSkills().update();
			return this.UIDataHelper.convertStashAndEntityToUIData(entity, null, false, this.m.InventoryFilter);
		}

		return general_onEquipStashItem(_data);
	}

	local general_onEquipBagItem = o.general_onEquipBagItem;
	o.general_onEquipBagItem = function (_data) {
		local entity = this.Tactical.getEntityByID(_data[0]);
		if (entity == null || !entity.isPlayerControlled()) {
			return general_onEquipBagItem(_data);
		}

		local inventory = entity.getItems();
		if (inventory == null) {
			return general_onEquipBagItem(_data);
		}

		local sourceItem = inventory.getItemByInstanceID(_data[1]);
		if (sourceItem == null) {
			return general_onEquipBagItem(_data);
		}

		// Reject if the item is not actually in the bag (stale UI after a previous equip)
		if (!sourceItem.isInBag()) {
			return this.UIDataHelper.convertStashAndEntityToUIData(entity, null, false, this.m.InventoryFilter);
		}

		// Proceed only if this is a 1h main hand weapon
		if (sourceItem.getSlotType() != this.Const.ItemSlot.Mainhand
			|| sourceItem.getBlockedSlotType() != null)
		{
			return general_onEquipBagItem(_data);
		}

		local mh = inventory.getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local oh = inventory.getItemAtSlot(this.Const.ItemSlot.Offhand);
		local ohBlocked = inventory.hasBlockedSlot(this.Const.ItemSlot.Offhand);

		local targetSlot = null;
		if (typeof _data == "array" && _data.len() >= 4 && _data[3] == "offhand") {
			targetSlot = this.Const.ItemSlot.Offhand;
		}

		// Equipping to offhand
		if (targetSlot == this.Const.ItemSlot.Offhand
			&& !ohBlocked
			&& inventory.canDualWield(entity, sourceItem))
		{

			local originalSlotType = sourceItem.m.SlotType;
			sourceItem.m.SlotType = this.Const.ItemSlot.Offhand;

			general_onEquipBagItem(_data);
			sourceItem.m.SlotType = originalSlotType;

			this.dualWieldRefresh(entity, this.Const.ItemSlot.Offhand);

			entity.getSkills().update();
			return this.UIDataHelper.convertStashAndEntityToUIData(entity, null, false, this.m.InventoryFilter);
		}

		// Equipping to mainhand while offhand has a dw weapon
		if (oh != null && oh.getSlotType() == this.Const.ItemSlot.Mainhand) {

			general_onEquipBagItem(_data);

			this.dualWieldRefresh(entity, this.Const.ItemSlot.Mainhand);

			entity.getSkills().update();
			return this.UIDataHelper.convertStashAndEntityToUIData(entity, null, false, this.m.InventoryFilter);
		}

		return general_onEquipBagItem(_data);
	}

	o.dualWieldRefresh <- function (_entity, _slot) {
		local effect = ::Legends.Effects.get(_entity, ::Legends.Effect.LegendDualWield);
		if (effect == null) {
			return;
		}

		local items = _entity.getItems();
		local mh = items.getItemAtSlot(this.Const.ItemSlot.Mainhand);
		local oh = items.getItemAtSlot(this.Const.ItemSlot.Offhand);

		if (mh != null && oh != null && mh.getID() != oh.getID()) {

			if (_slot == this.Const.ItemSlot.Offhand) {
				mh.onUnequip();
				mh.onEquip();
			} else if (_slot == this.Const.ItemSlot.Mainhand) {
				oh.onUnequip();
				oh.onEquip();
			}

		}
	}

	o.onSwapDualWieldSlots <- function (_data) {
		local entity = this.Tactical.getEntityByID(_data[0]);
		if (entity == null || !entity.isPlayerControlled()) {
			return null;
		}

		local inventory = entity.getItems();
		if (inventory == null || !inventory.swapDualWieldSlots()) {
			return null;
		}

		return this.UIDataHelper.convertStashAndEntityToUIData(entity, null, false, this.m.InventoryFilter);
	}
});
