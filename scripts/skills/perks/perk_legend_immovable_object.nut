this.perk_legend_immovable_object <- this.inherit("scripts/skills/skill", {
	m = {
		SteelBrow = false
	},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendImmovableObject);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
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
		_properties.Bravery += this.Math.floor(bonus);
		_properties.DamageReceivedDirectMult += 0.01 * bonus;
		if (fat > 50)
			this.m.SteelBrow = true;
		else
			this.m.SteelBrow = false;
		if (fat > 80 && ::Legends.Perks.has(this, ::Legends.Perk.SteelBrow))
			_properties.IsImmuneToKnockBackAndGrab = true;
	}
});
