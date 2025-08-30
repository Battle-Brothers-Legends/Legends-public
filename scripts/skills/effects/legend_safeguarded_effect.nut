this.legend_safeguarded_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Protector = null,
		IsActivated = false,
		TurnsLeft = 0
	},

	function activate()
	{
		this.m.IsActivated = true;
	}

	function setProtector( _p )
	{
		if (_p == null)
		{
			this.m.Protector = null;
		}
		else if (typeof _p == "instance")
		{
			this.m.Protector = _p;
		}
		else
		{
			this.m.Protector = this.WeakTableRef(_p);
		}
	}

	function isAlive()
	{
		return this.getContainer() != null && !this.getContainer().isNull() && this.getContainer().getActor() != null && this.getContainer().getActor().isAlive() && this.getContainer().getActor().getHitpoints() > 0;
	}

	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendSafeguarded);
		this.m.Description = "This character is being safeguarded.";
		this.m.Icon = "ui/perks/safegaurd_circle.png";//incorrect spelling but don't change I can't be arsed to mess with brush files
		this.m.IconMini = "mini_safegaurd_circle";//incorrect spelling but don't change I can't be arsed to mess with brush files
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local tooltip = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
		if (this.m.Protector)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "All damage done to this character will be transfered to " + this.m.Protector.getName()
			});
		}
	}

	function rotate(_protector, _ward)
	{
		this.Tactical.getNavigator().switchEntities(_protector, _ward, null, null, 1.0);
		return true;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (this.m.Protector == null || this.m.Protector.isNull() || !this.m.Protector.isAlive())
		{
			this.removeSelf();
			return;
		}

		if (_hitInfo.DamageRegular < 1 && _hitInfo.DamageArmor < 1)
			return;

		local ward = this.getContainer().getActor();
		// if (_attacker != null && !_attacker.isPlayerControlled() && this.isPlayerControlled())
		// {
		// 	actor.setDiscovered(true);
		// 	_attacker.getTile().addVisibilityForFaction(this.Const.Faction.Player);
		// }

		local overlapping = ::Legends.S.getOverlappingNeighbourActors(ward, this.m.Protector);
		local wardNeighbours = ::Legends.S.getNeighbouringActors(ward.getTile());
		local protectorNeighbours = ::Legends.S.getNeighbouringActors(this.m.Protector.getTile());

		local attackerIsAdjacentToProtector = protectorNeighbours.find(_attacker) != null;
		local attackerIsAdjacentToWard = wardNeighbours.find(_attacker) != null;
		local protectorIsAdjacentToWard = wardNeighbours.find(this.m.Protector) != null;
		local protectorHasAdjacentEnemies = false;
		foreach (entity in protectorNeighbours)
		{
			if (::Legends.S.isInZocWithActor(this.m.Protector, entity))
			{
				protectorHasAdjacentEnemies = true;
			}
		}

		local ret = false;
		local rotate = false;
		local canRotate = !this.m.Protector.getCurrentProperties().IsRooted && !ward.getCurrentProperties().IsRooted && ward.getCurrentProperties().IsMovable && !ward.getCurrentProperties().IsImmuneToRotation && (protectorHasAdjacentEnemies || this.m.Protector.getSkills().hasPerk(::Legends.Perk.LegendTwirl));

		if (_skill == null)
			return; // miasma case, ward takes dmg

		if (attackerIsAdjacentToWard && attackerIsAdjacentToProtector && protectorIsAdjacentToWard)
		{
			ret = _skill.attackEntity(_attacker, this.m.Protector);
		}

		if ((attackerIsAdjacentToWard || _skill.isRanged()) && !attackerIsAdjacentToProtector && !protectorHasAdjacentEnemies && protectorIsAdjacentToWard && canRotate)
		{
			this.rotate(this.m.Protector, this.getContainer().getActor());
			ret = _skill.attackEntity(_attacker, this.m.Protector);
			rotate = true;
		}

		if (attackerIsAdjacentToWard && !attackerIsAdjacentToProtector && protectorHasAdjacentEnemies)
			return; // do nothing Ward takes the hit

		if (!_attacker.isHiddenToPlayer() && ward.getTile().IsVisibleForPlayer && this.m.Protector.getTile().IsVisibleForPlayer)
		{
			if (ret && rotate)
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_attacker) + " attacks " + this.Const.UI.getColorizedEntityName(ward) + "but " + this.Const.UI.getColorizedEntityName(this.m.Protector) + "quickly gets them out of harms way and steps in their place");
			}
			else if (ret)
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_attacker) + " attacks " + this.Const.UI.getColorizedEntityName(ward) + "but " + this.Const.UI.getColorizedEntityName(this.m.Protector) + "steps in as their defender");
			}
		}

		_properties.DamageReceivedTotalMult = 0;
	}

	function onUpdate( _properties )
	{
		if (this.m.IsActivated && (this.m.Protector == null || this.m.Protector.isNull() || !this.m.Protector.isAlive()))
		{
			this.removeSelf();
		}
	}

	function onRemoved()
	{
		if (this.m.Protector == null || this.m.Protector.isNull() || !this.m.Protector.isAlive())
			return;
		local effect = ::Legends.Effects.get(this.m.Protector, ::Legends.Effect.LegendSafeguarding);
		if (effect == null)
			return;
		effect.setWard(null);
		effect.removeSelf();
		this.m.Protector.getSkills().update();
		this.m.Protector = null;
	}

	function onDeath( _fatalityType )
	{
		this.onRemoved();
	}

	function resetTime()
	{
		this.m.TurnsLeft = 1;
	}

	function onTurnStart()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

});
