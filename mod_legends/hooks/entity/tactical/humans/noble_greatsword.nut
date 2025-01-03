::mods_hookExactClass("entity/tactical/humans/noble_greatsword", function(o) 
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_mastery_greatsword"));

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_forceful_swing"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_feint"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_back_to_basics"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_bloody_harvest"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_full_force"));
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
