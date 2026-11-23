::mods_hookExactClass("events/events/ball_on_roof_event", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		// %otherbrother% refers to this.m.Other. For %otherbrother%-related pronouns, use %they_other%. Thank Vanilla code for this confusion
		::Legends.Screens.hook(this, "Good", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_97.png[/img]You send %otherbrother% to try and retrieve the ball. Using %otherother% as a stepstool, %they_other% launches himself onto the roof and gets the toy. The boy is ecstatic and the smile on his face warms even the most cynical of your mercenaries.";
			local start = _screen.start;
			_screen.start = function (_event) {
				start(_event);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_moral_reputation.png",
					text = "The company\'s moral reputation increases slightly"
				});
			}
		});
		::Legends.Screens.hook(this, "Bad", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_97.png[/img]You send %otherbrother% to try and retrieve the ball. %They_other% climbs the tree and jumps across a branch to land atop the roof. Mission complete, %they_other% tosses the ball to the kid. Unfortunately, the boy lets go of the tree branch to try and catch it. He slips off the branch and falls a good fifteen feet to the earth. The wallop of his landing has the whole company cringing. When you check on him he isn\'t moving and his back has taken a new shape. %otherother% yells at the idiot still standing in shock on the roof.%SPEECH_ON%What the hell were you thinking? Holy shit, %person_other%!%SPEECH_OFF%The mercenary climbs down off the roof. %They_other% looks at the kid and then nervously looks around.%SPEECH_ON%Well he, uh, he\'s got the ball. Let\'s get the hell out of here. Our... our work here is done.%SPEECH_OFF%What a goatfuck of a situation. You and the company quickly leave the scene before the parents get back.";
			local start = _screen.start;
			_screen.start = function (_event) {
				start(_event);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_moral_reputation.png",
					text = "The company\'s moral reputation decreases slightly"
				});
			}
		});
		::Legends.Screens.hook(this, "Surefooted", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_97.png[/img]%surefooted% clears %their_surefooted% throat and steps forward.%SPEECH_ON%I\'ll be your hero, kid.%SPEECH_OFF%%They_surefooted% opens %their_surefooted% arms and the kid jumps down into them. The boy is set aside and the sellsword points a finger to the earth.%SPEECH_ON%Stay down here.%SPEECH_OFF%The surefooted mercenary easily clambers up the tree and jumps over to the roof. %They_surefooted% picks the ball up and spins it on a finger before %they_surefooted% pirouettes off the eave like a tornado, landing right on %their_surefooted% toes with catlike grace. The boy claps excitedly and takes the toy and even the most cynical of mercenaries in the company are warmed by his happiness.";
			local start = _screen.start;
			_screen.start = function (_event) {
				start(_event);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_moral_reputation.png",
					text = "The company\'s moral reputation increases slightly"
				});
			}
		});
	}

	o.onUpdateScore = function () {
		if (!this.World.getTime().IsDaytime) {
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;
		local town;
		local playerTile = this.World.State.getPlayer().getTile();

		foreach (t in towns) {
			if (t.getTile().getDistanceTo(playerTile) <= 4 && t.isAlliedWithPlayer()) {
				nearTown = true;
				town = t;
				break;
			}
		}

		if (!nearTown) {
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3) {
			return;
		}

		local candidates_surefooted = [];
		local candidates_other = [];

		foreach (b in brothers) {
			if (b.getSkills().hasSkill("trait.sure_footing")) {
				candidates_surefooted.push(b);
			} else if (!b.getSkills().hasSkill("trait.player")) {
				candidates_other.push(b);
			}
		}

		if (candidates_other.len() == 0) {
			return;
		}

		this.m.Other = candidates_other[this.Math.rand(0, candidates_other.len() - 1)];

		if (candidates_surefooted.len() != 0) {
			this.m.Surefooted = candidates_surefooted[this.Math.rand(0, candidates_surefooted.len() - 1)];
		}

		do {
			this.m.OtherOther = brothers[this.Math.rand(0, brothers.len() - 1)];
		} while (this.m.OtherOther == null || this.m.OtherOther.getID() == this.m.Other.getID());

		this.m.Town = town;
		this.m.Score = 15;
	}
})
