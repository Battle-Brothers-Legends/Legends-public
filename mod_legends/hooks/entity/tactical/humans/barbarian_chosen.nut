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
				[1, ::Legends.Armor.Barbarian.thick_plated_barbarian_armor],
				[1, ::Legends.Armor.Barbarian.reinforced_heavy_iron_armor],
			];

			local helmet = [
				[1, ::Legends.Helmet.Barbarian.heavy_horned_plate_helmet],
				[1, ::Legends.Helmet.Standard.barbarian_chosen_helmet_00],
				[1, ::Legends.Helmet.Standard.barbarian_chosen_helmet_01],
				[1, ::Legends.Helmet.Standard.barbarian_chosen_helmet_02],
			];

			local outfits = [
				[1, ::Legends.Outfit.barbarian_chosen_outfit_00],
				[1, ::Legends.Outfit.barbarian_chosen_outfit_01],
				[1, ::Legends.Outfit.barbarian_chosen_outfit_02]
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
				[1, ::Legends.Armor.Barbarian.thick_plated_barbarian_armor],
				[1, ::Legends.Armor.Barbarian.reinforced_heavy_iron_armor],
				[1, ::Legends.Armor.Standard.barbarian_chosen_armor_00],
				[1, ::Legends.Armor.Standard.barbarian_chosen_armor_01]
			];
			this.m.Items.equip(this.Const.World.Common.pickArmor(armor));
		}
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
		{
			local helmet = [
				[1, ::Legends.Helmet.Barbarian.heavy_horned_plate_helmet],
				[1, ::Legends.Helmet.Standard.barbarian_chosen_helmet_00],
				[1, ::Legends.Helmet.Standard.barbarian_chosen_helmet_01],
				[1, ::Legends.Helmet.Standard.barbarian_chosen_helmet_02],
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
		local weapons = clone ::Const.Items.NamedBarbarianWeapons;
		local armor = ::Const.Items.NamedBarbarianArmors;
		local helmets = ::Const.Items.NamedBarbarianHelmets;
		local r = this.Math.rand(1, 3);

		if (r == 1)
		{
			if (this.Math.rand(1, 100) < 90) // basically low chance to spawn with these cause they're better than the rest of the barb gear
			{
				::MSU.Array.remove(weapons, "weapons/named/legend_named_rusty_greatsword");
				::MSU.Array.remove(weapons, "weapons/named/legend_named_rusty_serrated_axe");
			}
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}
		else if (r == 2)
		{
			local weightName = this.Const.World.Common.convNameToList(armor);
			this.m.Items.equip(this.Const.World.Common.pickArmor(weightName));
		}
		else
		{
			local weightName = this.Const.World.Common.convNameToList(helmets);
			this.m.Items.equip(this.Const.World.Common.pickHelmet(weightName));
		}
		return true;
	}
});
