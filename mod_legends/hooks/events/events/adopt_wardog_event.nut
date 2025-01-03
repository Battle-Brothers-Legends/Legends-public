::mods_hookExactClass("events/events/adopt_wardog_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "E") {
				s.start <- function ( _event ) {
					local item = this.new("scripts/items/accessory/legend_wardog_item");
					item.m.Name = "Battle Brother";
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + item.getName()
					});
				}
			}
			if (s.ID == "G") {
				s.start <- function ( _event ) {
					this.Characters.push(_event.m.Houndmaster.getImagePath());
					local item = this.new("scripts/items/accessory/legend_wardog_item");
					item.m.Name = "Battle Brother";
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

	local onUpdateScore = o.onUpdateScore;
	o.onUpdateScore = function () {
		onUpdateScore();
		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];
		foreach (bro in brothers)
			if (bro.getBackground().getID() == "background.houndmaster" || bro.getBackground().getID() == "background.legend_muladi")
				candidates.push(bro);

		if (candidates.len() != 0)
			this.m.Houndmaster = candidates[this.Math.rand(0, candidates.len() - 1)];
	}
})
