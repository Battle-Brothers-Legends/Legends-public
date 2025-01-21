::mods_hookExactClass("entity/tactical/humans/militia_veteran", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.Recover);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecialistMilitiaSkill);
		::Legends.Perks.grant(this, ::Legends.Perk.ShieldBash);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.SpecSpear);
			::Legends.Perks.grant(this, ::Legends.Perk.ShieldExpert);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecialistMilitiaDamage);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecSpearWall);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecSpearThrust);
			::Legends.Perks.grant(this, ::Legends.Perk.Rotation);
			::Legends.Perks.grant(this, ::Legends.Perk.ReachAdvantage);
			::Legends.Perks.grant(this, ::Legends.Perk.CoupDeGrace);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecialistShieldSkill);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecialistShieldPush);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendSmashingShields);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendBackToBasics);
			::Legends.Perks.grant(this, ::Legends.Perk.ShieldBash);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendStrengthInNumbers);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
	}

	o.assignRandomEquipment = function ()
	{
		local r;

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand) == null)
		{
			local weapons = [
				"weapons/hooked_blade",
				"weapons/pike",
				"weapons/woodcutters_axe",
				"weapons/bludgeon",
				"weapons/hand_axe",
				"weapons/militia_spear",
				"weapons/boar_spear",
				"weapons/falchion",
				"weapons/shortsword",
				"weapons/legend_militia_glaive",
				"weapons/legend_glaive",
				"weapons/legend_infantry_axe",
				"weapons/legend_military_goedendag",
				"weapons/goedendag",
				"weapons/warfork"
			];

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.Math.rand(1, 100) <= 50)
		{
			this.m.Items.equip(this.new("scripts/items/shields/wooden_shield"));
		}

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "leather_tunic"],
			[1, "gambeson"],
			[1, "padded_leather"],
			[1, "padded_surcoat"],
			[1, "leather_lamellar"],
			[1, "thick_tunic"]
		]));

		if (this.Math.rand(1, 100) <= 75)
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "hood"],
				[1, "aketon_cap"],
				[1, "full_leather_cap"]
			]))
		}
	}
});
