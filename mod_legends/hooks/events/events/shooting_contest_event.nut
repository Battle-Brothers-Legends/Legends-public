::mods_hookExactClass("events/events/shooting_contest_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_10.png[/img] You throw your hands up and tell the company to do what they must before retiring back to your tent. Outside comes the twang of released arrows quickly followed by the thwap of them finding their targets. Again and again. The din of mercenaries grows louder as what you can only assume what is a throng of observers grows. Finally, the contest is at some sort of end - indicated by a refreshing silence - and you get back to work.";
			}
			if (s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_10.png[/img]Feeling as though their arguments will never end, you give them the go-ahead to have their little competition before retiring back to your tent. Soon thereafter you hear the arrows nocking, releasing, and finding targets. Things which go \'thwang\' soon go \'thwap\' and the air is slowly filled with the din of a watching crowd. As you try to focus, you notice that the mercenaries have been shooting fervently for quite some time now. You step back out of your tent to find the two archers bickering some more, each one pointing a finger at the other before picking up an arrow and angrily launching it downrange. Their targets aren\'t even targets anymore, but small bushes of arrow shafts upon which break every other shot that lands upon them.\n\nShaking your head, you order the two to stop at once before they use up every last arrow the company has.";
			}
			if (s.ID == "D") {
				s.Text = "You shake your head no for supplies are far too low to enage in such behavior. The mercenaries sigh and walk away, continuing to argue with one another long and loud into the distance.";
			}
		}
	}

	o.onUpdateScore = function () {
		if (!this.World.getTime().IsDaytime)
			return;

		if (this.World.Assets.getAmmo() <= 80)
			return;

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
			return;

		local candidates = [];

		foreach( bro in brothers )
			if (bro.getBackground().getID() == "background.hunter" || bro.getBackground().getID() == "background.poacher" || bro.getBackground().getID() == "background.sellsword" || bro.getBackground().getID() == "background.bowyer" || (bro.getBackground().getID() == "background.adventurous_noble" && bro.getGender() == 1) || bro.getBackground().getID() == "background.legend_ranger")
				if (!bro.getFlags().has("ParticipatedInShootingContests") || bro.getFlags().get("ParticipatedInShootingContests") < 3)
					candidates.push(bro);

		if (candidates.len() < 2)
			return;

		this.m.Archer1 = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Archer2 = null;
		this.m.Score = candidates.len() * 5;

		do {
			this.m.Archer2 = candidates[this.Math.rand(0, candidates.len() - 1)];
		} while (this.m.Archer2 == null || this.m.Archer2.getID() == this.m.Archer1.getID());
	}
})
