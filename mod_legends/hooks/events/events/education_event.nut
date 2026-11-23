::mods_hookExactClass("events/events/education_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		this.m.Cooldown = 30.0 * this.World.getTime().SecondsPerDay;
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_15.png[/img]During your travels, %scholar% has taken some interest in %dumbguy%\'s intellectual shortcomings. %scholar_short% says that, with some time, %they_scholar% could teach the %person_dumbguy% a thing or two. %dumbguy_short% can put one foot in front of the other - and sometimes quite confidently - but you think that\'s about where %their_dumbguy% aptitude for all things comes to an end. Not only that, but %scholar_short% has gotten easily frustrated in the past. Teaching the dumb %sibling_dumbguy% might just be an exercise in self-inflating %their_scholar% own ego.";
				s.Options[0].Text = "See what you can teach %them_dumbguy%.";
			}
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_15.png[/img]{You come across %scholar% and %dumbguy% staring at a patch of dirt. Along the brown canvas you see that %scholar_short% has drawn geometric shapes, letters, numbers, and what looks like constellations. It appears that they\'ve been at this for hours now. \n\nA teaching stick in hand, %scholar% madly points at one of the star clusters and demands to know what it is. %dumbguy%, with a pained expression, guesses a sheep. %scholar% snaps the teaching stick in half and kicks dirt all over %their_scholar% drawings. It\'s a horse! A horse! %scholar% sighs heavily before marching off to the beat of endless profanity. Personally, you thought it was a crab. | You find %scholar% standing over %dumbguy%. Count the beetles, don\'t smash them, the learned %person_scholar% says with exasperation. %dumbguy% looks down at %their_dumbguy% beetle-juiced hands where {fragments of insect carapaces | carapaces of once-insects} dot %their_dumbguy% flesh. %They_dumbguy% nods, understandingly, and turns to pulling the beetles\' legs off instead. %scholar% lets out a string of swears you\'ve never heard in your life. | You find %scholar% and %dumbguy% yelling at one another. It appears they\'re at a very red-faced crossroads. %dumbguy_short% says %they_dumbguy% doesn\'t care if %they're_dumbguy% dumb, and the %scholar_short% argues that every man should be learned. Well it appears %dumbguy_short% would prefer to be left to %their_dumbguy% devices for %they_dumbguy% shows %scholar_short% %their_dumbguy% back as %they_dumbguy% walks away. Guess that\'s the end of the lesson for both of them. | You find %dumbguy% squatting beside a creek, staring at %themselves_dumbguy% in the shimmering reflection. %They_dumbguy% must have been at it for a while now for %they're_dumbguy% showing signs of sunburn. You ask if everything is alright, to which %they_dumbguy% explains that %they_dumbguy% is not \'getting it\' with %scholar%\'s teachings, and that %scholar% nearly went mad today before finally giving up on the venture. You explain that %dumbguy% doesn\'t have to be smart, %they_dumbguy% just needs to know how to swing a sword and shoot a bow. That\'s what you hired %them_dumbguy% for, after all. The %person_dumbguy% tries to hide a smile, but the running water betrays %them_dumbguy%. You take %them_dumbguy% back to camp where you then tell %scholar% to lay off for a while.}";
			}
			if (s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_15.png[/img]{You come across %dumbguy% mulling over a set of coins on a table. You inquire as to what %they_dumbguy% is doing and %they_dumbguy% says %they're_dumbguy% trying to figure out how much to save for retirement. First off, you\'re surprised %they_dumbguy% even knows what the word retirement is. Second off, counting? Looks like you might owe %scholar% a pint. | You find %dumbguy% sitting on a stump as %they_dumbguy% writes across a scroll. When you ask what %they're_dumbguy% doing, %they_dumbguy% says %they're_dumbguy% writing a letter. When you ask to whom it is addressed, the %person_dumbguy% looks up with a sheepish grin and asks, does it matter? Just then, you spot %scholar% in the distance, arms crossed, a look of satisfaction on %their_scholar% face.}"
			}
		}
	}

	o.onUpdateScore = function () {
		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
			return;

		local dumb_candidates = [];
		local scholar_candidates = [];

		foreach( bro in brothers ) {
			if (bro.getSkills().hasTrait(::Legends.Trait.Dumb))
				dumb_candidates.push(bro);
			else if ((bro.getBackground().getID() == "background.monk" || bro.getBackground().getID() == "background.historian" || bro.getBackground().getID() == "background.legend_inventor"  ||  bro.getBackground().getID() == "background.legend_witch" || bro.getBackground().getID() == "background.legend_commander_witch" ) && !bro.getSkills().hasTrait(::Legends.Trait.Hesistant) || bro.getSkills().hasPerk(::Legends.Perk.LegendScholar))
				scholar_candidates.push(bro);
		}

		if (dumb_candidates.len() == 0 || scholar_candidates.len() == 0)
			return;

		this.m.DumbGuy = dumb_candidates[this.Math.rand(0, dumb_candidates.len() - 1)];
		this.m.Scholar = scholar_candidates[this.Math.rand(0, scholar_candidates.len() - 1)];
		this.m.Score = 5;
	}
})
