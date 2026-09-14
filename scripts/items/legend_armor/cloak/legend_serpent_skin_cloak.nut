this.legend_serpent_skin_cloak <- this.inherit("scripts/items/legend_armor/legend_armor_cloak", {
	m = {},
	function create()
	{
		this.legend_armor_cloak.create();
		this.m.ID = "legend_armor.body.serpent_skin";
		this.m.Type = this.Const.Items.ArmorUpgrades.Cloak;
		this.m.Name = "Serpent Skin Mantle";
		this.m.Description = "A mantle crafted from the thin and shimmering scales of desert serpents, especially resistant to heat and flames.";
		this.m.ArmorDescription = "Includes a mantle of serpent skin.";
		this.m.Variants = [1];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 800;
		this.m.Condition = 25;
		this.m.ConditionMax = 25;
		this.m.StaminaModifier = -2;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "cloak_serpent_" + variant + "";
		this.m.SpriteDamagedBack = "cloak_serpent_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "cloak_serpent_" + variant + "_dead";
		this.m.Icon = "legend_armor/icon_cloak_serpent_" + variant + ".png";
		this.m.IconLarge = "legend_armor/inventory_cloak_serpent_"  + variant + ".png";
		this.m.OverlayIcon = "legend_armor/icon_cloak_serpent_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_cloak_serpent_"  + variant + ".png";
	}

	function getTooltip()
	{
		local result = this.legend_armor_cloak.getTooltip();
		result.push({
			id = 15,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Reduces damage from fire and firearms by [color=%negative%]-33%[/color]"
		});
		return result;
	}

	function onArmorTooltip( _result )
	{
		_result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Reduces damage from fire and firearms by [color=%negative%]-33%[/color]"
		});
	}

	function onEquip()
	{
		this.legend_armor_cloak.onEquip();
		local c = this.m.Armor.getContainer();

		if (c != null && c.getActor() != null && !c.getActor().isNull())
		{
			c.getActor().getSkills().add(this.new("scripts/skills/items/firearms_resistance_skill"));
		}
	}

	function onUnequip()
	{
		this.legend_armor_cloak.onUnequip();
		local c = this.m.Armor.getContainer();

		if (c != null && c.getActor() != null && !c.getActor().isNull())
		{
			c.getActor().getSkills().removeByID("items.firearms_resistance");
		}
	}
});