this.legend_named_warlock_cloak <- this.inherit("scripts/items/armor/named/named_armor", {
	m = {},
	function create()
	{
		this.named_armor.create();
		this.m.ID = "armor.body.legend_named_warlock_cloak";
		this.m.Description = "A cloak made from the skin of dead men and dark magic.";
		this.m.Name = "Warlock cloak";
		this.m.NameList = [
			"Dead Man\'s Skin",
			"Necromancer\'s Robe",
			"Seance\'s Skin",
			"Warlock\'s Cloak",
			"Deathcloak",
			"Sorceror\'s Cloak"
		];
		this.m.Variant = 508;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Value = 5000;
		this.m.Condition = 180;
		this.m.ConditionMax = 180;
		this.m.StaminaModifier = 8;
		this.randomizeValues();
	}


	function getTooltip()
	{
		local result = this.named_armor.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Grants [color=" + this.Const.UI.Color.PositiveValue + "] +10%[/color] Melee skill when at confident morale."
		});
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Grants [color=" + this.Const.UI.Color.PositiveValue + "] +10%[/color] Melee defense when at confident morale."
		});
		result.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Grants [color=" + this.Const.UI.Color.PositiveValue + "] +10%[/color] Ranged defense when at confident morale."
		});
		result.push({
			id = 9,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Increase max hitpoints by [color=" + this.Const.UI.Color.PositiveValue + "] +20[/color]."
		});
		return result;
	}

	function onUpdateProperties( _properties )
	{
		this.named_armor.onUpdateProperties(_properties);
		_properties.Hitpoints += 20;

		if (this.getContainer().getActor().getMoraleState() == this.Const.MoraleState.Confident)
		{
			_properties.MeleeSkill *= 1.1;
			_properties.MeleeDefense *= 1.1;
			_properties.RangedDefense *= 1.1;
		}
	}
});
