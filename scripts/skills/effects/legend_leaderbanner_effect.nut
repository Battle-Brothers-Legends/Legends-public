this.legend_leaderbanner_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Difference = 0
	},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LeaderbannerEffect);
		this.m.Description = "With the company\'s captain nearby, this character feels compelled to push onward no matter the danger.";
		this.m.Icon = "ui/perks/perk_28.png";
		this.m.IconMini = "perk_28_mini";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
	}

	function getTooltip()
	{
		local bonus = this.m.Difference;
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
				text = "[color=%positive%]+" + bonus + "[/color] Resolve"
			}
		];
	}

	function getBonus( _properties )
	{
		local actor = this.getContainer().getActor();

		if (!actor.isPlacedOnMap() || ("State" in this.Tactical) && this.Tactical.State.isBattleEnded())
		{
			return 0;
		}

		local myTile = actor.getTile();
		local allies = this.Tactical.Entities.getInstancesOfFaction(actor.getFaction());
		local bestBravery = 0;

		foreach( ally in allies )
		{
			if (ally.getID() == actor.getID() || !ally.isPlacedOnMap())
			{
				continue;
			}

			if (ally.getTile().getDistanceTo(myTile) > 4)
			{
				continue;
			}

			if (_properties.Bravery * _properties.BraveryMult >= ally.getBravery())
			{
				continue;
			}

			if (ally.getBravery() > bestBravery)
			{
				bestBravery = ally.getBravery();
			}
		}

		if (bestBravery != 0)
		{
			bestBravery = this.Math.min(bestBravery * 0.1, bestBravery - _properties.Bravery * _properties.BraveryMult);
		}

		return bestBravery;
	}

	function onUpdate( _properties )
	{
		this.m.IsHidden = true;
	}

	function onAfterUpdate( _properties )
	{
		local bonus = this.getBonus(_properties);

		if (bonus != 0)
		{
			this.m.IsHidden = false;
			_properties.Bravery += bonus;
			this.m.Difference = bonus;
		}
		else
		{
			this.m.IsHidden = true;
			this.m.Difference = 0;
		}
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.IsHidden = true;
		this.m.Difference = 0;
	}

});
