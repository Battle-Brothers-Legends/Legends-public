::mods_hookExactClass("entity/tactical/enemies/lindwurm_tail", function(o)
{
	local onInit = o.onInit;
	o.onInit = function () {
		onInit();
		local b = this.m.BaseProperties;
		b.IsAffectedByRain = false;
		::Legends.Perks.grant(this, ::Legends.Perk.Stalwart);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendComposure);
		if(::Legends.isLegendaryDifficulty())
		{
			this.m.Hitpoints = b.Hitpoints * 1.5;
			this.m.ActionPoints = b.ActionPoints + 5;
			::Legends.Perks.grant(this, ::Legends.Perk.LegendMuscularity);
			::Legends.Perks.grant(this, ::Legends.Perk.Pathfinder);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendComposure);
			::Legends.Perks.grant(this, ::Legends.Perk.KillingFrenzy);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
		this.getFlags().add("tail");

		local skills = this.getSkills();
		local skills_add = skills.add;
		skills.add = function( _skill, _order = 0 )	{
			if ((_skill.getID() in this.getActor().m.Body.m.EffectsSharedWithTailLookup || _skill.getID() == ::Legends.Effects.getID(::Legends.Effect.LegendChoked)) && (!("IsFromHead" in _skill.m) || !_skill.m.IsFromHead)) {
				return;
        	}
        	skills_add(_skill, _order);
		}.bindenv(skills);
	}
});
