this.legend_fear_nobles_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = ::Legends.Traits.getID(::Legends.Trait.LegendFearNobles);
		this.m.Name = "Fear of Nobles";
		this.m.Icon = "ui/traits/noblefear.png";
		this.m.Description = "Some past event or particularly convincing story in this character\'s life has left them scared of what nobles are capable of, making this character less reliable when facing nobles on the battlefield.";
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Fearless),
			::Legends.Traits.getID(::Legends.Trait.Brave),
			::Legends.Traits.getID(::Legends.Trait.Determined),
			::Legends.Traits.getID(::Legends.Trait.Cocky),
			::Legends.Traits.getID(::Legends.Trait.Bloodthirsty),
			::Legends.Traits.getID(::Legends.Trait.LegendAggressive),
			::Legends.Traits.getID(::Legends.Trait.LegendAmbitious),
			::Legends.Traits.getID(::Legends.Trait.LegendTalented),
			::Legends.Traits.getID(::Legends.Trait.LegendPragmatic),
			::Legends.Traits.getID(::Legends.Trait.LegendHateNobles)
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
				text = "[color=%negative%]-10[/color] Resolve when in battle with nobles"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=%negative%]-5%[/color] Melee Skill when in battle with nobles"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=%negative%]-5%[/color] Ranged Skill when in battle with nobles"
			}
		];
	}

	function onUpdate( _properties )
	{
		if (!this.getContainer().getActor().isPlacedOnMap())
		{
			// If not in battle, then this should be a trait and not a status effect
			this.m.Type = ::Const.SkillType.Trait;
			return;
		}

		local fightingNobles = false;
		local enemies = this.Tactical.Entities.getAllHostilesAsArray();

		foreach( enemy in enemies )
		{
			if (this.Const.EntityType.getDefaultFaction(enemy.getType()) == this.Const.FactionType.NobleHouse)
			{
				fightingNobles = true;
				break;
			}
		}

		if (fightingNobles)
		{
			_properties.Bravery -= 10;
			_properties.MeleeSkillMult *= 0.95;
			_properties.RangedSkillMult *= 0.95;
			// Make this a status effect so it will be visible for the battle
			this.m.Type = ::Const.SkillType.StatusEffect;
		} else {
			// Make this a trait so it will not be visible for the battle
			this.m.Type = ::Const.SkillType.Trait;
		}
	}

});
