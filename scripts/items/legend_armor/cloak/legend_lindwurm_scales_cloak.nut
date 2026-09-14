this.legend_lindwurm_scales_cloak <- this.inherit("scripts/items/legend_armor/legend_armor_cloak", {
	m = {},
	function create()
	{
		this.legend_armor_cloak.create();
		this.m.ID = "legend_armor.body.lindwurm_scales";
		this.m.Type = this.Const.Items.ArmorUpgrades.Cloak;
		this.m.Name = "Lindwurm Scale Cloak";
		this.m.Description = "A cloak made out of the scales of a Lindwurm. Not only is it a rare and impressive trophy, it also offers additional protection and is untouchable by corroding Lindwurm blood.";
		this.m.ArmorDescription = "Includes a cloak made out of Lindwurm scales.";
		this.m.Variants = [1];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 1800;
		this.m.Condition = 25;
		this.m.ConditionMax = 25;
		this.m.StaminaModifier = -2;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "cloak_lindwurm_" + variant + "";
		this.m.SpriteDamagedBack = "cloak_lindwurm_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "cloak_lindwurm_" + variant + "_dead";
		this.m.Icon = "legend_armor/icon_cloak_lindwurm_" + variant + ".png";
		this.m.IconLarge = "legend_armor/inventory_cloak_lindwurm_"  + variant + ".png";
		this.m.OverlayIcon = "legend_armor/icon_cloak_lindwurm_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_cloak_lindwurm_"  + variant + ".png";
	}


	function getTooltip()
	{
		local result = this.legend_armor_cloak.getTooltip();
		result.push({
			id = 15,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Unaffected by acidic Lindwurm blood"
		});
		return result;
	}

	function onArmorTooltip( _result )
	{
		_result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Unaffected by acidic Lindwurm blood"
		});
	}

	function onEquip()
	{
		this.legend_armor_upgrade.onEquip();
		local c = this.m.Armor.getContainer();

		if (c != null && c.getActor() != null && !c.getActor().isNull())
		{
			c.getActor().getFlags().add("body_immune_to_acid");
		}
	}

	function onUnequip()
	{
		this.legend_armor_upgrade.onUnequip();
		local c = this.m.Armor.getContainer();

		if (c != null && c.getActor() != null && !c.getActor().isNull())
		{
			c.getActor().getFlags().remove("body_immune_to_acid");
		}
	}
});