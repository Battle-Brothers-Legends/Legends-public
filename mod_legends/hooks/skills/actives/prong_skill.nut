::mods_hookExactClass("skills/actives/prong_skill", function(o)
{
	local getTooltip = o.getTooltip;
	o.getTooltip = function ()
	{
		local tooltip = this.getDefaultTooltip();

		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of [color=" + this.Const.UI.Color.PositiveValue + "]2[/color] tiles"
		});
		if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInSpears)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=" + this.Const.UI.Color.NegativeValue + "]-15%[/color] chance to hit targets directly adjacent because the weapon is too unwieldy"
			});
		}
		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInSpearThrust)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]+15%[/color] damage due to thrust specialisation"
			});
		}

		return tooltip;
	}

	local onAnySkillUsed = o.onAnySkillUsed;
	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		onAnySkillUsed( _skill, _targetEntity, _properties );
		if (_skill == this)
		{
			if (_properties.IsSpecializedInSpearThrust)
			{
				_properties.DamageTotalMult *= 1.15;
			}

			_properties.MeleeSkill += 10;

			if (_targetEntity != null && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInPolearms && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1)
			{
				_properties.MeleeSkill += -15;
				this.m.HitChanceBonus += -5;
			}
		}
	}
});
