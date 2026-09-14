this.legend_nomad_remembers_past_encounter <- ::inherit("scripts/encounters/encounter", {
	m = {
		Nomad = null
	},

	function create() {
		this.encounter.create();
		this.m.Type = "encounter.legend_nomad_remembers_past";
		this.m.Name = ::Const.Strings.randomCampEncounterName();
		this.m.Cooldown = 20 * this.World.getTime().SecondsPerDay;
	}

	function createScreens() {
		this.m.Screens.push({
			ID = "Start",
			Title = "Amongst the sands...",
			Text = "[img]gfx/ui/events/event_157.png[/img]{As you begin to strike camp, you notice %nomad% kneeling in the sand a ways off into the endless expanse of the desert. Approaching %them_nomad%, you see they\'re carefully stacking rocks atop each other, building a small yet formidably constructed cairn of sand and stone. Sensing your presence, %nomad% speaks, ever fixed on their golden monument.%SPEECH_ON%I killed my first man here, captain. Well, not far from here.%SPEECH_OFF%You look around but see only a never-ending sea of gleaming sands, hardly a notable feature or striking landmark to be made from the immensity of the desert. You figure you could live a lifetime here and be unable to recognise this spot from another, but know the nomads have spent countless lifetimes here mastering these lands, so trust %nomad%\'s intuition. Looking back, you see %nomad% has completed their cairn, tearing a piece of fabric from their person to sign it.%SPEECH_ON%A group from the city tracked us, manhunters and muladis in tow otherwise they\'d have been swallowed by the sands trying to find us. They attacked in the night whilst most of us slept or hunted. I was young enough to be amongst those at the camp when it happened, what feels like a lifetime ago…%SPEECH_OFF%They begin on another cairn, this one packed with malice and frustration. It almost crumbles twice before they continue.%SPEECH_ON%A conscript, barely older than myself found me, blood on their spear, hatred in his eyes. The fight was messy and slow, but by the time it was done, my tribe burned. Either scattered to the wind, slain, or carried off in chains to serve a cruel debt to the Gilder. I ran.%SPEECH_OFF%They finish the second cairn and rise to their feet. In a measured movement, they sweep the second cairn back into the sands it rose from leaving only their first cairn standing, fabric slowly dancing in the desert breeze. In their hand they hold a fistful of sand which they kiss and then pocket under their newly torn cloak.%SPEECH_ON%But they didn\'t get us all, captain. They didn\'t get me.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "How much sand do you keep in those pockets?",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.Characters.push(_event.m.Nomad.getImagePath());

				this.List.push(::Legends.EventList.changeResolve(_event.m.Nomad, 2));
				this.List.push(::Legends.EventList.changeMood(_event.m.Nomad, 1.0, _event.buildText("{Reflected on %their_nomad% survival against the city states}")));
			}
		});
	}

	function onPrepareVariables (_vars) {
		_vars.push(["nomad", this.m.Nomad.getName()]);
	}

	function isVisible() {
		local currentTile = this.World.State.getPlayer().getTile();
		if (currentTile.Type != ::Const.World.TerrainType.Desert)
			return false;

		local towns = this.World.EntityManager.getSettlements();
		foreach(t in towns){
			if (t.getTile().getDistanceTo(currentTile) <= 4)
				return false; //if too close to town, disable
		}
		return true;
	}

	function isValid(_camp) {
		if (::World.Assets.getOrigin().getID() == "scenario.legend_risen_legion")
			return false;

		local bros = ::World.getPlayerRoster().getAll();
		local candidates = [];
		foreach (bro in bros) {
			if (bro.getBackground().getID() == ::Legends.Backgrounds.getID(::Legends.Background.Nomad)) {
				candidates.push(bro);
			}
		}
		if (candidates.len() == 0) {
			return false;
		}
		this.m.Nomad = candidates[::Math.rand(0, candidates.len() - 1)];
		return this.m.Nomad != null && !this.isOnCooldown();
	}

	function onClear()
	{
		this.m.Nomad = null;
	}
});
