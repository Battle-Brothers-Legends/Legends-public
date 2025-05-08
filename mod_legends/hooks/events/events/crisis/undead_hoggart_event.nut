::mods_hookExactClass("events/events/crisis/undead_hoggart_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "C") {
				local startC = s.start;
				s.start <- function (_event) {
					startC(_event);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation decreases slightly"
					});
				}
			}
			if (s.ID == "F") {
				s.start <- function (_event) {
					local item = this.Const.World.Common.pickArmor([
						[1, ::Legends.Armor.Named.black_leather_armor],
					]);

					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + item.getName()
					});
				}
			}
			if (s.ID == "J") {
				local startJ = s.start;
				s.start <- function (_event) {
					startJ(_event);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_moral_reputation.png",
						text = "The company\'s moral reputation increases slightly"
					});
				}
			}
		}
	}
})
