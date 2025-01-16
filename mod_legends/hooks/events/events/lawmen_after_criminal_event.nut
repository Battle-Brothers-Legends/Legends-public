::mods_hookExactClass("events/events/lawmen_after_criminal_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_90.png[/img]Riders crest a nearby hill, their silhouettes dark and oddly shaped on its rim like a reef of rippling black. Not wholly able to see who they are, you order a few of your company to hide away. An ambush might be needed to defend yourself otherwise you stand no chance against such a mounted force. As the selected mercenaries dip into the bushes, the horsemen begin heading down the hill. The thunder of the hooves grows louder, but you stand resolute, hoping to give your men a good show of bravery.\n\nYou see that the bannerman is carrying a sigil of %noblehousename%. Behind him another horseman is dragging a travois with a few shackled men for cargo. When the men arrive, their leader stands up between the withers of his horse and points at you before talking.%SPEECH_ON%Mercenary! We have by the lord\'s authority the right to claim the - shackled! - hands of a %criminal%. This wretch is within your midst and must pay for past crimes. Hand the criminal over immediately and you will be rewarded.%SPEECH_OFF%You turn your head and spit. You nod at the lawman before asking him a question.%SPEECH_ON%And whose authority do you have? There are a lot of lords in these lands and not all of them pay me well.%SPEECH_OFF%The lawmen\'s captain sits back down in his saddle. His hands cross over his pommel, resting there with armored authority. He does not look the least bit amused and voices his displeasure as such.%SPEECH_ON%The punishment for willfully harboring a fugitive is death. You\'ve but one more chance to release this criminal to me or you shall face a fate well suited for a sword-selling dog.%SPEECH_OFF%";
				s.Options[0].Text = "The company would only suffer if we fought over this. The fugitive is yours.";
				s.Options[1].Text = "We\'ll not give up our own.";
			}
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_53.png[/img]You stand no chance against these men. Although it pains you mightily, you hand %criminal% over. Your former comrade barks curses at you as the lawmen lay on chains, and swears your name into the mud as they throw the fugitive in with the rest of the bound captives. The captain of the lawmen trots his horse over to you. He sneers at you before throwing a purse of coins to the ground. His body is close and there\'s an opening in his armor. You could fit a knife in there, right between the ribs, lead the blade right to his heart. It\'d be quick. But you wouldn\'t last much long after, and all of your company would be quickly slain.\n\nInstead, you lean over and pick up the coins, swallow you pride, and say your thanks. The lawmen waste little time returning from whence they came.";
				local start = s.start;
				s.start <- function ( _event )
				{
					::Legends.addFallen(_event.m.Criminal, "Handed over to authorities");
					start(_event);
				}
			}
			if (s.ID == "E") {
				s.Text = "[img]gfx/ui/events/event_78.png[/img]The captain hands you a scroll with %criminal%\'s face on it. True, the resemblance is there. But the figutive has been in your company long enough to gain a scar or two. Maybe they won\'t recognise the image? You ask the criminal to step forward, who nervously, does as told. You look to the captain.%SPEECH_ON%Is this the one you are after? I can see why you might think this is similar, but look at these scars. The face in the drawing has none. And look at the hair! The one in the drawing is straight, and this head nest is clearly matted and curly.%SPEECH_OFF%You stop because judging by the faces of your audience this isn\'t even coming close to working. The captain draws his sword.%SPEECH_ON%Do you take me for a fool? Kill them all.%SPEECH_OFF%Well, so much for that. Before the lawmen can charge you whistle as loud as you can. Half the company surges forth from the bushes, whooping and hollering like banshees. The sudden fright drives the horses wild, pitching their riders into the dirt and the travois-puller even runs off altogether, carrying with it a couple of very confused criminals.\n\n%randombrother% comes charging across the field of mayhem with a spear in hand, and plunges it deep into the captain\'s steed, bringing both man and beast crashing to the ground. The lawmen, what\'s left of them, gather around their captain. Seemingly growling, the man wipes blood from his face and spits out a tooth. He grins a gapped smile before ordering his men to charge.";
			}
			if (s.ID == "G") {
				s.Text = "[img]gfx/ui/events/event_12.png[/img]You walk directly toward the captain, stopping halfway between your men and his. With your fists to your hips, you call out to the captain\'s lawmen, asking if they know the name of the %companyname%. You see a few of the riders shift up on their saddles, balancing tented arms on their pommels as they stare intently at your banner. They quickly sit back down and hushed whispers trickle down and back up their battle line.\n\nOne man calls out, asking if it\'s true that you shorn the noses of those you slay. It is not true, but you\'ve no reason to spill the truth. Another man asks if %randombrother% is in your ranks, and has a necklace of ears and eats bonemeal for breakfast. You stifle the urge to laugh, only nodding in return. Quite naturally, the rumors overtake your opponents and they begin to cry out that this fight is not theirs to have.\n\nThe captain tells them that you\'re full of shit and to charge, but none follow his orders. Eventually, the captain is forced to turn back, heading after his men who are now in retreat.\n\nThe supposed cannibal walks up, scratching their head.%SPEECH_ON%Bonemeal for breakfast?%SPEECH_OFF%A crackle of laughter rips through the company and soon a chant of \'don\'t eat me!\' is to be had.";
			}
		}
	}

	o.onUpdateScore = function () {
		if (this.World.getTime().Days < 10)
			return;

		if (this.World.getTime().Days < 30 && this.World.Assets.getOrigin().getID() == "scenario.raiders")
			return;

		if (!this.World.getTime().IsDaytime)
			return;

		if (this.World.FactionManager.isGreaterEvil())
			return;

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
			return;

		if (this.Const.DLC.Desert && currentTile.SquareCoords.Y <= this.World.getMapSize().Y * 0.18)
			return;

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		if (brothers.len() < 2)
			return;

		foreach( bro in brothers ) {
			if ( bro.getSkills().hasTrait(::Legends.Trait.Player) )
				continue;
			if (bro.getBackground().getID() == "background.killer_on_the_run" || bro.getBackground().getID() == "background.thief" || bro.getBackground().getID() == "background.graverobber" || bro.getBackground().getID() == "background.raider" || bro.getBackground().getID() == "background.nomad" || bro.getBackground().getID() == "background.legend_commander_assassin")
				candidates.push(bro);
		}

		if (candidates.len() == 0)
			return;

		this.m.NobleHouse = this.getNearestNobleHouse(this.World.State.getPlayer().getTile());

		if (this.m.NobleHouse == null)
			return;

		this.m.Criminal = candidates[this.Math.rand(0, candidates.len() - 1)];

		do {
			this.m.OtherBro = brothers[this.Math.rand(0, brothers.len() - 1)];
		} while (this.m.OtherBro == null || this.m.OtherBro.getID() == this.m.Criminal.getID());

		this.m.Score = candidates.len() * 5;
	}
})
