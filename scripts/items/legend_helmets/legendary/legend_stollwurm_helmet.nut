this.legend_stollwurm_helmet <- this.inherit("scripts/items/helmets/named/named_helmet", {
	m = {},
	function create()
	{
		this.named_helmet.create();
		this.m.ID = "armor.head.legend_stollwurm_helmet";
		this.m.Name = "";
		this.m.Description = "A helmet made from the head of a stollwurm, grants immunity from being knocked or grabbed, immunity from morale penalties from being surrounded, and ensures you take no fatigue damage from being hit.";
		this.m.NameList = [
			"Wurms visage",
			"Helm of the wurm",
			"Wurm Crown",
			"Wurm Helm",
			"Digging Crown",
			"Burrowers Crown"
		];
		this.m.ShowOnCharacter = true;
		this.m.HideHair = true;
		this.m.HideBeard = false;
		this.m.Variant = 514;
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 9000;
		this.m.Condition = 320;
		this.m.ConditionMax = 320;
		this.m.StaminaModifier = -16;
		this.m.Vision = -2;
		this.randomizeValues();
	}

	function getTooltip()
	{
		local result = this.named_helmet.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Immunity from Knockback and Grab"
		});
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Being surrounded no longer affects this character's defences at all"
		});
		result.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "No fatigue penalties from melee damage"
		});
		return result;
	}

	function onUpdateProperties( _properties )
	{
		this.named_helmet.onUpdateProperties(_properties);
		_properties.IsImmuneToKnockBackAndGrab = true;
		_properties.FatigueReceivedPerHitMult *= 0.01;
		_properties.IsImmuneToSurrounding = true;
	}

});

