::mods_hookExactClass("events/events/player_is_rich_event", function(o) {
	o.onUpdateScore = function () {
		if (::World.Assets.getOrigin().getID() == "scenario.lone_wolf")
			return;

		if (::World.Assets.getMoney() <= 30000)
			return;

		if (::World.getPlayerRoster().getSize() < 5)
			return;

		if (::World.Assets.m.ProfessionEffect.LegendPaymaster > 0) {
			return;
		}

		local brothers = ::World.getPlayerRoster().getAll();
		local numBros = 0;

		foreach( bro in brothers ) {
			if (!::Legends.Backgrounds.has(bro, ::Legends.Background.Slave) && !bro.isStabled()) {
				numBros = ++numBros;
			}
		}

		if (numBros < 2)
			return;

		this.m.Score = (::World.Assets.getMoney() - 30000) * 0.0005;
	}
})
