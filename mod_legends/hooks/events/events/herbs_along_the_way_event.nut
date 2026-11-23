::mods_hookExactClass("events/events/herbs_along_the_way_event", function(o) {
	o.m.Herbalist <- null;
	local create = o.create;
	o.create = function() {
		create();
		::Legends.Screens.hook(this, "A", function (_screen) {
			_screen.Text = "%terrainImage%While heading toward your destination, %volunteer% runs up to you with a bundle of herbs in hand. Now you know this fool knows nothing about plants or wildlife, but %they_volunteer% seems rather persistent in wanting to try them out. Something about \'hearing\' of magical powers to be found in the essence of herbs. This talk gets the attention of a few others in the company. Soon, a number of them are asking to try out the \'medicine\' for the good of their brothers.";
			local start = _screen.start;
			_screen.start = function (_event) {
				start(_event);
				if (_event.m.Herbalist != null && this.Options.len() < 6) {
					this.Options.insert(this.Options.len() - 1, {
						Text = "{We actually have a herbalist, you know? | Let's ask %herbalist%.}",
						getResult = @(_event) "Herbalist"
					});
				}
			}
		});
		::Legends.Screens.hook(this, "C", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_18.png[/img]From one end comes vomit and from the other shite. It appears the herbs were not worth a try after all. %volunteer% bravely elected %themselves_volunteer% ready to chow down on the mystery plants and, suffice it to say, the proportions which you are seeing come out of %them_volunteer% are definitely mystical in that strange, \'can the body really hold that much?\', sort of way.";
		});

		this.m.Screens.push({
			ID = "Herbalist"
			Text = "[img]gfx/ui/events/event_40.png[/img]%herbalist% steps forward and carefully examines the herbs separating them into separate stacks. %SPEECH_ON%These ones will give you the runs, these will swell your tongue and these give you a nasty rash in the nethers...%SPEECH_OFF% As %they_herbalist% drones on %volunteer% suddenly seems a lot less eager to test the herbs and quietly backs off. The herbalist finishes his work and hands you the stack of medicinal herbs."
			Image = ""
			List = []
			Characters = []
			Options = [{
				Text = "A right jester you are."
				getResult = @(_event) 0
			}]
			function start(_event) {
				this.Characters.push(_event.m.Herbalist.getImagePath());

				local amount = this.Math.rand(5, 12);
				this.World.Assets.addMedicine(amount);
				this.List.extend([
					{
						id = 10,
						icon = "ui/icons/asset_medicine.png",
						text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + amount + "[/color] Medical Supplies"
					},
					::Legends.EventList.changeResolve(_event.m.Herbalist, 2),
					::Legends.EventList.changeMood(_event.m.Herbalist, 1.0, "Was useful in finding medicine")
				]);
			}
		});
	}

	local onUpdateScore = o.onUpdateScore;
	o.onUpdateScore = function () {
		if (this.World.Assets.getOrigin().getID() == "scenario.legend_risen_legion")
			return;

		local brothers = this.World.getPlayerRoster().getAll();
		if (brothers.len() < 3)
			return;

		local herbalists = [];
		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.legend_herbalist" || ::Legends.Perks.has(bro, ::Legends.Perk.LegendGatherer))
			{
				herbalists.push(bro);
			}
		}
		if (herbalists.len() > 0)
			this.m.Herbalist = herbalists[this.Math.rand(0, herbalists.len() - 1)];

		onUpdateScore();
	}

	local onPrepareVariables = o.onPrepareVariables;
	o.onPrepareVariables = function (_vars) {
		onPrepareVariables(_vars);
		_vars.push([
			"herbalist",
			this.m.Herbalist != null ? this.m.Herbalist.getName() : ""
		]);
	}

	local onClear = o.onClear;
	o.onClear = function () {
		onClear();
		this.m.Herbalist = null;
	}
});
