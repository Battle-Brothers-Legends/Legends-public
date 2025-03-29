this.legend_haunted_05_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.legend_haunted_05";
		this.m.Name = "Tormented by spirit runes";
		this.m.Icon = "ui/traits/trait_haunted_05.png";
		this.m.Description = "This character is carrying five spirits encased in runes. The thought never leaves their mind, every movement disturbs the dead. They mutter to themselves, disapear randomly and look at friends like strangers. They are descending into madness. ";
		this.m.Excluded = [
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
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-6[/color] Resolve"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-6[/color] Resolve at morale checks against fear, panic or mind control effects"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]+6[/color] or [color=" + this.Const.UI.Color.NegativeValue + "]-6[/color] Resolve randomly at every morale check"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-6[/color] Resolve when in battle with undead"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-6[/color] Melee Skill when in battle with undead"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-6[/color] Ranged Skill when in battle with undead"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/morale.png",
				text = "Will start combat at wavering morale"
			}
		];
	}
	function onUpdate( _properties )
	{
	_properties.IsAffectedByDyingAllies = false;
		if (!this.getContainer().getActor().isPlacedOnMap())
		{
			return;
		}
		_properties.Bravery += -6;
		if (this.Tactical.Entities.getInstancesNum(this.World.FactionManager.getFactionOfType(this.Const.FactionType.Zombies).getID()) != 0 || this.Tactical.Entities.getInstancesNum(this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).getID()) != 0)
		{
			_properties.Bravery -= 6;
			_properties.MeleeSkill -= 6;
			_properties.RangedSkillMult -= 6;
		}
	}
	
	function onCombatStarted()
	{
		local actor = this.getContainer().getActor();

		if (actor.getMoodState() >= this.Const.MoodState.Disgruntled && actor.getMoraleState() > this.Const.MoraleState.Wavering)
		{
			actor.setMoraleState(this.Const.MoraleState.Wavering);
		}
	}
});

