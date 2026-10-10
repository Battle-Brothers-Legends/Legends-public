::mods_hookExactClass("skills/actives/round_swing", function(o)
{
	local create = o.create;
	o.create = function() {
		create();
		this.m.HitChanceBonus = -15;
	}

	o.getTooltip = function () {
		local tooltip = this.getDefaultTooltip();
		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Can hit up to 6 targets"
		});

		return tooltip;
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties ) {
		if (_skill == this) {
			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInAxes) {
				this.m.HitChanceBonus += 5;
			}
			_properties.MeleeSkill += this.m.HitChanceBonus;
		}
	}
});
