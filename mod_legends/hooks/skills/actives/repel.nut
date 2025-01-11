::mods_hookExactClass("skills/actives/repel", function(o)
{
	o.onVerifyTarget = function ( _originTile, _targetTile )
	{
		this.m.IsAttack = false; // work around to allow targeting on allies
		local result = this.skill.onVerifyTarget(_originTile, _targetTile);
		this.m.IsAttack = true;
		return result && !_targetTile.getEntity().getCurrentProperties().IsRooted;
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
