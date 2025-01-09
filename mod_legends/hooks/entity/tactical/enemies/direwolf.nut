::mods_hookExactClass("entity/tactical/enemies/direwolf", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		if (::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.Backstabber);
			this.m.Skills.add(this.new("scripts/skills/racial/legend_werewolf_racial"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
	}
});
