::mods_hookExactClass("entity/tactical/humans/barbarian_beastmaster", function(o) 
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		this.m.Skills.removeByID("effects.dodge");
		if("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_onslaught"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_alert"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_balance"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_mastery_fist"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 30)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_dodge"));
		}
	}

	o.assignRandomEquipment = function ()
	{
		this.m.Items.equip(this.new("scripts/items/weapons/barbarians/thorned_whip"));
		
		this.m.Items.equip(this.Const.World.Common.pickArmor([
				[1, "barbarians/hide_and_bone_armor"]
		]));

		this.m.Items.equip(this.Const.World.Common.pickHelmet([
			[1, "barbarians/beastmasters_headpiece"]
		]));
	}
});