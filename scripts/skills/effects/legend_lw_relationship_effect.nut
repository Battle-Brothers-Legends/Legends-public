this.legend_lw_relationship_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendLwRelationship);
		this.m.Description = "Trust is a rare weapon on the battlefield. Fighting with trust in those around them allows this character to focus and fight better.";
		this.m.Icon = "ui/traits/trait_icon_58.png"; //team player
		this.m.IconMini = "band_of_brothers_mini"; //change
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
	}

	function getTooltip()
	{
		local bonus = getBonus();
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
				icon = "ui/icons/melee_skill.png",
				text = "[color=%positive%]" + bonus * 2 + "[/color] Melee Skill"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=%positive%]" + bonus * 3 + "[/color] Ranged Skill"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=%positive%]" + bonus * 2 + "[/color] Melee Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%positive%]" + bonus * 2 + "[/color] Ranged Defense"
			}
		];
	}

	function getBonus()
	{
		local actor = this.getContainer().getActor();

		if (!actor.isPlacedOnMap())
		{
			return 0;
		}

		local myTile = actor.getTile();
		local num = 0;

		for( local i = 0; i != 6; i = ++i )
		{
			if (!myTile.hasNextTile(i))
			{
			}
			else
			{
				local tile = myTile.getNextTile(i);

				if (!tile.IsEmpty && tile.IsOccupiedByActor && this.Math.abs(myTile.Level - tile.Level) <= 1)
				{
					local entity = tile.getEntity();

					if (actor.getFaction() == entity.getFaction() || entity.isAlliedWith(actor))
					{
						num = ++num;
					}
				}
			}
		}

		return num;
	}

	function onUpdate( _properties )
	{
		local bonus = getBonus();
		if (!this.getContainer().getActor().isPlacedOnMap())
		{
			this.m.IsHidden = true;
			return;
		}
		if (bonus > 0)
		{
			this.m.IsHidden = false;
			_properties.MeleeSkill += bonus * 2;
			_properties.RangedSkill += bonus * 3;
			_properties.MeleeDefense += bonus * 2;
			_properties.RangedDefense += bonus * 2;
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
