this.repair_building <- this.inherit("scripts/entity/world/camp/camp_building", {
	m = {
		ToolsUsed = 0,
		Stash = null,
		Repairs = null,
		Capacity = 0,
		PointsNeeded = 0,
		ItemsRepaired = 0,
		PointsRepaired = 0,
	},

	function create()
	{
		this.camp_building.create();
		this.m.ID = ::Legends.Camp.CampBuildings.Repair;
		this.m.BaseCraft = 10.0;
		this.m.ModName = "Repair";
		this.m.Escorting = true;
		this.m.Slot = "repair";
		this.m.Name = "Repair Tent";
		this.m.Description = "Manage the repair of company items";
		this.m.BannerImage = "ui/buttons/banner_repair.png";
		local sounds = getCampSounds(11, "blacksmith");
		this.m.Sounds = sounds;
		this.m.SoundsAtNight = [];
	}

	function isHidden() {
		return false;
	}

	function getTitle() {
		return this.m.Name + (this.getUpgraded() ? " *Upgraded*" : " *Not Upgraded*");
	}

	function getDescription() {
		//"Buying an upgraded tent from a settlement will increase repair speed by [color=" + this.Const.UI.Color.PositiveEventValue + "]33%[/color] and increase tool efficiency by [color=" + this.Const.UI.Color.PositiveEventValue + "]33%[/color] (1 tool repairs 20 instead of 15).";
		return "Repair damaged items in selected order. Equipped items are added automatically to the front of the queue at the end of the battle.\n\nRepair speed increases considerably when encamped. Default repair speed is based on game combat difficulty.";
	}

	function getModifierTooltip()
	{
		this.init();
		local nonNullEntries = this.m.Repairs.filter(@(_, _item) (_item != null)).len();
		local mod = this.getModifiers();
		local ret = [
			{
				id = 3,
				type = "text",
				icon = "ui/icons/plus.png",
				text = "There are [color=%positive%]" + nonNullEntries + "[/color] items in the repair queue."
			},
			{
				id = 4,
				type = "text",
				icon = "ui/buttons/icon_time.png",
				text = "It will take [color=%positive%]" + this.getRequiredTime() + "[/color] hours to repair all items in the queue."
			},
			{
				id = 5,
				type = "text",
				icon = "ui/icons/repair_item.png",
				text = "Total repair modifier is [color=%positive%]" + mod.Craft + "[/color] units per hour."
			}
		];
		local id = 6;
		foreach (bro in mod.Modifiers)
		{
			ret.push({
				id = id,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "[color=%positive%]" + bro[0] + "[/color] units/hour " + bro[1] + " (" + bro[2] + ")"
			});
			++id;
		}
		return ret;
	}

	function getUpgraded() {
		return ::Stash.hasItem(::Legends.Camp.Tent.Repair);
	}

	function getLevel()	{
		return (this.getUpgraded() ? "tent" : "dude") + "_" + (this.getAssignedBros() > 0 ? "full" : "empty");
	}

	function init()	{
		this.onInit();
		this.m.ToolsUsed = 0;
		this.m.PointsRepaired = 0;
		this.m.ItemsRepaired = 0;
		this.m.PointsNeeded = 0;
		foreach (item in this.m.Repairs.filter(@(_, _item) (_item != null))) {
			this.m.PointsNeeded += item.Item.getRepairMax() - item.Item.getRepair();
		}
	}

	function onInit() {
		local items = this.getListOfItemsNeedingRepair();
		this.m.Stash = items.Stash;
		this.m.Repairs = items.Items;
		local capacity =  this.m.Repairs.len() + this.m.Stash.len();
		this.m.Capacity = capacity;
		while (this.m.Stash.len() < capacity) {
			this.m.Stash.push(null);
		}

		while (this.m.Repairs.len() < capacity)	{
			this.m.Repairs.push(null);
		}
	}

	// Convert tools-per-condition to condition-per-tool for display.
	// Base: ArmorPartsPerArmor=0.067 (~1/15).
	// If upgraded, reduce tools-per-condition by ~25% yielding ~20 per tool instead of 15.
	function getConversionRate() {
		return this.Math.floor(1.0 / (::World.Assets.m.ArmorPartsPerArmor * ::Legends.S.getToolEfficiency()) + 0.5);
	}

	function getStash() {
		return this.m.Stash;
	}

	function getRepairs() {
		return this.m.Repairs;
	}


	function getCapacity() {
		return this.m.Capacity;
	}

	function getResults() {
		if (this.m.ToolsUsed == 0) {
			return [];
		}

		return [
			{
				id = 10,
				icon = "ui/icons/asset_supplies.png",
				text = "You used [color=%negative%]" + ::Math.floor(this.m.ToolsUsed) + "[/color] units of tools and repaired [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.m.ItemsRepaired + "[/color] pieces of equipment."
			}
		];
	}


	function getModifiers()
	{
		local ret = this.camp_building.getModifiers();
		// Align consumption with field repairs.
		// Base: ArmorPartsPerArmor=0.067 (~1/15).
		// If upgraded, reduce tools-per-condition by ~25% yielding ~20 per tool instead of 15.
		ret.Consumption = ::World.Assets.m.ArmorPartsPerArmor * ::Legends.S.getToolEfficiency();

		ret.Craft += this.m.BaseCraft;
		ret.Craft *= ::World.Assets.m.RepairSpeedMult;
		if (::World.Assets.m.ProfessionEffect.LegendHammerThemOut > 0)
			ret.Craft *= (1 + ::World.Assets.m.ProfessionEffect.LegendHammerThemOut);
		local buff = ::Math.ceil(::World.getPlayerRoster().getAll().len() * ::Const.Difficulty.RepairMult[::World.Assets.getEconomicDifficulty()] * ::World.Assets.m.RepairSpeedMult * (1.33 * ::Const.World.Assets.ArmorPerHour));
		ret.Craft = ret.Craft + buff; // to buff it as a compensation for disabling asset_manager part while camping
		if (this.getUpgraded())	{
			ret.Craft = ::Math.ceil(ret.Craft * 1.33);
		}
		return ret;
	}

	function getRepairPoints(){
		local points = 0;
		local repairs = this.m.Repairs.filter(@(_, _item) (_item != null));
		foreach (_item in repairs) {
			points += _item.Item.getRepairMax() - _item.Item.getRepair();
		}
		return points;
	}

	function getRequiredSupplies() {
		return ::Math.ceil(this.getRepairPoints() * this.getModifiers().Consumption);
	}

	function getRequiredTime() {
		this.init();
		if (this.m.Repairs == null)	{
			return 0;
		}

		return ::Math.ceil(this.getRepairPoints() / this.getModifiers().Craft);
	}

	function getAssignedBros() {
		return this.getModifiers().Assigned;
	}


	function getResourceImage()	{
		return "ui/buttons/icon_time.png";
	}

	function getResourceCount()	{
		return this.getRequiredTime();
	}

	function getUpdateText() {
		if (this.m.PointsNeeded == 0)
			return "No repairs queued";

		if (this.getRequiredSupplies() == 0)
			return "Repaired ... 100%";

		return "Repaired ... " + (::Math.floor((this.m.PointsRepaired / this.m.PointsNeeded) * 10000) / 100.0) + "%" + (::World.Assets.getArmorParts() == 0 ? "(No tools left!)" : "");
	}

	function update () {
		if (this.m.Repairs == null)	{
			this.init();
		}

		if (this.m.Repairs.len() == 0 || ::World.Assets.getArmorPartsF() == 0) {
			return this.getUpdateText();
		}

		local modifiers = this.getModifiers();
		modifiers.Craft = this.Math.round(modifiers.Craft); //important

		foreach (i, item in this.m.Repairs) {
			if (item == null) {
				continue;
			}

			local needed = item.Item.getRepairMax() - item.Item.getRepair();
			if (modifiers.Craft < needed) {
				needed = modifiers.Craft;
			}

			item.Item.onRepair(item.Item.getRepair() + needed);
			this.m.PointsRepaired += needed;
			modifiers.Craft -= needed;

			if (::World.Assets.isConsumingAssets()) {
				// Round to 3 decimal places for better determinism
				local toolsUsed = ::Math.round(needed * modifiers.Consumption * 1000.0) / 1000.0;
				this.m.ToolsUsed += toolsUsed;
				::World.Assets.addArmorPartsF(toolsUsed * -1.0);
			}

			if (item.Item.getRepair() >= item.Item.getRepairMax()) {
				this.m.ItemsRepaired += 1;
				this.swapItems("camp-screen-repair-dialog-module.shop", i, "camp-screen-repair-dialog-module.stash", null);
			}

			if (modifiers.Craft <= 0 || ::World.Assets.getArmorPartsF() == 0) {
				break;
			}
		}
		return this.getUpdateText();
	}

	function getListOfItemsNeedingRepair() {
		local items = [];
		local stash = [];
		foreach (bro in ::World.getPlayerRoster().getAll())	{
			local broItemsToBeRepaired = bro.getItems().getAllItems().filter(@(_,_item) (_item != null && _item.getRepair() < _item.getRepairMax()));
			foreach(item in broItemsToBeRepaired) {
				items.push({
					Bro = bro.getID(),
					Item = item
				});
			}
		}
		local stashItemsToBeRepaired = ::Stash.getItems().filter(@(_,_item) (_item != null && _item.getRepair() < _item.getRepairMax()) && !_item.isToBeSalvaged());
		foreach(item in stashItemsToBeRepaired) {
			local target = item.isToBeRepaired() ? items : stash;
			target.push({
				Bro = null,
				Item = item
			});
		}
		items.sort(@(_a, _b) _a.Item.isToBeRepairedQ() - _b.Item.isToBeRepairedQ());
		return {Items = items, Stash = stash};
	}

	function assignEquipped() {
		foreach( bro in ::World.getPlayerRoster().getAll())	{
			local broItemsNeedingRepair = bro.getItems().getAllItems().filter(@(_,_item) (_item != null && _item.getRepair() < _item.getRepairMax() && !_item.isToBeRepaired()));
			foreach(item in broItemsNeedingRepair) {
				item.setToBeRepaired(true, 0);
			}
		}
	}

	function assignAll( _filter = 0 ) {
		if (_filter == 0) {
			_filter = ::Const.Items.ItemFilter.All;
		}

		local index = 0;
		foreach (i, s in this.m.Stash) {
			if (s == null) {
				continue;
			}

			if (_filter == 99 && s.Bro != null)	{
				continue;
			} else if ((s.Item.getItemType() & _filter) == 0) {
				continue;
			}

			while (index < this.m.Repairs.len() && this.m.Repairs[index] != null) {
                index++;
            }

			s.Item.setToBeRepaired(true, index);
			s.Item.playInventorySound(::Const.Items.InventoryEventType.PlacedInBag);
			if (index >= this.m.Repairs.len()) {
				this.m.Repairs.push(s);
			} else {
				this.m.Repairs[index] = s;
			}
			
			this.m.Stash[i] = null;
			index++;
		}
	}

	function removeAll() {
		local index = 0;
		foreach (i, s in this.m.Repairs) {
			if (s == null)	{
				continue;
			}

			s.Item.setToBeRepaired(false, 0);
			s.Item.playInventorySound(::Const.Items.InventoryEventType.PlacedInBag);

			while (index < this.m.Stash.len() && this.m.Stash[index] != null) {
                index++;
            }
			
			if (index >= this.m.Stash.len()) {
				this.m.Stash.push(s);
			} else {
				this.m.Stash[index] = s;
			}
			
			this.m.Repairs[i] = null;
			index++;
		}
	}

	function swapItems(sourceItemOwner, sourceItemIdx, targetItemOwner, targetItemIdx) {
		if (targetItemOwner == null) {
			this.logError("onSwapItem #1");
			return false;
		}

		if (sourceItemOwner == targetItemOwner && sourceItemIdx == targetItemIdx) {
			return false;
		}

		local sourceList = null;
		local targetList = null;
		local isRepair = false;
		switch (sourceItemOwner) {
			case "camp-screen-repair-dialog-module.stash":
				sourceList = this.m.Stash;
				if (sourceItemOwner == targetItemOwner) {
					targetList = this.m.Stash;
				} else {
					targetList = this.m.Repairs;
					isRepair = true;
				}
				break;

			case "camp-screen-repair-dialog-module.shop":
				sourceList = this.m.Repairs;
				if (sourceItemOwner == targetItemOwner) {
					targetList = this.m.Repairs;
					isRepair = true;
				} else {
					targetList = this.m.Stash;
				}
				break;
		}

		local sourceItem = sourceList[sourceItemIdx];

		if (sourceItem == null) {
			this.logError("onSwapItem(stash) #2");
			return false;
		}

		//We've picked a spot to drop it
		if (targetItemIdx != null) {
			//Make sure array is big enough for target spot
			while (targetItemIdx > targetList.len() - 1) {
				targetList.push(null);
			}
			sourceList[sourceItemIdx] = targetList[targetItemIdx];
			targetList[targetItemIdx] = sourceItem;
			sourceItem.Item.playInventorySound(::Const.Items.InventoryEventType.PlacedInBag);
			sourceItem.Item.setToBeRepaired(isRepair, isRepair ? targetItemIdx : 0);
			return true;
		}

		//didn't pick a spot to drop, find the first null spot
		foreach (i, r in targetList) {
			if (r != null) {
				continue;
			}
			targetList[i] = sourceItem;
			sourceList[sourceItemIdx] = null;
			sourceItem.Item.playInventorySound(::Const.Items.InventoryEventType.PlacedInBag);
			sourceItem.Item.setToBeRepaired(isRepair, isRepair ? i : 0);
			return true;
		}

		//No null spot, push to the end
		targetList.push(sourceItem);
		sourceList[sourceItemIdx] = null;
		sourceItem.Item.playInventorySound(::Const.Items.InventoryEventType.PlacedInBag);
		sourceItem.Item.setToBeRepaired(isRepair, isRepair ? targetList.len() - 1 : 0);
		return true;
	}
});
