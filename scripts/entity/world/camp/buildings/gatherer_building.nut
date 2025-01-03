this.gatherer_building <- this.inherit("scripts/entity/world/camp/camp_building", {
	m = {
		Items = [],
		MedsAdded = 0,
		NumBros = 0,
		Craft = 0
	},
	function create()
	{
		this.camp_building.create();
		this.m.ID = this.Const.World.CampBuildings.Gatherer;
		this.m.ModName = "Gathering";
		this.m.BaseCraft = 0.5;
		this.m.Slot = "gather";
		this.m.Name = "Supply Tent";
		this.m.Description = "Send people out to gather supplies like medicinal herbs, plants, wood and stones.";
		this.m.BannerImage = "ui/buttons/banner_gather.png";
		this.m.CanEnter = false;
	}

	function getTitle()
	{
		if (this.getUpgraded())
		{
			return this.m.Name + " *Upgraded*";
		}

		return this.m.Name + " *Not Upgraded*";
	}

	function getDescription()
	{
		local desc = "";
		desc = desc + "People assigned to this task will go out get supplies, like herbs and plants of medicinal quality. The more people assigned, the more is gathered. ";
		desc = desc + "The more people assigned, the more medicine is gathered. Skilled backgrounds increase the amount further.";
		desc = desc + "\n\n";
		desc = desc + "Assigning Woodsmen with the Woodsman\'s Cuts perk can return wood for trade, while Miners with the Miners Strikes perk can find gems. ";
		desc = desc + "Assigning skilled apocatheries like Herbalists, Vala, Alchemists and Druids can return more advanced medicines and bandages.";
		desc = desc + "\n\n";
		desc = desc + "Buying an upgraded tent will increase gathering speed by 15% and produce more kinds of medicine. ";
		desc = desc + "Having both an upgraded tent and skilled apothecaries can provide rare medicines, and powerful potions.";
		return desc;
	}

	function getModifierToolip()
	{
		local mod = this.getModifiers();
		local ret = [
			{
				id = 5,
				type = "text",
				icon = "ui/buttons/asset_medicine_up.png",
				text = "Produces [color=" + this.Const.UI.Color.PositiveValue + "]" + mod.Craft / 3.0 + "[/color] units of medicine per hour."
			}
		];
		local id = 6;

		foreach( bro in mod.Modifiers )
		{
			ret.push({
				id = id,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + bro[0] / 3.0 + "[/color] units/hour " + bro[1] + " (" + bro[2] + ")"
			});
			id = ++id;
		}

		return ret;
	}

	function isHidden()
	{
		if (::Legends.Mod.ModSettings.getSetting("SkipCamp").getValue())
		{
			return false;
		}

		return !this.World.Flags.get("HasLegendCampGathering");
	}

	function getUpgraded()
	{
		return this.Stash.hasItem("tent.gather_tent");
	}

	function getLevel()
	{
		local pro = "dude";

		if (this.getUpgraded())
		{
			pro = "tent";
		}

		local sub = "empty";

		if (this.getAssignedBros() > 0)
		{
			sub = "full";
		}

		return pro + "_" + sub;
	}

	function init()
	{
		this.m.MedsAdded = 0;
		this.m.Items = [];
		local mod = this.getModifiers();
		this.m.NumBros = mod.Assigned;
		this.m.Craft = mod.Craft;
	}

	function getResults()
	{
		local res = [];
		local id = 60;

		if (this.m.MedsAdded > 0)
		{
			res.push({
				id = id,
				icon = "ui/buttons/asset_medicine_up.png",
				text = "You gathered " + this.Math.floor(this.m.MedsAdded) + " units of medicine"
			});
			id = ++id;
		}

		foreach( b in this.m.Items )
		{
			if (b == null)
			{
				this.logWarning("Null item attempted in gatherer building, the length of items arr is " + this.m.Items.len());
				continue;
			}

			res.push({
				id = id,
				icon = "ui/items/" + b.getIcon(),
				text = "You gained " + b.getName()
			});
			id = ++id;
		}

		return res;
	}

	function getAssignedBros()
	{
		local mod = this.getModifiers();
		return mod.Assigned;
	}

	function getUpdateText()
	{
		if (this.World.Assets.getMedicine() + this.m.MedsAdded >= this.World.Assets.getMaxMedicine())
		{
			return "Gathered ... " + this.Math.floor(this.m.MedsAdded) + " meds and " + this.m.Items.len() + " items";
		}

		local points = this.Math.floor(this.m.Craft * this.m.Camp.getElapsedHours());
		this.m.MedsAdded = this.Math.min(this.World.Assets.getMaxMedicine(), points / 3.0);
		return "Gathered ... " + this.Math.floor(this.m.MedsAdded) + " meds and " + this.m.Items.len() + " items";
	}

	function update()
	{
		if (this.m.NumBros == 0)
		{
			return null;
		}

		local levels = this.getAllLevels();
		local emptySlots = this.Stash.getNumberOfEmptySlots();

		if (emptySlots == 0)
		{
			return this.getUpdateText();
		}

		local item;
		local dropLoot = -3.0 / (this.m.Craft + 0.4) + 7.5 > this.Math.rand(1, 100);

		if (dropLoot && this.getUpgraded())
		{
			local r = this.Math.rand(1, 2);

			if (r == 1)
			{
				item = this.new("scripts/items/supplies/roots_and_berries_item");
			}
			else
			{
				item = this.new("scripts/items/supplies/legend_medicine_small_item");
			}

			this.m.Items.push(item);
			this.Stash.add(item);
			emptySlots = --emptySlots;

			if (emptySlots == 0)
			{
				return this.getUpdateText();
			}
		}

		dropLoot = -500.0 / (levels.Woodsman + 60) + 10 > this.Math.rand(1, 100);

		if (dropLoot && levels.Woodsman > 0)
		{
			local r = levels.Woodsman <= 10 ? 1 : this.Math.rand(1, 10);

			if (r >= 6)
			{
				item = this.new("scripts/items/trade/legend_raw_wood_item");
			}

			if (r == 3)
			{
				item = this.new("scripts/items/trade/quality_wood_item");
			}

			this.m.Items.push(item);
			this.Stash.add(item);
			emptySlots = --emptySlots;

			if (emptySlots == 0)
			{
				return this.getUpdateText();
			}
		}

		dropLoot = -300.0 / (levels.Woodsman + 60) + 10 > this.Math.rand(1, 100);

		if (dropLoot && levels.Woodsman > 0)
		{
			local r = levels.Woodsman > 5 ? 1 : this.Math.rand(1, 3);

			if (r == 1)
			{
				item = this.new("scripts/items/trade/legend_raw_wood_item");
			}

			this.m.Items.push(item);
			this.Stash.add(item);
			emptySlots = --emptySlots;

			if (emptySlots == 0)
			{
				return this.getUpdateText();
			}
		}

		dropLoot = -500.0 / (levels.Miner + 60) + 10 > this.Math.rand(1, 100);

		if (dropLoot && levels.Miner > 0)
		{
			local r = levels.Miner <= 10 ? 1 : this.Math.rand(1, 10);

			if (r > 7)
			{
				item = this.new("scripts/items/trade/legend_gem_shards_item");
			}

			if (r == 3)
			{
				item = this.new("scripts/items/trade/uncut_gems_item");
			}

			if (r < 2)
			{
				item = this.new("scripts/items/trade/salt_item");
			}

			this.m.Items.push(item);
			this.Stash.add(item);
			emptySlots = --emptySlots;

			if (emptySlots == 0)
			{
				return this.getUpdateText();
			}
		}

		dropLoot = -300.0 / (levels.Miner + 60) + 10 > this.Math.rand(1, 100);

		if (dropLoot && levels.Miner > 0)
		{
			local r = levels.Miner > 5 ? 1 : this.Math.rand(1, 3);

			if (r == 1)
			{
				item = this.new("scripts/items/trade/legend_gem_shards_item");
			}

			this.m.Items.push(item);
			this.Stash.add(item);
			emptySlots = --emptySlots;

			if (emptySlots == 0)
			{
				return this.getUpdateText();
			}
		}

		dropLoot = levels.Apothecary > 0 ? -600.0 / (levels.Apothecary + levels.Brewer + 60) + 10 > this.Math.rand(1, 100) : false;

		if (dropLoot)
		{
			local loot = this.new("scripts/mods/script_container");
			loot.extend([
				"scripts/items/accessory/berserker_mushrooms_item",
				"scripts/items/accessory/antidote_item",
				"scripts/items/accessory/poison_item",
				"scripts/items/misc/mysterious_herbs_item",
				"scripts/items/misc/legend_mistletoe_item",
				"scripts/items/supplies/medicine_item"
			]);

			if (this.getUpgraded() && levels.Apothecary >= 0)
			{
				loot.extend([
					"scripts/items/accessory/legend_apothecary_mushrooms_item",
					"scripts/items/misc/happy_powder_item"
				]);

				if (levels.Apothecary >= 10)
				{
					loot.extend([
						"scripts/items/accessory/lionheart_potion_item",
						"scripts/items/accessory/iron_will_potion_item",
						"scripts/items/accessory/recovery_potion_item",
						"scripts/items/accessory/cat_potion_item"
					]);

					if (levels.Apothecary >= 20)
					{
						loot.extend([
							"scripts/items/misc/miracle_drug_item",
							"scripts/items/accessory/spider_poison_item"
						]);

						if (levels.Brewer >= 35 && levels.Apothecary >= 45)
						{
							loot.extend([
								"scripts/items/misc/potion_of_knowledge_item"
							]);
						}
					}
				}
			}


			item = this.new(loot.roll());
			this.m.Items.push(item);
			this.Stash.add(item);
			emptySlots = --emptySlots;

			if (emptySlots == 0)
			{
				return this.getUpdateText();
			}
		}

		return this.getUpdateText();
	}

	function getAllLevels()
	{
		local map = {
			Brewer = 0,
			Woodsman = 0,
			Miner = 0,
			Apothecary = 0
		};
		local roster = this.World.getPlayerRoster().getAll();

		foreach( bro in roster )
		{
			if (bro.getCampAssignment() != this.m.ID)
			{
				continue;
			}

			if (bro.getSkills().hasSkill("perk.legend_potion_brewer"))
			{
				map.Brewer += bro.getLevel();
			}

			if (bro.getSkills().hasSkill("perk.legend_specialist_woodaxe_damage"))
			{
				map.Woodsman += bro.getLevel();
			}

			if (bro.getSkills().hasSkill("perk.legend_specialist_pickaxe_damage"))
			{
				map.Miner += bro.getLevel();
			}

			switch(bro.getBackground().getID())
			{
				case "background.legend_vala":
				case "background.legend_herbalist":
				case "background.legend_alchemist":
				case "background.legend_druid":
				case "background.legend_druid_commander":
					map.Apothecary += bro.getLevel();
			}

			if (bro.getSkills().hasSkill("perk.legend_gatherer"))
			{
				map.Apothecary += bro.getLevel();
			}
		}

		return map;
	}

	function completed()
	{
		local item;

		if (this.m.MedsAdded > 0)
		{
			this.World.Assets.addMedicine(this.Math.floor(this.m.MedsAdded));
		}
	}

	function onClicked( _campScreen )
	{
		_campScreen.showGathererDialog();
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

