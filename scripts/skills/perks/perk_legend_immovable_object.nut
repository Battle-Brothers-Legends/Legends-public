this.perk_legend_immovable_object <- this.inherit("scripts/skills/skill", {
	m = {
		SteelBrow = false
	},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendImmovableObject);
	}

	function onUpdate( _properties )
	{
		local fat = this.getContainer().getActor().getItems().getStaminaModifier(
			[
				::Const.ItemSlot.Body,
				::Const.ItemSlot.Head,
				::Const.ItemSlot.Mainhand,
				::Const.ItemSlot.Offhand,
				::Const.ItemSlot.Bag
			]
		);
		fat *= -1;
		local bonus = fat / 10;
		_properties.Bravery += this.Math.floor(bonus);
		_properties.DamageReceivedDirectMult *= 1.0 - 0.01 * bonus;
		if (fat > 50)
			this.m.SteelBrow = true;
		else
			this.m.SteelBrow = false;
		if (fat > 80 && ::Legends.Perks.has(this, ::Legends.Perk.SteelBrow))
			_properties.IsImmuneToKnockBackAndGrab = true;
	}
});
