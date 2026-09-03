this.legend_unleash_white_wolf_skill <- this.inherit("scripts/skills/actives/legend_unleash_animal_skill", {
	m = {
		Item = null,
		Sounds0 = ::Legends.S.setSounds("sounds/enemies/wolf_death", 6, 0),
		Sounds1 = ::Legends.S.setSounds("sounds/enemies/wolf_flee", 3, 0),
		Sounds2 = ::Legends.S.setSounds("sounds/enemies/wolf_hurt", 4, 0),
		Sounds3 = ::Legends.S.setSounds("sounds/enemies/wolf_idle", 10, 0)
	},
	function setItem( _i ) {
		this.m.Item = this.WeakTableRef(_i);
	}

	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendUnleashWhiteWolf);
		this.m.Description = "Unleash your white wolf and send him charging into the enemy. Needs a free tile adjacent.";
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/enemies/wolf_idle", 10, 0);
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Last + 5;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsTargetingActor = false;
		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function addResources()
	{
		this.legend_unleash_animal_skill.addResources();

		foreach( r in this.m.Sounds0 )
		{
			this.Tactical.addResource(r);
		}

		foreach( r in this.m.Sounds1 )
		{
			this.Tactical.addResource(r);
		}

		foreach( r in this.m.Sounds2 )
		{
			this.Tactical.addResource(r);
		}

		foreach( r in this.m.Sounds3 )
		{
			this.Tactical.addResource(r);
		}
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
		if (this.m.Item.isUnleashed() || !this.legend_unleash_animal_skill.isUsable())
		{
			return false;
		}

		return true;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		local actor = this.getContainer().getActor();
		return this.legend_unleash_animal_skill.onVerifyTarget(_originTile, _targetTile) && _targetTile.IsEmpty;
	}

	function onUpdate( _properties )
	{
		this.m.IsHidden = this.m.Item.isUnleashed();
	}

	function onUse( _user, _targetTile )
	{
		local entity = this.Tactical.spawnEntity(this.m.Item.getScript(), _targetTile.Coords.X, _targetTile.Coords.Y);
		entity.setFaction(this.Const.Faction.PlayerAnimals);
		entity.setItem(this.m.Item);
		entity.setName(this.m.Item.getName());
		entity.setVariant(this.m.Item.getVariant(), entity.getSprite("body").Color, entity.getSprite("body").Saturation);
		this.m.Item.setEntity(entity);

		if (this.getContainer().hasSkill(::Legends.Backgrounds.getID(::Legends.Background.Houndmaster)))
		{
			entity.setMoraleState(this.Const.MoraleState.Confident);
		}

		this.addAnimalSkills(entity);

		if (!this.World.getTime().IsDaytime)
		{
			::Legends.Effects.grant(entity, ::Legends.Effect.Night);
		}

		this.m.IsHidden = true;
		return true;
	}

});