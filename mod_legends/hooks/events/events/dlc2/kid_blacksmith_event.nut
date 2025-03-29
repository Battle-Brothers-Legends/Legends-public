::mods_hookExactClass("events/events/dlc2/kid_blacksmith_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "Good") {
				s.start <- function (_event) {
					this.Characters.push(_event.m.Other.getImagePath());
					this.World.Assets.addMoralReputation(1);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation increases slightly"
					});
					local stash = this.World.Assets.getStash().getItems();
					local items = 0;

					foreach( item in stash ) {
						if (item != null && item.isItemType(this.Const.Items.ItemType.Weapon) && item.getCondition() < item.getConditionMax()) {
							item.setCondition(item.getRepairMax());
							this.List.push({
								id = 10,
								icon = "ui/items/" + item.getIcon(),
								text = "Your " + item.getName() + " is repaired"
							});
							items++;

							if (items > 3)
								break;
						}
					}
				}
			}
			if (s.ID == "Bad") {
				local startBad = s.start;
				s.start <- function (_event) {
					this.World.Assets.addMoralReputation(-1);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation decreases slightly"
					});
					startBad(_event);
				}
			}
			if (s.ID == "Killer") {
				s.Text = "[img]gfx/ui/events/event_97.png[/img]{You ask %killer% the murderer to help the kid. The killer obliges with a smile to which the kid seems intuitively offended by. He takes a few steps back and waves the help away.%SPEECH_ON%No sir, I think I\'m quite alright. Th-thank you. After all, a man\'s gotta do what a man\'s gotta do, right?%SPEECH_OFF%The killer smiles, crouches, and puts a thumb to the kid\'s cheek and leaves it laying there.%SPEECH_ON%That\'s right, boy. That\'s right. An man does what is needed.%SPEECH_OFF%Now you\'re offended and ask %killer% to go count inventory. The murderer rubs the lad\'s hair and then rises and departs. The kid runs off, but quickly returns with a dagger.%SPEECH_ON%H-here, take this. Keep that creep all the hells away from me, please sir. Got it? I want no business with that freak and would sooner seek a blacksmith\'s hiding than see that face ever again. You take the weapon, you keep that thing away. Deal? Deal, yeah? Take it!%SPEECH_OFF%You measure that the kid\'s never bargained in his life, that or this is the first time he\'s felt his life on the line. Either way, you accept the dagger. The kid sighs in relief before returning to the smithy, there working away, and there always keeping an eye over his shoulder.}";
			}
		}
	}
});
