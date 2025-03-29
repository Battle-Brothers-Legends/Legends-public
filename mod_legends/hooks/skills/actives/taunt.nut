::mods_hookExactClass("skills/actives/taunt", function(o)
{
	o.onUse = function ( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		target.getAIAgent().setForcedOpponent(_user);
		::Legends.Effects.grant(target, ::Legends.Effect.Taunted);
		return true;
		::Legends.Effects.grant(this, ::Legends.Effect.Taunt);
	}
});
