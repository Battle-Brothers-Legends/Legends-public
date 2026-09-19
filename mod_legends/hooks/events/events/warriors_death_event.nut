::mods_hookExactClass("events/events/warriors_death_event", function(o) {
	o.onUpdateScore = function () {
		if (::Time.getVirtualTimeF() - ::World.Events.getLastBattleTime() > 6.0)
			return;

		local fallen = [];
		local fallen = ::World.Statistics.getFallen();

		if (fallen.len() < 3)
			return;

		local f0;
		local f1;

		foreach( f in fallen )
		{
			if (f.Expendable)
				continue;

			if (f0 == null)
				f0 = f;
			else if (f1 == null)
				f1 = f;
			else
				break;
		}

		if (f0 == null || f1 == null)
			return;

		if (f0.Time < ::World.getTime().Days || f1.Time < ::World.getTime().Days)
			return;

		local brothers = ::World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
			return;

		local candidates_gravedigger = [];

		foreach( bro in brothers )
			if (::Legends.Backgrounds.has(bro, ::Legends.Background.Gravedigger))
				candidates_gravedigger.push(bro);

		this.m.Casualty = f0.Name;

		if (candidates_gravedigger.len() != 0)
			this.m.Gravedigger = candidates_gravedigger[::Math.rand(0, candidates_gravedigger.len() - 1)];

		this.m.Score = 500;
	}
})
