this.legend_beastslayers_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = ::Legends.Traits.getID(::Legends.Trait.LegendBeastslayers);
		this.m.Name = "Natural Order";
		this.m.Icon = "ui/traits/legend_natural_order_trait.png";
		this.m.Description = "Nature is not for the faint of heart — those that dwell on the fringes of society not only thrive in the danger, but know the natural order of things will eat them alive. Quite literally.";
		this.m.Order = this.Const.SkillOrder.Trait - 2;
		this.m.Excluded = [];
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
				text = "[color=%positive%]+5[/color] Resolve when in battle with beasts"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=%positive%]+10%[/color] Melee damage when in battle with beasts"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=%positive%]+10%[/color] Ranged damage when in battle with beasts"
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

		local fightingBeasts = false;
		local enemies = this.Tactical.Entities.getAllHostilesAsArray();

		foreach( enemy in enemies )
		{
			if (this.Const.EntityType.getDefaultFaction(enemy.getType()) == this.Const.FactionType.Beasts || enemy.getType() == this.Const.EntityType.BarbarianUnhold || enemy.getType() == this.Const.EntityType.BarbarianUnholdFrost)
			{
				fightingBeasts = true;
				break;
			}
		}

		if (fightingBeasts)
		{
			_properties.Bravery += 5;
			_properties.MeleeDamageMult *= 1.1;
			_properties.RangedDamageMult *= 1.1;
			// Make this a status effect so it will be visible for the battle
			this.m.Type = ::Const.SkillType.StatusEffect;
		} else {
			// Make this a trait so it will not be visible for the battle
			this.m.Type = ::Const.SkillType.Trait;
		}
	}

});

