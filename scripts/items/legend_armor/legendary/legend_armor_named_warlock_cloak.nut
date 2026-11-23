this.legend_armor_named_warlock_cloak <- this.inherit("scripts/items/legend_armor/legend_named_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_named_armor_upgrade.create();
		this.m.ID = "legend_armor.body.legend_named_warlock_cloak";
		this.m.Type = this.Const.Items.ArmorUpgrades.Cloak;
		this.m.Name = "";
		this.m.Description = "A cloak made from the skin of dead men and dark magic. This wretched garment pulses with a cold, malevolent life of its own, serving as both a horrific trophy and a conduit for the forbidden arts.";
		this.m.ArmorDescription = "Includes a cloak made from the skin of dead men and dark magic.";
		this.m.Variants = [1, 2, 3, 4, 5];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Value = 5000;
		this.resetStats();
		this.randomizeValues();
		this.m.NameList = ["Dead Man\'s Skin","Necromancer\'s Robe","Seance\'s Skin","Warlock\'s Cloak","Deathcloak","Sorceror\'s Cloak"];
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "cloak_cursed_" + variant + "";
		this.m.SpriteDamagedBack = "cloak_cursed_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "cloak_cursed_" + variant + "_dead";
		this.m.Icon = "legend_armor/icon_cloak_cursed_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_cloak_cursed_"  + variant + ".png";
		this.m.OverlayIcon = "legend_armor/icon_cloak_cursed_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_cloak_cursed_"  + variant + ".png";
	}

	function resetStats() {
		this.m.Condition = 30;
		this.m.ConditionMax = 30;
		this.m.StaminaModifier = -2;
	}

	function getTooltip()
	{
		local result = this.legend_named_armor_upgrade.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Grants [color=%positive%] +10%[/color] Melee skill when at confident morale."
		});
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Grants [color=%positive%] +10%[/color] Melee defense when at confident morale."
		});
		result.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Grants [color=%positive%] +10%[/color] Ranged defense when at confident morale."
		});
		result.push({
			id = 9,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Increase max hitpoints by [color=%positive%] +20[/color]."
		});
		return result;
	}

	function onUpdateProperties( _properties )
	{
		this.legend_named_armor_upgrade.onUpdateProperties(_properties);
		_properties.Hitpoints += 20;

		if (this.getContainer().getActor().getMoraleState() == this.Const.MoraleState.Confident)
		{
			_properties.MeleeSkill *= 1.1;
			_properties.MeleeDefense *= 1.1;
			_properties.RangedDefense *= 1.1;
		}
	}
});
