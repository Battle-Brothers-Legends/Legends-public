::mods_hookExactClass("skills/actives/sleep_skill", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Use soothing vapours to lull an enemy to sleep. The chance of success is determined by their resolve";
	}

	o.onVerifyTarget = function ( _userTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_userTile, _targetTile))
		{
			return false;
		}

		if (_targetTile.getEntity().getCurrentProperties().IsStunned || _targetTile.getEntity().getMoraleState() == this.Const.MoraleState.Ignore)
		{
			return false;
		}

		if (_targetTile.getEntity().isNonCombatant())
		{
			return false;
		}

		return true;
	}

	// function isUsable()
	// {
	// 	if (!this.skill.isUsable())
	// 	{
	// 		return false;
	// 	}

	// 	if (this.getContainer().getActor().isPlayerControlled())
	// 	{
	// 		return true;
	// 	}

	// 	local b = this.getContainer().getActor().getAIAgent().getBehavior(this.Const.AI.Behavior.ID.AttackDefault);
	// 	local targets = b.queryTargetsInMeleeRange(this.getMinRange(), this.getMaxRange());
	// 	local myTile = this.getContainer().getActor().getTile();

	// 	foreach( t in targets )
	// 	{
	// 		if (this.onVerifyTarget(myTile, t.getTile()))
	// 		{
	// 			return true;
	// 		}
	// 	}

	// 	return false;

	// }

	o.isUsable = function () //allows this skill to be used by non-melee entities now
	{
		if (!this.skill.isUsable())
			return false;

		if (this.getContainer().getActor().getFlags().has("alp"))
			return true;

		return !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions());
	}

});
