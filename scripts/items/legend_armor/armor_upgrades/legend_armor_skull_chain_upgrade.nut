this.legend_armor_skull_chain_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.body.legend_armor_skull_chain";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Skull Chain";
		this.m.Description = "The skull of a dead man hangs from this heavy chain. It serves as a reminder of the intended outcome.";
		this.m.ArmorDescription = "The skull of a dead man hangs from this armor on a heavy chain, a grizzly trophy";
		this.m.Icon = "armor_upgrades/upgrade_skull_and_chain_01.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_upgrade_skull_and_chain_01.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_upgrade_skull_and_chain_01.png";
		this.m.SpriteBack = "upgrade_skull_and_chain";
		this.m.SpriteDamagedBack = "upgrade_skull_and_chain_damaged";
		this.m.SpriteCorpseBack = "upgrade_skull_and_chain_dead";

		this.m.Value = 150;
		this.m.Condition = 10;
		this.m.ConditionMax = 10;
		this.m.StaminaModifier = -2;
	}
	function getTooltip()
	{
	
		local result = this.legend_armor_upgrade.getTooltip();
		result.push({
			id = 10,
			type = "text",
			icon = "ui/icons/chance_to_hit_head.png",
			text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]+5%[/color] Chance To Hit Head"
		});
		result.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Builds up [color=" + this.Const.UI.Color.NegativeValue + "]1[/color] more fatigue for each tile travelled"
		});
		return result;
	}	
	function onUpdateProperties( _properties )
	{
		this.legend_armor_upgrade.onUpdateProperties(_properties);
		_properties.HitChance[this.Const.BodyPart.Head] += 5;
		_properties.MovementFatigueCostAdditional += 1;
	}
});

