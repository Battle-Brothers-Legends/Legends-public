::mods_hookExactClass("entity/tactical/humans/noble_greatsword", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Rotation);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Recover);
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_mastery_greatsword"));

		if (::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Underdog);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendForcefulSwing);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendFeint);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendBackToBasics);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendBloodyHarvest);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendFullForce);
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
	}

	o.assignRandomEquipment = function ()
	{
		local r;
		local banner = 3;

		if (!this.Tactical.State.isScenarioMode())
		{
			banner = this.World.FactionManager.getFaction(this.getFaction()).getBanner();
		}
		else
		{
			banner = this.getFaction();
		}

		this.m.Surcoat = banner;

		if (this.Math.rand(1, 100) <= 50)
		{
			this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));
		}

		r = this.Math.rand(1, 1);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/greatsword"));
		}



		this.m.Items.equip(this.Const.World.Common.pickArmor([
			// [2, "mail_hauberk", 28],
			// [1, "scale_armor"],
			// [1, "reinforced_mail_hauberk"],
			// [2, "footman_armor"],
			[2, "seedmaster_noble_armor"],
			[2, "citreneking_noble_armor"]
		]));


		this.m.Items.equip(this.Const.World.Common.pickHelmet([
			//[1, "greatsword_hat"],  Only 70 durability
			[1, "rondel_helm"],
			[1, "scale_helm"],
			[1, "greatsword_faction_helm", banner],
			[1, "wallace_sallet"],
			[5, "heavy_noble_house_helmet_00"]
		]));
	}
});
