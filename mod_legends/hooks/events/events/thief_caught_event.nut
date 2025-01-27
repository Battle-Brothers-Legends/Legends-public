::mods_hookExactClass("events/events/thief_caught_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_33.png[/img]During a short rest, your company managed to catch a thief that tried to make off with some of your supplies. The villain\'s clothes are but rags and looks more skeleton than human. What are you going to do with the crook?";
				s.Options[0].Text = "Give that poor soul some food and water.";
				s.Options[1].Text = "Give the rotter a good beating.";
				s.Options[2].Text = "Put that thief to the sword.";
			}
			if (s.ID == "B") {
				s.Text = "[img]gfx/ui/events/event_33.png[/img]Under the cloak of night some thief managed to nick some of your supplies. Supplies that will probably be offered back to you in the next settlement...";
			}
			if (s.ID == "C") {
				s.Text = "[img]gfx/ui/events/event_33.png[/img]%randombrother% gives the thief a proper beating with a short cane. The shaft lands viciously hard and you can hear the sound of the blows passing through the theif\'s almost hollow frame. The beaten culprit wilts and turns and tries hard to get away, but the sellsword is persistent in meting out the punishment. When it\'s all said and done, you leave the beaten thief behind, wimpering and clutching the dirt between frail fingers.";
			}
			if (s.ID == "D") {
				s.Text = "[img]gfx/ui/events/event_33.png[/img]Feeling bad for the feeble cutpurse, you decide to offer some water and food. The withered person almost snatches the meal away from you and drives a famished face into it. The thief thanks you between every bite.";
			}
			if (s.ID == "E") {
				s.Text = "[img]gfx/ui/events/event_33.png[/img] You tell the mercenaries to get back to marching. The thief uses a thin arm to wipe their mouth and stands up, wobbling on weak legs to take a few steps after you and asks if maybe they could join the company. %SPEECH_ON%I\'ll give my life for you, if I must, just anything to not have to steal anymore.%SPEECH_OFF%";
				s.Options[1].Text = "We need warriors, not underfed thieves.";
				s.start <- function ( _event ) {
					local roster = this.World.getTemporaryRoster();
					_event.m.Dude = roster.create("scripts/entity/tactical/player");
					if (this.World.Assets.getOrigin().getID() == "scenario.legend_risen_legion") {
						_event.m.Dude.getFlags().add("PlayerSkeleton");
						_event.m.Dude.getFlags().add("undead");
						_event.m.Dude.getFlags().add("skeleton");
						_event.m.Dude.setStartValuesEx(this.Const.CharacterThiefBackgrounds);
						::Legends.Traits.grant(_event.m.Dude, ::Legends.Trait.RacialSkeleton);
						::Legends.Traits.grant(_event.m.Dude, ::Legends.Trait.LegendFleshless);
					} else {
						_event.m.Dude.setStartValuesEx(this.Const.CharacterThiefBackgrounds);
					}
					this.Characters.push(_event.m.Dude.getImagePath());
				}
			}
			if (s.ID == "F") {
				s.Text = "[img]gfx/ui/events/event_33.png[/img]As you draw your sword, the thief cowers, beggin for mercy as their mirrored face ripples over the blade\'s fuller and edges. You raise the weapon. The theif screams out that %SPEECH_ON% I\'ll work for you, I\'ll work for free, anything to spare my life.%SPEECH_OFF% You hesitate, your sword still lingering in the air.";
			}
			if (s.ID == "G") {
				s.Text = "[img]gfx/ui/events/event_33.png[/img]%SPEECH_ON%The punishment for thievery is death.%SPEECH_OFF%You plunge the sword down, cutting off the thief\'s last words with a quick stab into their chest. The body seizes up, speechless save for the scratching of thin hands grabbing the killing implement, and then the face falls back, dead within moment. You retrieve your weapon and clean it off in the nook of your elbow. The dead head turns to a side as blood pools quietly beneath.";
				s.List.push({
					id = 10,
					icon = "ui/icons/asset_moral_reputation.png",
					text = "The company\'s moral reputation decreases slightly"
				});
			}
			if (s.ID == "H") {
				s.Text = "[img]gfx/ui/events/event_05.png[/img]You lower your weapon and the theif crawls to you and hugs your legs, kissing your feet until you draw away.\n\nTo get things straight, you give a long list of orders and how it is to work in the company. You also give a contract which is then signed with a jagged \'x\'. A few of the company then spend the rest of the day teaching the ropes and introducing the new sellsword to the rest of the company. By night\'s end, it seems like the new blood is already beginning to fit in. By next morning, you wake to see a great number of supplies are missing and the new recruit is nowhere in sight. It appears that, although you stayed the thief\'s execution, they went on ahead and stole things anyway. Let that be a lesson to you.";
			}
		}
	}
})
