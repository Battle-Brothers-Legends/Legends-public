::mods_hookExactClass("skills/perks/perk_steadfast", function(o) {
	o.onUpdate = function ( _properties )
	{
		_properties.FatigueLossOnAnyAttackMult *= 0.1;

		local fat = this.getContainer.getActor().getItems().getStaminaModifier(
			[
				::Const.ItemSlot.Body,
				::Const.ItemSlot.Head,
				::Const.ItemSlot.Mainhand,
				::Const.ItemSlot.Offhand,
				::Const.ItemSlot.Bag
			]
		);
		fat *= -1;
		local bonus = this.Math.abs(fat / 10);
		_properties.MeleeDefense += this.Math.floor(bonus);
	}
});
