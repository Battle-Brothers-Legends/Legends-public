this.legend_pack_small <- this.inherit("scripts/items/accessory/accessory", {
	m = {},
	function create()
	{
		this.accessory.create();
		this.m.ID = "accessory.legend_pack_small";
		this.m.Name = "Traveler\'s Sash";
		this.m.Description = "A sash worn by travelers to help carry additional supplies";
		this.m.SlotType = this.Const.ItemSlot.Accessory;
		this.m.IsDroppedAsLoot = true;
		this.m.IsAllowedInBag = false;
		this.m.ShowOnCharacter = true;
		this.m.IconLarge = "accessory/legend_pack_small.png";
		this.m.Icon = "accessory/legend_pack_small.png";
		this.m.Sprite = "legend_pack_small";
		this.m.StashModifier = 3;
		this.m.StaminaModifier = -1;
		this.m.AddGenericSkill = true;
		this.m.Value = 100;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/cloth_01.wav", this.Const.Sound.Volume.Inventory);
	}

});
