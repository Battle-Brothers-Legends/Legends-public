::mods_hookExactClass("skills/actives/reap_skill", function(o)
{
	o.m.SoundsA <- [
		"sounds/combat/cleave_hit_hitpoints_01.wav",
		"sounds/combat/cleave_hit_hitpoints_02.wav",
		"sounds/combat/cleave_hit_hitpoints_03.wav"
	],
	o.m.SoundsB <- [
		"sounds/combat/chop_hit_01.wav",
		"sounds/combat/chop_hit_02.wav",
		"sounds/combat/chop_hit_03.wav"
	]

	local getTooltip = o.getTooltip;
	o.getTooltip = function ()
	{
		local tooltip = getTooltip();
		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Inflicts additional stacking [color=" + this.Const.UI.Color.DamageValue + "]5[/color] bleeding damage per turn, for 2 turns"
			});
		}

		return tooltip;
	}

	o.addResources <- function ()
	{
		foreach( r in this.m.SoundsA )
		{
			this.Tactical.addResource(r);
		}

		foreach( r in this.m.SoundsB )
		{
			this.Tactical.addResource(r);
		}
	}

	o.onUse = function ( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectSwing);
		local ret = false;
		local myTile = _user.getTile();
		local myTile = this.m.Container.getActor().getTile();
		local d = myTile.getDistanceTo(_targetTile);
		local result = {
			Tiles = [],
			MyTile = myTile,
			TargetTile = _targetTile,
			Num = 0
		};
		this.Tactical.queryTilesInRange(myTile, d, d, false, [], this.onQueryTilesHit, result);
		local tiles = [];

		for( local i = 0; i != result.Tiles.len(); i = ++i )
		{
			if (result.Tiles[i].ID == _targetTile.ID)
			{
				tiles.push(result.Tiles[i]);
				local idx = i - 1;

				if (idx < 0)
				{
					idx = idx + result.Tiles.len();
				}

				tiles.push(result.Tiles[idx]);
				idx = i - 2;

				if (idx < 0)
				{
					idx = idx + result.Tiles.len();
				}

				tiles.push(result.Tiles[idx]);
				break;
			}
		}

		foreach( t in tiles )
		{
			if (!t.IsVisibleForEntity)
			{
				continue;
			}

			if (this.Math.abs(t.Level - myTile.Level) > 1 || this.Math.abs(t.Level - _targetTile.Level) > 1)
			{
				continue;
			}

			if (!t.IsEmpty && t.getEntity().isAttackable())
			{
				ret = this.applyBleed( _user, t) || ret;
			}

			if (!_user.isAlive() || _user.isDying())
			{
				break;
			}
		}

		return ret;
	}

	o.applyBleed( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		local hp = target.getHitpoints();
		local success = this.attackEntity(_user, _targetTile.getEntity());

		if (!_user.isAlive() || _user.isDying())
		{
			return;
		}

		if (success && _user.getCurrentProperties().IsSpecializedInCleavers)
		{
			if (!target.isAlive() || target.isDying())
			{
				if (this.isKindOf(target, "lindwurm_tail") || !target.getCurrentProperties().IsImmuneToBleeding)
				{
					this.Sound.play(this.m.SoundsA[this.Math.rand(0, this.m.SoundsA.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
				}
				else
				{
					this.Sound.play(this.m.SoundsB[this.Math.rand(0, this.m.SoundsB.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
				}
			}
			else if (!target.getCurrentProperties().IsImmuneToBleeding && hp - target.getHitpoints() >= this.Const.Combat.MinDamageToApplyBleeding)
			{
				::Legends.Effects.grant(target, ::Legends.Effect.Bleeding, function(_effect) {
					if (_user.getFaction() == this.Const.Faction.Player )
						_effect.setActor(this.getContainer().getActor());
					_effect.setDamage(5);
				}.bindenv(this));
				this.Sound.play(this.m.SoundsA[this.Math.rand(0, this.m.SoundsA.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
			}
			else
			{
				this.Sound.play(this.m.SoundsB[this.Math.rand(0, this.m.SoundsB.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
			}
		}

		return success;
	}

});
