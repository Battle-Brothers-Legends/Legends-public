::mods_hookExactClass("skills/actives/taunt", function (o) {
	local onVerifyTarget = o.onVerifyTarget;
	o.onVerifyTarget = function (_originTile, _targetTile) {
		return onVerifyTarget(_originTile, _targetTile) && !_targetTile.getEntity().getCurrentProperties().IsImmuneToTaunt;
	}

	o.onUse = function (_user, _targetTile) {
		local target = _targetTile.getEntity();
		if (target.getCurrentProperties().IsImmuneToTaunt) {
			return true;
		}

		target.getAIAgent().setForcedOpponent(_user);
		::Legends.Effects.grant(target, ::Legends.Effect.Taunted);
		::Legends.Effects.grant(this, ::Legends.Effect.Taunt);
		return true;
	}
});
