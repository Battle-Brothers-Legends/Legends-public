this.legend_grazed_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 5,
		Damage = 2,
		LastRoundApplied = 0,
		Actor = null,
	},
	function getDamage()
	{
		return this.m.Damage;
	}

	function setDamage( _d )
	{
		this.m.Damage = _d;
	}

	function setActor( _a )
	{
		this.m.Actor = ::MSU.asWeakTableRef(_a);
	}

	function getAttacker()
	{
		if (!::Legends.Mod.ModSettings.getSetting("BleedKiller").getValue())
		{
			return this.getContainer().getActor();
		}

		if (::MSU.isNull(this.m.Actor))
		{
			return this.getContainer().getActor();
		}

		if (this.m.Actor.getID() != this.getContainer().getActor().getID())
		{
			if (this.m.Actor.isAlive() && this.m.Actor.isPlacedOnMap())
			{
				return this.m.Actor;
			}
		}

		return this.getContainer().getActor();
	}

	function create()
	{
		this.m.ID = "effects.legend_grazed_effect";
		this.m.Name = "Bleeding from grazes";
		this.m.KilledString = "Bled to death";
		this.m.Icon = "skills/graze_circle.png";
		this.m.IconMini = "mini_graze_circle";
		this.m.Overlay = "graze";
		this.m.Type = this.Const.SkillType.StatusEffect | this.Const.SkillType.DamageOverTime;
		this.m.IsActive = false;
		this.m.IsStacking = true;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character is bleeding slowly from multiple recent deep grazes [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.Damage + "[/color] hitpoints each turn for [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color] more turn(s).";
	}

	function applyDamage()
	{
		if (this.m.LastRoundApplied != this.Time.getRound())
		{
			this.m.LastRoundApplied = this.Time.getRound();
			local actor = this.getContainer().getActor();
			this.spawnIcon("status_effect_01", actor.getTile());
			local hitInfo = clone this.Const.Tactical.HitInfo;
			hitInfo.DamageRegular = this.m.Damage;
			hitInfo.DamageDirect = 1.0;
			hitInfo.BodyPart = this.Const.BodyPart.Body;
			hitInfo.BodyDamageMult = 1.0;
			hitInfo.FatalityChanceMult = 0.0;
			actor.onDamageReceived(this.getAttacker(), this, hitInfo);

			if (--this.m.TurnsLeft <= 0)
			{
				this.removeSelf();
			}
		}
	}

	function onAdded()
	{
		if (this.getContainer().getActor().getCurrentProperties().IsResistantToAnyStatuses && this.Math.rand(1, 100) <= 50)
		{
			if (!this.getContainer().getActor().isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " had his bleeding wound quickly close thanks to his unnatural physiology");
			}

			this.removeSelf();
		}
		else
		{
			this.m.TurnsLeft = this.Math.max(3, 5 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);

			if (this.getContainer().hasSkill("trait.bleeder"))
			{
				++this.m.TurnsLeft;
				++this.m.TurnsLeft;
			}
		}
	}

	function onUpdate( _properties )
	{
	}

	function onTurnEnd()
	{
		this.applyDamage();
	}

	function onWaitTurn()
	{
		this.applyDamage();
	}

});

