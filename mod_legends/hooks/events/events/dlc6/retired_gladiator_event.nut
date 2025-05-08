::mods_hookExactClass("events/events/dlc6/retired_gladiator_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "BuyArmor") {
				s.start <- function ( _event ) {
					local a = this.Const.World.Common.pickArmor([
						[1, ::Legends.Armor.Southern.gladiator_harness],
					]);
					a.setUpgrade(this.new("scripts/items/legend_armor/armor_upgrades/legend_heavy_gladiator_upgrade"));
					this.List.push({
						id = 12,
						icon = "ui/items/armor_upgrades/upgrade_25.png",
						text = "You gain a " + a.getName()
					});
					this.World.Assets.getStash().add(a);
					this.World.Assets.addMoney(-1000);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "You lose [color=" + this.Const.UI.Color.NegativeEventValue + "]1,000[/color] Crowns"
					});
				}
			}
		}
	}
})
