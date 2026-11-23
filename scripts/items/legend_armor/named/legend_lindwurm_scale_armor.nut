this.legend_lindwurm_scale_armor <- this.inherit("scripts/items/legend_armor/legend_named_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_named_armor_upgrade.create();
		this.m.ID = "legend_armor.body.legend_lindwurm_scale_armor";
		this.m.Type = this.Const.Items.ArmorUpgrades.Plate;
		this.m.Name = "";		
		this.m.Description = "A masterwork leather armor made from overlapping lindwurm scales. Not only do the scales deflect blows and hits, but they also remain unscathed by the acidic Lindwurm blood.";
		this.m.ArmorDescription = "Includes a masterwork leather armor made from overlapping lindwurm scales. Not only do the scales deflect blows and hits, but they also remain unscathed by the acidic Lindwurm blood.";
		this.m.Variants = [1];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 3000;
		this.m.Condition = 60;
		this.m.ConditionMax = 60;
		this.m.StaminaModifier = -6;
		this.randomizeValues();
		this.resetStats();
		this.m.NameList = ["Wild Scale", "Wurm Skin", "Dragon Cloak", "Snakeskin", "Wyvern Scale", "Drakenguard"];
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "wild_scale_" + variant;
		this.m.SpriteDamagedBack = "wild_scale_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "wild_scale_" + variant + "_dead";
		this.m.Icon = "legend_armor/icon_wild_scale_" + variant + ".png";
		this.m.IconLarge = "legend_armor/inventory_wild_scale_" + variant + ".png";
		this.m.OverlayIcon = "legend_armor/icon_wild_scale_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_wild_scale_" + variant + ".png";
	}

	function resetStats()
	{
		this.m.Condition = 60;
		this.m.ConditionMax = 60;
		this.m.StaminaModifier = -6;
	}

	function getTooltip()
	{
		local result = this.legend_named_armor_upgrade.getTooltip();
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
		this.legend_named_armor_upgrade.onEquip();
		local c = this.m.Armor.getContainer();

		if (c != null && c.getActor() != null && !c.getActor().isNull())
		{
			c.getActor().getFlags().add("body_immune_to_acid");
		}
	}

	function onUnequip()
	{
		local c = this.m.Armor.getContainer();

		if (c != null && c.getActor() != null && !c.getActor().isNull())
		{
			c.getActor().getFlags().remove("body_immune_to_acid");
		}
		this.legend_named_armor_upgrade.onUnequip();
	}
});
