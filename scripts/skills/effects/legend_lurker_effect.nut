this.legend_lurker_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendLurker);
		this.m.Description = this.Const.Strings.PerkDescription.LegendLurker;
		this.m.Icon = "ui/perks/lurker.png";
		this.m.IconMini = "perk_61_mini"; //needs a mini at some point
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsSerialized = false;
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
				icon = "ui/icons/action_points.png",
				text = "[color=%positive%]+3[/color] Action Points"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%positive%]+30%[/color] Ranged Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=%positive%]+20[/color] Initiative"
			}
		];
	}

	function onUpdate( _properties )
	{
		this.skill.onUpdate(_properties);

		local actor = this.getContainer().getActor();

		if (!this.getContainer().getActor().isPlacedOnMap())
		{
			this.m.IsHidden = true;
			return;
		}

		local myTile = actor.getTile();
		local allies = this.Tactical.Entities.getInstancesOfFaction(actor.getFaction());
		local entites = this.Tactical.Entities.getAllHostilesAsArray();
		local isAlone = true;

		foreach( ally in allies )
		{
			if (ally.getID() == actor.getID() || !ally.isPlacedOnMap())
			{
				continue;
			}
			if (ally.getTile().getDistanceTo(myTile) <= 2)
			{
				isAlone = false;
				break;
			}
		}


		foreach( unit in entites )
		{
            if (unit.getID() == actor.getID())
            {
                continue;
            }
			if (unit.getTile().getDistanceTo(myTile) <= 2)
			{
				isAlone = false;
				break;
			}
		}

		if (isAlone)
		{
			this.m.IsHidden = false;
			_properties.ActionPoints += 3;
			_properties.RangedDefense *= 1.30;
			_properties.Initiative += 20;

		}
		else
		{
			this.m.IsHidden = true;
		}
	}

	function onCombatFinished()
	{
		this.m.IsHidden = true;
	}

});

