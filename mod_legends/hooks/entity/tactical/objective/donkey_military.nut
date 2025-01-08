::mods_hookExactClass("entity/tactical/objective/donkey_military", function(o)
{
	o.onInit <- function ()
	{
		this.donkey.onInit();
		this.m.Skills.add(this.new("scripts/skills/actives/legend_donkey_kick_skill"));
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendMuscularity);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Steadfast);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Stalwart);
		}
		this.m.Skills.update();
	}
});
