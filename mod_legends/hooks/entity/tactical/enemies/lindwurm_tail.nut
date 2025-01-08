::mods_hookExactClass("entity/tactical/enemies/lindwurm_tail", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		local b = this.m.BaseProperties;
		b.IsAffectedByRain = false;
		this.m.Skills.add(this.new("scripts/skills/perks/perk_stalwart"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_composure"));
		if(::Legends.isLegendaryDifficulty())
		{
			this.m.Hitpoints = b.Hitpoints * 1.5;
			this.m.ActionPoints = b.ActionPoints + 5;
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_muscularity"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_composure"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
		this.getFlags().add("tail");
	}
});
