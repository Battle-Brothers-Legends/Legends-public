::mods_hookExactClass("skills/actives/repel", function(o)
{
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

	o.onTargetSelected <- function ( _targetTile )
	{
		local knockToTile = this.findTileToKnockBackTo(getContainer().getActor().getTile(), _targetTile);

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
