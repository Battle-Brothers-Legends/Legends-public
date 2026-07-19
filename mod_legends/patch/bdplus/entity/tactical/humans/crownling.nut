::mods_hookExactClass("entity/tactical/humans/crownling", function(o) {
	local assignRandomEquipment = o.assignRandomEquipment;
	o.assignRandomEquipment = function () {
		assignRandomEquipment();
		local items = this.getItems();

		local body = items.getItemAtSlot(::Const.ItemSlot.Body);
		if (body != null)
			items.unequip(body);
		items.equip(::Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Southern.southern_mail_shirt],
			[1, ::Legends.Armor.Southern.mail_and_lamellar_plating],
			[1, ::Legends.Armor.Southern.southern_long_mail_with_padding],
			[1, ::Legends.Armor.Standard.mail_hauberk],
			[1, ::Legends.Armor.Standard.reinforced_mail_hauberk],
			[1, ::Legends.Armor.Standard.lamellar_harness],
			[1, ::Legends.Armor.Standard.sellsword_armor],
			[1, ::Legends.Armor.Standard.footman_armor],
			[1, ::Legends.Armor.Standard.light_scale_armor],
		]));

		local head = items.getItemAtSlot(::Const.ItemSlot.Head);
		if (head != null)
			items.unequip(head);
		items.equip(::Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Southern.wrapped_southern_helmet],
			[1, ::Legends.Helmet.Southern.spiked_skull_cap_with_mail],
			[1, ::Legends.Helmet.Southern.nomad_reinforced_helmet],
			[1, ::Legends.Helmet.Southern.southern_helmet_with_coif],
			[1, ::Legends.Helmet.Southern.heavy_lamellar_helmet],
			[1, ::Legends.Helmet.Standard.reinforced_mail_coif],
			[1, ::Legends.Helmet.Standard.conic_helmet_with_closed_mail]
		]));
	}
});
