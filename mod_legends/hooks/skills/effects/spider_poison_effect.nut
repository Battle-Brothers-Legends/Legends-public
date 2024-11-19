::mods_hookExactClass("skills/effects/spider_poison_effect", function(o) {
	o.m.Actor <- null;

	o.getDamage <- function ()
	{
		return this.m.Damage;
	}

	o.setDamage <- function ( _d )
	{
		this.m.Damage = _d;
	}

	o.setActor <- function ( _a )
	{
		this.m.Actor = ::MSU.asWeakTableRef(_a);
	}

	o.getAttacker <- function ()
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

	o.getDescription = function ()
	{
		if("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			return "This character has a vicious poison running through his veins and will lose [color=" + this.Const.UI.Color.NegativeValue + "]" + 2 * this.m.Damage + "[/color] hitpoints each turn for [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color] more turn(s).";
		}
		return "This character has a vicious poison running through his veins and will lose [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.Damage + "[/color] hitpoints each turn for [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color] more turn(s).";
	}

	o.applyDamage = function ()
	{
		if (this.m.LastRoundApplied != this.Time.getRound())
		{
			local actor = this.getContainer().getActor();
			this.m.LastRoundApplied = this.Time.getRound();
			this.spawnIcon("status_effect_54", actor.getTile());

			if (this.m.SoundOnUse.len() != 0)
			{
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.0, actor.getPos());
			}

			local hitInfo = clone this.Const.Tactical.HitInfo;
			hitInfo.DamageRegular = this.m.Damage;
			if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
			{
				hitInfo.DamageRegular = 2 * this.m.Damage;
			}


			hitInfo.DamageDirect = 1.0;
			hitInfo.BodyPart = this.Const.BodyPart.Body;
			hitInfo.BodyDamageMult = 1.0;
			hitInfo.FatalityChanceMult = 0.0;
			actor.onDamageReceived(this.getAttacker(), this, hitInfo);
		}
	}

});