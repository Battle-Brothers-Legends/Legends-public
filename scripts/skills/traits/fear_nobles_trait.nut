this.fear_nobles_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.fear_nobles";
		this.m.Name = "Fear of Nobles";
		this.m.Icon = "ui/traits/noblefear.png";
		this.m.Description = "Some past event or particularly convincing story in this character\'s life has left them scared of what nobles are capable of, making this character less reliable when facing nobles on the battlefield.";
		this.m.Excluded = [
			"trait.fearless",
			"trait.brave",
			"trait.determined",
			"trait.cocky",
			"trait.bloodthirsty",
			"trait.aggressive",
			"trait.ambitious",
			"trait.natural",
			"trait.pragmatic",
			"trait.hate_nobles"
		];
	}

	function getTooltip()
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
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10[/color] Resolve when in battle with nobles"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-5%[/color] Melee Skill when in battle with nobles"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-5%[/color] Ranged Skill when in battle with nobles"
			}
		];
	}

	function onUpdate( _properties )
	{
		if (!this.getContainer().getActor().isPlacedOnMap())
		{
			return;
		}

		if (this.Tactical.Entities.getInstancesNum(this.World.FactionManager.getFactionOfType(this.Const.FactionType.NobleHouse).getID()) != 0)
		{
			_properties.Bravery -= 10;
			_properties.MeleeSkillMult *= 0.95;
			_properties.RangedSkillMult *= 0.95;
		}
	}

});
