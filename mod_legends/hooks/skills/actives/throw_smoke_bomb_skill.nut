::mods_hookExactClass("skills/actives/throw_smoke_bomb_skill", function(o) 
{
	o.m.Item <- null;
	o.setItem <- function( _i )
	{
		this.m.Item = this.WeakTableRef(_i);
	}

	o.getTooltip = function()
	{
		local ret = getTooltip();
		local ammo = this.getAmmo();

		if (ammo > 0)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]" + ammo + "[/color] use left"
			});
		}
		else
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Has been used[/color]"
			});
		}

		return ret;
	}

	o.isUsable <- function()
	{
		return !this.Tactical.isActive() || this.skill.isUsable() && this.getAmmo() > 0 && !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions());
	}

	o.getAmmo <- function()
	{
		if (this.m.Item == null && this.m.Item.isNull())
			return 0;

		return this.m.Item.getAmmo();
	}

	o.consumeAmmo <- function()
	{
		if (this.m.Item != null && !this.m.Item.isNull())
		{
			this.m.Item.consumeAmmo();
		}
	}

	o.onUse = function( _user, _targetTile )
	{
		if (this.m.IsShowingProjectile && this.m.ProjectileType != 0)
		{
			local flip = !this.m.IsProjectileRotated && _targetTile.Pos.X > _user.getPos().X;

			if (_user.getTile().getDistanceTo(_targetTile) >= this.Const.Combat.SpawnProjectileMinDist)
			{
				this.Tactical.spawnProjectileEffect(this.Const.ProjectileSprite[this.m.ProjectileType], _user.getTile(), _targetTile, 1.0, this.m.ProjectileTimeScale, this.m.IsProjectileRotated, flip);
			}
		}
		
		this.consumeAmmo();
		
		this.Time.scheduleEvent(this.TimeUnit.Real, 250, this.onApply.bindenv(this), {
			Skill = this,
			User = _user,
			TargetTile = _targetTile
		});
	}

	o.onAfterUpdate = function( _properties )
	{
		this.m.FatigueCostMult = (_properties.IsSpecializedInThrowing || _properties.IsSpecializedInNets) ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		this.m.MaxRange = _properties.IsSpecializedInNets ? 4 : 3;
	}
});
