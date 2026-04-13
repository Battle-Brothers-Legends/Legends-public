this.legend_skin_ghoul_blood_flask_item <- this.inherit("scripts/items/accessory/accessory", {
	m = {},
	function create()
	{
		this.accessory.create();
		this.m.ID = "accessory.legend_skin_ghoul_blood_flask";
		this.m.Name = "Flask of Skin Ghoul Blood";
		this.m.Description = "This flask holds the blood of a skin ghoul, it will heal any skin it touches. If taken internally it will spread through your body, knitting flesh and closing wounds, and who knows what else.";
		this.m.SlotType = this.Const.ItemSlot.Bag;
		this.m.IsAllowedInBag = true;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = false;
		this.m.IconLarge = "";
		this.m.Icon = "consumables/potion_blood.png";
		this.m.StaminaModifier = -2;
		this.m.Value = 3500;
	}

	function getTooltip()
	{
		local result = this.accessory.getTooltip();
		result.push({
				id = 11,
				type = "text",
				icon = "ui/icons/days_wounded.png",
				text = "Restores up to [color=%positive%]+10%[/color] of max health"
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
		::Legends.Actives.grant(this, ::Legends.Active.LegendDrinkSkinGhoulBlood, function (_skill) {
			_skill.setItem(this);
		}.bindenv(this));
	}

	function onPutIntoBag()
	{
		this.onEquip();
	}

});

