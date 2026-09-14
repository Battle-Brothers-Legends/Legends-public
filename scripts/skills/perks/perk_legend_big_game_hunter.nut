this.perk_legend_big_game_hunter <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendBigGameHunter);
	}

	function onUpdate( _properties)
	{
		local actor = this.getContainer().getActor();

		if (actor.isArmedWithRangedWeapon() && !actor.getSkills().hasEffect(::Legends.Effect.LegendHuntingBigGame))
		{
			::Legends.Effects.grant(actor, ::Legends.Effect.LegendHuntingBigGame);
		}
	}

});
