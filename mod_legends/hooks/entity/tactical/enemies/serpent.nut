::mods_hookExactClass("entity/tactical/enemies/serpent", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
	 	if (::Legends.isLegendaryDifficulty())
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_dodge"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_alert"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
			this.m.Skills.add(this.new("scripts/skills/traits/weasel_trait"));
		}
	}
});
