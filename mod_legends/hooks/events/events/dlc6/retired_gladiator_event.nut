::mods_hookExactClass("events/events/dlc6/retired_gladiator_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "BuyArmor") {
				s.start <- function ( _event ) {
					local item = this.Const.World.Common.pickArmor([
						[1, ::Legends.Armor.Southern.gladiator_harness],
					]);
					item.setUpgrade(this.new("scripts/items/legend_armor/armor_upgrades/legend_heavy_gladiator_upgrade"));

					this.List.extend(::Legends.EventList.addItems([item], ::World.Assets.getStash()));
					this.List.push(::Legends.EventList.changeMoney(-1000));
				}
			}
		}
	}
})
