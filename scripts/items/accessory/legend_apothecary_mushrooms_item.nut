this.legend_apothecary_mushrooms_item <- this.inherit("scripts/items/accessory/accessory", {
	m = {},
	function create()
	{
		this.accessory.create();
		this.m.ID = "accessory.legend_apothecary_mushrooms";
		this.m.Name = "Apothecary Mushrooms";
		this.m.Description = "Strange mushrooms that have anyone chewing them enter a trance-like state where they don\'t feel any pain and exhibit significantly decreased aggression. May result in sickness. Eat responsibly.";
		this.m.SlotType = this.Const.ItemSlot.Bag;
		this.m.IsAllowedInBag = true;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = false;
		this.m.IconLarge = "";
		this.m.Icon = "consumables/mushrooms_02.png";
		this.m.StaminaModifier = -2;
		this.m.Value = 100;
	}

	function getTooltip()
	{
		local result = this.accessory.getTooltip();
		return result;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/cloth_01.wav", this.Const.Sound.Volume.Inventory);
	}

	function onEquip()
	{
		this.accessory.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendApothecaryMushrooms, function (_skill) {
			_skill.setItem(this);
		}.bindenv(this));
	}

	function onPutIntoBag()
	{
		this.onEquip();
	}

});

