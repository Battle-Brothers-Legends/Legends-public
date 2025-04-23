::mods_hookExactClass("events/events/tailor_werewolf_hide_armor_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.start = function ( _event ) {
					this.Characters.push(_event.m.Tailor.getImagePath());
					local stash = this.World.Assets.getStash().getItems();
					local numPelts = 0;

					foreach( i, item in stash ) {
						if (item != null && item.getID() == "misc.werewolf_pelt") {
							numPelts = ++numPelts;
							stash[i] = null;
							this.List.push({
								id = 10,
								icon = "ui/items/" + item.getIcon(),
								text = "You lose " + item.getName()
							});

							if (numPelts >= 2)
								break;
						}
					}

					local item = this.Const.World.Common.pickArmor([
						[1, ::Legends.Armor.Standard.werewolf_hide_armor],
					]);


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
