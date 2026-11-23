::mods_hookExactClass("events/events/dlc2/kid_blacksmith_event", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		::Legends.Screens.hook(this, "Good", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_97.png[/img]{%other% is fetched to go help the kid. %They_other% helps place the sword\'s handle and steel together and the kid works his magic on his own, easily mending the sword back into one piece. You\'re amazed by his skill and wonder how good the blacksmith himself must be if this is his apprentice. After the work is done, the boy offers to fix some of the weapons for the %companyname% which you happily accept.}";
			_screen.start <- function (_event) {
				this.Characters.push(_event.m.Other.getImagePath());
				this.World.Assets.addMoralReputation(1);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_moral_reputation.png",
					text = "The company\'s moral reputation increases slightly"
				});
				local stash = this.World.Assets.getStash().getItems();
				local items = 0;

				foreach (item in stash) {
					if (item != null && item.isItemType(this.Const.Items.ItemType.Weapon) && item.getCondition() < item.getConditionMax()) {
						item.setCondition(item.getRepairMax());
						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							imageOverlayPath = item.getIconOverlay(),
							text = "Your " + item.makeName() + " is repaired"
						});
						items++;

						if (items > 3) {
							break;
						}
					}
				}
			}
		});
		::Legends.Screens.hook(this, "Bad", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_97.png[/img]{%other% sighs after you ask that %they_other% go help the kid with his duties. %They_other% lazily steps over to the blacksmith\'s anvil which is shaped like a molar as it rests on thin iron stilts. The blacksmith\'s goods are hanging from ad hoc walls manufactured out of old iron fences, the spokes curved outward to help catch the metalworks. The kid claps his hands.%SPEECH_ON%Now don\'t touch nothing else, just help me with this.%SPEECH_OFF% %other% turns \'round with confusion and mid-sentence knocks the anvil\'s leg out. It starts to crumple sideways and the kid rushes to catch it if only to stem the tide of trouble which has beset his day. The insane weight pastes him flat against the cobblestones, his limbs briefly stretched up like a cricket smooshed beneath a thumb. You see this all from a distance and whistle for the mercenary to head back before there\'s trouble. %They_other% makes his escape just as a few passersby start to take notice. %They_other% shrugs.%SPEECH_ON%We didn\'t do nothing, right sir?%SPEECH_OFF%You nod.}";
			local startBad = _screen.start;
			_screen.start <- function (_event) {
				this.World.Assets.addMoralReputation(-1);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_moral_reputation.png",
					text = "The company\'s moral reputation decreases slightly"
				});
				startBad(_event);
			}
		});
		::Legends.Screens.hook(this, "Juggler", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_97.png[/img]{Your suspicions about the juggler volunteering to be sent to help are confirmed true as you soon see %them_juggler% throwing daggers and axes into the air and wowing the public at large. Seeing the crowds gather, %they_juggler% places a hat upon the cobblestones and continues the act. They throw plenty of coin in, and the applause is deafening as %they_juggler% plays out his final act of five maces at the same time. Bowing, %they_juggler% picks up the hat and rushes back over.%SPEECH_ON%A fine day\'s work, aye sir?%SPEECH_OFF%Nodding, you ask about the boy\'s broken sword. %They_juggler% clears the sweat from %their_juggler% brow.%SPEECH_ON%What you say, sir? Get back with the company? Aye sir, I\'ll get back with the company now.%SPEECH_OFF%Pursing your lips, you look back toward the smithery to see the boy bent over an anvil and taking a sound leather hiding from the returned blacksmith.}";
		});
		::Legends.Screens.hook(this, "Apprentice", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_97.png[/img]{%apprentice% the young apprentice is tasked with helping the kid. %They_apprentice% saunters over to the smithy and starts helping the kid. But %they_apprentice% does more than just help: %they_apprentice% fashions the sword back together in such a way that is stronger than it was to begin with. The blacksmith returns to find the handiwork and demands to know how to do it, almost begging for insight. %apprentice% laughs.%SPEECH_ON%You give me this sword and I\'ll give you the secret my meister passed down to me.%SPEECH_OFF%You didn\'t even know the apprentice knew how to do any of this, but the %sib_apprentice% is nothing if not a sponge in boots. A trade is made with the blacksmith and both parties leave more than happy.}";
		});
		::Legends.Screens.hook(this, "Killer", function (_screen) {
			_screen.Text = "[img]gfx/ui/events/event_97.png[/img]{You ask %killer% the murderer to help the kid. The %person_killer% obliges with a smile to which the kid seems intuitively offended by. He takes a few steps back and waves the help away.%SPEECH_ON%No sir, I think I\'m quite alright. Th-thank you. After all, a man\'s gotta do what a man\'s gotta do, right?%SPEECH_OFF%The killer smiles, crouches, and puts a thumb to the kid\'s cheek and leaves it laying there.%SPEECH_ON%That\'s right, boy. That\'s right. A man does what he needs.%SPEECH_OFF%Now you\'re offended and ask %killer% to go count inventory. %They_killer% rubs the lad\'s hair and then rises and departs. The kid runs off, but quickly returns with a dagger.%SPEECH_ON%H-here, take this. Keep that creep all the hells away from me, please sir. Got it? I want no business with that %person_killer% and would sooner seek a blacksmith\'s hiding than see %them_killer% ever again. You take the weapon, you keep %them_killer% away. Deal? Deal, yeah? Take it!%SPEECH_OFF%You measure that the kid\'s never bargained in his life, that or this is the first time he\'s felt his life on the line. Either way, you accept the dagger. The kid sighs in relief before returning to the smithy, there working away, and there always keeping an eye over his shoulder.}";
		});
	}
});
