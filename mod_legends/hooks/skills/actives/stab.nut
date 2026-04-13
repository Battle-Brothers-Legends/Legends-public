::mods_hookExactClass("skills/actives/stab", function(o)
{
	o.m.IsEstocStab <- false;

	o.setItem <- function(_item) {
		this.skill.setItem(_item);
		if (this.m.IsEstocStab) {
			this.m.Name = "Thrust";
			this.m.Description = "A swift stab aiming for the weak points between the armor.";
			this.m.Icon = "skills/skewer_general.png";
			this.m.IconDisabled = "skills/skewer_general_bw.png";
			this.m.Overlay = "skewer_general";
			this.m.DirectDamageMult = 0.2;
			this.m.ActionPointCost = 4;
			this.m.FatigueCost = 10;
		}
	}

	local onUse = o.onUse;
	o.onUse = function(_user, _targetTile)
	{
		if (this.m.IsEstocStab)
			this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectThrust);
		return onUse(_user, _targetTile);
	}

	o.onAfterUpdate = function ( _properties )
	{
		if (this.m.IsEstocStab)
		{
			this.m.FatigueCostMult = _properties.IsSpecializedInSwords ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
			return;
		}

		if (_properties.IsSpecializedInDaggers)
		{
			this.m.FatigueCostMult = this.Const.Combat.WeaponSpecFatigueMult;
			this.m.ActionPointCost = 3;
		}
		else
		{
			this.m.FatigueCostMult = 1.0;
		}
	}

});
