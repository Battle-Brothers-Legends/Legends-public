::mods_hookExactClass("entity/tactical/enemies/lindwurm_tail", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		local b = this.m.BaseProperties;
		b.IsAffectedByRain = false;
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Stalwart);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendComposure);
		if(::Legends.isLegendaryDifficulty())
		{
			this.m.Hitpoints = b.Hitpoints * 1.5;
			this.m.ActionPoints = b.ActionPoints + 5;
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendMuscularity);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Pathfinder);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendComposure);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.KillingFrenzy);
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
		this.getFlags().add("tail");
	}
});
