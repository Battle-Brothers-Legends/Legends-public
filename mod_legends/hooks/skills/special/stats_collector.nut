::mods_hookExactClass("skills/special/stats_collector", function(o)
{
	local onTargetKilled = o.onTargetKilled;
	o.onTargetKilled = function ( _targetEntity, _skill )
	{
		local actor = this.getContainer().getActor();
		if (_targetEntity.getXPValue() > 0)
		{
			::Const.LegendMod.SetFavoriteEnemyKill(actor, _targetEntity);
		}
		onTargetKilled(_targetEntity, _skill);
	}
});
