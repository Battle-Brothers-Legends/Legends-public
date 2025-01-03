::mods_hookExactClass("events/events/dlc8/something_in_barn_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "B") {
				s.start <- function ( _event ) {
					local item = this.new("scripts/items/accessory/legend_wardog_item");
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + item.getName()
					});
					this.Characters.push(_event.m.Anatomist.getImagePath());
				}
			}
		}
	}
})
