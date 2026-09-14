::mods_hookExactClass("entity/tactical/humans/crownling_low", function(o) {
	local assignRandomEquipment = o.assignRandomEquipment;
	o.assignRandomEquipment = function () {
		assignRandomEquipment();
		local items = this.getItems();

		local body = items.getItemAtSlot(::Const.ItemSlot.Body);
		if (body != null)
			items.unequip(body);
		items.equip(::Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Southern.padded_vest],
			[1, ::Legends.Armor.Southern.linothorax],
			[1, ::Legends.Armor.Southern.southern_mail_shirt],
			[1, ::Legends.Armor.Southern.stitched_nomad_armor],
			[1, ::Legends.Armor.Southern.plated_nomad_mail],
			[1, ::Legends.Armor.Southern.leather_nomad_robe]
		]));

		local head = items.getItemAtSlot(::Const.ItemSlot.Head);
		if (head != null)
			items.unequip(head);
		items.equip(::Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Southern.southern_head_wrap],
			[1, ::Legends.Helmet.Southern.wrapped_southern_helmet],
			[1, ::Legends.Helmet.Southern.spiked_skull_cap_with_mail],
			[1, ::Legends.Helmet.Southern.nomad_light_helmet],
			[1, ::Legends.Helmet.Southern.nomad_reinforced_helmet]
		]));
	}
});
