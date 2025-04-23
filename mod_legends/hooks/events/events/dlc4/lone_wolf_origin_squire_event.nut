::mods_hookExactClass("events/events/dlc4/lone_wolf_origin_squire_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.start <- function ( _event )
				{
					local roster = this.World.getTemporaryRoster();
					_event.m.Dude = roster.create("scripts/entity/tactical/player");
					_event.m.Dude.setStartValuesEx([
						"squire_background"
					]);
					_event.m.Dude.getBackground().m.RawDescription = "You met %name% in " + _event.m.Town.getName() + " where he volunteered to be your squire. He probably had no idea what he was getting into back then.";
					_event.m.Dude.getBackground().buildDescription(true);
					_event.m.Dude.getItems().unequip(_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand));
					_event.m.Dude.getItems().unequip(_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand));
					_event.m.Dude.getItems().unequip(_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head));
					_event.m.Dude.getItems().unequip(_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Body));

					_event.m.Dude.getItems().equip(this.Const.World.Common.pickArmor([
						[1, ::Legends.Armor.Standard.linen_tunic],
					]));

					_event.m.Dude.setTitle("the Squire");
					this.Characters.push(_event.m.Dude.getImagePath());
				}
			}
		}
	}
})
