this.legend_hand_wraps_item <- this.inherit("scripts/items/accessory/gloves/legend_glove_item", {
	m = {
		RegularDamage = 3,
		RegularDamageMax = 6,
		ChokeMin = 3,
		ChokeMax = 6,
		ArmorDamageMult = 0.0,
		DirectDamageMult = 0.0,
		InventorySound = "sounds/combat/armor_leather_impact_01.wav"

	},
	function create()
	{
		this.legend_glove_item.create();
		this.m.ID = "accessory.legend_hand_wraps";
		this.m.Name = "Pugilist Hand Wraps";
		this.m.Description = "Simple cloth wrapped around the hands, protects the wearer from the impact of his own punches and allows them to hit harder.";
		this.m.Icon = "accessory/hand_wraps.png";
		this.m.Value = 35;
	}
});
