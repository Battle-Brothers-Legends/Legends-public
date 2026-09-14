this.legend_hexen_ichor_potion_item <- this.inherit("scripts/items/accessory/accessory", {
	m = {},
	function create()
	{
		this.accessory.create();
		this.m.ID = "accessory.legend_hexen_ichor_potion";
		this.m.Name = "Hexen Ichor Potion";
		this.m.Description = "A disgusting Hexen brew, will heal and remove fatigue for 8 turns, but poison for 3 turns.";
		this.m.SlotType = this.Const.ItemSlot.Bag;
		this.m.IsAllowedInBag = true;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = false;
		this.m.IconLarge = "";
		this.m.Icon = "consumables/potion_ichor.png";
		this.m.StaminaModifier = -2;
		this.m.Value = 7000;
	}

	function getTooltip()
	{
		local result = this.accessory.getTooltip();
		return result;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
	}

	function onEquip()
	{
		this.accessory.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendDrinkHexeIchorPotion, function (_skill) {
			_skill.setItem(this);
		}.bindenv(this));
	}

	function onPutIntoBag()
	{
		this.onEquip();
	}

});

