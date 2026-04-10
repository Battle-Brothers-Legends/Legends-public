::mods_hookExactClass("skills/actives/smite_skill", function(o)
{
	o.getTooltip = function ()
	{
		local tooltip = this.getDefaultTooltip();
		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has a [color=%positive%]100%[/color] chance to stagger on a hit"
		});
		return tooltip;
	}

	o.onUse = function ( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectBash);
		local success = this.attackEntity(_user, _targetTile.getEntity());

		if (::Legends.S.skillEntityAliveCheck(_user, target))
			return success;

		if (success) {
			local stagger = ::Legends.Effects.grant(target, ::Legends.Effect.Staggered);
			if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer && !target.getFlags().has("tail")) {
				this.Tactical.EventLog.log(stagger.getLogEntryOnAdded(this.Const.UI.getColorizedEntityName(_user), this.Const.UI.getColorizedEntityName(target)));
			}
		}

		return success;
	}
});
