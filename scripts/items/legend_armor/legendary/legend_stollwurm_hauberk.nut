this.legend_stollwurm_hauberk <- this.inherit("scripts/items/legend_armor/legend_named_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_named_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.Chain;
		this.m.ID = "legend_armor.body.legend_stollwurm_hauberk";
		this.m.Name = "";
        this.m.NameList = ["Heraldic Scale", "Splendor", "Grandiosity", "Pageantry", "Swank", "Full Scale", "Scale Hauberk", "Scalemail", "Surcoat", "Duty", "Honor", "Noble Scale"];
		this.m.Description = "An exceptional hauberk made from the small, flexible scales of a Stollwurm. Incredibly sturdy, but still bendable enough to not impede movement more than a regular chain hauberk.";
		this.m.ArmorDescription = "Includes a stollwurm hauberk, boasting flexibility and sturdiness.";
		this.m.SlotType = this.Const.ItemSlot.Body;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 10000;
		this.m.Condition = 120;
		this.m.ConditionMax = 120;
		this.m.StaminaModifier = -15;
        this.m.ItemType = this.m.ItemType;
        this.randomizeValues();
	}

	function getTooltip()
	{
		local result = this.legend_named_armor_upgrade.getTooltip();
		result.push({
			id = 15,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Immune to stun, knockback, grab and acid"
		});
		return result;
	}

	function onArmorTooltip( _result )
	{
		_result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Immune to stun, knockback, grab and acid"
		});
	}

	function onUpdateProperties( _properties )
	{
		this.legend_named_armor_upgrade.onUpdateProperties(_properties);
		_properties.IsImmuneToStun = true;
		_properties.IsImmuneToKnockBackAndGrab = true;
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

	function updateVariant()
	{
		this.m.SpriteBack = "bust_wurm_hauberk_01";
		this.m.SpriteDamagedBack = "bust_wurm_hauberk_01_damaged";
		this.m.SpriteCorpseBack = "bust_wurm_hauberk_01_dead";
		this.m.Icon = "legend_armor/icon_wurm_hauberk_01.png";
		this.m.IconLarge = "legend_armor/inventory_wurm_hauberk_01.png";
		this.m.OverlayIcon = "legend_armor/icon_wurm_hauberk_01.png";
		this.m.OverlayIconLarge = "legend_armor/inventory_wurm_hauberk_01.png";
	}

});
