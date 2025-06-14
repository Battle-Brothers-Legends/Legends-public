::mods_hookExactClass("events/events/crisis/undead_frozen_pond_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "Good") {
				s.Text = "[img]gfx/ui/events/event_143.png[/img]%chosenbrother% elects to try and make a run on getting the dead knight\'s sword. %Their_chosenbrother% first step on the pond sends an icy warble clear across the underbelly of the frozen sheet. %They_chosenbrother% tests %their_chosenbrother% footing again. The ice shifts and chitters, but it does not crack. With every step, the sellsword measures %their_chosenbrother% own weight and its likelihood to collapse the ice - all the meanwhile, making sure %they_chosenbrother% doesn\'t step on one of the corpses littered about. \n\n %They_chosenbrother% successfully gets to the undead knight. Icicles dangle off its sword, the blade itself encapsulated in a layer of ice. The sellsword grabs the blade and yanks. The undead knight\'s arm lurches forward and breaks off at the elbow, sending the sellsword arse-skating backward across the pond. %They_chosenbrother% slides up against the edge where your men help %them_lightweight% up. The sword will need to be heated to get the ice off, but the weapon is definitely usable.";
			}
			if (s.ID == "Bad") {
				s.Text = "[img]gfx/ui/events/event_143.png[/img]%chosenbrother% tries the ice, putting a foot right on the edge of the pond. A soft warble echoes across the pondwater\'s cold underbelly, as though someone had skipped a drumming rock across a barreled surface. %They_chosenbrother% looks back at the party and shrugs.%SPEECH_ON%Seem\'s aight.%SPEECH_OFF%%Their_chosenbrother% next step sends %them_lightweight% crashing through the ice. Shards break into a sort of chevron entrapment and when %They_chosenbrother% reaches out to grab one it slices %their_chosenbrother% hands. The men quickly throw %them_lightweight% a rope and drag him out.\n\n Bloodied and shivering, %chosenbrother% shakes %their_chosenbrother% head as %they_chosenbrother%\'s wrapped in blankets.%SPEECH_ON%I-I-I-I believe that was aw-aw-aw-awful. Aw-aw-awful idea, sir.%SPEECH_OFF%";
			}
			if (s.ID == "Lightweight") {
				s.Text = "[img]gfx/ui/events/event_143.png[/img]%lightweight% steps forward.%SPEECH_ON%Ice? Ice is nothing. You can glide on it like this.%SPEECH_OFF%Without even a pause, the %person_lightweight% leaps out onto the frozen pond and skates across its surface. Cracks emerge out from behind him like a wake of imminently bad news, but %they_lightweight% remains unperturbed. %They_lightweight% swings by the undead knight and grabs the frozen sword. The wiederganger groans as its arm breaks off at the elbow. The %person_lightweight% merrily skates %their_lightweight% way back to the edge of the pond and presents the sword to you. %otherbrother% steps forward and cracks the wiederganger\'s frozen arm off the handle like a man breaking a crab claw.%SPEECH_ON%Would ya look at that?%SPEECH_OFF%He crushes the fingers into fragments and in the powdered remains there is a signet. A sword and jewelry, what\'s not to love about this result?";
			}
		}
	}

	// Vanilla event has a bug where if the player has no brother with >= 130 initiative, the
	// `candidates_lightweight` array ends up empty before it is read - hence why we override it.
	o.onUpdateScore = function () {
		if(!World.FactionManager.isUndeadScourge())
			return;

		// limit by terrain
		local currentTile = World.State.getPlayer().getTile();
			if(currentTile.Type != Const.World.TerrainType.Snow)
				return;

		if(currentTile.HasRoad)
			return;

		// limit by stash space
		if(!World.Assets.getStash().hasEmptySlot())
			return;

		// limit by terrain
		local towns = World.EntityManager.getSettlements();
		local nearTown = false;

		foreach(t in towns)
		{
			if(t.getTile().getDistanceTo(currentTile) <= 6)
			{
				nearTown = true;
				break;
			}
		}

		if(nearTown)
			return;

		local brothers = World.getPlayerRoster().getAll();

		local candidates_lightweight = [];
		local candidates = [];

		foreach(bro in brothers)
		{
			if(bro.getCurrentProperties().getInitiative() >= 130)
				candidates_lightweight.push(bro);
			else
				candidates.push(bro);
		}

		if(candidates.len() == 0)
			return;

		if(candidates_lightweight.len() > 0) {
			m.Lightweight = candidates_lightweight[Math.rand(0, candidates_lightweight.len() - 1)];
		}
		m.Other = candidates[Math.rand(0, candidates.len() - 1)];
		m.Score = 20;
	}

	local onPrepareVariables = o.onPrepareVariables;
	o.onPrepareVariables = function ( _vars )
	{
		onPrepareVariables(_vars);
		if (this.m.Lightweight != null)
			::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.Lightweight.getGender(), "lightweight");
		if (this.m.Other != null)
			::Const.LegendMod.extendVarsWithPronouns(_vars, this.m.Other.getGender(), "chosenbrother");
	}
})
