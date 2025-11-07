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
	]

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
		if (skill.isUsable() && skill.onVerifyTarget(actor.getTile(), _attacker.getTile()) && isUsableOn(actor.getTile()) && this.Math.rand(1, 100) < chance)
		{
			::Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(actor) + " has dodged the attack and preparing to counter.");
			return skill.onUse(actor, _attacker.getTile());
		}
	}
});