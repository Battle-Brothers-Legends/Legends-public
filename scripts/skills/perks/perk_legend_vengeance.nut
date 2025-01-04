this.perk_legend_vengeance <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendVengeance);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		local actor = this.getContainer().getActor();

		if (_attacker != null && !_attacker.isAlliedWith(actor) && !actor.getSkills().hasSkill("effect.legend_vengeance"))
		{
			actor.getSkills().add(this.new("scripts/skills/effects/legend_vengeance_effect"));
		}
	}

});

