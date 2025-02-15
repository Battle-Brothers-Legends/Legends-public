this.legend_stollwurm_hauberk <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_named_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.Chain;
		this.m.ID = "legend_armor.body.legend_stollwurm_hauberk";
		this.m.Name = "";
        this.m.NameList = ["Heraldic Mail", "Splendor", "Grandiosity", "Pageantry", "Swank", "Full Mail", "Mail Hauberk", "Chainmail", "Surcoat", "Duty", "Honor", "Noble Mail", ];
		this.m.Description = ".";
		this.m.SlotType = this.Const.ItemSlot.Body;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 10000;
		this.m.Condition = 120;
		this.m.ConditionMax = 120;
		this.m.StaminaModifier = -15;
        this.m.ItemType = this.m.ItemType;
        this.randomizeValues();
	}

	function getTooltip()
	{
		local result = this.legend_armor_cloak.getTooltip();
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
		this.legend_armor_cloak.onUpdateProperties(_properties);
		_properties.IsImmuneToStun = true;
		_properties.IsImmuneToKnockBackAndGrab = true;
	}

	function onEquip()
	{
		this.legend_armor_cloak.onEquip();
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

