::mods_hookExactClass("entity/tactical/humans/barbarian_chosen", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		if (::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.Overwhelm);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendOnslaught);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendAlert);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendBalance);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendStrengthInNumbers);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecUnarmed);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
	}

	o.getLootForTile <- function (_killer, _loot) {
		if (!(_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals))
			return getLootForTile(_killer, _loot);
		if (this.getSkills().hasSkill("injury_permanent.legend_ursathropy_injury"))
			_loot.push(::new("scripts/items/misc/legend_werehand_item"));
		return this.human.getLootForTile(_killer, _loot);
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
			];

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
			];

			foreach( item in this.Const.World.Common.pickOutfit(outfits, armor, helmet) )
			{
				this.m.Items.equip(item);
			}
			return;
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body))
		{
			local armor = [
				[1, "barbarians/thick_plated_barbarian_armor"],
				[1, "barbarians/reinforced_heavy_iron_armor"],
				[1, "barbarian_chosen_armor_00"],
				[1, "barbarian_chosen_armor_01"]
			];
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
		::Legends.Perks.grant(this, ::Legends.Perk.Fearsome);
		return true;
	}
});
