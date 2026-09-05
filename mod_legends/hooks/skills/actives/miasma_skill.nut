::mods_hookExactClass("skills/actives/miasma_skill", function (o) {
	o.onUse = function (_user, _targetTile) {
		local targets = [_targetTile];
		targets.extend([0, 1, 2, 3, 4, 5].filter(@(_, _direction) _targetTile.hasNextTile(_direction)).map(@(_direction) _targetTile.getNextTile(_direction)));

		foreach (tile in targets) {
			::Tactical.State.spawnMiasmaOnTile(tile, _user);
		}

		return true;
	}
});
