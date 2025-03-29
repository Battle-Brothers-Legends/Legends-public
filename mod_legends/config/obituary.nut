::Legends.addFallen <- function (_bro, _cause) {
	local fallen = {
		Name = _bro.getName(),
		Time = this.World.getTime().Days,
		TimeWithCompany = this.Math.max(1, _bro.getDaysWithCompany()),
		Kills = _bro.getLifetimeStats().Kills,
		Battles = _bro.getLifetimeStats().Battles,
		KilledBy = _cause,
		Expendable = _bro.getBackground().getID() == "background.slave"
	};

	::World.Statistics.addFallen(_bro.finalizeFallen(fallen));
}
