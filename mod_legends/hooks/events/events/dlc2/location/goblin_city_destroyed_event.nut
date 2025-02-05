::mods_hookExactClass("events/events/dlc2/location/goblin_city_destroyed_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "B") {
				s.start <- function ( _event ) {
					this.World.Assets.getStash().makeEmptySlots(1);
					local item = this.new("scripts/items/legend_helmets/legendary/legend_emperors_countenance");
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
