this.legend_prosthetic_forearm <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = ::Legends.Traits.getID(::Legends.Trait.LegendProstheticForearm);
		this.m.Name = "Prosthetic Forearm";
		this.m.Icon = "ui/traits/legend_prosthetic_forearm.png";
		this.m.Description = "A brand new arm for a sword to be swung with. Of course, the user loses most control in their arm, all feeling, and must manually change the position of their fingers with their other hand. But still, at least it\'s something.";
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
				icon = "ui/icons/melee_defense.png",
				text = "[color=%negative%]-15%[/color] Melee Defense"
			},
			{
				id = 16,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Is always content with being in reserve"
			}
		];
		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.MeleeSkillMult *= 0.9;
		_properties.RangedSkillMult *= 0.9;
		_properties.MeleeDefenseMult *= 0.85;
	}

	function onApplyAppearance()
	{
	}

});
