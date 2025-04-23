::mods_hookExactClass("events/events/crisis/greenskins_pet_goblin_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "H") {
				s.start <- function ( _event ) {
					if (this.World.Assets.getMedicine() >= 2) {
						this.World.Assets.addMedicine(-2);
						this.List.push({
							id = 10,
							icon = "ui/icons/asset_medicine.png",
							text = "You lose [color=" + this.Const.UI.Color.NegativeEventValue + "]-2[/color] Medical Supplies."
						});
					}

					local r = this.Math.rand(1, 4);
					local item = null;
					if (r == 1)
						item = this.new("scripts/items/weapons/named/named_axe");
					else if (r == 2)
						item = this.new("scripts/items/weapons/named/named_spear");
					else if (r == 3)
						item = this.Const.World.Common.pickHelmet([[1, ::Legends.Helmet.Named.wolf_helmet]]);
					else if (r == 4) {
						item = this.Const.World.Common.pickArmor([
							[1, ::Legends.Armor.Named.black_leather_armor],
						]);
					}

					this.World.Assets.getStash().makeEmptySlots(1);
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
