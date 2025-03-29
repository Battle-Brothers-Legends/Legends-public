this.perk_legend_big_game_hunter <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendBigGameHunter);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
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
