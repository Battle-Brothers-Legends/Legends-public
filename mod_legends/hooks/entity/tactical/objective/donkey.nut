::mods_hookExactClass("entity/tactical/objective/donkey", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();

		this.m.Skills.add(this.new("scripts/skills/actives/legend_donkey_kick_skill"));
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.LegendMuscularity);
			::Legends.Perks.grant(this, ::Legends.Perk.Steadfast);
			::Legends.Perks.grant(this, ::Legends.Perk.Stalwart);
		}
		this.m.Skills.update();
	}
});
