::mods_hookExactClass("skills/actives/disarm_skill", function (o) {
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

	o.onAnySkillUsed = function (_skill, _targetEntity, _properties) {
		if (_skill == this) {
			local bonus = 0;
			if (_properties.IsSpecializedInCleavers) {
				bonus += 15;
			}
			_properties.MeleeSkill += this.addHitChanceBonus(bonus);
			_properties.DamageTotalMult = 0.0;
			_properties.HitChanceMult[::Const.BodyPart.Head] = 0.0;
		}
	}
});
