this.legend_robes_wizard <- this.inherit("scripts/items/legend_armor/cloth/legend_robes", {
	m = {},
	function create()
	{
		this.legend_robes.create();
		this.m.ID = "legend.armor.body.wizard_robe";
		this.m.Name = "Wizard\'s Robe";
		this.m.Description = "A cloth robe coverd in all kinds of mystical ornaments and symbols.";
		this.m.Variant = 3;
		this.updateVariant();
		this.m.Value = 500;
		this.m.Condition = 20;
		this.m.ConditionMax = 20;
		this.m.StaminaModifier = 2;
	}

});

