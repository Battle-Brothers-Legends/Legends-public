::mods_hookExactClass("events/events/dlc4/rangers_origin_hunt_food_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		this.m.Cooldown = 4.0 * ::World.getTime().SecondsPerDay;
	}

	o.onUpdateScore = function () {
		if (!::Const.DLC.Wildmen)
			return;

		if (::World.Assets.getOrigin().getID() != "scenario.rangers" && ::World.Assets.getOrigin().getID() != "scenario.legends_rangers")
			return;

		if (!::World.getTime().IsDaytime)
			return;

		local currentTile = ::World.State.getPlayer().getTile();

		if (currentTile.Type != ::Const.World.TerrainType.Forest && currentTile.Type != ::Const.World.TerrainType.LeaveForest && currentTile.Type != ::Const.World.TerrainType.AutumnForest && currentTile.Type != ::Const.World.TerrainType.SnowyForest)
			return;

		local brothers = ::World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
			return;

		if (!::World.Assets.getStash().hasEmptySlot())
			return;

		local candidates = [];

		foreach( bro in brothers ) {
			if (!bro.getSkills().hasSkillOfType(::Const.SkillType.TemporaryInjury))
				candidates.push(bro);
		}

		if (candidates.len() == 0)
			return;

		this.m.Hunter = candidates[::Math.rand(0, candidates.len() - 1)];
		this.m.Score = 10;
	}
})
