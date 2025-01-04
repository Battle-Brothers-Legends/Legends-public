::mods_hookExactClass("events/events/dlc8/anatomist_wants_skull_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "D") {
				s.start <- function ( _event ) {
					_event.m.Anatomist.improveMood(1.0, "Acquired an unusual skull to study");
					_event.m.Thief.improveMood(1.0, "Successfully stole from the peasantry");

					if (_event.m.Anatomist.getMoodState() >= this.Const.MoodState.Neutral) {
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[_event.m.Anatomist.getMoodState()],
							text = _event.m.Anatomist.getName() + this.Const.MoodStateEvent[_event.m.Anatomist.getMoodState()]
						});
					}

					if (_event.m.Thief.getMoodState() >= this.Const.MoodState.Neutral) {
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[_event.m.Thief.getMoodState()],
							text = _event.m.Thief.getName() + this.Const.MoodStateEvent[_event.m.Thief.getMoodState()]
						});
					}

					_event.m.Anatomist.addXP(100, false);
					_event.m.Anatomist.updateLevel();
					this.List.push({
						id = 16,
						icon = "ui/icons/xp_received.png",
						text = _event.m.Anatomist.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+100[/color] Experience"
					});
					local initiativeBoost = this.Math.rand(2, 4);
					_event.m.Thief.getBaseProperties().Initiative += initiativeBoost;
					_event.m.Thief.getSkills().update();
					this.List.push({
						id = 16,
						icon = "ui/icons/initiative.png",
						text = _event.m.Thief.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + initiativeBoost + "[/color] Initiative"
					});
					local item;
					local weaponList = [
						"militia_spear",
						"militia_spear",
						"militia_spear",
						"shortsword",
						"falchion",
						"light_crossbow"
					];
					local itemAmount = this.Math.rand(1, 2);

					for( local i = 0; i < itemAmount; i = ++i ) {
						item = this.new("scripts/items/weapons/" + weaponList[this.Math.rand(0, weaponList.len() - 1)]);
						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = "You gain " + item.getName()
						});
						this.World.Assets.getStash().add(item);
					}

					local armorList = this.Const.World.Common.pickArmor([
						[1, "leather_tunic"],
						[1, "leather_tunic"],
						[1, "thick_tunic"],
						[1, "thick_tunic"],
						[1, "padded_surcoat"],
						[1, "padded_leather"]
					]);
					itemAmount = this.Math.rand(1, 2);

					for( local i = 0; i < itemAmount; i = ++i ) {
						item = this.new(armorList[this.Math.rand(0, armorList.len() - 1)]);
						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = "You gain " + item.getName()
						});
						this.World.Assets.getStash().add(item);
					}

					this.Characters.push(_event.m.Anatomist.getImagePath());
					this.Characters.push(_event.m.Thief.getImagePath());
				}
			}
		}
	}
})
