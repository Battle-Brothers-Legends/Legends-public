::mods_hookExactClass("entity/tactical/enemies/hyena", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		local b = this.m.BaseProperties;
		if (::Legends.isLegendaryDifficulty())
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
			this.m.ActionPoints = b.ActionPoints + 2;
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
			this.m.Skills.add(this.new("scripts/skills/traits/iron_jaw_trait"));
		};
	}
});
