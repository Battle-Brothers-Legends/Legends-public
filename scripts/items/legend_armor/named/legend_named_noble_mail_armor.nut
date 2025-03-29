this.legend_named_noble_mail_armor <- this.inherit("scripts/items/legend_armor/legend_named_armor", {
	m = {},
	function create()
	{
		this.legend_named_armor.create();
		this.m.ID = "legend_armor.body.named_noble_mail_armor";
		this.m.Description = "This piece of light mail armor was once the personal item of a well known fencing master. It is as light as a tunic, but protects all vital body parts.";
		this.m.NameList = [
			"Reinforced Mail",
			"Nightcloak",
			"Noble Mail",
			"Fencing Mail"
		];
		this.m.Variant = 99;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 5500;
		this.m.Condition = 160;
		this.m.ConditionMax = 160;
		this.m.StaminaModifier = -15;
		this.randomizeValues();
	}

});

