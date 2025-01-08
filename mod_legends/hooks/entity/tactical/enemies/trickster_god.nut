::mods_hookExactClass("entity/tactical/enemies/trickster_god", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		local b = this.m.BaseProperties;
		b.IsAffectedByRain = false;
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendComposure);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendPoisonImmunity);
		{
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Colossus);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Fearsome);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.KillingFrenzy);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendLastStand);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Underdog);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendCarnage);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendBattleheart);
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
	}

	local onDeath = o.onDeath;
	o.onDeath = function ( _killer, _skill, _tile, _fatalityType )
	{
		onDeath( _killer, _skill, _tile, _fatalityType );
		if (_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals)
		{
			if (this.Math.rand(1, 100) <= 15) //15%
			{
				local loot = this.new("scripts/items/misc/legend_masterwork_tools");
				loot.drop(_tile);
			}
		}
	}
});
