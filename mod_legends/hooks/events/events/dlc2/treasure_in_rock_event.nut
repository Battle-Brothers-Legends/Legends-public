::mods_hookExactClass("events/events/dlc2/treasure_in_rock_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "Tiny") {
				s.start <- function ( _event ) {
					this.Characters.push(_event.m.Tiny.getImagePath());
					local item = this.Const.World.Common.pickArmor([
						[1, ::Legends.Armor.Ancient.ancient_breastplate],
					]);
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain an " + item.getName()
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
