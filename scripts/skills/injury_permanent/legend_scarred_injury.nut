this.legend_scarred_injury <- this.inherit("scripts/skills/injury_permanent/permanent_injury", {
	m = {},
	function create()
	{
		this.permanent_injury.create();
		this.m.ID = "injury.legend_scarred_injury";
		this.m.Name = "Scarred";
		this.m.Description = "A blade to the face. Scarred and battle hardened";
		this.m.Icon = "ui/injury/injury_scarred.png";
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
				icon = "ui/icons/health.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color] Hitpoints"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color] Max Fatigue"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]75%[/color] chance to survive if struck down and not killed by a fatality"
			}
		];
		this.addTooltipHint(ret);
		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.SurviveWithInjuryChanceMult *= 2.27;
		_properties.HitpointsMult *= 0.90;
		_properties.StaminaMult *= 0.90;
	}

	function onApplyAppearance()
	{
		local sprite = this.getContainer().getActor().getSprite("permanent_injury_scarred");
		if (this.getContainer().getActor().getEthnicity() == 1)
		{
			sprite.setBrush("permanent_injury_scarred_southern");
		}
		else
		{
			sprite.setBrush("permanent_injury_scarred");
		}

		sprite.Visible = true;
	}

});

