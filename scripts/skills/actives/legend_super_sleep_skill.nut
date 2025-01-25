this.legend_super_sleep_skill <- this.inherit("scripts/skills/actives/sleep_skill", {
	m = {},
	function create()
	{
		this.sleep_skill.create();
		this.m.ActionPointCost = 6;
	}

	function onDelayedEffect( _tag )
	{
		local targets = [];
		local _targetTile = _tag.TargetTile;
		local _user = _tag.User;

		for( local i = 5; i >= 0; --i )
		{
			if (!_targetTile.hasNextTile(i))
				continue;

			local tile = _targetTile.getNextTile(i);

			if (::Math.abs(tile.Level - _targetTile.Level) > 1 || !tile.IsOccupiedByActor || !tile.getEntity().isAttackable() || tile.getEntity().isAlliedWith(_user))
				continue;

			targets.push(tile.getEntity());
		}

		if (_targetTile.IsOccupiedByActor && !tile.getEntity().isAlliedWith(_user))
			targets.push(_targetTile.getEntity());

		local myTile = _user.getTile();

		foreach( target in targets )
		{
			local bonus = this.m.MaxRange + 1 - myTile.getDistanceTo(target.getTile());

			if (target.checkMorale(0, -60 * bonus, this.Const.MoraleCheckType.MentalAttack))
			{
				if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(target) + " resists the urge to sleep thanks to his resolve");
				}

				continue;
			}

			::Legends.Effects.grant(target, ::Legends.Effect.Sleeping);

			if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(target) + " falls to sleep");
			}
		}
	}

});

