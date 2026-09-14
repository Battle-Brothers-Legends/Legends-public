::mods_hookExactClass("skills/actives/kraken_move_skill", function (o) {
	local onTeleportStart = o.onTeleportStart;
	o.onTeleportStart = function (_tag) {
		if (::Legends.S.isEntityNullOrDead(_tag.User) || !_tag.User.isPlacedOnMap()) {
			return;
		}

		local userTile = _tag.User.getTile();
		local targetTile = _tag.TargetTile;
		if (!targetTile.IsEmpty && targetTile.ID != userTile.ID) {
			_tag.TargetTile = userTile;
		}

		onTeleportStart(_tag);
	}

	local onTeleportDone = o.onTeleportDone;
	o.onTeleportDone = function (_entity, _tag) {
		if (::Legends.S.isEntityNullOrDead(_entity)) {
			return;
		}
		onTeleportDone(_entity, _tag);
	}
});
