this.legend_hexen_leader_cloak <- this.inherit("scripts/items/legend_armor/legend_armor_cloak", {
	m = {
		IDKeyword = "HexenCloak"
	},
	function create()
	{
		this.legend_armor_cloak.create();
		this.m.ID = "legend_armor.body.legend_hexe_leader_cloak";
		this.m.Type = this.Const.Items.ArmorUpgrades.Cloak;
		this.m.Name = "Hexen Leader Silk Cloak";
		this.m.Description = "This elegant cloak is made from spider web that bolsters its users resolve";
		this.m.ArmorDescription = "A Hexen cloak able to increase its users resolve";
		this.m.Icon = "armor_upgrades/upgrade_cloak_purple.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_upgrade_cloak_purple.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_upgrade_cloak_purple.png";
		this.m.SpriteFront = null;
		this.m.SpriteBack = "cloak_purple";
		this.m.SpriteDamagedFront = null;
		this.m.SpriteDamagedBack = "cloak_purple_damaged";
		this.m.SpriteCorpseFront = null;
		this.m.SpriteCorpseBack = "cloak_purple_dead";

		this.m.Value = 7500;
		this.m.Condition = 25;
		this.m.ConditionMax = 25;
		this.m.StaminaModifier = -2;
	}

	function getTooltip()
	{
		local result = this.armor_upgrade.getTooltip();
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Increases resolve by [color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] and provides [color=" + this.Const.UI.Color.PositiveValue + "]+40[/color] resolve at morale checks against fear, panic or mind control effects"
		});
		return result;
	}

	function onArmorTooltip( _result )
	{
		_result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Increases resolve by [color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] and provides [color=" + this.Const.UI.Color.PositiveValue + "]+40[/color] resolve at morale checks against fear, panic or mind control effects"
		});
	}

	function onUpdateProperties( _properties )
	{
		this.armor_upgrade.onUpdateProperties(_properties);
		_properties.MoraleCheckBravery[1] += 40;
		_properties.BraveryMult *= 1.10;
	}
		//Old. Should reuse this code somewhere. - Luft.
	// function getTooltip()
	// {
	// 	local result = this.legend_armor_cloak.getTooltip();
	// 	result.push({
	// 		id = 7,
	// 		type = "text",
	// 		icon = "ui/icons/special.png",
	// 		text = "Grants the perk [color=" + this.Const.UI.Color.PositiveValue + "]Fortified Mind[/color] to its user while equipped"
	// 	});
	// 	return result;
	// }

	// function onArmorTooltip( _result )
	// {
	// 	_result.push({
	// 		id = 7,
	// 		type = "text",
	// 		icon = "ui/icons/special.png",
	// 		text = "Grants the perk [color=" + this.Const.UI.Color.PositiveValue + "]Fortified Mind[/color] to its user while equipped"
	// 	});
	// }

	// function onEquip()
	// {
	// 	this.legend_armor_cloak.onEquip();

	// 	local container = this.m.Armor.getContainer();
	// 	if (container != null && container.getActor() != null && !container.getActor().isNull())
	// 	{
	// 		if (container.getActor().getSkills().hasSkill("perk.fortified_mind")) return;
	// 		local fortifiedMindPerk = this.new("scripts/skills/perks/perk_fortified_mind");
	// 		fortifiedMindPerk.m.ID += this.m.IDKeyword;
	// 		container.getActor().getSkills().add(fortifiedMindPerk);
	// 	}
	// }

	// function onUnequip()
	// {
	// 	this.legend_armor_cloak.onUnequip();

	// 	local container = this.m.Armor.getContainer();
	// 	if (container != null && container.getActor() != null && !container.getActor().isNull())
	// 	{
	// 		container.getActor().getSkills().removeByID("perk.fortified_mind" + this.m.IDKeyword);
	// 	}
	// }

	// function updateVariant()	// Needs to overwrite the base function which would otherwise overwrite Icon and Graphic of this Cloak
	// {
	// }
});

