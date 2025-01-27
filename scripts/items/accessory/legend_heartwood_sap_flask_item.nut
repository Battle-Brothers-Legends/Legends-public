this.legend_heartwood_sap_flask_item <- this.inherit("scripts/items/accessory/accessory", {
	m = {},
	function create()
	{
		this.accessory.create();
		this.m.ID = "accessory.legend_heartwood_sap_flask";
		this.m.Name = "Flask of Heartwood Sap";
		this.m.Description = "This flask holds the sap of a heartwood schrat, it will grant a feeling of intense clarity and speed. The sensation takes over your mind and body, placing you in a flow state of pure presence.";
		this.m.SlotType = this.Const.ItemSlot.Bag;
		this.m.IsAllowedInBag = true;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = false;
		this.m.IconLarge = "";
		this.m.Icon = "consumables/potion_sap.png";
		this.m.StaminaModifier = -2;
		this.m.Value = 3500;
	}

	function getTooltip()
	{
		local result = this.accessory.getTooltip();
		result.push({
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Grants perfect focus, halving the action point costs of all skills for three turns"
			});
		return result;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
	}

	function onEquip()
	{
		this.accessory.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendDrinkHeartwoodSap, function (_skill) {
			_skill.setItem(this);
		}.bindenv(this));
	}

	function onPutIntoBag()
	{
		this.onEquip();
	}

});

