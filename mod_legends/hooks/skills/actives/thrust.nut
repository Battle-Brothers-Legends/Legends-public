::mods_hookExactClass("skills/actives/thrust", function(o)
{
	o.m.IsGoedendagThrust <- false;
	o.m.DazeChance <- 25;

	o.setItem <- function (_item)
	{
		this.skill.setItem(_item);
		if (this.m.IsGoedendagThrust)
		{
			this.m.Description = "A hefty swift slashing attack dealing average damage.";
			this.m.Icon = "skills/active_128.png";
			this.m.IconDisabled = "skills/active_128_sw.png";
			this.m.Overlay = "active_128";
			this.m.DirectDamageMult = 0.4;
			this.m.FatigueCost = 15;
		}
	}

	local onAfterUpdate = o.onAfterUpdate;
	o.onAfterUpdate = function (_properties)
	{
		onAfterUpdate(_properties);
		this.m.DazeChance = _properties.IsSpecializedInMaces ? 50 : 25;
	}

	local onUse = o.onUse;
	o.onUse = function ( _user, _targetTile )
	{
		if (!this.m.IsGoedendagThrust)
			return onUse(_user, _targetTile);

		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectBash);
		local success = this.attackEntity(_user, _targetTile.getEntity());

		if (!_user.isAlive() || _user.isDying())
		{
			return success;
		}

		if (success && _targetTile.IsOccupiedByActor)
		{
			local target = _targetTile.getEntity();

			if (!target.getCurrentProperties().IsImmuneToDaze && this.Math.rand(1, 100) <= this.m.DazeChance)
				::Legends.Effects.grant(target, ::Legends.Effect.Dazed);

			if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has dazed " + this.Const.UI.getColorizedEntityName(target) + " for one turn");
			}
		}

		return success;
	}
});
