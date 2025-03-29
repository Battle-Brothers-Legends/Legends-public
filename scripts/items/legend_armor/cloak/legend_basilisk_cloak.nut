this.legend_basilisk_cloak <- this.inherit("scripts/items/legend_armor/legend_armor_cloak", {
	m = {},
	function create()
	{
		this.legend_armor_cloak.create(); //attachment gives poison immunity and extra durability
		this.m.ID = "legend_armor.body.legend_basilisk_cloak";
		this.m.Type = this.Const.Items.ArmorUpgrades.Cloak;
		
		this.m.Name = "Basilisk Cloak";
		this.m.Description = "A cloak made from feathers of a Basilisk. The weave offers exceptional padding and protects the midsection and mouth from poison.";
		this.m.ArmorDescription = "A cloak made from feathers of a Basilisk. The weave offers exceptional padding and protects the midsection and mouth from poison.";
		
		this.m.Icon = "legend_armor/upgrades/upgrade_basilisk.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = this.m.Icon; 
		this.m.OverlayIconLarge = "legend_armor/upgrades/inventory_upgrade_basilisk.png"; 
		this.m.SpriteFront = null;
		this.m.SpriteBack = "upgrade_basilisk_back";
		this.m.SpriteDamagedFront = null;
		this.m.SpriteDamagedBack = "upgrade_basilisk_back_damaged";
		this.m.SpriteCorpseFront = null;
		this.m.SpriteCorpseBack = "upgrade_basilisk_back_dead";

		this.m.Value = 2800;
		this.m.Condition = 30; //normal would be around 20 to 25
		this.m.ConditionMax = 30;
		this.m.StaminaModifier = -3;
	}

	function getTooltip()
	{
		local result = this.legend_armor_cloak.getTooltip();
		result.push({
			id = 15,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Unaffected by poison"
		});
		return result;
	}

	function onArmorTooltip( _result )
	{
		_result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Unaffected by poison"
		});
	}

	function onUpdateProperties( _properties )
	{
		this.legend_armor_cloak.onUpdateProperties(_properties);
		_properties.IsImmuneToPoison = true;
	}

	function updateVariant()	// Needs to overwrite the base function which would otherwise overwrite Icon and Graphic of this Cloak
	{
	}
});
