::mods_hookExactClass("entity/tactical/humans/barbarian_marauder", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.Overwhelm);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendOnslaught);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendAlert);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendBalance);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendStrengthInNumbers);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecUnarmed);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60)
		{
			::Legends.Perks.grant(this, ::Legends.Perk.Relentless);
		}
	}

	o.assignRandomEquipment = function ()
	{
		local r = this.Math.rand(1, 5);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/barbarians/axehammer"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/barbarians/crude_axe"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/barbarians/blunt_cleaver"));
		}
		else if (r == 4)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/barbarians/skull_hammer"));
		}
		else if (r == 5)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/barbarians/two_handed_spiked_mace"));
		}

		if (this.getIdealRange() == 1 && this.Math.rand(1, 100) <= 40)
		{
			r = this.Math.rand(1, 3);

			if (r == 1)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/barbarians/heavy_throwing_axe"));
			}
			else if (r == 2)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/barbarians/heavy_javelin"));
			}
			else if (r == 3)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/throwing_spear"));
			}
		}

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null && this.Math.rand(1, 100) <= 20)
		{
			this.m.Items.equip(this.new("scripts/items/shields/wooden_shield_old"));
		}

		local armor = [
			[33, ::Legends.Armor.Barbarian.scrap_metal_armor],
			[34, ::Legends.Armor.Barbarian.hide_and_bone_armor],
			[33, ::Legends.Armor.Barbarian.reinforced_animal_hide_armor]
		];
		armor.push(
			[5, ::Legends.Armor.Barbarian.legend_barbarian_southern_armor]
		);

		this.m.Items.equip(this.Const.World.Common.pickArmor(armor));

		local item = this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Barbarian.leather_headband],
			[1, ::Legends.Helmet.Barbarian.bear_headpiece],
			[1, ::Legends.Helmet.Barbarian.leather_helmet],
			[1, ::Legends.Helmet.Barbarian.crude_metal_helmet],
			[1, ""]
		]);
		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}
});
