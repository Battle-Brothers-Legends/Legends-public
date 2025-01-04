::mods_hookExactClass("events/events/dlc8/volunteers_event", function(o) {
	o.onUpdateScore = function () {
		if (!this.Const.DLC.Paladins)
			return;

		local fallen = [];
		local fallen = this.World.Statistics.getFallen();

		if (fallen.len() < 5)
			return;

		if (fallen[0].Time > this.World.getTime().Days + 7 || fallen[1].Time > this.World.getTime().Days + 7 || fallen[2].Time > this.World.getTime().Days + 7 || fallen[3].Time > this.World.getTime().Days + 7 || fallen[4].Time > this.World.getTime().Days + 7)
			return;

		if (this.World.getPlayerRoster().getSize() + 3 >= this.World.Assets.getBrothersMax())
			return;

		if (this.World.Assets.getBusinessReputation() < 1800 || this.World.Assets.getMoney() > 1500)
			return;

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
			return;

		this.m.Score = 20;
	}
})
