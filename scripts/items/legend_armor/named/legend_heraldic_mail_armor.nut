this.legend_heraldic_mail_armor <- this.inherit("scripts/items/legend_armor/legend_named_armor", {
	m = {},
	function create()
	{
		this.legend_named_armor.create();
		this.m.ID = "legend_armor.body.heraldic_mail";
		this.m.Description = "Truly fit for a knight, this mail hauberk is made from the highest quality materials and boasts precious decorations and ornaments.";
		this.m.NameList = [
			"Heraldic Mail",
			"Splendor",
			"Grandiosity",
			"Pageantry",
			"Swank",
			"Full Mail",
			"Mail Hauberk",
			"Chainmail",
			"Surcoat",
			"Duty",
			"Honor",
			"Noble Mail"
		];
		this.m.Variant = 36;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 7000;
		this.m.Condition = 210;
		this.m.ConditionMax = 210;
		this.m.StaminaModifier = -26;
		this.randomizeValues();
	}

});

