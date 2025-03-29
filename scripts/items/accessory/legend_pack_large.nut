this.legend_pack_large <- this.inherit("scripts/items/accessory/accessory", {
	m = {},
	function create()
	{
		this.accessory.create();
		this.m.ID = "accessory.legend_pack_large";
		this.m.Name = "Merchant's pack";
		this.m.Description = "A backpack worn by merchants to carry many more supplies";
		this.m.SlotType = this.Const.ItemSlot.Accessory;
		this.m.IsDroppedAsLoot = true;
		this.m.IsAllowedInBag = false;
		this.m.ShowOnCharacter = true;
		this.m.IconLarge = "accessory/legend_pack_large.png";
		this.m.Icon = "accessory/legend_pack_large.png";
		this.m.Sprite = "legend_pack_large";
		this.m.StaminaModifier = -2;
		this.m.StashModifier = 6;
		this.m.AddGenericSkill = true;
		this.m.Value = 1000;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/cloth_01.wav", this.Const.Sound.Volume.Inventory);
	}

});
