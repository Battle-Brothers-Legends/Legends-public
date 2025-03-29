this.legend_necromancer_robes <- this.inherit("scripts/items/armor/armor", {
	m = {},
	function create()
	{
		this.armor.create();
		this.m.ID = "armor.body.legend_necromancer_robes";
		this.m.Name = "Necromancer\'s Robes";
		this.m.Description = "Dark robes that have grown darker with ichor";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Value = 25;
		this.m.Condition = 40;
		this.m.ConditionMax = 40;
		this.m.StaminaModifier = 0;
	}

	function updateVariant()
	{
		this.m.Sprite = "bust_body_60";
		this.m.SpriteDamaged = "bust_body_60_damaged";
		this.m.SpriteCorpse = "bust_body_60_dead";
		this.m.IconLarge = "";
		this.m.Icon = "armor/icon_body_armor_60.png";
	}

});
