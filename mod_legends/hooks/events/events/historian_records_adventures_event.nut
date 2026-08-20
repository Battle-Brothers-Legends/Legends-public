::mods_hookExactClass("events/events/historian_records_adventures_event", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		::Legends.Screens.hook(this, "A", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_15.png[/img]Carrying a leathered tome in hand, %historian% shuffles into your tent. Without a word spoken %they_historian% lays the book on the table and takes a step back. You set your quill pen down and ask what it is. %They_historian% says to open it. Sighing, you open the book and come to find pages littered with names and events you know well. It is a history of the company and its adventures. You flip through the pages, seeing old tales that warm the heart and some that break it. You close the book and push it back across the table. %historian% asks if it is alright, and you nod. You say give it to the men to read around camp for it will surely lift their spirits.";
		});
	}

	o.onUpdateScore = function () {
		local candidates = ::World.getPlayerRoster().getAll().filter(@(_, _bro)(_bro.getLevel() > 8	&& (::Legends.Backgrounds.has(_bro, ::Legends.Background.Historian)	|| _bro.getSkills().hasPerk(::Legends.Perk.LegendScholar))));

		if (candidates.len() == 0) {
			return;
		}

		this.m.Historian = candidates[::Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 10;
	}
})
