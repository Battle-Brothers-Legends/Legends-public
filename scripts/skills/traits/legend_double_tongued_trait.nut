this.legend_double_tongued_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.legend_double_tongued";
		this.m.Name = "Double tongued";
		this.m.Icon = "ui/traits/trait_double_tongued.png";
		this.m.Description = "The nature of humanity brings out the destructive side in many, however this one appears to be worse than the usual.";
		this.m.Excluded = [
			"trait.optimist",
			"trait.teamplayer",
			"trait.determined",
			"trait.legend_gift_of_people"
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
				icon = "ui/icons/morale.png",
				text = "Has a [color=" + this.Const.UI.Color.NegativeValue + "]5%[/color] chance to start ranting about the inevitability of entropy and depress company morale at the start of a combat"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/morale.png",
				text = "Mercenaries who are Pessimistic, Superstitious, Paranoid, Traumatized, or have a Deathwish are strangely inspired by these dark speeches and gain [color=" + this.Const.UI.Color.PositiveValue + "]+2[/color] Action Points"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/morale.png",
				text = "Considers death unavoidable, experiences no morale check when allies die"
			}
		];
	}
	
	function onCombatStarted()
	{
		this.skill.onCombatStarted();
		
		if (this.Math.rand(1, 20) <= 1)
		{
			local allies = this.Tactical.Entities.getInstancesOfFaction(this.getContainer().getActor().getFaction());
			local ownID = this.getContainer().getActor().getID();

			foreach( ally in allies )
			{

				if (ally.getID() == ownID)
				{
					continue;
				}
				if (ally.getSkills().hasSkill("trait.legend_double_tongued") || ally.getSkills().hasSkill("trait.deathwish") || ally.getSkills().hasSkill("trait.superstitious") || ally.getSkills().hasSkill("trait.paranoid") || ally.getSkills().hasSkill("trait.pessimist") || ally.getSkills().hasSkill("injury.traumatized"))
				{
					ally.getSkills().add(this.new("scripts/skills/effects/legend_cheered_on_effect"));
					
					continue;
				}		
				
				local ally_morale = ally.getMoraleState();
				
				if (ally_morale > this.Const.MoraleState.Fleeing && ally_morale < ::Const.MoraleState.Ignore)
				{
					ally.setMoraleState(ally_morale - 1);
				}
			}
		}
		

	}	
	function onUpdate( _properties )
	{
		_properties.IsAffectedByDyingAllies = false;
	}
});

