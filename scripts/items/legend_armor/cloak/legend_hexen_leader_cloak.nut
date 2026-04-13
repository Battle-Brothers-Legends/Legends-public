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
		this.m.Description = "An elegant cloak made of gossamer and powerful witch's hair shielding the wearer's mind against adversity and foul magic alike.";
		this.m.ArmorDescription = "Includes an elegant cloak.";
		this.m.Variants = [1, 2, 3, 4, 5];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Value = 7500;
		this.m.Condition = 25;
		this.m.ConditionMax = 25;
		this.m.StaminaModifier = -2;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "cloak_hexe_" + variant + "";
		this.m.SpriteDamagedBack = "cloak_hexe_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "cloak_hexe_" + variant + "_dead";
		this.m.Icon = "legend_armor/icon_cloak_hexe_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "legend_armor/icon_cloak_hexe_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_cloak_hexe_"  + variant + ".png";
	}

	function getTooltip()
	{
		local result = this.legend_armor_cloak.getTooltip();
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Increases resolve by [color=%positive%]+10%[/color] and provides [color=%positive%]+40[/color] resolve at morale checks against fear, panic or mind control effects"
		});
		return result;
	}

	function onArmorTooltip( _result )
	{
		_result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Increases resolve by [color=%positive%]+10%[/color] and provides [color=%positive%]+40[/color] resolve at morale checks against fear, panic or mind control effects"
		});
	}

	function onUpdateProperties( _properties )
	{
		this.legend_armor_cloak.onUpdateProperties(_properties);
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
	// 		text = "Grants the perk [color=%positive%]Fortified Mind[/color] to its user while equipped"
	// 	});
	// 	return result;
	// }

	// function onArmorTooltip( _result )
	// {
	// 	_result.push({
	// 		id = 7,
	// 		type = "text",
	// 		icon = "ui/icons/special.png",
	// 		text = "Grants the perk [color=%positive%]Fortified Mind[/color] to its user while equipped"
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

