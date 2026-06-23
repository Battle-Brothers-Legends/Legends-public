::mods_hookExactClass("skills/actives/throw_daze_bomb_skill", function(o)
{
	o.m.Item <- null;
	o.setItem <- function( _i ) {
		this.m.Item = this.WeakTableRef(_i);
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function() {
		local ret = getTooltip();
		local ammo = this.getAmmo();
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "If the target is already [color=%status%]Dazed[/color] targets will be [color=%status%]Stunend[/color] for 1 turn"
		});
		if (ammo > 0) {
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Has [color=%positive%]" + ammo + "[/color] use left"
			});
		}
		else {
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Has been used[/color]"
			});
		}

		return ret;
	}

	o.isUsable <- function()
	{
		return !this.Tactical.isActive() || this.skill.isUsable() && this.getAmmo() > 0;
	}

	o.getAmmo <- function() {
		if (this.m.Item != null && !this.m.Item.isNull())
			return this.m.Item.getAmmo();

		return 0;
	}

	o.consumeAmmo <- function() {
		if (this.m.Item != null && !this.m.Item.isNull())
			this.m.Item.consumeAmmo();
	}

	o.onUse = function( _user, _targetTile ) {
		if (this.m.IsShowingProjectile && this.m.ProjectileType != 0) {
			local flip = !this.m.IsProjectileRotated && _targetTile.Pos.X > _user.getPos().X;

			if (_user.getTile().getDistanceTo(_targetTile) >= this.Const.Combat.SpawnProjectileMinDist) {
				this.Tactical.spawnProjectileEffect(this.Const.ProjectileSprite[this.m.ProjectileType], _user.getTile(), _targetTile, 1.0, this.m.ProjectileTimeScale, this.m.IsProjectileRotated, flip);
			}
		}

		this.consumeAmmo();

		this.Time.scheduleEvent(this.TimeUnit.Real, 250, this.onApply.bindenv(this), {
			Skill = this,
			User = _user,
			TargetTile = _targetTile
		});

		this.m.Item.drop(_targetTile);
		return true;
	}

	o.onAfterUpdate = function( _properties ) {
		this.m.FatigueCostMult = (_properties.IsSpecializedInThrowing || _properties.IsSpecializedInNetCasting) ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		this.m.MaxRange = _properties.IsSpecializedInNetCasting ? 4 : 3;
	}

	o.onApply = function ( _data ) {
		local targets = [];
		targets.push(_data.TargetTile);

		for( local i = 0; i != 6; i = ++i ) {
			if (!_data.TargetTile.hasNextTile(i)) {
				continue;
			}
			else {
				local tile = _data.TargetTile.getNextTile(i);
				targets.push(tile);
			}
		}

		if (_data.Skill.m.SoundOnHit.len() != 0) {
			this.Sound.play(_data.Skill.m.SoundOnHit[this.Math.rand(0, _data.Skill.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, _data.TargetTile.Pos);
		}

		foreach( tile in targets ) {
			for( local i = 0; i < this.Const.Tactical.DazeParticles.len(); i = ++i ) {
				this.Tactical.spawnParticleEffect(false, this.Const.Tactical.DazeParticles[i].Brushes, tile, this.Const.Tactical.DazeParticles[i].Delay, this.Const.Tactical.DazeParticles[i].Quantity, this.Const.Tactical.DazeParticles[i].LifeTimeQuantity, this.Const.Tactical.DazeParticles[i].SpawnRate, this.Const.Tactical.DazeParticles[i].Stages);
			}

			local target = tile.getEntity();
			if (tile.IsOccupiedByActor && !target.getCurrentProperties().IsImmuneToDaze) {
				::Legends.Effects.grant(target, ::Legends.Effect.Dazed);
				if (!target.getCurrentProperties().IsImmuneToStun && target.getSkills().hasEffect(::Legends.Effect.Dazed)) {
					::Legends.Effects.grant(target, ::Legends.Effect.Stunned);

					if (!_data.User.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer) {
						this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_data.User) + " was already dazed, so the flash pot has stunned " + this.Const.UI.getColorizedEntityName(target) + " for one turn");
					}
				}

			}
		}
	}
});
