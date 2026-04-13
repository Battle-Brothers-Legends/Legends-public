this.legend_burned_injury <- this.inherit("scripts/skills/injury_permanent/permanent_injury", {
	m = {},
	function create()
	{
		this.permanent_injury.create();
		this.m.ID = "injury.legend_burned_injury";
		this.m.Name = "Burned";
		this.m.Description = "Horribly burned and disfigured. Got too close to the fire. Defense and Attack skills all reduced by 10%, but the sight of it strikes fear into all enemies";
		this.m.Icon = "ui/injury/injury_burned.png";
	}

	function getTooltip()
	{
		local ret = [
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
				id = 7,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=%negative%]-10%[/color] Melee Skill"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=%negative%]-10%[/color] Ranged Skill"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=%negative%]-10%[/color] Melee Defense"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=%negative%]-10%[/color] Ranged Defense"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "[color=%negative%]-1[/color] Vision"
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Reduces the Resolve of any opponent engaged in melee by [color=%negative%]-10[/color]"
			}
		];
		this.addTooltipHint(ret);
		return ret;
	}

	function onUpdate( _properties )
	{

		_properties.MeleeSkillMult *= 0.90;
		_properties.RangedSkillMult *= 0.90;
		_properties.MeleeDefenseMult *= 0.90;
		_properties.RangedDefenseMult *= 0.90;
		_properties.Vision -= 1;
		_properties.Threat += 10;
	}

	function onApplyAppearance()
	{
		local sprite = this.getContainer().getActor().getSprite("permanent_injury_burned");
		if (this.getContainer().getActor().getEthnicity() == 1)
		{
			sprite.setBrush("permanent_injury_burned_southern");
		}
		else if (this.getContainer().getActor().getEthnicity() == 2)
		{
			sprite.setBrush("permanent_injury_burned_african");
		}
		else
		{
			sprite.setBrush("permanent_injury_burned");
		}

		sprite.Visible = true;
	}

});

