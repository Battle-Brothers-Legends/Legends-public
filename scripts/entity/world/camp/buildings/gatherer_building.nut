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
		desc = desc + "Assigning Woodsmen with the Woodsman\'s Cuts perk can return wood for trade, while Miners with the Ore Hunter perk can find gems. ";
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
				text = "Produces [color=%positive%]" + mod.Craft / 3.0 + "[/color] units of medicine per hour."
			}
		];
		local id = 6;

		foreach( bro in mod.Modifiers )
		{
			ret.push({
				id = id,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "[color=%positive%]" + bro[0] / 3.0 + "[/color] units/hour " + bro[1] + " (" + bro[2] + ")"
			});
			id = ++id;
		}

		return ret;
	}

	function isHidden()
	{
		if (::Legends.Settings.skipCamp())
		{
			return false;
		}

		return !this.World.Flags.get("HasLegendCampGathering");
	}

	function getUpgraded()
	{
		return this.Stash.hasItem(::Legends.Camp.Tent.Gather);
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

	function update() {
		if (this.m.NumBros == 0) {
			return null;
		}

		if (this.Stash.getNumberOfEmptySlots() == 0) {
			return this.getUpdateText();
		}

		local gatherItem = function (_condition, _lootTable) {
			if (_condition < ::Math.rand(1, 100) || _lootTable.len() == 0) {
				return false;
			}

			local chanceSum = 0;
			foreach (item in _lootTable) {
				chanceSum += item.chance;
			}
			local r = ::Math.rand(1, chanceSum);

			foreach (loot in _lootTable) {
				r -= loot.chance;

				if (r <= 0) {
					if (loot.script == null) {
						return false;
					}

					local item = ::new(loot.script);
					this.m.Items.push(item);
					this.Stash.add(item);
					return this.Stash.getNumberOfEmptySlots() == 0;
				}
			}

			return false;
		}.bindenv(this);

		local levels = this.getAllLevels();
		local lootTable = null;

		if (this.getUpgraded()) {
			lootTable = [
        		{ script = "scripts/items/supplies/roots_and_berries_item", chance = 1 },
        		{ script = "scripts/items/supplies/legend_medicine_small_item", chance = 1 }
    		];
			if (gatherItem(-3.0 / (this.m.Craft + 0.4) + 7.5, lootTable)) {
				return this.getUpdateText()
			}
        }

		if (levels.Woodsman > 0) {
			lootTable = [
        		{ script = "scripts/items/trade/legend_raw_wood_item", chance = levels.Woodsman <= 10 ? 0 : 5 },
        		{ script = "scripts/items/trade/quality_wood_item", chance = levels.Woodsman <= 10 ? 0 : 1 },
				{ script = null, chance = 4 }
    		];
			if (gatherItem(-500.0 / (levels.Woodsman + 60) + 10, lootTable)) {
				return this.getUpdateText()
			}

			lootTable = [
				{ script = "scripts/items/trade/legend_raw_wood_item", chance = 1 },
				{ script = null, chance = levels.Woodsman > 5 ? 0 : 2 }
			];
			if (gatherItem(-300.0 / (levels.Woodsman + 60) + 10, lootTable)) {
				return this.getUpdateText()
			}
		}

		if (levels.Miner > 0) {
			lootTable = [
				{ script = "scripts/items/trade/legend_gem_shards_item", chance = levels.Miner <= 10 ? 0 : 3 },
				{ script = "scripts/items/trade/uncut_gems_item", chance = levels.Miner <= 10 ? 0 : 1 },
				{ script = "scripts/items/trade/salt_item", chance = 1 },
				{ script = null, chance = levels.Miner <= 10 ? 0 : 5 }
			];
			if (gatherItem(-500.0 / (levels.Miner + 60) + 10, lootTable)) {
				return this.getUpdateText()
			}

			lootTable = [
				{ script = "scripts/items/trade/legend_gem_shards_item", chance = 1 },
				{ script = null, chance = levels.Miner > 5 ? 0 : 2 }
			];
			if (gatherItem(-300.0 / (levels.Miner + 60) + 10, lootTable)) {
				return this.getUpdateText()
			}
		}

		if (levels.Apothecary > 0) {
			lootTable = [
				{ script = "scripts/items/accessory/berserker_mushrooms_item", chance = 1 },
				{ script = "scripts/items/accessory/antidote_item", chance = 1 },
				{ script = "scripts/items/accessory/poison_item", chance = 1 },
				{ script = "scripts/items/misc/mysterious_herbs_item", chance = 1 },
				{ script = "scripts/items/misc/legend_mistletoe_item", chance = 1 },
				{ script = "scripts/items/supplies/medicine_item", chance = 1 }
			];

			if (this.getUpgraded()) {
				lootTable.extend([
					{ script = "scripts/items/misc/happy_powder_item", chance = 1 },
					{ script = "scripts/items/accessory/legend_apothecary_mushrooms_item", chance = 1 }
				]);
			}
			if (levels.Apothecary >= 10) {
                   lootTable.extend([
					{ script = "scripts/items/accessory/lionheart_potion_item", chance = 1 },
					{ script = "scripts/items/accessory/iron_will_potion_item", chance = 1 },
					{ script = "scripts/items/accessory/recovery_potion_item", chance = 1 },
					{ script = "scripts/items/accessory/cat_potion_item", chance = 1 }
                ]);

                if (levels.Apothecary >= 20) {
                    lootTable.extend([
						{ script = "scripts/items/misc/miracle_drug_item", chance = 1 },
						{ script = "scripts/items/accessory/spider_poison_item", chance = 1 }
                    ]);

            	    if (levels.Brewer >= 35 && levels.Apothecary >= 45) {
                        lootTable.extend([
							{ script = "scripts/items/misc/potion_of_knowledge_item", chance = 1 }
						]);
                    }
                }
            }

			if (gatherItem(-600.0 / (levels.Apothecary + levels.Brewer + 60) + 10, lootTable)) {
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

			if (bro.getSkills().hasPerk(::Legends.Perk.LegendPotionBrewer))
			{
				map.Brewer += bro.getLevel();
			}

			if (bro.getSkills().hasPerk(::Legends.Perk.LegendWoodworking))
			{
				map.Woodsman += bro.getLevel();
			}

			if (bro.getSkills().hasPerk(::Legends.Perk.LegendOreHunter))
			{
				map.Miner += bro.getLevel();
			}

			switch(bro.getBackground().getID())
			{
				case "background.legend_vala":
				case "background.legend_herbalist":
				case "background.legend_alchemist":
				case "background.legend_druid":
				case "background.legend_commander_druid":
					map.Apothecary += bro.getLevel();
			}

			if (bro.getSkills().hasPerk(::Legends.Perk.LegendGatherer))
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


