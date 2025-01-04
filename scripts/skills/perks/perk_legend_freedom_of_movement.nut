this.perk_legend_freedom_of_movement <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendFreedomOfMovement);
		this.m.Description = "You are moving with freedom.";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Gain hit point damage reduction proportional to the difference between your current initiative and your attacker\'s, up to 80% for 100 initiative."
		});
		return tooltip;
	}

	function getBonus( _attacker, _defender )
	{
		local bonus = 1;
		if (::MSU.isNull(_attacker) || ::MSU.isNull(_defender)) return bonus;

		local defenderCurrentInitiative = _defender.getInitiative();
		local attackerCurrentInitiative = _attacker.getInitiative();

		if (defenderCurrentInitiative > attackerCurrentInitiative)
		{
			local diff = (defenderCurrentInitiative - attackerCurrentInitiative) / 100.0;
			local diffPoint = this.Math.minf(1, this.Math.pow(diff, 0.4)) * 0.80;
			bonus = 1 - diffPoint;
		}

		return bonus;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_attacker == null || _attacker != null && _attacker.getID() == this.getContainer().getActor().getID() || _skill == null || !_skill.isAttack() || !_skill.isUsingHitchance())
		{
			return;
		}

		local bonus = this.getBonus(_attacker, this.getContainer().getActor());

		_properties.DamageReceivedRegularMult *= bonus;
	}

	// MSU custom-added event
	function onOtherActorTooltip( _tooltip, _targetActor )
	{
		if (::MSU.isNull(_targetActor) || _targetActor.isPlayerControlled())
		{
			return;
		}

		local bonus = (1 - this.getBonus( _targetActor, this.getContainer().getActor() )) * 100;

		_tooltip.push({
			id = "10",
			type = "hint",
			icon = "ui/perks/freedom_of_movement_circle.png",
			text = "Receive " + ::Const.UI.getColorized(::Math.round(bonus) + "%", ::Const.UI.Color.PositiveValue) + " less damage from this character due to the current difference in Initiative"
		});
	}

	// MSU function
	function onGetHitFactorsAsTarget( _skill, _targetTile, _tooltip )
	{
		local attacker = ::MSU.isNull(_skill) ? null : _skill.getContainer().getActor();

		if (::MSU.isNull(attacker))
		{
			return;
		}

		local bonus = (1 - this.getBonus(attacker, this.getContainer().getActor())) * 100;

		if (bonus > 0)
		{
			_tooltip.push({
				id = "10",
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = ::Const.UI.getColorized("-" + ::Math.round(bonus) + "%", ::Const.UI.Color.NegativeValue) + " damage from " + this.m.Name,
			})
		}
	}

});

