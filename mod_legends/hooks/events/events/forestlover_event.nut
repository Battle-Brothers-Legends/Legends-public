::mods_hookExactClass("events/events/forestlover_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_25.png[/img] {%forestlover% looks up at the forest canopy, a hand playfully strumming through the lightfalls. Looking up at you.%SPEECH_ON%I used to play through these forests as a kid.%SPEECH_OFF%You nod, then wonder aloud.%SPEECH_ON%I thought you were born outside %randomtown%?%SPEECH_OFF%%forestlover%\'s hand falls and he stares at the ground.%SPEECH_ON%Oh yeah, that\'s right. Well, we should get moving then, right?%SPEECH_OFF%Before you can say anything more, the red-faced mercenary marches on. | You find that %forestlover% appears to be in better spirits lately. As it turns out, these forests are familiar to the forester and a return to their greenery has the mercenary beaming with warm nostalgia. | Even though you\'ve marched through plenty of forests, this one\'s viridscapes has you impressed. No doubt %forestlover% is loving a return to the trees\' thick domain. | Trees, fat trunks and strong-limbed, rise above you. %forestlover% seems to be mesmerized by their towering. You find the mercenary smiling all the time lately, as though a return to the forest is a return to better times.}";
				s.Options[0].Text = "Good for you.";
			}
		}
	}

	o.onUpdateScore = function () {
		if (!this.World.getTime().IsDaytime)
			return;

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Forest && currentTile.Type != this.Const.World.TerrainType.LeaveForest && currentTile.Type != this.Const.World.TerrainType.AutumnForest)
			return;

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
			return;

		local candidates = [];

		foreach( bro in brothers )
			if (bro.getBackground().getID() == "background.hunter" || bro.getBackground().getID() == "background.poacher" || bro.getBackground().getID() == "background.legend_ranger" || bro.getBackground().getID() == "background.legend_herbalist" || bro.getBackground().getID() == "background.lumberjack")
				candidates.push(bro);

		if (candidates.len() > 0) {
			this.m.Forestlover = candidates[this.Math.rand(0, candidates.len() - 1)];
			this.m.Score = candidates.len() * 10;
		}
	}
})
