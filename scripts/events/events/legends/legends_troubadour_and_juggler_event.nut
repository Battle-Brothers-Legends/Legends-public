this.legends_troubadour_and_juggler_event <- this.inherit("scripts/events/event", {
	m = {
		Troubadour = null,
		Juggler = null
	},
	function create() {
		this.m.ID = "event.legends_troubadour_and_juggler";
		this.m.Title = "During camp...";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_26.png[/img]As sparks rise from the fire, %juggler% is stretching and adopting various acrobatic poses. %troubadour% approaches and adopts some of the positions along side the juggler. %SPEECH_ON% These movements remind me of the theater troupe I used to perform in. Playing at fighting and love needs tight timings and positioning, to know your spacing as well as your lines. Do you know the faked dagger pass? The trust fall? What of the stage dive? %SPEECH_OFF% \n\n The juggler laughs and replies. %SPEECH_ON%I have been practicing them for years troubadour, shall we dance? %SPEECH_OFF% The two rise and begin conducting a series of moves you have not seen before. One turning their back to the other and then falling into their arms, before trading places. They grow faster and faster at this blind falling, before the juggler turns midair and the fall becomes a tumble. Soon both are tumbling, through each others arms, and spinning around each other. It becomes a blur of arms, legs and objects moving between them. They begin passing things back and forth, first a ball, then a rock, then a knife. Before long there are items hurling through the air, most caught, but some bouncing off through the camp.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "Not standard training, but it will do",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.Characters.push(_event.m.Troubadour.getImagePath());
				this.Characters.push(_event.m.Juggler.getImagePath());
				local r = ::Math.rand(0, 20);
				local tmdef = _event.m.Troubadour.getCurrentProperties().getMeleeDefense();
				local jmdef = _event.m.Juggler.getCurrentProperties().getMeleeDefense();
				local avgmdef = ::Math.floor((tmdef + jmdef) / 2);
				if (r > avgmdef) {
					r = ::Math.rand(1, 5);
					if (r == 1) {
						this.List.push(::Legends.EventList.changeMeleeDefense(_event.m.Troubadour, 1));
					} else if (r == 2) {
						this.List.push(::Legends.EventList.changeMeleeSkill(_event.m.Troubadour, 1));
					} else if (r == 3) {
						this.List.push(::Legends.EventList.addInjury(_event.m.Troubadour, ::Const.Injury.BluntBody));
					} else {
						this.List.push(::Legends.EventList.addInjury(_event.m.Troubadour, ::Const.Injury.PiercingBody));
					}
				} else {
					r = ::Math.rand(1, 8);
					if (r == 1) {
						this.List.push(::Legends.EventList.changeRangedDefense(_event.m.Juggler, 1));
					} else if (r == 2) {
						this.List.push(::Legends.EventList.changeRangedSkill(_event.m.Juggler, 1));
					} else if (r == 3) {
						this.List.push(::Legends.EventList.addInjury(_event.m.Troubadour, ::Const.Injury.BluntBody));
					} else if (r == 4) {
						this.List.push(::Legends.EventList.addInjury(_event.m.Troubadour, ::Const.Injury.PiercingBody));
					}

					local brothers = this.World.getPlayerRoster().getAll();
					foreach (bro in brothers) {
						if (bro.getID() == _event.m.Troubadour.getID() || bro.getID() == _event.m.Juggler.getID()) {
							continue;
						}
						local r = ::Math.rand(1, 20);
						if (r == 1) {
							this.List.push(::Legends.EventList.changeRangedDefense(bro, 1));
						} else if (r == 2) {
							this.List.push(::Legends.EventList.addInjury(bro, ::Const.Injury.Archery));
						}
					}
				}
			}

		});
	}

	function onUpdateScore() {
		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
			return;

		local candidates_troubadour = [];
		foreach (bro in brothers) {
			if (::Legends.Backgrounds.has(bro, ::Legends.Background.Minstrel) && bro.getGender() == 1) {
				candidates_troubadour.push(bro);
			}
		}
		if (candidates_troubadour.len() == 0)
			return;

		local candidates_juggler = [];
		foreach (bro in brothers) {
			if (::Legends.Backgrounds.has(bro, ::Legends.Background.Juggler)) {
				candidates_juggler.push(bro);
			}
		}

		if (candidates_juggler.len() == 0)
			return;

		this.m.Troubadour = candidates_troubadour[::Math.rand(0, candidates_troubadour.len() - 1)];
		this.m.Juggler = candidates_juggler[::Math.rand(0, candidates_juggler.len() - 1)];
		this.m.Score = (candidates_troubadour.len() + candidates_juggler.len()) * 5;
	}

	function onPrepare() {}

	function onPrepareVariables(_vars) {
		_vars.push([
			"troubadour",
			this.m.Troubadour.getNameOnly()
		]);
		_vars.push([
			"juggler",
			this.m.Juggler.getName()
		]);
	}

	function onClear() {
		this.m.Troubadour = null;
		this.m.Juggler = null;
	}

});
