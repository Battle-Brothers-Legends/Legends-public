::mods_hookExactClass("entity/tactical/objective/donkey", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();

		this.m.Skills.add(this.new("scripts/skills/actives/legend_donkey_kick_skill"));
		if(::Legends.isLegendaryDifficulty())
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_muscularity"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_steadfast"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_stalwart"));
		}
		this.m.Skills.update();
	}
});
