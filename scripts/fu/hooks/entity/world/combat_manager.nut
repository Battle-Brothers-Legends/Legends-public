::mods_hookNewObjectOnce("entity/world/combat_manager", function(o) {
	/* Compatibility for mods that add factions. At least two areas need to get changed,
	combat_manager and getLocalCombatProperties of world_state. The problem is that the
	Factions array is initialised with fixed size 32, which is not large enough once
	custom factions (or more towns etc) are added. This hook is the cleanest way to
	fix combat_manager, so you don't need to overwrite multiple functions instead. */
	local joinCombat = o.joinCombat;
	o.joinCombat = function( _combat, _party )
	{
		if (_combat.Factions.len() <= 100)
		{
			_combat.Factions.resize(256, []);
		}
		joinCombat(_combat, _party);
	}
});
