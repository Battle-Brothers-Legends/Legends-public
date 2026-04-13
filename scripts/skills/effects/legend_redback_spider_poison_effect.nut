this.legend_redback_spider_poison_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 7,
		Damage = 1,
		LastRoundApplied = 0,
		Actor = null
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

	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendRedbackSpiderPoison);
		this.m.KilledString = "Died from redback poison";
		this.m.Icon = "skills/status_effect_54.png";
		this.m.IconMini = "status_effect_54_mini";
		this.m.SoundOnUse = [
			"sounds/enemies/dlc2/giant_spider_poison_01.wav",
			"sounds/enemies/dlc2/giant_spider_poison_02.wav"
		];
		this.m.Type = this.Const.SkillType.StatusEffect | this.Const.SkillType.DamageOverTime;
		this.m.IsActive = false;
		this.m.IsStacking = true;
		this.m.IsRemovedAfterBattle = true;
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

	function getDescription()
	{
		local timeDamage = (this.m.Damage * this.m.TurnsLeft);
		if (::Legends.isLegendaryDifficulty() && !this.getAttacker().isPlayerControlled())
		{
			timeDamage *= 2;
		}
		return "This character has a vicious poison running through their veins and will lose [color=%negative%]" + timeDamage + "[/color] hitpoints each turn for [color=%negative%]" + this.m.TurnsLeft + "[/color] more turn(s).";
	}

	function resetTime()
	{
		this.m.TurnsLeft = this.Math.max(1, 10 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);

		if (this.getContainer().hasTrait(::Legends.Trait.Ailing))
		{
			++this.m.TurnsLeft;
		}
	}

	function applyDamage()
	{
		if (this.m.LastRoundApplied != this.Time.getRound())
		{
			local actor = this.getContainer().getActor();
			this.m.LastRoundApplied = this.Time.getRound();
			this.spawnIcon("status_effect_54", this.getContainer().getActor().getTile());

			if (actor.getCurrentProperties().IsImmuneToPoison) {
				return;
			}

			if (this.m.SoundOnUse.len() != 0)
			{
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.0, actor.getPos());
			}
			local timeDamage = (this.m.Damage * this.m.TurnsLeft);
			local hitInfo = clone this.Const.Tactical.HitInfo;
			hitInfo.DamageRegular = timeDamage;

			if (::Legends.isLegendaryDifficulty() && !this.getAttacker().isPlayerControlled())
			{
				local timeDamage = (this.m.Damage * this.m.TurnsLeft);
				hitInfo.DamageRegular = 2 * timeDamage;
			}

			hitInfo.DamageDirect = 1.0;
			hitInfo.BodyPart = this.Const.BodyPart.Body;
			hitInfo.BodyDamageMult = 1.0;
			hitInfo.FatalityChanceMult = 0.0;
			actor.onDamageReceived(this.getAttacker(), this, hitInfo);
		}
	}

	function onAdded()
	{
		this.m.TurnsLeft = this.Math.max(1, 10 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);

		if (this.getContainer().hasTrait(::Legends.Trait.Ailing))
		{
			++this.m.TurnsLeft;
		}
	}

	function onTurnEnd()
	{
		this.applyDamage();

		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

	function onWaitTurn()
	{
		this.applyDamage();
	}

});
