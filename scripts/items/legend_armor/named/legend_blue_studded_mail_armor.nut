this.legend_blue_studded_mail_armor <- this.inherit("scripts/items/legend_armor/legend_named_armor", {
	m = {},
	function create()
	{
		this.legend_named_armor.create();
		this.m.ID = "legend_armor.body.blue_studded_mail";
		this.m.Description = "This particular mail shirt is combined with a gambeson and covered with a sturdy, riveted leather jacket for a light yet protective armor.";
		this.m.NameList = [
			"Padded Mail",
			"Toadskin",
			"Ogreskin",
			"Layered Armor",
			"Reinforced Mail"
		];
		this.m.Variant = 46;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 4000;
		this.m.Condition = 150;
		this.m.ConditionMax = 150;
		this.m.StaminaModifier = -18;
		this.randomizeValues();
	}

});

