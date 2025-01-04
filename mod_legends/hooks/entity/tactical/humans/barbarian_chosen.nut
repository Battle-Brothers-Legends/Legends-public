::mods_hookExactClass("entity/tactical/humans/barbarian_chosen", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_onslaught"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_alert"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_balance"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_mastery_fist"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
	}

	o.onDeath = function ( _killer, _skill, _tile, _fatalityType )
	{
		if (!this.Tactical.State.isScenarioMode() && _killer != null && _killer.isPlayerControlled())
		{
			this.updateAchievement("KingOfTheNorth", 1, 1);
		}
		if ((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals) && this.m.Skills.hasSkill("injury_permanent.legend_ursathropy_injury"))
		{
			local loot = this.new("scripts/items/misc/legend_werehand_item");
			loot.drop(_tile);
		}

		this.human.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	o.assignRandomEquipment = function ()
	{
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/barbarians/rusty_warblade",
				"weapons/barbarians/heavy_rusty_axe"
			];
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body) && this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
		{
			local armor = [
				[1, "barbarians/thick_plated_barbarian_armor"],
				[1, "barbarians/reinforced_heavy_iron_armor"],
			]

			local helmet = [
				[1, "barbarians/heavy_horned_plate_helmet"],
				[1, "barbarian_chosen_helmet_00"],
				[1, "barbarian_chosen_helmet_01"],
				[1, "barbarian_chosen_helmet_02"],
			];

			local outfits = [
				[1, "barbarian_chosen_outfit_00"],
				[1, "barbarian_chosen_outfit_01"],
				[1, "barbarian_chosen_outfit_02"]
			]

			foreach( item in this.Const.World.Common.pickOutfit(outfits, armor, helmet) )
			{
				this.m.Items.equip(item)
			}
			return;
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body))
		{
			local armor = [
				[1, "barbarians/thick_plated_barbarian_armor"]
			];
			armor.push(
				[1, "barbarians/reinforced_heavy_iron_armor"]
			);
			armor.push(
				[1, "barbarian_chosen_armor_00"]
			);
			armor.push(
				[1, "barbarian_chosen_armor_01"]
			);

			this.m.Items.equip(this.Const.World.Common.pickArmor(armor));
		}
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
		{
			local helmet = [
				[1, "barbarians/heavy_horned_plate_helmet"],
				[1, "barbarian_chosen_helmet_00"],
				[1, "barbarian_chosen_helmet_01"],
				[1, "barbarian_chosen_helmet_02"],
			];

			// if (!::Legends.Mod.ModSettings.getSetting("UnlayeredArmor").getValue())
			// {
			// 	helmet.push(
			// 		[1, "barbarians/rusted_heavy_plate_helmet"]
			// 	);
			// }

			this.m.Items.equip(this.Const.World.Common.pickHelmet(helmet));
		}
	}

	o.makeMiniboss = function ()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = this.Const.Items.NamedBarbarianWeapons;
		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
		return true;
	}
});
