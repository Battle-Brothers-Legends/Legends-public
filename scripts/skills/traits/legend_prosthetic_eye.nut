this.legend_prosthetic_eye <- this.inherit("scripts/skills/traits/character_trait", {
	m = {
		IsUpgraded = false
	},
	function create()
	{
		this.character_trait.create();
		this.m.ID = ::Legends.Traits.getID(::Legends.Trait.LegendProstheticEye);
		this.m.Name = "Prosthetic Eye";
		this.m.Icon = "ui/traits/legend_prosthetic_eye.png";
		this.m.Description = "My, what pretty eyes! This one seems a bit off, however, and the owner has to constantly shift their pupil back into position to look straight.";
		// if (this.World.Flags.get("Item Identified"))
		// {
		// 	this.m.Name = "Enhanced Prosthetic Eye";
		// 	this.m.Description = "There isn\'t really much you can improve on a fake eye, but the pupil stabilizes itself, unlike the previous iteration. The clear, expensive crystal conveys light directly to the missing eye organ and the prosthetic looks like the user is constantly mad.";
		// }
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
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=%negative%]-50%[/color] Ranged Skill"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=%positive%]+7[/color] Resolve"
			}
		];
		if (!this.m.IsUpgraded)
		{
			ret.push({
				id = 12,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "[color=%negative%]-2[/color] Vision"
			});
		}
		else
		{
			ret.extend([{
				id = 12,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "[color=%negative%]-1[/color] Vision"
			},
			{
				id = 15,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "Reduces the Resolve of any opponent engaged in melee by [color=%negative%]-3[/color]"
			}]);
		}

		return ret;
	}

	function onUpdate (_properties)
	{
		_properties.RangedSkillMult *= 0.5;
		_properties.Bravery += 7;
		if (!this.m.IsUpgraded)
		{
			_properties.Vision -= 2;
		}
		else
		{
			_properties.Vision -= 1;
			_properties.Threat += 3;
		}
	}
});
