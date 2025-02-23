::mods_hookExactClass("events/events/imprisoned_wildman_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_100.png[/img]The animal tamer leads you to a carriage. You immediately see why his hired hands quit: a frenzied and mercurial feral human is sitting inside the cage. Raw wrists bleed against shackles, signs of attempted escapes. Half-starved, the wild human gnaws on sticks poking out from a tumbleweed of hair. Seeing this sad sight, you grab the stranger by his shirt and slam him against the wagon.%SPEECH_ON%Does that look like an animal to you?%SPEECH_OFF%The animal tamer grins, ivory for teeth. He explains himself.%SPEECH_ON%Cityfolk have gotten wind of the \'uncivilized\' humans and wish to see them up close. I am only fulfilling this new demand as any businessman would. Now, all I need help with is to get that dead body out of the cage.%SPEECH_OFF%He points toward a corpse in the corner of the cage. The wildling rears back, snarling, and goes to protectively sit on the body. The animal tamer shakes his head.%SPEECH_ON%One of my helpers got too close and, well, yeah. I can\'t go into town with that mess in there so I thought maybe you could help me fish it out. I\'ll pay plenty, of course. A pouch of 250 crowns sound good to you? Just reach on in there and yank that garbage out.%SPEECH_OFF%";
				s.start <- function ( _event ) {
					this.Options.push({
						Text = "Alright, I\'ll send a man in.",
						function getResult( _event ) {
							return this.Math.rand(1, 100) <= 80 ? "C" : "D";
						}
					});

					if (_event.m.Wildman != null) {
						this.Options.push({
							Text = "We got our own wildling who could help.",
							function getResult( _event ) {
								return "Wildman";
							}
						});
					}

					if (_event.m.Monk != null) {
						this.Options.push({
							Text = "Our holy one seems a little disturbed by this.",
							function getResult( _event ) {
								return "Monk";
							}
						});
					}

					this.Options.push({
						Text = "I won\'t put the life of my men at risk for this.",
						function getResult( _event ) {
							return "E";
						}
					});
				}
			}
			if (s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_100.png[/img]%taskedbro% is the one tasked with cleaning out the wildling\'s corpse-featured terrarium. He rolls up his sleeves and approaches the cage with both hands out.%SPEECH_ON%Whoa there, easy now. Easy!%SPEECH_OFF%The wildling gets up off the dead body and goes to the other side of its habitat. The sellsword easily grabs the boot of the corpse and drags it toward the bars. It slips through with sickening ease, already clumped up in the fashion of discarded wet clothes. Guts and limbs dribble off the edge of the wagon\'s platform. The animal tamer cheers happily.%SPEECH_ON%Thank you so much! And you made it look so easy, too!%SPEECH_OFF%%taskedbro% stares at the dead body with the realization that could have easily been their end.%SPEECH_ON%Yeah. You\'re welcome.%SPEECH_OFF%"
			}
			if (s.ID == "D") {
				s.Text = "[img]gfx/ui/events/event_100.png[/img]%taskedbro% is tasked with getting the corpse out of the habitat.  Approaching the cage like a harlot streetwalking a particularly pious town. When geting close the bars, %taskedbro%  smiles like an old friend.%SPEECH_ON%Hey there buddy. That\'s a nice corpse you got there. A great corpse, truly one of the best I\'ve ever seen. How about I just... take it... out...%SPEECH_OFF%When the mercenary reaches in, the wildling swipes out. It\'s too fast to even see. %taskedbro% slowly turns around. There\'s a black hole where one of his eyes used to be. The wildling squishes the eye between its teeth, a white goop bursting forth like a popped pustule, and it turns into a filmy paste as it chews. The animal tamer throws you a sack of crowns and runs off.%SPEECH_ON%Not liable! I am not liable!%SPEECH_OFF%%taskedbro% passes out as a few vengeful brothers stab the imprisoned wildling to death. All the caged beasts roar up as though you\'d just slain their leader. You quickly order the mercenaries away from the caravan before one of its beasts gets free and causes more damage.";
			}
			if (s.ID == "Wildman") {
				s.Text = "[img]gfx/ui/events/event_100.png[/img]If anyone in the party could help talk the caged wildling down, it\'s probably %wildman%. Who goes to the cage and stares in. There\'s an exchange of hoots. Your wildling raps the bars with a knuckle, and the prisoner raps back and hoots somberly. Suddenly, %wildman% grabs the animal tamer by the head and drives him into the bars. You go to save the tamer, but the imprisoned wildling soars across the cage with atavistic terror in his eyes. Stepping back for your own safety, you can only watch as this bestial human sets upon the tamer. Both wildlings pull and drag on the man\'s face. The concussed man groggily yells.%SPEECH_ON%I thought we had an agreeeeeemeeeaahh!%SPEECH_OFF%%wildman% corks his thumbs into the man\'s eyes while the imprisoned wildling grips the tamer\'s mouth and pulls down. His head is literally ripped apart by the seams and sinews. A few men vomit as the tamer\'s brains falls out where his tongue should be, a truly awful way of speaking one\'s mind. The \'warden\' taken care of, %wildman% looks at you and at the wildling with a sort of \'can we keep him?\' gesture.";
				s.Options[0].Text = "Absolutely disgusting. It\'s perfect.";
				s.Options[1].Text = "No, it\'s clearly far too dangerous.";
			}
			if (s.ID == "Wildman1") {
				s.Text = "[img]gfx/ui/events/event_100.png[/img]An outstanding capacity for violence is well-suited to a mercenary band. You agree to take the imprisoned wildling on.";
				s.start <- function ( _event ) {
					local roster = this.World.getTemporaryRoster();
					_event.m.Dude = roster.create("scripts/entity/tactical/player");
					if (this.World.Assets.getOrigin().getID() == "scenario.legend_risen_legion") {
						_event.m.Dude.getFlags().add("PlayerSkeleton");
						_event.m.Dude.getFlags().add("undead");
						_event.m.Dude.getFlags().add("skeleton");
						_event.m.Dude.setStartValuesEx([
							"wildman_background"
						]);
						::Legends.Traits.grant(_event.m.Dude, ::Legends.Trait.RacialSkeleton);
						::Legends.Traits.grant(_event.m.Dude, ::Legends.Trait.LegendFleshless);
					} else {
						_event.m.Dude.setStartValuesEx([
							"wildman_background"
						]);
					}

					_event.m.Dude.setTitle("the Animal");
					_event.m.Dude.getBackground().m.RawDescription = "%name% was \'saved\' by you during a confrontation with an animal tamer-turned-enslaver. A sense of gratitude and debt overcomes any language barriers: the once imprisoned wildling serves the company loyally for the rescue.";
					_event.m.Dude.getBackground().buildDescription(true);

					if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null)
						_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).removeSelf();

					if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) != null)
						_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand).removeSelf();

					if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head) != null)
						_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head).removeSelf();

					this.Characters.push(_event.m.Dude.getImagePath());
				}
			}
			if (s.ID == "Wildman2") {
				s.Text = "[img]gfx/ui/events/event_100.png[/img]You don\'t think the imprisoned wildling would fit in with the company, but you do set it free nonetheless. It shoots out the cage like a banshee and runs for the tree line. There it stands at a distance hooting and hollering until it runs off again.";
				s.Options[0].Text = "I guess that\'s its way of saying thanks.";
			}
			if (s.ID == "Monk") {
				s.Text = "[img]gfx/ui/events/event_100.png[/img]%monk% the monk steps forth, hands clasped, head bowed forward. The embodiment of a sermon, the posture of good morals, or misguided ones. He pulls the tamer aside.%SPEECH_ON%The old gods would frown upon what you have done here.%SPEECH_OFF%The animal tamer laughs and leans against the cage, smugly crossing his arms. He states that in the south they consider slavery a part of the natural order. The monk continues.%SPEECH_ON%True, but neither you nor this wildman are kin to their way of life. You wish to enslave him by means of his being an outsider. He does not understand the relationship which makes it especially grievous and improper. My suggestion is to have him work for you and learn from you. Make him a friend and you will have a friend for life-%SPEECH_OFF%The imprisoned wildman\'s hands dart through the bars and digs his fingers into his eyeballs. His face is ripped apart like a loaf of old bread, a couple of coathangers for a jawbone, a tongue lolling like an uprooted snake. %monk% vomits as his face is doused in blood. %otherbrother% shakes his head.%SPEECH_ON%I\'d say he\'d fit right in with the %companyname%...%SPEECH_OFF%";
				s.Options[0].Text = "Absolutely disgusting. It\'s perfect.";
				s.Options[1].Text = "No, it\'s clearly far too dangerous.";
				s.start <- function ( _event ) {
					this.Characters.push(_event.m.Monk.getImagePath());
					_event.m.Monk.worsenMood(1.0, "Shaken by the violence they witnessed");

					if (_event.m.Monk.getMoodState() < this.Const.MoodState.Neutral)
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[_event.m.Monk.getMoodState()],
							text = _event.m.Monk.getName() + this.Const.MoodStateEvent[_event.m.Monk.getMoodState()]
						});
				}
			}
			if (s.ID == "AnimalsFreed") {
				s.start <- function( _event ) {
					local item = this.new("scripts/items/accessory/legend_wardog_item");
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + item.getName()
					});
					item = this.new("scripts/items/accessory/falcon_item");
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain a " + item.getName()
					});
				}
			}
		}
	}

	local onUpdateScore = o.onUpdateScore;
	o.onUpdateScore = function ()
	{
		if (this.Stash.getNumberOfEmptySlots() < 4)
			return;
		onUpdateScore();
	}
})
