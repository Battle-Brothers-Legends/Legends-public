this.legend_killer_scares_noble_encounter <- ::inherit("scripts/encounters/encounter", {
	m = {
		Killer = null,
		Noble = null
	},

	function create() {
		this.m.ID = "encounter.legend_killer_scares_noble";
		this.m.Name = ::Const.Strings.randomCampEncounterName();
		this.m.Cooldown = 30 * this.World.getTime().SecondsPerDay;
		this.createScreens();
	}

	function createScreens() {
		this.m.Screens.push({
			ID = "Start",
			Title = "In camp...",
			Text = "[img]gfx/ui/events/event_33.png[/img]{Leaving your tent, you spy %noble% making a poor attempt of hiding by the wagon. You meet their gaze and are about to call out to them, when they gasp, spin on their heels, and bolt. Amused at the sight, you hardly hear %killer% approach until they\'ve firmly clasped their hand on your shoulder.%SPEECH_ON%They\'re an imaginative sort, that one.%SPEECH_OFF%They gesture, the blue-blooded mercenary now a scrambling mess, slipping on a patch of mud in some vain attempt to flee.%SPEECH_ON%Has it in their head I\'m some dangerous fella' out to get them [as revenge for some misdeed in their past] [as part of some long contract for one noble house or other.]%SPEECH_OFF%You detect the faintest smirk slipping through the careful facade before they continue.%SPEECH_ON%But I\'m not, captain, don\'t you worry. I kill on your word only, but it doesn\'t hurt to keep up one\'s professional reputation amongst the highborn, does it?%SPEECH_OFF%You shrug and tell them not to scare the noble too bad. %SPEECH_ON%Of course, captain.%SPEECH_OFF%They pat your shoulder again as they follow the fresh and frantic footsteps of a man marked.%SPEECH_ON%Come here, little rabbit.%SPEECH_OFF%}",
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
		::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.Killer.getGender(), "killer");
		::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.Noble.getGender(), "noble");
	}

	function onClear() {
		this.m.Killer = null;
		this.m.Noble = null;
	}
});
