this.legend_spiked_gauntlets_item <- this.inherit("scripts/items/accessory/gloves/legend_glove_item", {
	m = {
		RegularDamage = 10,
		RegularDamageMax = 16,
		ChokeMin = 3,
		ChokeMax = 6,
		ArmorDamageMult = 0.3,
		DirectDamageMult = 0.2,
		InventorySound = "sounds/combat/armor_halfplate_impact_01.wav"

	},
	function create()
	{
		this.legend_glove_item.create();
		this.m.ID = "accessory.legend_spiked_gauntlets";
		this.m.Name = "Spiked Gauntlets";
		this.m.Description = "A pair of armored gauntlets with spikes on the knuckles that can certainly pack a punch, but also help deflect blows from weak spots.";
		this.m.Icon = "accessory/spiky_gauntlets.png";
		this.m.Value = 2600;
		this.m.StaminaModifier = -3;
	}

	function getTooltip()
	{
		local result = this.legend_glove_item.getTooltip();

		result.extend(
		[
			{
				id = 15,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=%positive%]+2[/color] Melee Defense."
			}
		]);
		return result;
	}

	function onUpdateProperties ( _properties )
	{
		this.legend_glove_item.onUpdateProperties(_properties);
		_properties.MeleeDefense += 2;
	}
});
