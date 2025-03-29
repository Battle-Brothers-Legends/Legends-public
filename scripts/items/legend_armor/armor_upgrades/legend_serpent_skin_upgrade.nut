this.legend_serpent_skin_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_serpent_skin";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Serpent Skin Mantle";
		this.m.Description = "A mantle crafted from the thin and shimmering scales of desert serpents, especially resistant to heat and flames.";
		this.m.ArmorDescription = "A mantle of serpent skin has been attached to this armor, which makes it more resistant to heat and flames.";
		this.m.Icon = "armor_upgrades/upgrade_27.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_upgrade_27.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_upgrade_27.png";
		this.m.SpriteBack = "upgrade_27_back";
		this.m.SpriteDamagedBack = "upgrade_27_back_damaged";
		this.m.SpriteCorpseBack = "upgrade_27_back_dead";
		this.m.Value = 600;
		this.m.ConditionModifier = 20;
		this.m.Condition = 20;
		this.m.ConditionMax = 20;
		this.m.StaminaModifier = -3;
	}

	function getTooltip()
	{
		local result = this.legend_armor_upgrade.getTooltip();
		result.push({
			id = 15,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Reduces damage from fire and firearms by [color=" + this.Const.UI.Color.NegativeValue + "]33%[/color]"
		});
		return result;
	}

	function onArmorTooltip( _result )
	{
		_result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Reduces damage from fire and firearms by [color=" + this.Const.UI.Color.NegativeValue + "]33%[/color]"
		});
	}

	function onEquip()
	{
		this.legend_armor_upgrade.onEquip();
		local c = this.m.Armor.getContainer();

		if (c != null && c.getActor() != null && !c.getActor().isNull())
		{
			c.getActor().getSkills().add(this.new("scripts/skills/items/firearms_resistance_skill"));
		}
	}

	function onUnequip()
	{
		local c = this.m.Armor.getContainer();

		if (c != null && c.getActor() != null && !c.getActor().isNull())
		{
			c.getActor().getSkills().removeByID("items.firearms_resistance");
		}
		this.legend_armor_upgrade.onUnequip();
	}
});
