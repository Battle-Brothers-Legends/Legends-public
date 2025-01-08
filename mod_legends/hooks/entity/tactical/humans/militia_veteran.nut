::mods_hookExactClass("entity/tactical/humans/militia_veteran", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Recover);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendSpecialistMilitiaSkill);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.ShieldBash);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.SpecSpear);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.ShieldExpert);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendSpecialistMilitiaDamage);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendSpecSpearWall);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendSpecSpearThrust);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Rotation);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.ReachAdvantage);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.CoupDeGrace);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendSpecialistShieldSkill);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendSpecialistShieldPush);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendSmashingShields);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendBackToBasics);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.ShieldBash);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Backstabber);
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
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
			];

			if (this.Const.DLC.Unhold)
			{
				weapons.extend([
					"weapons/goedendag"
				]);
			}

			if (this.Const.DLC.Wildmen)
			{
				weapons.extend([
					"weapons/warfork"
				]);
			}

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
