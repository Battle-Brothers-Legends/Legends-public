this.legend_cannibal_corrupts_butcher <- this.inherit("scripts/events/event", {
	m = {
		Cannibal = null,
		Butcher = null
	},
	function create() {
		this.m.ID = "event.legend_cannibal_corrupts_butcher";
		this.m.Title = "During camp...";
		this.m.Cooldown = 30 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/legend_cannibal_corrupts_butcher.png[/img]As it turns out, a butcher of men and a butcher of animals aren't that different. Since %cannibal% and %butcher% have been acquainted, the two have become fast friends. Perhaps too friendly even... \n You\'re interrupted in your ruminating by %butcher% %themselves_butcher%.%SPEECH_ON% Dinner\'s ready, Captain. Got a new recipe.%SPEECH_OFF% Handing you a bowl, the butcher strides off towards %cannibal%. You feel a sudden lack of appetite.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "Just in case.",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.Characters.push(_event.m.Cannibal.getImagePath());
				::Legends.Traits.grant(_event.m.Butcher, ::Legends.Trait.LegendCannibalistic, function(_trait) {
					this.List.push({
						id = 10,
						icon = _trait.getIcon(),
						text = _event.m.Butcher.m.Name + " now enjoys forbidden meat"
					});
				}.bindenv(this));
				this.List.push(::Legends.EventList.changeMood(_event.m.Cannibal, 2.0, "Spread the joys of cannibalism"));
				this.List.push(::Legends.EventList.changeMood(_event.m.Butcher, 2.0, "Started appreciating forbidden meat"));
			}
		});
	}

	function onUpdateScore() {
		local brothers = ::World.getPlayerRoster().getAll();
		local cannibal_candidates = [];
		local butcher_candidates = [];

		foreach (bro in brothers) {
			if (bro.getSkills().hasTrait(::Legends.Trait.LegendCannibalistic)) {
				cannibal_candidates.push(bro);
			} else if (::Legends.Backgrounds.has(bro, ::Legends.Background.Butcher)) {
				butcher_candidates.push(bro);
			}
		}

		if (cannibal_candidates.len() < 1)
			return;

		if (butcher_candidates.len() < 1)
			return;

		this.m.Cannibal = cannibal_candidates[::Math.rand(0, cannibal_candidates.len() - 1)];
		this.m.Butcher = butcher_candidates[::Math.rand(0, butcher_candidates.len() - 1)];
		this.m.Score = 5 + (this.m.Cannibal.getLevel() + this.m.Butcher.getLevel()) * 5.0 / ::Const.LevelXP.len();
	}

	function onPrepare() {}

	function onPrepareVariables(_vars) {
		_vars.push([
			"cannibal",
			this.m.Cannibal.m.Name
		]);
		_vars.push([
			"butcher",
			this.m.Butcher.m.Name
		]);
	}

	function onClear() {
		this.m.Cannibal = null;
		this.m.Butcher = null;
	}

});

