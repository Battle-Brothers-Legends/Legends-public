::mods_hookExactClass("entity/tactical/enemies/serpent", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
	 	if (::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Dodge);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Anticipation);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendAlert);
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
			this.m.Skills.add(this.new("scripts/skills/traits/weasel_trait"));
		}
	}
});
