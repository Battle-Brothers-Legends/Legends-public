::mods_hookExactClass("skills/effects/rooted_effect", function(o) {
	o.m.DamageMin <- 0;
	o.m.DamageMax <- 0;
	o.m.SoundOnHitHitpoints <- [
		"sounds/combat/break_free_roots_00.wav",
		"sounds/combat/break_free_roots_01.wav",
		"sounds/combat/break_free_roots_02.wav",
		"sounds/combat/break_free_roots_03.wav"
	];

	o.setDamage <- function(_damageMin, _damageMax)
	{
		this.m.DamageMin = _damageMin;
		this.m.DamageMax = _damageMax;
	}

	local create = o.create;
	o.create = function()
	{
		create();
		this.m.KilledString = "Crushed by vines";
	}

	o.applyDamage <- function ()
	{
		if (this.m.DamageMin == 0 || this.m.DamageMax == 0)
			return;

		local actor = this.getContainer().getActor();
		local hp = actor.getHitpoints();
		local damage = this.Math.rand(this.m.DamageMin, this.m.DamageMax);
		local hitInfo = clone this.Const.Tactical.HitInfo;
		hitInfo.DamageRegular = damage;
		hitInfo.DamageArmor = damage;
		hitInfo.DamageDirect = 0.9;
		hitInfo.BodyPart = this.Const.BodyPart.Body;
		hitInfo.BodyDamageMult = 1.0;
		hitInfo.FatalityChanceMult = 0.0;
		actor.onDamageReceived(this.getContainer().getActor(), this, hitInfo);

		if (!actor.isAlive())
			return;

		if (!actor.isHiddenToPlayer())
		{
			if (this.m.SoundOnHitHitpoints.len() != 0)
			{
				this.Sound.play(this.m.SoundOnHitHitpoints[this.Math.rand(0, this.m.SoundOnHitHitpoints.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.2, actor.getPos());
			}
		}

		if (actor.getFlags().has("undead"))
			return;

		if (actor.getCurrentProperties().IsImmuneToPoison || (hp - actor.getHitpoints()) < this.Const.Combat.PoisonEffectMinDamage || actor.getHitpoints() <= 0)
			return;

		if (!actor.isHiddenToPlayer())
		{
			if (this.m.SoundOnUse.len() != 0)
			{
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.5, actor.getPos());
			}

			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " is poisoned");
		}

		this.spawnIcon("status_effect_54", actor.getTile());
		local poison = ::Legends.Effects.get(actor, ::Legends.Effect.GoblinPoison);

		if (poison == null)
		{
			::Legends.Effects.grant(actor, ::Legends.Effect.GoblinPoison);
		}
		else
		{
			poison.resetTime();
		}
	}

	o.onAdded <- function ()
	{
		this.applyDamage();
	}

	o.onTurnEnd <- function()
	{
		this.applyDamage();
	}
});
