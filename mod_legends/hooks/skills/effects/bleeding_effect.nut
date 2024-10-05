::mods_hookExactClass("skills/effects/bleeding_effect", function(o) {
	o.m.Actor <- null;

	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Overlay = "status_effect_01";
	}
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

	o.applyDamage = function ()
	{
		if (this.m.LastRoundApplied != this.Time.getRound())
		{
			this.m.LastRoundApplied = this.Time.getRound();
			local actor = this.getContainer().getActor();
			this.spawnIcon("status_effect_01", actor.getTile());
			local hitInfo = clone this.Const.Tactical.HitInfo;
			hitInfo.DamageRegular = this.m.Damage * (actor.getSkills().hasSkill("effects.hyena_potion") ? 0.5 : 1.0);
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
});