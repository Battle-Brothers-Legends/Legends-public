::mods_hookExactClass("entity/tactical/enemies/serpent", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
	 	if (::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.Dodge);
			::Legends.Perks.grant(this, ::Legends.Perk.Anticipation);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendAlert);
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
			this.m.Skills.add(this.new("scripts/skills/traits/weasel_trait"));
		}
	}
});
