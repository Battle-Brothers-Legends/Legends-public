::mods_hookExactClass("events/events/archery_stunt_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]Something of a commotion draws you from your tent. The company are sitting on a few stumps or on the ground, eagerly watching something in the distance. With squinting eyes, you spot %clown% and %archer% doing something odd. An apple rests on one mercenary\'s head, while the other is walking away - a bow in hand.\n\nYou ask %otherguy% what is going on, who explains that the two are going to try some sort of stunt or trick that involves shooting a piece of fruit off a person\'s head. Shocked, you exclaim that\'s not safe at all, to which the mercenary grins and explains that is the point.";
			}
			if (s.ID == "B1") {
				s.Text = "[img]gfx/ui/events/event_10.png[/img]You mull the situation over. The company look to you, expecting a stoppage, but instead you take a seat amongst them. This spurs a brief cheer from the crowd which quickly quiets to hushed whispers as %clown% and %archer% get ready.%SPEECH_ON%Make sure to hit the apple!%SPEECH_OFF%One comrade shouts. Laughter ripples through the group.%SPEECH_ON%From that distance %clown_short%\'s nose kinda looks like an apple to me.%SPEECH_OFF%More laughter, but it is ever nervous as the stunt is about to unfold.";
			}
			if (s.ID == "B2") {
				s.Text = "[img]gfx/ui/events/event_10.png[/img]%archer% angles shoulders to %clown% and draws the bow, the silhouette forming a crescent of wood, string, and arm. You can\'t see %clown%\'s face, but you assume eyes are closed. The shot is released. It zips. It disappears. %clown% rocks backward, clutching at their face. This isn\'t looking good. The mercenary screams. The crowd oohs. %archer% slowly lowers the bow and looks at it as though it is at fault.\n\n Eventually, %clown% is carried past you, a shaft of an arrow sticking out of their head. Another comrade lingers behind, quietly eating an apple in the wake of the chaos.";
			}
			if (s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_10.png[/img]The company cheer as you give an affirming nod. You take a seat amongst them as %archer% and %clown% get ready, the former nocking an arrow while the latter balances an apple atop their head. When the fruit is good and steady, the archer draws back the bow, forming but a silhouette of arm, wood, and string, a crescent of determination while aiming downfield. The company are exchanging bets on whether or not the archer misses. You want to look away, but the spectacle truly is too much.\n\n A great gasp follows the arrow\'s release, as though some ominous event long foretold had finally happened. Mercenaries reel back in their seats, wincing and gritting their teeth. The apple is shot off %clown%\'s head, fruit and arrow spinning away. After a brief silence, the company erupts in cheers. %clown% takes a bow, while %archer% slackens draw and looks a bit relieved.";
			}
		}
	}

	o.onUpdateScore = function () {
		if (!this.World.getTime().IsDaytime)
			return;

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
			return;

		local clown_candidates = [];

		foreach( bro in brothers ) {
			if (bro.getSkills().hasSkill("trait.bright") || bro.getSkills().hasSkill("trait.hesitant") || bro.getSkills().hasSkill("trait.craven") || bro.getSkills().hasSkill("trait.fainthearted") || bro.getSkills().hasSkill("trait.insecure"))
				continue;

			if ((bro.getBackground().getID() == "background.minstrel" || bro.getBackground().getID() == "background.juggler" || bro.getBackground().getID() == "background.vagabond") && !bro.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury))
				clown_candidates.push(bro);
		}

		if (clown_candidates.len() == 0)
			return;

		local archer_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.bright") || bro.getSkills().hasSkill("trait.hesitant") || bro.getSkills().hasSkill("trait.craven") || bro.getSkills().hasSkill("trait.fainthearted") || bro.getSkills().hasSkill("trait.insecure"))
				continue;

			if (bro.getBackground().getID() == "background.hunter" || bro.getBackground().getID() == "background.poacher" || bro.getBackground().getID() == "background.sellsword" || bro.getBackground().getID() == "background.bowyer" || (bro.getBackground().getID() == "background.adventurous_noble" && bro.getGender() == 1) && !bro.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury))
				archer_candidates.push(bro);
		}

		if (archer_candidates.len() == 0)
			return;

		this.m.Clown = clown_candidates[this.Math.rand(0, clown_candidates.len() - 1)];
		this.m.Archer = archer_candidates[this.Math.rand(0, archer_candidates.len() - 1)];
		this.m.Score = clown_candidates.len() * 3;

		do {
			this.m.OtherGuy = brothers[this.Math.rand(0, brothers.len() - 1)];
		} while (this.m.OtherGuy == null || this.m.OtherGuy.getID() == this.m.Clown.getID() || this.m.OtherGuy.getID() == this.m.Archer.getID());
	}
})
