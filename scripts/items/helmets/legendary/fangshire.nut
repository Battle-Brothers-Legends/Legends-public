this.fangshire <- this.inherit("scripts/items/legend_helmets/legend_helmet_upgrade", {
	m = {},
	function create()
	{
		this.legend_helmet_upgrade.create();
		this.m.Type = this.Const.Items.HelmetUpgrades.Vanity;
		this.m.ID = "armor.head.fangshire";
		this.m.Name = "Fangshire";
		this.m.Description = "The Fangshire is a northern tiger\'s skull that nestles the faces of men deeply and darkly behind two ferocious fangs. Originally worn by Bjarund the Beastman, a fierce northern raider, it instilled fear into the hearts of his enemies as he went on bloody raids and burned down many a village along the coastline. When Bjarund was finally slain, Fangshire was taken as a trophy and went further south. Rumors proclaim that its wearer\'s eyes glow a sharpened yellow, allowing them to see through the very night.";
		this.m.ArmorDescription = this.m.Description;
		this.m.Variant = 24;
		this.updateVariant();
		this.m.ImpactSound = [
			"sounds/enemies/skeleton_hurt_03.wav"
		];
		this.m.InventorySound = this.Const.Sound.ArmorLeatherImpact;
		this.m.ItemType = this.m.ItemType | this.Const.Items.ItemType.Legendary;
		this.m.Value = 500;
		this.m.Condition = 40;
		this.m.ConditionMax = 40;
		this.m.StaminaModifier = -2;
		this.m.IsLowerVanity = false;
		this.m.HideHair = true;
		this.m.HideBeard = false;
	}
	
	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "bust_helmet_" + variant;
		this.m.SpriteDamaged = "bust_helmet_" + variant + "_damaged";
		this.m.SpriteCorpse = "bust_helmet_" + variant + "_dead";
		this.m.Icon = "helmets/inventory_helmet_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "helmets/icon_helmet_" + variant + ".png";
		this.m.OverlayIconLarge = this.m.OverlayIcon;
	}

	function getTooltip()
	{
		local result = this.legend_helmet_upgrade.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Allows the wearer to see at night and negates any penalties due to nighttime."
		});
		return result;
	}

	function onUpdateProperties( _properties )
	{
		this.legend_helmet_upgrade.onUpdateProperties(_properties);
		_properties.IsAffectedByNight = false;
	}

});

