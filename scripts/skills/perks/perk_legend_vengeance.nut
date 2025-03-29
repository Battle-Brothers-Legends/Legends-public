this.perk_legend_vengeance <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendVengeance);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		local actor = this.getContainer().getActor();

		if (_attacker != null && !_attacker.isAlliedWith(actor) && !actor.getSkills().hasEffect(::Legends.Effect.LegendVengeance))
		{
			::Legends.Effects.grant(actor, ::Legends.Effect.LegendVengeance);
		}
	}

});

