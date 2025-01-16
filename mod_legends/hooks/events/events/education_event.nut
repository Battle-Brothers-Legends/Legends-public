::mods_hookExactClass("events/events/education_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		this.m.Cooldown = 30.0 * this.World.getTime().SecondsPerDay;
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_15.png[/img]During your travels, %scholar% has taken some interest in %dumbguy%\'s intellectual shortcomings. %scholar_short% says that, with some time, we could teach a thing or two. %dumbguy_short% can put one foot in front of the other - and sometimes quite confidently - but you think that\'s about where the aptitude for all things comes to an end. Not only that, but %scholar_short% has gotten easily frustrated in the past. Teaching the dumb sellsword might just be an exercise in self-inflating ego.";
				s.Options[0].Text = "See what you can teach.";
			}
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_15.png[/img]{You come across %scholar% and %dumbguy% staring at a patch of dirt. Along the brown canvas you see that %scholar_short% has drawn geometric shapes, letters, numbers, and what look like constellations. It appears that they\'ve been at this for hours now. \n\nA teaching stick in hand, %scholar% madly points at one of the star clusters and demands to know what it is. %dumbguy%, with a pained expression, guesses a sheep. %scholar% snaps the teaching stick in half and kicks dirt all over the drawings. It\'s a horse! A horse! %scholar% sighs heavily before marching off to the beat of endless profanity. Personally, you thought it was a crab. | You find %scholar% standing over %dumbguy%. Count the beetles, don\'t smash them, the learned one says with exasperation. %dumbguy% looks down at his beetle-juiced hands where {fragments of insect carapaces | carapaces of once-insects} dot the flesh. Nodding, understandingly, and turning to pulling the beetles\' legs off instead. %scholar% lets out a string of swears you\'ve never heard in your life. | You find %scholar% and %dumbguy% yelling at one another. It appears they\'re at a very red-faced crossroads. %dumbguy_short% says  %SPEECH_ON% I don\'t care if I\'m dumb%SPEECH_OFF%, and the %scholar_short% argues that everyone should be learned. Well it appears %dumbguy_short% would prefer to be left unlearned, showing %scholar_short% their back while walking away. Guess that\'s the end of the lesson for both. | You find %dumbguy% squatting beside a creek, staring at the shimmering reflection. The sellsword must have been at it for a while now, and is showing signs of sunburn. You ask if everything is alright, and while still staring at the water, you\'re told the student is just not \'getting it\' with %scholar%\'s teachings, and that %scholar% nearly went mad today before finally giving up on the venture. You explain that %dumbguy% doesn\'t have to be smart, just needs to know how to swing a sword and shoot a bow. That\'s what you hire for, after all. That dumb face tries to hide a smile, but the running water betrays it. You take the dullard back to camp where you then tell %scholar% to lay off for a while.}";
			}
			if (s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_15.png[/img]{You come across %dumbguy% mulling over a set of coins on a table. You inquire what is happening, and the dumb sellsword is apparently trying to figure out how much to save for retirement. First off, you\'re surprised %dumbguy% even knows what the word retirement is. Second off, counting? Looks like you might owe %scholar% a pint. | You find %dumbguy% sitting on a stump as writing across a scroll. When you ask what is happening, it appears %dumbguy% is writing a letter. When you ask to whom it is addressed, the dullard looks up with a sheepish grin and asks, does it matter? Just then, you spot %scholar% in the distance, arms crossed, and a look of satisfaction.}";
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
