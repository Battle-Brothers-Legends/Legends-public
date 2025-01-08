::mods_hookExactClass("entity/tactical/enemies/zombie_betrayer", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		local b = this.m.BaseProperties;
		b.SurroundedBonus = 5; // resetting from vanilla
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_poison_immunity"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
		if(::Legends.isLegendaryDifficulty())
		{
			b.MeleeSkill += 5;
			this.m.Hitpoints = b.Hitpoints * 1.5;
		}
	}
});
