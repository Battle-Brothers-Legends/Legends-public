this.legend_drums_of_war_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendDrumsOfWar);
		this.m.Description = "Push allies on with your music, lowering the fatigue of all allies within 8 tiles by 3 fatigue. Must be holding a musical instrument to use.";
		this.m.Icon = "skills/drums_of_war_square.png";
		this.m.IconDisabled = "skills/drums_of_war_square_bw.png";
		this.m.Overlay = "drums_of_war_square";
		this.m.SoundOnUse = [
			"sounds/enemies/dlc4/wardrums_01.wav",
			"sounds/enemies/dlc4/wardrums_02.wav",
			"sounds/enemies/dlc4/wardrums_03.wav"
		];
		this.m.SoundVolume = 1.5;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = true;
		this.m.IsAttack = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.ActionPointCost = 8;
		this.m.FatigueCost = 30;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

function getTooltip()
	{
		local ret = [
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
				id = 3,
				type = "text",
				text = this.getCostString()
			}
		];
		return ret;
	}

	function isUsable()
	{
		local mainhand = this.m.Container.getActor().getMainhandItem();
		if (mainhand == null || !this.skill.isUsable())
		{
			return false;
		}
		return mainhand.isWeaponType(this.Const.Items.WeaponType.Musical);

	}

	function onUse( _user, _targetTile )
	{
		local myTile = _user.getTile();
		local actors = this.Tactical.Entities.getInstancesOfFaction(_user.getFaction());

		foreach( a in actors )
		{
			if (a.getID() == _user.getID())
			{
				continue;
			}

			if (a.getFatigue() == 0)
			{
				continue;
			}

			if (myTile.getDistanceTo(a.getTile()) > 8)
			{
				continue;
			}

			if (a.getFaction() == _user.getFaction())
			{
				::Legends.Effects.grant(a, ::Legends.Effect.LegendDrumsOfWar);
				//a.setFatigue(this.Math.max(0, a.getFatigue() - 5)); - Redundant?
				this.spawnIcon(this.m.Overlay, a.getTile());
			}
		}

		::Legends.Effects.grant(this, ::Legends.Effect.LegendDrumsOfWar);
		return true;
	}

});

