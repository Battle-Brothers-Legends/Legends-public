::Legends.AttackPattern <- {}

/*
* Implements Swing pattern type
* 3 adjacent tiles to bro
*/
::Legends.AttackPattern.Swing <- {
	// clockwise
	standard = function(_targetTile) {
		local ownTile = this.getContainer().getActor().getTile();
		local dir = ownTile.getDirectionTo(_targetTile);
		for (local i = 0; i < 3; i++) {
			local nextDir = (dir - i + ::Const.Direction.COUNT) % ::Const.Direction.COUNT;
			if (ownTile.hasNextTile(nextDir)) {
				local nextTile = ownTile.getNextTile(nextDir);
				if (::Math.abs(nextTile.Level - ownTile.Level) <= 1) {
					::Tactical.getHighlighter().addOverlayIcon(::Const.Tactical.Settings.AreaOfEffectIcon, nextTile, nextTile.Pos.X, nextTile.Pos.Y);
				}
			}
		}
	}

	// counter-clockwise
	alternative = function(_targetTile) {
		local ownTile = this.getContainer().getActor().getTile();
		local dir = ownTile.getDirectionTo(_targetTile);
		for (local i = 0; i < 3; i++) {
			local nextDir = (dir + i) % ::Const.Direction.COUNT;
			if (ownTile.hasNextTile(nextDir)) {
				local nextTile = ownTile.getNextTile(nextDir);
				if (::Math.abs(nextTile.Level - ownTile.Level) <= 1) {
					::Tactical.getHighlighter().addOverlayIcon(::Const.Tactical.Settings.AreaOfEffectIcon, nextTile, nextTile.Pos.X, nextTile.Pos.Y);
				}
			}
		}
	}

	onTargetSelected = function (_skill, _targetTile) {
		if (::Tactical.State.m.AlternativeAttack) {
			this.alternative.bindenv(_skill)(_targetTile)
		} else {
			this.standard.bindenv(_skill)(_targetTile)
		}
	}
}
