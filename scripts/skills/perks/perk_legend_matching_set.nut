this.perk_legend_matching_set <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_matching_set";
		this.m.Name = this.Const.Strings.PerkName.LegendMatchingSet;
		this.m.Description = this.Const.Strings.PerkDescription.LegendMatchingSet;
		this.m.Icon = "ui/perks/matching_set.png";
		this.m.IconDisabled = "ui/perks/matching_set_bw.png"
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getDescription()
	{
		return "Balanced as scales, this character can shift the weight of armor to equally distribute the load, granting fatigue recovery.";
	}

	function getTooltip()
	{
		local actor = this.getContainer().getActor();
		local body = actor.getArmorMax(this.Const.BodyPart.Body);
		local head = actor.getArmorMax(this.Const.BodyPart.Head);

		local bonus = 0;
		if ((body + head) <= 350 )
		{
		local diff = this.Math.abs(body - head);
		local diffadj = diff / 10;
		local bonus = this.Math.max(1, (5 - diffadj));
		}

		if (bonus > 0)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Gain [color=" + this.Const.UI.Color.PositiveValue + "]" + bonus + "[/color] fatigue each turn"
			});
		}
		else
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]This character\'s body and head armor are too different to benefit from matching set[/color]"
			});
		}

		return tooltip;
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		local body = actor.getArmorMax(this.Const.BodyPart.Body);
		local head = actor.getArmorMax(this.Const.BodyPart.Head);

		if ((body + head) <= 350 )
		{
		local diff = this.Math.abs(body - head);
		local diffadj = diff / 10;
		local bonus = this.Math.max(1, (5 - diffadj));
		_properties.FatigueRecoveryRate += bonus;
		}
	}

});

