this.legend_white_wolf_helmet <- this.inherit("scripts/items/helmets/named/named_helmet", {
	m = {},
	function create()
	{
		this.named_helmet.create();
		this.m.ID = "armor.head.legend_white_wolf";
		this.m.Description = "A sturdy metal helmet with attached mail, adorned with the trophy of a white wolf head. Makes opponents flee.";
		this.m.Name = ""
		this.m.NameList = [
			"Crown of the king of beasts",
			"Helmet of the White Wolf",
			"Wulfserker Coif",
			"Wolf Kings Helm",
			"White Wolf Crown",
			"Predator Crown"
		];
		this.m.ShowOnCharacter = true;
		this.m.HideHair = true;
		this.m.HideBeard = false;
		this.m.Variant = 511;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 7000;
		this.m.Condition = 260;
		this.m.ConditionMax = 260;
		this.m.StaminaModifier = -12;
		this.randomizeValues();
	}
	
	function getTooltip()
	{
		local result = this.named_helmet.getTooltip();
		result.push({
			id = 15,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Reduces the Resolve of any opponent engaged in melee by [color=" + this.Const.UI.Color.NegativeValue + "]-10[/color]"
		});
		return result;
	}

	function onUpdateProperties( _properties )
	{
		this.named_helmet.onUpdateProperties(_properties);
		_properties.Threat += 10;
	}
});

