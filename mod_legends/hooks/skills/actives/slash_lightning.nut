::mods_hookExactClass("skills/actives/slash_lightning", function(o)
{
	o.onUse = function ( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectSlash);
		local success = this.attackEntity(_user, _targetTile.getEntity());
		local myTile = _user.getTile();

		if (success && _user.isAlive() && this.Tactical.TurnSequenceBar.getActiveEntity().getID() == _user.getID())
		{
			local selectedTargets = [];
			local potentialTargets = [];
			local potentialTiles = [];
			local target;
			local targetTile = _targetTile;

			if (this.m.SoundOnLightning.len() != 0)
			{
				this.Sound.play(this.m.SoundOnLightning[this.Math.rand(0, this.m.SoundOnLightning.len() - 1)], this.Const.Sound.Volume.Skill * 2.0, _user.getPos());
			}

			if (!targetTile.IsEmpty && targetTile.getEntity().isAlive() && !targetTile.getEntity().isNull())
			{
				target = targetTile.getEntity();
				selectedTargets.push(target.getID());
			}

			local data = {
				Skill = this,
				User = _user,
				TargetTile = targetTile,
				Target = target
			};
			this.applyEffect(data, 100);
			potentialTargets = [];
			potentialTiles = [];

			for( local i = 0; i < 6; i = ++i )
			{
				if (!targetTile.hasNextTile(i))
				{
				}
				else
				{
					local tile = targetTile.getNextTile(i);

					if (tile.ID != myTile.ID)
					{
						potentialTiles.push(tile);
					}

					if (!tile.IsOccupiedByActor || !tile.getEntity().isAttackable() || tile.getEntity().isAlliedWith(_user) || selectedTargets.find(tile.getEntity().getID()) != null)
					{
					}
					else
					{
						potentialTargets.push(tile);
					}
				}
			}

			if (potentialTargets.len() != 0)
			{
				target = potentialTargets[this.Math.rand(0, potentialTargets.len() - 1)].getEntity();
				selectedTargets.push(target.getID());
				targetTile = target.getTile();
			}
			else
			{
				target = null;
				targetTile = potentialTiles[this.Math.rand(0, potentialTiles.len() - 1)];
			}

			local data = {
				Skill = this,
				User = _user,
				TargetTile = targetTile,
				Target = target
			};
			this.applyEffect(data, 350);
			potentialTargets = [];
			potentialTiles = [];

			for( local i = 0; i < 6; i = ++i )
			{
				if (!targetTile.hasNextTile(i))
				{
				}
				else
				{
					local tile = targetTile.getNextTile(i);

					if (tile.ID != myTile.ID)
					{
						potentialTiles.push(tile);
					}

					if (!tile.IsOccupiedByActor || !tile.getEntity().isAttackable() || tile.getEntity().isAlliedWith(_user) || selectedTargets.find(tile.getEntity().getID()) != null)
					{
					}
					else
					{
						potentialTargets.push(tile);
					}
				}
			}

			if (potentialTargets.len() != 0)
			{
				target = potentialTargets[this.Math.rand(0, potentialTargets.len() - 1)].getEntity();
				selectedTargets.push(target.getID());
				targetTile = target.getTile();
			}
			else
			{
				target = null;
				targetTile = potentialTiles[this.Math.rand(0, potentialTiles.len() - 1)];
			}

			local data = {
				Skill = this,
				User = _user,
				TargetTile = targetTile,
				Target = target
			};
			this.applyEffect(data, 550);
		}

		return success;
	}

});
