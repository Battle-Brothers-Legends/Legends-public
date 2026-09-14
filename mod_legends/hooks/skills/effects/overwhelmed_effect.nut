::mods_hookExactClass("skills/effects/overwhelmed_effect", function(o) {

	o.getTooltip = function()
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
				icon = "ui/icons/melee_skill.png",
				text = "[color=%negative%]-" + this.m.Count * 5 + "%[/color] Melee Skill"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=%negative%]-" + this.m.Count * 5 + "%[/color] Ranged Skill"
			}
		];
	}

	o.onUpdate = function ( _properties )
	{
		_properties.MeleeSkillMult = this.Math.maxf(0.0, _properties.MeleeSkillMult - 0.05 * this.m.Count);
		_properties.RangedSkillMult = this.Math.maxf(0.0, _properties.RangedSkillMult - 0.05 * this.m.Count);
	}
});
