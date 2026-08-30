::mods_hookExactClass("events/events/dlc2/treasure_in_rock_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "Tiny") {
				s.Text = "[img]gfx/ui/events/event_66.png[/img]The ever tiny %tiny% walks up to the crack in the berm and stares into it. %They_tiny% turns 'round like a top.%SPEECH_ON%Now I ain't one to assume, but I've the sense of being slighted here.%SPEECH_OFF%You assure %them_tiny% that you mean nothing at all by asking %they_tiny% make use of %their_tiny% comical size. %They_tiny% nods and gets to the task as though %they_tiny% were born for it, easily wiggling %their_tiny% way into the crack until it's just a pair of boots sticking out the earth. One of the sellswords glances over and quietly asks if it's weird that %they_tiny% feels the urge to tickle the feet. You ask what in the fark does that mean with no intention of attaining an answer. Thankfully, %tiny% yells out that %they_tiny%'s got the item and the men help yank %them_tiny% back out. %tiny% flips over with the treasure held aloft in %their_tiny% tiny hands.";
				s.start <- function ( _event ) {
					this.Characters.push(_event.m.Tiny.getImagePath());
					local item = this.Const.World.Common.pickArmor([
						[1, ::Legends.Armor.Ancient.ancient_breastplate],
					]);
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						imageOverlayPath = item.getIconOverlay(),
						text = "You gain an " + item.makeName()
					});

					local weapons = [
						[2, "weapons/ancient/ancient_sword"],
						[1, "weapons/ancient/legend_gladius"],
					];
					item = this.Const.World.Common.pickItem(weapons, "scripts/items/");
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain an " + item.getName()
					});
					_event.m.Tiny.improveMood(2.0, "Used his unique stature to benefit the company");

					if (_event.m.Tiny.getMoodState() >= this.Const.MoodState.Neutral) {
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[_event.m.Tiny.getMoodState()],
							text = _event.m.Tiny.getName() + this.Const.MoodStateEvent[_event.m.Tiny.getMoodState()]
						});
					}
				}
			}
		}
	}
});
