this.legend_stollwurm_blood_effect <- this.inherit("scripts/skills/skill", {
	m = {
	TurnsLeft = 3
	},
	function create()
	{
		this.m.ID = "effects.legend_stollwurm_blood";
		this.m.Name = "Stollwurm vigour";
		this.m.Icon = "ui/perks/perk_30.png";
		this.m.IconMini = "perk_30_mini";
		this.m.Overlay = "perk_30";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character has gathered all their physical strength and willpower to become indomitable.";
	}

	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Only receive [color=" + this.Const.UI.Color.PositiveValue + "]50%[/color] of any damage"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Immune to being stunned"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Immune to being knocked back or grabbed"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.DamageReceivedTotalMult *= 0.5;
		_properties.IsImmuneToStun = true;
		_properties.IsImmuneToKnockBackAndGrab = true;
		_properties.TargetAttractionMult *= 0.5;
	}

	function onTurnEnd()
	{

		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

});

