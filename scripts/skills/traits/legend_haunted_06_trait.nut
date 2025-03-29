this.legend_haunted_06_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.legend_haunted_06";
		this.m.Name = "Broken by spirit runes";
		this.m.Icon = "ui/traits/trait_haunted_06.png";
		this.m.Description = "This character is carrying the rune trapped spirits of six dead people. They are driven mad with thoughts of the dead, and no longer fear death. They will charge into battle and may attack everyone including your own units. ";
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
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+6[/color] Resolve"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/morale.png",
				text = "No morale check triggered upon allies dying"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/morale.png",
				text = "No morale check triggered upon losing hitpoints"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Is not affected by fresh injuries sustained during the current battle"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Chance to lose control of this character at the end of each turn"
			}

		];
	}
	function onTurnEnd()
	{
		local r = this.Math.rand(1, 100);
		local actor = this.getContainer().getActor();
		if (r < 33)
		{
			actor.setFaction(this.Const.Faction.PlayerAnimals);
			this.logDebug(this.getName() + " AI set to " + this.m.Agent2);
			local agent = this.new("scripts/ai/tactical/agents/wardog_agent");
			actor.setAIAgent(agent);
			this.m.AgentID = agent.getID();
		}
		else if ( r > 66)
		{
			actor.setFaction(this.Const.Faction.Beasts);
			local agent = this.new("scripts/ai/tactical/agents/zombie_agent");
			actor.setAIAgent(agent);
			this.logDebug(this.getName() + " AI set to " + this.m.Agent1);
			this.m.AgentID = agent.getID();
		}
		else
		{
			actor.setFaction(this.Const.Faction.Player);
		}
	}

	function onRemoved()
	{
		this.removeEffect();
	}

	function onUpdate( _properties )
	{
		_properties.Bravery += 6;
		_properties.IsAffectedByDyingAllies = false;
		_properties.IsAffectedByLosingHitpoints = false;
		_properties.IsAffectedByFreshInjuries = false;

	}
});

