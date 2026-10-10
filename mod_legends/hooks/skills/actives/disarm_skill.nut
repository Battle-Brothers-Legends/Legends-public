::mods_hookExactClass("skills/actives/disarm_skill", function(o)
{
	o.getTooltip = function () {
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has a [color=" + ::Const.UI.Color.PositiveValue + "]100%[/color] chance to disarm on a hit"
		});
		return ret;
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			if (_properties.IsSpecializedInCleavers) {
				this.m.HitChanceBonus += 15;
			}
			_properties.MeleeSkill += this.m.HitChanceBonus;
			_properties.DamageTotalMult = 0.0;
			_properties.HitChanceMult[this.Const.BodyPart.Head] = 0.0;
		}
	}
});
