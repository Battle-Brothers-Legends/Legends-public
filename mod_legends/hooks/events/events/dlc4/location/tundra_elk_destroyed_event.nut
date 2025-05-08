::mods_hookExactClass("events/events/dlc4/location/tundra_elk_destroyed_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.start <- function ( _event ) {
					this.World.Flags.set("IjirokStage", 5);
					local stash = this.World.Assets.getStash().getItems();

					foreach( i, item in stash ) {
						if (item != null && item.getID() == "misc.broken_ritual_armor") {
							stash[i] = null;
							this.List.push({
								id = 10,
								icon = "ui/items/" + item.getIcon(),
								text = "You lose " + item.getName()
							});
							break;
						}
					}

					this.World.Assets.getStash().makeEmptySlots(2);
					local item = this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Legendary.legend_ijirok_helmet]]);
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + item.getName()
					});

					item = this.Const.World.Common.pickArmor([[1, ::Legends.Armor.Legendary.legend_ijirok_armor]]);

					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + item.getName()
					});
				}
			}
		}
	}
})
