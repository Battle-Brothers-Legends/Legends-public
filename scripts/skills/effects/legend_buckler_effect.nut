this.legend_buckler_effect <- this.inherit("scripts/skills/skill", {
	m = {
		DefenseSingleEnemy = 12,
		DefenseTwoEnemies = 6,
		DefenseThreeEnemies = 4
	},
	function create()
	{
		this.m.ID = "effects.legend_buckler";
		this.m.Name = "Buckler Defense";
		this.m.Icon = "ui/perks/perk_02.png";
		//this.m.IconMini = "perk_02_mini";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsSerialized = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "Bucklers work best against a single opponent. Gain [color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.DefenseSingleEnemy + "[/color] Melee Defense when facing one enemy, [color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.DefenseTwoEnemies + "[/color] when facing two, or [color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.DefenseThreeEnemies + "[/color] when facing three, and half as much Ranged Defense.";
	}

	function isHidden()
	{
		return this.getBonus() == 0;
	}

	function getBonus()
	{
		local actor = this.getContainer().getActor();
		if (actor == null)
		{
			return 0;
		}

		if (!actor.isPlacedOnMap() || ("State" in this.Tactical) && this.Tactical.State.isBattleEnded())
		{
			return 0;
		}

		local myTile = actor.getTile();
		local myFaction = actor.getFaction();
		local nearbyEnemies = 0;

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

		if (this.Tactical.State.isAutoRetreat())
		{
			return 0;
		}

		if (!this.Tactical.isActive())
		{
			return 0;
		}

		local actors = this.Tactical.Entities.getAllInstancesAsArray();
		local bonus = 0;
		foreach( a in actors )
		{
			if (a == null)
			{
				continue;
			}

			if(!a.isPlacedOnMap())
			{
				continue;
			}

			if (a.getFaction() == myFaction)
			{
				continue;
			}

			if (a.getTile() == null)
			{
				continue;
			}

			if (a.getTile().getDistanceTo(myTile) != 1)
			{
				continue;
			}
			++nearbyEnemies;
		}

		if (nearbyEnemies == 3)
		{
			return this.m.DefenseThreeEnemies;
		}

		if (nearbyEnemies == 2)
		{
			return this.m.DefenseTwoEnemies;
		}
		if (nearbyEnemies == 1)
		{
			return this.m.DefenseSingleEnemy;
		}

		return 0;
	}

	function getTooltip()
	{
		local bonus = this.getBonus();
		local tooltip = [
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
		];

		if (::Tactical.isActive()) {
			tooltip.extend([{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + bonus + "[/color] Melee Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + bonus / 2 + "[/color]  Ranged Defense"
			}])
		}
		return tooltip;
	}

	function onUpdate( _properties )
	{
		local bonus = this.getBonus();
		_properties.MeleeDefense += bonus;
		_properties.RangedDefense += bonus / 2;
	}


});
