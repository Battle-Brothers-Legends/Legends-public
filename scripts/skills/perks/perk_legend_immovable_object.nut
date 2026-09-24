this.perk_legend_immovable_object <- this.inherit("scripts/skills/skill", {
	m = {
		isGrantingStunImmunity = false
	},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendImmovableObject);
	}

	function onUpdate(_properties) {
		local fat = -1 * this.getContainer().getActor().getItems().getStaminaModifier([
			::Const.ItemSlot.Body,
			::Const.ItemSlot.Head,
			::Const.ItemSlot.Mainhand,
			::Const.ItemSlot.Offhand,
			::Const.ItemSlot.Bag,
			::Const.ItemSlot.Accessory
		]);
		local bonus = fat / 10;
		_properties.Bravery += ::Math.floor(bonus);
		_properties.DamageReceivedDirectMult *= 1.0 - 0.01 * bonus;
		this.m.isGrantingStunImmunity = fat > 50;
		if (fat > 80 && ::Legends.Perks.has(this, ::Legends.Perk.SteelBrow)) {
			_properties.IsImmuneToKnockBackAndGrab = true;
		}
	}
});
