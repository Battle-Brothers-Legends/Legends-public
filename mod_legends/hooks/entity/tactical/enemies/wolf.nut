::mods_hookExactClass("entity/tactical/enemies/wolf", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.Berserk);
			::Legends.Perks.grant(this, ::Legends.Perk.Backstabber);
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
	}
});
