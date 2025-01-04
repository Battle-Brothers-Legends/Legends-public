::mods_hookExactClass("events/events/crisis/greenskins_investigation_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "D") {
				local startD = s.start;
				s.start <- function (_event) {
					startD(_event);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation decreases slightly"
					});
				}
			}
			if (s.ID == "G") {
				s.start <- function (_event) {
					this.Banner = _event.m.NobleHouse.getUIBannerSmall();
					local item;
					item = this.new("scripts/items/accessory/poison_item");
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + item.getName()
					});
					item = this.new("scripts/items/accessory/antidote_item");
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + item.getName()
					});
					item = this.new("scripts/items/accessory/berserker_mushrooms_item");
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + item.getName()
					});
					item = this.new("scripts/items/accessory/legend_wardog_item");
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
