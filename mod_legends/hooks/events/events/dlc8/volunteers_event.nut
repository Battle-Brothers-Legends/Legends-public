::mods_hookExactClass("events/events/dlc8/volunteers_event", function(o) {
	o.onUpdateScore = function () {
		if (!::Const.DLC.Paladins)
			return;

		local fallen = [];
		local fallen = ::World.Statistics.getFallen();

		if (fallen.len() < 5)
			return;

		if (fallen[0].Time > ::World.getTime().Days + 7 || fallen[1].Time > ::World.getTime().Days + 7 || fallen[2].Time > ::World.getTime().Days + 7 || fallen[3].Time > ::World.getTime().Days + 7 || fallen[4].Time > ::World.getTime().Days + 7)
			return;

		if (::World.getPlayerRoster().getSize() + 3 >= ::World.Assets.getBrothersMax())
			return;

		if (::World.Assets.getBusinessReputation() < 1800 || ::World.Assets.getMoney() > 1500)
			return;

		local brothers = ::World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
			return;

		this.m.Score = 20;
	}
})
