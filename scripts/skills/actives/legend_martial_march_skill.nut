this.legend_martial_march_skill <- this.inherit("scripts/skills/skill", {
	m = {
		AffectedActors = []
	},
	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendMartialMarch);
		this.m.Description = "A good marching melody uplifts the company, granting them temporary AP. Targets can only be inspired once per turn.";
		this.m.Icon = "skills/martial_march_square.png";
		this.m.IconDisabled = "skills/martial_march_square_bw.png";
		this.m.Overlay = "martial_march_square";
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
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsVisibleTileNeeded = false;
		this.m.ActionPointCost = 9;
		this.m.FatigueCost = 45;
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
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Grants all allied units within 8 tiles [color=%positive%]1[/color] additional Action Point for their next turn."
			}
		];

		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Can not be used because this character is engaged in melee[/color]"
			});
		}

		return ret;
	}

	function isHidden() {
		if (this.getContainer != null && !::Legends.Perks.has(this.getContainer(), ::Legends.Perk.LegendMeistersanger))
			return true;
		return this.skill.isHidden();
	}

	function isUsable()
	{
		if (!this.Tactical.isActive())
		{
			return false;
		}

		local tile = this.getContainer().getActor().getTile();
		return this.skill.isUsable() && !tile.hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions());
	}

	function onUse( _user, _targetTile )
	{
		local myTile = _user.getTile();
		local actors = this.Tactical.Entities.getInstancesOfFaction(_user.getFaction());

		foreach( a in actors )
		{
			if (a.getFaction() == _user.getFaction())
			{
				::Legends.Effects.grant(a, ::Legends.Effect.LegendMartialMarch);
			}
			this.m.AffectedActors.push(a.weakref());
		}
		return true;
	}

	function onTurnStart()
	{
		foreach(actor in this.m.AffectedActors)
		{
			if (actor == null)
				continue;
			if ("isNull" in actor && actor.isNull())
				continue;
			if (::Legends.S.skillEntityAliveCheck(actor))
				continue;
			::Legends.Effects.remove(actor.getSkills(), ::Legends.Effect.LegendDrumsOfWar);
		}
		this.m.AffectedActors = [];
	}

	function onCombatFinished()
	{
		this.m.AffectedActors = [];
	}

});

