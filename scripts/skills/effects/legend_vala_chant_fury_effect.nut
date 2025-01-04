this.legend_vala_chant_fury_effect <- this.inherit("scripts/skills/effects/legend_vala_chant", {
	m = {
		isPerformingPayback = false
	},
	function create()
	{
		this.legend_vala_chant.create();
		this.m.ID = "effects.legend_vala_chant_fury_effect";
		this.m.Description = "This character has been invigorated by the Vala\'s Chant of Fury!"
		this.m.Range = 3;
	}
	function getWardenDamage()
	{
		return (this.m.Vala.getBravery() / 30.0) + ((this.getContainer().getActor().getFatigueMax() - this.getContainer().getActor().getFatigue()) / 30.0);
	}

	function getDamageBonus()
	{
		local bonus = (this.m.Vala.getBravery() / 30.0) + ((this.getContainer().getActor().getFatigueMax() - this.getContainer().getActor().getFatigue()) / 30.0);
		return this.Math.max(0, this.Math.floor(bonus * this.getMasteryMult() * this.getDistanceMult()));
	}

	function getPayBackChance()
	{
		local chance = (this.m.Vala.getBravery() / 4.0) + (this.getContainer().getActor().getHitpoints() / 3.0);
		return this.Math.min(95, this.Math.max(5, chance * this.getMasteryMult() * this.getDistanceMult()));
	}

	function getPayBackDamage()
	{
		local damage = (this.m.Vala.getBravery() / 3.0) + (this.getContainer().getActor().getCurrentProperties().getMeleeSkill() / 4.0);
		return this.Math.min(100, damage * this.getMasteryMult() * this.getDistanceMult());
	}

	function getDistanceMult()
	{
		local distance = this.getContainer().getActor().getTile().getDistanceTo(this.m.Vala.getTile());
		if (distance == 3)
		{
			return 0.5;
		}
		else if (distance == 2)
		{
			return 0.75;
		}

		return 1.0;
	}

	function getMasteryMult()
	{
		return this.isMastered() ? 1.1 : 1.0;
	}

	function getTooltip()
	{
		local regulardamage = this.getDamageBonus();
		local paybackchance = this.getPayBackChance();
		local paybackdamage = this.getPayBackDamage();

		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 1,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + regulardamage + "%[/color] damage inflicted"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + paybackchance + "%[/color] chance to retaliate against an attacker that hits you in melee range, for [color=" + this.Const.UI.Color.PositiveValue + "]" + paybackdamage + "%[/color] damage"
			}
		];
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		local actor = this.getContainer().getActor();
		if (_attacker == null || _attacker.isAlliedWith(actor) || ::Tactical.TurnSequenceBar.isActiveEntity(actor) || actor.getTile().getDistanceTo(_attacker.getTile()) != 1)
			return;

		if (_damageHitpoints >= actor.getHitpoints())
			return;

		if (!actor.isAlive() || actor.isDying())
			return;

		if (!this.checkEntities() || !this.isInRange())
			return;

		local chance = this.getPayBackChance();

		if (this.Math.rand(1, 100) <= chance)
		{
			local payback = this.getContainer().getAttackOfOpportunity();
			if (payback != null)
			{
				this.getContainer().setBusy(true);
				local attackinfo = {
					User = actor,
					Skill = payback,
					TargetTile = _attacker.getTile(),
					Container = this.getContainer(),
				};
				this.Time.scheduleEvent(this.TimeUnit.Virtual, this.Const.Combat.RiposteDelay, this.onPerformPaypack.bindenv(this), attackinfo);
			}
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		local actor = this.getContainer().getActor();

		if (!actor.isPlacedOnMap() || ("State" in this.Tactical) && this.Tactical.State.isBattleEnded())
			return;

		if (!this.checkEntities() || !this.isInRange())
			return;

		if (this.Tactical.TurnSequenceBar.getActiveEntity() != null && this.Tactical.TurnSequenceBar.getActiveEntity().getID() == this.getContainer().getActor().getID())
			return;

		if (this.m.isPerformingPayback == true)
			_properties.DamageTotalMult *= this.getPayBackDamage() * 0.01;
	}

	function onPerformPaypack(_attackinfo)
	{
		_attackinfo.Container.setBusy(false);
		this.m.isPerformingPayback = true;
		if (_attackinfo.User.isAlive() && _attackinfo.TargetTile.getEntity().isAlive())
		{
			return _attackinfo.Skill.attackEntity(_attackinfo.User, _attackinfo.TargetTile.getEntity());
		}
		this.m.isPerformingPayback = false;
	}

	function updateEffect(_v)
	{
		if (_v)
		{
			this.m.Name = "Fury";
			this.m.Icon = "ui/perks/perk_36.png";
			this.m.IconMini = "perk_36_mini";
			this.m.Overlay = "perk_36";
		}
		else
		{
			this.m.Name = "";
			this.m.Icon = "";
			this.m.IconMini = "";
			this.m.Overlay = "";
		}
	}


	function onMovementCompleted( _tile )
	{
		if (!this.checkEntities())
		{
			this.updateEffect(false);
			return;
		}

		if (!this.isInRange())
		{
			this.updateEffect(false);
			return;
		}

		if (this.getContainer().getActor().getID() != this.m.Vala.getID())
		{
			this.spawnIcon("perk_36", this.getContainer().getActor().getTile());
		}

		this.updateEffect(true);
	}


	function onUpdate(_properties)
	{
		if (!this.checkEntities())
		{
			this.updateEffect(false);
			return;
		}

		if (!this.isInRange())
		{
			this.updateEffect(false);
			return;
		}

		local distance = this.getContainer().getActor().getTile().getDistanceTo(this.m.Vala.getTile());
		local damageBonus = this.getDamageBonus();

		_properties.DamageTotalMult *= 1.0 + damageBonus * 0.01;

		this.updateEffect(true);
	}
});
