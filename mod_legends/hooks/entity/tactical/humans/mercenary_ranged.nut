::mods_hookExactClass("entity/tactical/humans/mercenary_ranged", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Rotation);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Footwork);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Recover);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendBallistics);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.NineLives);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Pathfinder);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LoneWolf);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendLookout);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Berserk);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendCloseCombatArcher);
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
	}

	o.assignRandomEquipment = function ()
	{
		local r = this.Math.rand(1, 3);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/hunting_bow"));
			this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/war_bow"));
			this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/crossbow"));
			this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		}

		r = this.Math.rand(1, 4);

		if (r == 1)
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/dagger"));
		}
		else if (r == 2)
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/scramasax"));
		}
		else if (r == 3)
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/hatchet"));
		}
		else if (r == 4)
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/bludgeon"));
		}

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "thick_tunic"],
			[1, "padded_surcoat"],
			[1, "basic_mail_shirt"],
			[1, "mail_shirt"],
			[1, "ragged_surcoat"],
			[1, "padded_leather"]
		]));

		if (this.Math.rand(1, 100) <= 75)
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "hood"],
				[1, "aketon_cap"],
				[1, "full_aketon_cap"],
				[1, "full_leather_cap"],
				[1, "headscarf"],
				[1, "kettle_hat"],
				[1, "rondel_helm"],
				[1, "scale_helm"],
				[1, "mail_coif"]
			]))
		}
	}
});
