this.legend_marked_target <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 2
	},
	function create()
	{
		this.m.ID = "effects.legend_marked_target";
		this.m.Name = "Marked target";
		this.m.Description = "This character is a marked target, leaving them vulnerable and exposed."
		this.m.Icon = "skills/MarkTargetSkill.png";
		this.m.IconMini = "mini_mark_target";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
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
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10[/color] Melee Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10[/color] Ranged Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + getBonus() + "%[/color] Damage Received from all sources"
			}
		];
	}

	function getBonus()
	{
		return 1.0 + this.Math.min(0.2 , this.getContainer().getHitpointsMax());
	}

	function onUpdate( _properties )
	{
		_properties.RangedDefense -= 10;
		_properties.MeleeDefense -= 10;
		_properties.DamageReceivedTotalMult *= getBonus() * 0.01;
	}


	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

});
