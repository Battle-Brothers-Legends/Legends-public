this.legend_named_warlock_cloak <- this.inherit("scripts/items/armor/named/named_armor", {
	m = {},
	function create()
	{
		this.named_armor.create();
		this.m.ID = "armor.body.legend_named_warlock_cloak";
		this.m.Description = "A cloak made from the skin of dead men and dark magic. +10% melee skill and defense when at confident morale. Also grants +20 hitpoints";
		this.m.Name = "Warlock cloak"
		this.m.NameList = [
			"Dead Man\'s Skin",
			"Necromancer\'s Robe",
			"Seance\'s Skin",
			"Warlock\'s Cloak",
			"Deathcloak",
			"Sorceror\'s Hood"
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
			text = "Grants [color=" + this.Const.UI.Color.PositiveEventValue + "] +10%[/color] Melee skill when at confident morale."
		});
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Grants [color=" + this.Const.UI.Color.PositiveEventValue + "] +10%[/color] Melee defense when at confident morale."
		});
		result.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Grants [color=" + this.Const.UI.Color.PositiveEventValue + "] +10%[/color] Ranged defense when at confident morale."
		});
		result.push({
			id = 9,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Increase max hitpoints by [color=" + this.Const.UI.Color.PositiveEventValue + "] +20[/color]."
		});
		return result;
	}

	function onEquip()
	{
		this.named_armor.onEquip();
		local a = this.getContainer().getActor();
		if (a == null)
		{
			return;
		}
		
		local b = a.getBaseProperties();
		b.Hitpoints += 20;
		if (!a.getSkills().hasSkill("perk.legend_assured_conquest"))
		{
			a.getSkills().add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));
		}
	}

	function onUnequip()
	{
		local a = this.getContainer().getActor();
		if (a == null)
		{
			return;
			
		}
		a.getSkills().removeByID("perk.legend_assured_conquest");
		local b = a.getBaseProperties();
		b.Hitpoints -= 20;
		this.named_armor.onUnequip();
	}

});

