this.legend_killer_scares_noble_encounter <- ::inherit("scripts/encounters/encounter", {
	m = {
		Killer = null,
		Noble = null
	},

	function create() {
		this.encounter.create();
		this.m.Type = "encounter.legend_killer_scares_noble";
		this.m.Name = ::Const.Strings.randomCampEncounterName();
		this.m.Cooldown = 60 * this.World.getTime().SecondsPerDay;
	}

	function createScreens() {
		this.m.Screens.push({
			ID = "Start",
			Title = "In camp...",
			Text = "[img]gfx/ui/events/event_33.png[/img]Leaving your tent, you spy %noble% making a poor attempt of hiding by the wagon. You meet %their_noble% gaze and are about to call out to %them_noble%, when %they_noble% gasps, spins on %their_noble% heels, and bolts. Amused at the sight, you hardly hear %killer% approach until %they_killer%\'s firmly clasped %their_killer% hand on your shoulder.%SPEECH_ON%%They're_noble% an imaginative sort, that one.%SPEECH_OFF%%They_killer% gestures, the blue-blooded mercenary now a scrambling mess, slipping on a patch of mud in some vain attempt to flee.%SPEECH_ON%Has it in %their_noble% head I\'m some dangerous assassin\' out to get them { as revenge for some misdeed in %their_noble% past. | as part of some long contract for one noble house or other. }%SPEECH_OFF%You detect the faintest smirk slipping through the careful facade before %they_killer% continues.%SPEECH_ON%But I\'m not, captain, don\'t you worry. I kill on your word only, but it doesn\'t hurt to keep up one\'s professional reputation amongst the highborn, does it?%SPEECH_OFF%You shrug and tell %them_killer% not to scare the noble too bad. %SPEECH_ON%Of course, captain.%SPEECH_OFF%%They_killer% pats your shoulder again as %they_killer% follows the fresh and frantic footsteps of a %person_noble% marked.%SPEECH_ON%Come here, little rabbit.%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "{Enjoy yourself, I guess | I\'m glad they\'re getting along}",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.Characters.push(_event.m.Killer.getImagePath());
				this.Characters.push(_event.m.Noble.getImagePath());

				this.List.push(::Legends.EventList.changeResolve(_event.m.Killer, ::Math.rand(1, 2)));
				this.List.push(::Legends.EventList.changeInitiative(_event.m.Killer, ::Math.rand(1, 2)));
				this.List.push(::Legends.EventList.changeMood(_event.m.Killer, 0.5, "Scared noble"));

				local effect = ::Legends.Effects.grant(_event.m.Noble, ::Legends.Effect.Afraid);
				this.List.push(::Legends.EventList.changeMood(_event.m.Noble, -0.5, "Was scared by " + _event.m.Killer.getName()));
				this.List.push({
					id = 10,
					icon = effect.getIcon(),
					text = _event.m.Noble.getName() + " is afraid"
				});
			}
		});
	}

	function isVisible() {
		return !::World.getTime().IsDaytime;
	}

	function isValid(_camp) {
		if (::World.Assets.getOrigin().getID() == "scenario.legend_risen_legion")
			return false;

		local brothers = ::World.getPlayerRoster().getAll();
		local candidates_noble = brothers.filter(@(idx, bro) bro.getBackground().isNoble());
		if (candidates_noble.len() == 0)
			return false;

		local candidates_killer = brothers.filter(@(idx, bro)
			bro.getLevel() > 4 && (bro.getBackground().getID() == "background.assassin" || bro.getBackground().getID() == "background.killer_on_the_run")
		);
		if (candidates_killer.len() == 0)
			return false;

		this.m.Killer = candidates_killer[::Math.rand(0, candidates_killer.len() - 1)];
		this.m.Noble = candidates_noble[::Math.rand(0, candidates_noble.len() - 1)];

		return !this.isOnCooldown();
	}

	function onPrepareVariables(_vars) {
		_vars.push(["killer", this.m.Killer.m.Name]);
		_vars.push(["noble", this.m.Noble.m.Name]);
	}

	function onClear() {
		this.m.Killer = null;
		this.m.Noble = null;
	}
});
