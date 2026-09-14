::mods_hookExactClass("entity/tactical/humans/indemnifier", function(o) {
	local assignRandomEquipment = o.assignRandomEquipment;
	o.assignRandomEquipment = function () {
		assignRandomEquipment();
		local items = this.getItems();

		local body = items.getItemAtSlot(::Const.ItemSlot.Body);
		if (body != null)
			items.unequip(body);
		items.equip(::Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Southern.mail_and_lamellar_plating],
			[1, ::Legends.Armor.Southern.southern_long_mail_with_padding],
			[1, ::Legends.Armor.Southern.padded_mail_and_lamellar_hauberk],
			[1, ::Legends.Armor.Standard.lamellar_harness],
			[1, ::Legends.Armor.Standard.scale_armor]
		]));

		local head = items.getItemAtSlot(::Const.ItemSlot.Head);
		if (head != null)
			items.unequip(head);
		items.equip(::Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Southern.southern_helmet_with_coif],
			[1, ::Legends.Helmet.Southern.heavy_lamellar_helmet],
			[1, ::Legends.Helmet.Southern.turban_helmet],
			[1, ::Legends.Helmet.Standard.conic_helmet_with_closed_mail]
		]));
	}
});
