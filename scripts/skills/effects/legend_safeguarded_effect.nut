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

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (this.m.Protector == null || this.m.Protector.isNull() || !this.m.Protector.isAlive())
		{
			this.removeSelf();
			return;
		}

		if (_damageHitpoints > 0)
		{
			local actor = this.getContainer().getActor();
			if (!_attacker.isHiddenToPlayer() && actor.getTile().IsVisibleForPlayer)
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_attacker) + " attacks " + this.Const.UI.getColorizedEntityName(actor) + "but " + this.Const.UI.getColorizedEntityName(this.m.Protector) + "takes the hit instead");
			}
			this.m.Protector.applyDamage(_damageHitpoints, _attacker);
		}

		if (this.m.Protector == null || this.m.Protector.isNull() || !this.m.Protector.isAlive())
		{
			this.removeSelf();
		}
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
		if (!(this.m.Protector != null && !this.m.Protector.isNull()))
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
