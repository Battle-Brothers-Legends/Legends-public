this.legend_lindwurm_armor <- this.inherit("scripts/items/legend_armor/legend_named_armor", {
	m = {},
	function create()
	{
		this.legend_named_armor.create();
		this.m.ID = "legend_armor.body.lindwurm_armor";
		this.m.Description = "The sturdy scales of a fierce Lindwurm sewn together ontop a heavy chainmail. Not only is it a trophy to a great hunter, but it also deflects the fiercest of blows, and the shimmering scales remain untouched by any corroding Lindwurm blood.";
		this.m.Name = "";
		this.m.NameList = [
			"Lindwurm Scales",
			"Dragon\'s Hide",
			"Lizard\'s Coat",
			"Lindwurm Harness",
			"Lindwurm Coat",
			"Wurmscales",
			"Coat of the Lindwurm"
		];
		this.m.Variant = 82;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 7500;
		this.randomizeValues();
		this.resetStats();
	}

	function resetStats()
	{
		this.m.Condition = 300;
		this.m.ConditionMax = 300;
		this.m.StaminaModifier = -36;
	}

	function getTooltip()
	{
		local result = this.legend_armor.getTooltip(); // For some reason this was using the formula for unlayered armor
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Unaffected by acidic Lindwurm blood"
		});
		return result;
	}

	function onEquip()
	{
		this.legend_named_armor.onEquip();
		local c = this.getContainer();

		if (c != null && c.getActor() != null && !c.getActor().isNull())
		{
			c.getActor().getFlags().add("body_immune_to_acid");
		}
	}

	function onUnequip()
	{
		local c = this.getContainer();

		if (c != null && c.getActor() != null && !c.getActor().isNull())
		{
			c.getActor().getFlags().remove("body_immune_to_acid");
		}

		this.armor.onUnequip();
	}

});

