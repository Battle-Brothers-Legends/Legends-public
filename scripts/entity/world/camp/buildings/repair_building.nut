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
		this.m.ID = this.Const.World.CampBuildings.Repair;
		this.m.BaseCraft = 10.0;
		this.m.Conversion = 10.0;
		this.m.ModName = "Repair";
		this.m.Escorting = true;
		this.m.Slot = "repair";
		this.m.Name = "Repair Tent";
		this.m.Description = "Manage the repair of company items"
		this.m.BannerImage = "ui/buttons/banner_repair.png";
		this.m.Sounds = [
			{
				File = "ambience/camp/camp_blacksmith_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_blacksmith_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_blacksmith_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_blacksmith_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_blacksmith_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_blacksmith_06.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_blacksmith_07.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_blacksmith_08.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_blacksmith_09.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_blacksmith_10.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/camp_blacksmith_11.wav",
				Volume = 1.0,
				Pitch = 1.0
			}
		];
		this.m.SoundsAtNight = [];
	}

	function getTitle()
	{
		if (this.getUpgraded())
		{
			return this.m.Name + " *Upgraded*"
		}
		return this.m.Name +  " *Not Upgraded*"
	}

	function getDescription()
	{
		local desc = "";
		desc += "This tent repairs damaged items in your stash and equipped fighers. Equipment is repaired one item at time in the order they were queued."
		desc += "At the end of a battle, any damaged equipped gear is added to the front of the repair queue."
		desc += "\n\n"
		desc += "Items will repair very slowly when not camped. Camping increases the speed even with no one assigned. Default repair speed is based on game combat difficulty."
		desc += "The more people assigned to the repair tent, the quicker the repairs. Mercenaries with repair skills increase the speed even further and may save you tools."
		desc += "\n\n"
		desc += "Buying an upgraded tent from a settlement will increase repair speed by 33% and reduce tool use by -33%."
		return desc;
	}

	function getModifierToolip()
	{
		this.init();
		local mod = this.getModifiers();
		local ret = [
			{
				id = 3,
				type = "text",
				icon = "ui/icons/plus.png",
				text = "There are [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.Repairs.len() + "[/color] items in the repair queue."
			},
			{
				id = 4,
				type = "text",
				icon = "ui/buttons/icon_time.png",
				text = "It will take [color=" + this.Const.UI.Color.PositiveValue + "]" + this.getRequiredTime() + "[/color] hours to repair all items in the queue."
			},
			{
				id = 5,
				type = "text",
				icon = "ui/icons/repair_item.png",
				text = "Total repair modifier is [color=" + this.Const.UI.Color.PositiveValue + "]" + mod.Craft + "[/color] units per hour."
			}
		];
		local id = 6;
		foreach (bro in mod.Modifiers)
		{
			ret.push({
				id = id,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + bro[0] + "[/color] units/hour " + bro[1] + " (" + bro[2] + ")"
			})
			++id;
		}
		return ret;
	}

	function getUpgraded()
	{
		return this.Stash.hasItem("tent.repair_tent");
	}

	function getLevel()
	{
		local pro = "dude";
		if (this.getUpgraded())
		{
			pro = "tent";
		}

		local sub = "empty";

		if (this.getAssignedBros() > 0) {
			sub =  "full";
		}
		return pro + "_" + sub;
	}

	function init()
	{
		this.onInit();
		this.m.ToolsUsed = 0;
		this.m.PointsRepaired = 0;
		this.m.ItemsRepaired = 0;
		this.m.PointsNeeded = 0;
		foreach (i, r in this.m.Repairs)
		{
			if (r == null)
			{
				continue;
			}

			this.m.PointsNeeded += r.Item.getRepairMax() - r.Item.getRepair()
		}
	}

	function onInit()
	{
		local items = this.getListOfItemsNeedingRepair()
		this.m.Stash = items.Stash;
		this.m.Repairs = items.Items;
		local capacity =  this.m.Repairs.len() + this.m.Stash.len();
		this.m.Capacity = capacity;
		while (this.m.Stash.len() < capacity)
		{
			this.m.Stash.push(null);
		}

		while (this.m.Repairs.len() < capacity)
		{
			this.m.Repairs.push(null);
		}
	}

	function getConversionRate()
	{
		return this.m.Conversion;
	}

	function getStash()
	{
		return this.m.Stash;
	}

	function getRepairs()
	{
		return this.m.Repairs;
	}


	function getCapacity()
	{
		return this.m.Capacity;
	}

	function getResults()
	{
		if (this.m.ToolsUsed == 0)
		{
			return [];
		}

		return [{
				id = 10,
				icon = "ui/icons/asset_supplies.png",
				text = "You used [color=" + this.Const.UI.Color.NegativeEventValue + "]" + this.Math.floor(this.m.ToolsUsed) + "[/color] units of tools and repaired [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.m.ItemsRepaired + "[/color] pieces of equipment."
			}];
	}


	function getModifiers()
	{
		local ret = this.camp_building.getModifiers();
		if (this.getUpgraded())
		{
			ret.Consumption = 1.0 / 20.0
		}

		ret.Craft += this.m.BaseCraft;
		ret.Craft = ret.Craft * this.World.Assets.m.RepairSpeedMult; // should be taken into account (blacksmith influence)
		local buff =  this.Math.ceil(this.World.getPlayerRoster().getAll().len() * this.Const.Difficulty.RepairMult[this.World.Assets.getEconomicDifficulty()] * this.World.Assets.m.RepairSpeedMult * (1.33 * this.Const.World.Assets.ArmorPerHour));
		ret.Craft = ret.Craft + buff; // to buff it as a compensation for disabling asset_manager part while camping
		if (this.getUpgraded())
		{
			ret.Craft = this.Math.ceil(ret.Craft * 1.33);
		}
		return ret;
	}

	function getRequiredSupplies()
	{
		local points = 0;
		foreach (i, r in this.m.Repairs)
		{
			if (r == null)
			{
				continue;
			}

			points += r.Item.getRepairMax() - r.Item.getRepair()
		}
		local modifiers = this.getModifiers();
		return this.Math.ceil(points * modifiers.Consumption);
	}

	function getRequiredTime()
	{
		local points = 0;
		if (this.m.Repairs == null)
		{
			return 0;
		}

		foreach (i, r in this.m.Repairs)
		{
			if (r == null)
			{
				continue;
			}

			points += r.Item.getRepairMax() - r.Item.getRepair()
		}
		local modifiers = this.getModifiers();
		return this.Math.ceil(points / modifiers.Craft);
	}

	function getAssignedBros()
	{
		local mod = this.getModifiers();
		return mod.Assigned;
	}


	function getResourceImage()
	{
		return "ui/buttons/icon_time.png";
	}

	function getResourceCount()
	{
		return this.getRequiredTime();
	}

	function getUpdateText()
	{
		if (this.m.PointsNeeded == 0)
			return "No repairs queued";

		if (this.getRequiredSupplies() == 0)
			return "Repaired ... 100%";

		local percent = this.Math.floor((this.m.PointsRepaired / this.m.PointsNeeded) * 10000) / 100.0;
		local text = "Repaired ... " + percent + "%";

		if (this.World.Assets.getArmorParts() == 0)
			return text + " (No tools left!)";

		return text;
	}

	function update ()
	{
		if (this.m.Repairs == null)
		{
			this.init();
		}

		if (this.m.Repairs.len() == 0)
		{
			return this.getUpdateText();
		}

		if (this.World.Assets.getArmorPartsF() == 0)
		{
			return this.getUpdateText();
		}

		local modifiers = this.getModifiers();
		modifiers.Craft = this.Math.round(modifiers.Craft); //important

		local roster = this.World.getPlayerRoster().getAll(); // so that repair perks have effect while camping too
		local perkMod = 1.0;

		foreach( bro in roster )
		{
			local items = bro.getItems().getAllItems();
			local skills = [
				"perk.legend_tools_spares",
				"perk.legend_tools_drawers"
			];

			foreach( s in skills )
			{
				local skill = bro.getSkills().getSkillByID(s);

				if (skill != null)
				{
					perkMod = this.Math.maxf(perkMod - skill.getModifier() * 0.003, 0.5);
				}
			}
		}
		foreach (i, r in this.m.Repairs)
		{
			if (r == null)
			{
				continue;
			}

			local needed = r.Item.getRepairMax() - r.Item.getRepair()
			if (modifiers.Craft < needed)
			{
				needed = modifiers.Craft;
			}

			r.Item.onRepair(r.Item.getRepair() + needed);
			this.m.PointsRepaired += needed;
			modifiers.Craft -= needed;

			if (this.World.Assets.isConsumingAssets())
			{
				local consumed = needed * modifiers.Consumption;
				this.m.ToolsUsed += consumed * perkMod;
				this.World.Assets.addArmorPartsF(consumed * perkMod * -1.0);
			}

			if (r.Item.getRepair() >= r.Item.getRepairMax())
			{
				this.m.ItemsRepaired += 1
				this.swapItems("camp-screen-repair-dialog-module.shop", i, "camp-screen-repair-dialog-module.stash", null);
			}

			if (modifiers.Craft <= 0)
			{
				break;
			}

			if ( this.World.Assets.getArmorPartsF() == 0)
			{
				break;
			}
		}

		return this.getUpdateText();
	}

	function sortRepairQueue( _f1, _f2 )
	{
		if (_f1.Item.isToBeRepairedQ() > _f2.Item.isToBeRepairedQ())
		{
			return 1;
		}
		else if (_f1.Item.isToBeRepairedQ() < _f2.Item.isToBeRepairedQ())
		{
			return -1;
		}
		else
		{
			return 0;
		}
	}

	function getListOfItemsNeedingRepair()
	{
		local items = [];
		local stash = [];
		local roster = this.World.getPlayerRoster().getAll()
		foreach (bro in roster)
		{
			local bitems = bro.getItems().getAllItems();
			foreach( item in bitems )
			{
				if (item == null)
				{
					continue
				}

				if (item.getRepair() >= item.getRepairMax())
				{
					continue;
				}

				items.push({
					Bro = bro.getID(),
					Item = item
				});
			}
		}
		local stashItems = this.Stash.getItems();
		foreach( item in stashItems)
		{
			if (item == null)
			{
				continue;
			}

			if (item.getRepair() >= item.getRepairMax())
			{
				continue;
			}

			if (item.isToBeSalvaged())
			{
				continue;
			}

			if (item.isToBeRepaired())
			{
				items.push({
					Bro = null,
					Item = item
				});
			}
			else
			{
				stash.push({
					Bro = null,
					Item = item
				});
			}
		}
		items.sort(this.sortRepairQueue);
		return {Items = items, Stash = stash};
	}

	function assignEquipped()
	{
		local roster = this.World.getPlayerRoster().getAll()
		foreach( bro in roster)
		{
			local bitems = bro.getItems().getAllItems();
			foreach( item in bitems )
			{
				if (item == null)
				{
					continue
				}

				if (item.getRepair() >= item.getRepairMax())
				{
					continue;
				}

				if (item.isToBeRepaired())
				{
					continue;
				}

				item.setToBeRepaired(true, 0);
			}
		}
	}

	function assignAll( _filter = 0 )
	{
		if (_filter == 0)
		{
			_filter = this.Const.Items.ItemFilter.All;
		}

		local index = 0
		foreach (i, s in this.m.Stash)
		{
			if (s == null)
			{
				continue
			}

			if (_filter == 99 && s.Bro != null)
			{
				continue;
			}
			else if ((s.Item.getItemType() & _filter) == 0)
			{
				continue;
			}

			for (index; index < this.m.Repairs.len(); index = ++index)
			{
				if (this.m.Repairs[index] == null)
				{
					break;
				}
			}

			s.Item.setToBeRepaired(true, index);
			if (index >= this.m.Repairs.len())
			{
				this.m.Repairs.push(s);
			}
			else
			{
				this.m.Repairs[index] = s;
			}
			s.Item.playInventorySound(this.Const.Items.InventoryEventType.PlacedInBag)
			this.m.Stash[i] = null;
		}
	}

	function removeAll()
	{
		local index = 0;
		foreach (i, s in this.m.Repairs)
		{
			if (s == null)
			{
				continue
			}

			for (index; index < this.m.Repairs.len(); index = ++index)
			{
				if (this.m.Stash[index] == null)
				{
					break;
				}
			}

			s.Item.setToBeRepaired(false, 0);
			if (index >= this.m.Stash.len())
			{
				this.m.Stash.push(s);
			}
			else
			{
				this.m.Stash[index] = s;
			}
			s.Item.playInventorySound(this.Const.Items.InventoryEventType.PlacedInBag)
			this.m.Repairs[i] = null;
		}
	}

	function swapItems( sourceItemOwner, sourceItemIdx, targetItemOwner, targetItemIdx )
	{
		if (targetItemOwner == null)
		{
			this.logError("onSwapItem #1");
			return false;
		}

		if (sourceItemOwner == targetItemOwner && sourceItemIdx == targetItemIdx)
		{
			return false
		}

		local sourceList = null;
		local targetList = null;
		local isRepair = false
		switch(sourceItemOwner)
		{
		case "camp-screen-repair-dialog-module.stash":
			sourceList = this.m.Stash
			if (sourceItemOwner == targetItemOwner)
			{
				targetList = this.m.Stash;
			}
			else
			{
				targetList = this.m.Repairs;
				isRepair = true;
			}
			break;

		case "camp-screen-repair-dialog-module.shop":
			sourceList = this.m.Repairs
			if (sourceItemOwner == targetItemOwner)
			{
				targetList = this.m.Repairs;
				isRepair = true
			}
			else
			{
				targetList = this.m.Stash;
			}
			break;
		}

		local sourceItem = sourceList[sourceItemIdx];

		if (sourceItem == null)
		{
			this.logError("onSwapItem(stash) #2");
			return false;
		}

		//We've picked a spot to drop it
		if (targetItemIdx != null)
		{
			//Make sure array is big enough for target spot
			while (targetItemIdx > targetList.len() - 1)
			{
				targetList.push(null)
			}
			sourceList[sourceItemIdx] = targetList[targetItemIdx];
			targetList[targetItemIdx] = sourceItem;
			sourceItem.Item.playInventorySound(this.Const.Items.InventoryEventType.PlacedInBag)
			local index = 0
			if (isRepair)
			{
				index = targetItemIdx
			}
			sourceItem.Item.setToBeRepaired(isRepair, index);
			return true
		}

		//didn't pick a spot to drop, find the first null spot
		foreach (i,r in targetList)
		{
			if (r != null)
			{
				continue
			}
			targetList[i] = sourceItem;
			sourceList[sourceItemIdx] = null;
			sourceItem.Item.playInventorySound(this.Const.Items.InventoryEventType.PlacedInBag)
			local index = 0
			if (isRepair)
			{
				index = i
			}
			sourceItem.Item.setToBeRepaired(isRepair, index);
			return true
		}

		//No null spot, push to the end
		targetList.push(sourceItem);
		sourceList[sourceItemIdx] = null;
		sourceItem.Item.playInventorySound(this.Const.Items.InventoryEventType.PlacedInBag)
		local index = 0
		if (isRepair)
		{
			index = targetList.len() - 1
		}
		sourceItem.Item.setToBeRepaired(isRepair, index);
		return true
	}

	function onClicked( _campScreen )
	{
		_campScreen.showRepairDialog();
		this.camp_building.onClicked(_campScreen);
	}

	function onSerialize( _out )
	{
		this.camp_building.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.camp_building.onDeserialize(_in);
	}

});
