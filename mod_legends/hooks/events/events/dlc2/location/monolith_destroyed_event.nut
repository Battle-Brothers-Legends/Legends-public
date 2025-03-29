::mods_hookExactClass("events/events/dlc2/location/monolith_destroyed_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "B") {
				s.start <- function ( _event ) {
					this.World.Assets.getStash().makeEmptySlots(2);
					local item = this.new("scripts/items/legend_armor/legendary/legend_emperors_armor");
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + item.getName()
					});
					item = this.new("scripts/items/legend_armor/named/legend_armor_cloak_emperors");
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
