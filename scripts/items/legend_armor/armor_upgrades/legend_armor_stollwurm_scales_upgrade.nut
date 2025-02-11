this.legend_armor_stollwurm_scales_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_armor_stollwurm_scales";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Stollwurm Scale Cloak";
		this.m.Description = "A cloak made out of the scales of a Stollwurm. Not only is it a rare and impressive trophy, it also offers additional protection";
		this.m.ArmorDescription = "A cloak made out of Stollwurm scales is worn over this armor for additional protection.";
		this.m.Variants = [1, 2];
		this.m.Variant = 1;
		this.m.Value = 6000;
		this.m.Condition = 40;
		this.m.ConditionMax = 40;
		this.m.ConditionModifier = 40;
		this.m.StaminaModifier = -2;
		this.updateVariant();
	}

	function updateVariant() {
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Icon = "armor_upgrades/icon_upgrade_stollwurm_" + variant + ".png";
		this.m.IconLarge = "legend_armor/upgrades/inventory_upgrade_stollwurm_" + variant + ".png";
		this.m.OverlayIcon = "armor_upgrades/icon_upgrade_stollwurm_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/upgrades/inventory_upgrade_stollwurm_" + variant + ".png";
		this.m.SpriteFront = null;
		this.m.SpriteBack = "upgrade_stollwurm_back_" + variant;
		this.m.SpriteDamagedFront = null;
		this.m.SpriteDamagedBack = "upgrade_stollwurm_back_" + variant + "_damaged";
		this.m.SpriteCorpseFront = null;
		this.m.SpriteCorpseBack = "upgrade_stollwurm_back_" + variant + "_dead";
	}

	function getTooltip()
	{
		local result = this.legend_armor_upgrade.getTooltip();
		result.push({
			id = 15,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Immune to stun, knockback and grab, and acid"
		});
		return result;
	}

	function onArmorTooltip( _result )
	{
		_result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Immune to stun, knockback and grab, and acid"
		});
	}

	function onUpdateProperties( _properties )
	{
		this.legend_armor_upgrade.onUpdateProperties(_properties);
		_properties.IsImmuneToStun = true;
		_properties.IsImmuneToKnockBackAndGrab = true;
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
		local c = this.m.Armor.getContainer();

		if (c != null && c.getActor() != null && !c.getActor().isNull())
		{
			c.getActor().getFlags().remove("body_immune_to_acid");
		}
		this.legend_armor_upgrade.onUnequip();
	}
});
