::mods_hookExactClass("events/events/dlc4/rangers_origin_hunt_food_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		this.m.Cooldown = 4.0 * this.World.getTime().SecondsPerDay;
	}

	o.onUpdateScore = function () {
		if (!this.Const.DLC.Wildmen)
			return;

		if (this.World.Assets.getOrigin().getID() != "scenario.rangers" && this.World.Assets.getOrigin().getID() != "scenario.legends_rangers")
			return;

		if (!this.World.getTime().IsDaytime)
			return;

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Forest && currentTile.Type != this.Const.World.TerrainType.LeaveForest && currentTile.Type != this.Const.World.TerrainType.AutumnForest && currentTile.Type != this.Const.World.TerrainType.SnowyForest)
			return;

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
			return;

		if (!this.World.Assets.getStash().hasEmptySlot())
			return;

		local candidates = [];

		foreach( bro in brothers ) {
			if (!bro.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury))
				candidates.push(bro);
		}

		if (candidates.len() == 0)
			return;

		this.m.Hunter = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = 10;
	}
})
