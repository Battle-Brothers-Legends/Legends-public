::mods_hookExactClass("skills/effects/bleeding_effect", function(o) {
	o.m.Actor <- null;

	o.getDamage = function ()
	{
		return this.m.Damage * (this.getContainer().getActor().getSkills().hasEffect(::Legends.Effect.HyenaPotion) ? 0.5 : 1.0);
	}

	o.setActor <- function ( _a )
	{
		this.m.Actor = ::MSU.asWeakTableRef(_a);
	}

	o.applyDamage = function ()
	{
		if (this.m.LastRoundApplied != this.Time.getRound())
		{
			this.m.LastRoundApplied = this.Time.getRound();
			local actor = this.getContainer().getActor();
			this.spawnIcon("status_effect_01", actor.getTile());
			local hitInfo = clone this.Const.Tactical.HitInfo;
			hitInfo.DamageRegular = this.getDamage();
			hitInfo.DamageDirect = 1.0;
			hitInfo.BodyPart = this.Const.BodyPart.Body;
			hitInfo.BodyDamageMult = 1.0;
			hitInfo.FatalityChanceMult = 0.0;
			actor.onDamageReceived(this.getEffectOwner(), this, hitInfo);

			if (--this.m.TurnsLeft <= 0)
			{
				this.removeSelf();
			}
		}
	}
});
