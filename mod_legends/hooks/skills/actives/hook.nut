::mods_hookExactClass("skills/actives/hook", function(o)
{
	o.m.IsChain <- false;

	o.setItem <- function (_item)
	{
		this.skill.setItem(_item);
		if (this.m.IsChain)
		{
			this.m.Description = "A target up to 3 tiles away is hooked and pulled close if there is space. Anyone hit will be staggered and lose initiative. A target can not be pulled up a level of height, but may take damage if it is pulled down several levels of height at once. Shieldwall, Spearwall and Riposte will be canceled for a successfully hooked-in target. A rooted target can not be hooked.";
			this.m.MaxRange = 3;
			this.m.FatigueCost = 30;
		}
	}

	local onVerifyTarget = o.onVerifyTarget;
	o.onVerifyTarget = function ( _originTile, _targetTile )
	{
		this.m.IsAttack = false; // work around to allow targeting on allies
		local result = onVerifyTarget(_originTile, _targetTile);
		this.m.IsAttack = true;
		return result;
	}

	local onUse = o.onUse;
	o.onUse = function ( _user, _targetTile )
	{
		local target = _targetTile.getEntity();

		if (getContainer().hasTrait(::Legends.Trait.Teamplayer) && target.isAlliedWith(_user))
			target.getFlags().set("CanNotBeStaggered", true);

		local ret = onUse(_user, _targetTile);

		if (!ret)
			target.getFlags().remove("CanNotBeStaggered");

		return ret;
	}

	local onAfterUpdate = o.onAfterUpdate;
	o.onAfterUpdate = function ( _properties )
	{
		if (this.m.IsChain)
		{
			this.m.FatigueCostMult = _properties.IsSpecializedInFlails ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
			this.m.ActionPointCost = _properties.IsSpecializedInFlails ? 5 : 6;
		}
		else
		{
			onAfterUpdate( _properties );
		}
	}

	o.onTargetSelected <- function ( _targetTile )
	{
		local knockToTile = this.getPulledToTile(getContainer().getActor().getTile(), _targetTile);

		if (knockToTile == null)
			return;
		// to show where the target may be knocked back
		this.Tactical.getHighlighter().addOverlayIcon("mortar_target_02", knockToTile, knockToTile.Pos.X, knockToTile.Pos.Y);
	}

	o.getHitchance <- function ( _targetEntity )
	{
		if (this.getContainer().hasTrait(::Legends.Trait.Teamplayer) && _targetEntity.isAlliedWith(getContainer().getActor()))
			return 100;

		return this.skill.getHitchance(_targetEntity);
	}
});
