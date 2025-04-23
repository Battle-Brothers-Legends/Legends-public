::mods_hookExactClass("entity/tactical/humans/cultist", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		local b = this.m.BaseProperties;
		b.IsSpecializedInFlails = true;
		b.IsSpecializedInCleavers = true;
		this.getSprite("socket").setBrush("bust_base_orcs");
		::Legends.Perks.grant(this, ::Legends.Perk.Dodge);
		::Legends.Perks.grant(this, ::Legends.Perk.SpecFlail);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendLacerate);
		::Legends.Perks.grant(this, ::Legends.Perk.HeadHunter);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendBloodbath);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecialistCultist);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecCultHood);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecCultArmor);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.BattleFlow);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
	}

	o.assignRandomEquipment = function ()
	{
		local r = this.Math.rand(1, 7);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/butchers_cleaver"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/reinforced_wooden_flail"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/wooden_flail"));
		}
		else if (r == 4)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/battle_whip"));
		}
		else if (r == 5)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/barbarians/antler_cleaver"));
		}
		else if (r == 6)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/barbarians/blunt_cleaver"));
		}
		else if (r == 7)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_ranged_wooden_flail"));
		}

		if (this.Math.rand(1, 100) <= 66 && this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
		{
			if (this.Math.rand(1, 100) <= 50)
			{
				this.m.Items.equip(this.new("scripts/items/tools/throwing_net"));
			}
			else
			{
				this.m.Items.equip(this.new("scripts/items/shields/wooden_shield_old"));
			}
		}

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[3, ::Legends.Armor.Standard.cultist_leather_robe],
			[3, ::Legends.Armor.Standard.tattered_sackcloth],
			[2, ::Legends.Armor.Barbarian.animal_hide_armor],
			[1, ::Legends.Armor.Barbarian.hide_and_bone_armor]
		]));

		local item = this.Const.World.Common.pickHelmet([
			[2, ::Legends.Helmet.Standard.cultist_hood],
			[1, ::Legends.Helmet.Standard.cultist_leather_hood]
		]);

		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}
});
