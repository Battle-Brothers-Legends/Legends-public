this.legend_skin_helmet <- this.inherit("scripts/items/helmets/named/named_helmet", {
	m = {},
	function create()
	{
		this.named_helmet.create();
		this.m.ID = "armor.head.legend_skin_helmet";
		this.m.Description = "A helmet made from the face of a skin ghoul, grants the ability to feast on corpses";
		this.m.Name = "";
		this.m.NameList = [
			"Rotten visage",
			"Helm of the ghoul",
			"Ghoul Crown",
			"Ghoul Helm",
			"Ghoul Crown",
			"Skin Crown"
		];
		this.m.ShowOnCharacter = true;
		this.m.HideHair = true;
		this.m.HideBeard = false;
		this.m.Variant = 515;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 9000;
		this.m.Condition = 160;
		this.m.ConditionMax = 160;
		this.m.StaminaModifier = -6;
		this.m.Vision = -1;
		this.randomizeValues();
	}

	function getTooltip()
	{
		local result = this.named_helmet.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Grants gruesome feast"
		});
		return result;
	}

	function onEquip()
	{
		this.named_helmet.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendGruesomeFeast);
	}

});

