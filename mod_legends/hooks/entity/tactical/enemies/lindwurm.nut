::mods_hookExactClass("entity/tactical/enemies/lindwurm", function(o)
{
	o.m.DroppableRunes <- [
		::Legends.Rune.LegendRsaEndurance,
		::Legends.Rune.LegendRsaSafety
	];
	o.m.EffectsSharedWithTail <- [
		::Legends.Effect.Staggered,
		::Legends.Effect.Dazed,
		::Legends.Effect.LegendDazed,
		::Legends.Effect.LegendBaffled,
		::Legends.Effect.Withered,
		::Legends.Effect.InsectSwarm
	];
	o.m.EffectsSharedWithTailLookup <- {};

	local create = o.create;
	o.create = function () {
		create();
		local rolls = ::Legends.S.extraLootChance(1);
		for(local i = 0; i < rolls; i++)
		{
			this.m.OnDeathLootTable.push([1, function () {
				local selected = this.m.DroppableRunes[::Math.rand(0, this.m.DroppableRunes.len() - 1)];
				local rune = ::new(::Legends.Runes.get(selected).Script);
				rune.setRuneVariant(selected);
				rune.setRuneBonus(true);
				rune.updateRuneSigilToken();
				return rune;
			}.bindenv(this)]);
		}
		foreach(def in this.m.EffectsSharedWithTail) { // you have id:def mapping here
			this.m.EffectsSharedWithTailLookup[::Legends.Effects.getID(def)] <- def
		}
	}

	local onInit = o.onInit;
	o.onInit = function () {
		onInit();
		local b = this.m.BaseProperties;
		b.IsAffectedByRain = false;
		::Legends.Perks.grant(this, ::Legends.Perk.Stalwart);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendComposure);
		::Legends.Perks.remove(this, ::Legends.Perk.HoldOut);
		if(::Legends.isLegendaryDifficulty())
		{
			b.Hitpoints *= 1.5;
			this.m.ActionPoints = b.ActionPoints + 5;
			::Legends.Perks.grant(this, ::Legends.Perk.LegendMuscularity);
			::Legends.Perks.grant(this, ::Legends.Perk.Pathfinder);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendComposure);
			::Legends.Perks.grant(this, ::Legends.Perk.KillingFrenzy);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);

		}
		local skills = this.getSkills();
		local skills_add = skills.add;
		skills.add = function( _skill, _order = 0 ) {
			skills_add(_skill, _order);

			local actor = this.getActor();
			if (::Legends.S.isEntityNullOrDead(actor.m.Tail))
				return;
			if (_skill.getID() in actor.m.EffectsSharedWithTailLookup) {
				::Legends.Effects.grant(actor.m.Tail, actor.m.EffectsSharedWithTailLookup[_skill.getID()], function(_effect) {
					_effect.m.IsFromHead <- true;
				});
			}
		}.bindenv(skills);
	}

	local kill = o.kill;
	o.kill = function (_killer = null, _skill = null, _fatalityType = this.Const.FatalityType.None, _silent = false) {
		kill(_killer, _skill, _fatalityType, _silent);
		::Tactical.TurnSequenceBar.ForceRecheckNextTurnCondition();
	}
});
