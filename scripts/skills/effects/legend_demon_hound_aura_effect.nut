this.legend_demon_hound_aura_effect <- this.inherit("scripts/skills/skill", {
	m = {
	Penalty = 0
	},
	function create()
	{
		this.m.ID = "effects.legend_demon_hound_aura";
		this.m.Name = "Sluggish";
		this.m.Description = "The Höllenhund's presence has sapped the strength from this character\'s limbs, slowing them down.";
		this.m.Icon = "ui/orientation/hollenhound_orientation.png";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
	}

	function getTooltip()
	{
		local penalty = this.m.Penalty;
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
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + penalty * 100 + "%[/color] Initative"
			}
		];
	}

	function getPenalty( _properties )
	{
		local actor = this.getContainer().getActor();

		if (!actor.isPlacedOnMap() || ("State" in this.Tactical) && this.Tactical.State.isBattleEnded())
		{
			return 0;
		}

		local myTile = actor.getTile();
		if (myTile == null)
		{
			return 0;
		}

		if (!("Entities" in this.Tactical))
		{
			return 0;
		}

		if (this.Tactical.Entities == null)
		{
			return 0;
		}

		if (!this.Tactical.isActive())
		{
			return 0;
		}

		local worstPenalty = 0;
		local targets = this.Tactical.Entities.getAllInstancesAsArray();

		foreach(t in targets)
		{
			if (t.getID() == actor.getID() || !t.isPlacedOnMap())
			{
				continue;
			}

			if (t.getType() != this.Const.EntityType.LegendDemonHound)
			{
				continue;
			}

			local distance = t.getTile().getDistanceTo(myTile);
			if (distance > 2)
			{
				continue;
			}

			local distance = t.getTile().getDistanceTo(myTile);
			local penalty = 0.25;

			if (distance == 1)
			{
				penalty = 0.50;
			}

			if (penalty > worstPenalty)
			{
				worstPenalty = penalty;
			}

		}


		return worstPenalty;
	}

	function onUpdate( _properties )
	{
		this.m.IsHidden = true;
		this.m.Penalty = 0;
	}

	function onAfterUpdate( _properties )
	{
		local penalty = this.getPenalty(_properties);
		if (penalty == 0)
		{
			return;
		}
		_properties.InitiativeMult *= 1.0 - penalty;
		this.m.Penalty = penalty;
		this.m.IsHidden = false;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.IsHidden = true;
		this.m.Penalty = 0;
	}

});

