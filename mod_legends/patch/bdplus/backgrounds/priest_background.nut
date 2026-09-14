::mods_hookExactClass("skills/backgrounds/priest_background", function(o) {
	o.getTooltip = @() this.character_background.getTooltip();

	o.setGender <- @(_gender = -1) 0; // men only, idk what priest could be for woman, we already have nuns

	local onAddEquipment = o.onAddEquipment;
	o.onAddEquipment = function () {
		onAddEquipment();
		local items = this.getContainer().getActor().getItems();

		local body = items.getItemAtSlot(::Const.ItemSlot.Body);
		if (body != null)
			items.unequip(body);
		items.equip(::Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Southern.cloth_sash],
			[1, ::Legends.Armor.Southern.padded_vest]
		]));
	}
});
