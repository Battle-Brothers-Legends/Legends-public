::mods_hookExactClass("entity/tactical/enemies/direwolf", function(o) 
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
			this.m.Skills.add(this.new("scripts/skills/racial/legend_werewolf_racial"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
	}
});
