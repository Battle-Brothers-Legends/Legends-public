::mods_hookExactClass("skills/perks/perk_steadfast", function(o) {
	o.onUpdate = function ( _properties )
	{
		_properties.FatigueLossOnAnyAttackMult *= 0.1;

		local container = this.getContainer();
		if (container == null) {
			return;
		}
		local actor = container.getActor();
		if (actor == null) {
			return;
		}
		local fat = actor.getItems().getStaminaModifier(
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
