::mods_hookExactClass("skills/actives/taunt", function (o) {
	o.onUse = function (_user, _targetTile) {
		local target = _targetTile.getEntity();
		target.getAIAgent().setForcedOpponent(_user);
		::Legends.Effects.grant(target, ::Legends.Effect.Taunted);
		::Legends.Effects.grant(this, ::Legends.Effect.Taunt);
		return true;
	}
});
