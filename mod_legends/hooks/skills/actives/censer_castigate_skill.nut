::mods_hookExactClass("skills/actives/censer_castigate_skill", function(o)
{
	o.getTooltip = function()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Can hit up to 3 targets"
		});
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of [color=" + this.Const.UI.Color.PositiveValue + "]2" + "[/color] tiles"
		});

		if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInFlails)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=" + this.Const.UI.Color.NegativeValue + "]-15%[/color] chance to hit targets directly adjacent because the weapon is too unwieldy"
			});
		}

		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Leaves a cloud of miasma on target tiles"
		});
		return ret;
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			if (_targetEntity != null && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInFlails && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1)
			{
				_properties.MeleeSkill -= 15;
				this.m.HitChanceBonus -= 15;
			}
		}
	}
});
