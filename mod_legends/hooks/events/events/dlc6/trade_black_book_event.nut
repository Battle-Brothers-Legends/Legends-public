::mods_hookExactClass("events/events/dlc6/trade_black_book_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "C") {
				s.start <- function ( _event ) {
					local book;

					foreach( item in this.World.Assets.getStash().getItems() ) {
						if (item != null && item.getID() == "misc.black_book") {
							book = item;
							break;
						}
					}

					this.World.Assets.getStash().removeByID("misc.black_book");
					this.List.push({
						id = 10,
						icon = "ui/items/" + book.getIcon(),
						text = "You lose " + book.getName()
					});
					this.World.Assets.getStash().makeEmptySlots(2);
					local item = this.new("scripts/items/special/trade_jug_01_item");
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain a " + item.getName()
					});
					item = this.new("scripts/items/special/trade_jug_02_item");
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain a " + item.getName()
					});
				}
			}
		}
	}
})
