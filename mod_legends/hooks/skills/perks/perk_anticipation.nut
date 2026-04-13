::mods_hookExactClass("skills/perks/perk_anticipation", function(o) {
	o.m.Skills <- [
		::Legends.Active.ShootBolt,
		::Legends.Active.ShootStake,
		::Legends.Active.QuickShot,
		::Legends.Active.ThrowJavelin,
		::Legends.Active.ThrowSpear,
		::Legends.Active.ThrowBalls,
		::Legends.Active.ThrowAxe,
		::Legends.Active.SlingStone,
		::Legends.Active.LegendShootStone,
		::Legends.Active.LegendSlingHeavyStone,
		::Legends.Active.SlingStone,
	];

	o.onMissed <- function ( _attacker, _skill )
	{
		if (_skill.isGarbage())
			return;
		if (!_skill.m.IsWeaponSkill)
			return;
		if (!_skill.isUsingHitchance())
			return;
		if (!_skill.isRanged())
			return;
		local actor = this.getContainer().getActor();

		if (::Legends.S.skillEntityAliveCheck(_attacker))
			return;

		if (::Legends.S.skillEntityAliveCheck(actor))
			return;

		local skill = null;
		foreach (s in this.m.Skills)
		{
			if (::Legends.Actives.has(this, s))
			{
				skill = ::Legends.Actives.get(this, s);
				break;
			}
		}

		if (skill == null)
			return;
		local chance = actor.getCurrentProperties().getRangedDefense();
		local attackerTile = _attacker.getTile();
		local myTile = actor.getTile();

		if (skill.isUsable() && skill.onVerifyTarget(myTile, attackerTile) && skill.isUsableOn(attackerTile, myTile) && this.Math.rand(1, 100) < chance)
		{
			local info = {
				User = actor,
				Skill = skill,
				TargetTile = _attacker.getTile()
			};
			local delay = this.Math.max(this.Const.Combat.RiposteDelay, skill.m.Delay);
			this.Time.scheduleEvent(this.TimeUnit.Virtual, delay, this.onCounterFire.bindenv(this), info);
		}
	}

	o.onCounterFire <- function(_info)
	{
		::Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(_info.User) + " has dodged the attack and performing a counter attack.");
		return skill.onUse(_info.User, _info.TargetTile);
	}
});
