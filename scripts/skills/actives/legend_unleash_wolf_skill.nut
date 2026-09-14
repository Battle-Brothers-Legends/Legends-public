this.legend_unleash_wolf_skill <- this.inherit("scripts/skills/actives/legend_unleash_animal_skill", {
	m = {
		Entity = null,
		EntityName = "Hound",
		Script = "scripts/entity/tactical/warwolf",
		Sounds0 = ::Legends.S.setSounds("sounds/enemies/wolf_hurt", 4, 0),
		Sounds1 = ::Legends.S.setSounds("sounds/enemies/wolf_death", 6, 0),
		Sounds2 = ::Legends.S.setSounds("sounds/enemies/wolf_flee", 3, 0),
		Sounds3 = ::Legends.S.setSounds("sounds/enemies/wolf_idle", 10, 0),
		Sounds4 = ::Legends.S.setSounds("sounds/enemies/wardog_charge", 3, 0),
		Sounds5 = ::Legends.S.setSounds("sounds/enemies/wardog_charge", 3, 0)
	},
	function setItem( _i )
	{
		this.m.Item = this.WeakTableRef(_i);
	}

	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendUnleashWolf);
		this.m.Description = "Summon a faithful wolf. Needs a free tile adjacent. Only one per battle.";
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/enemies/wolf_idle", 10, 0);
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Last + 5;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsTargetingActor = false;
		this.m.ActionPointCost = 7;
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

		foreach( r in this.m.Sounds4 )
		{
			this.Tactical.addResource(r);
		}

		foreach( r in this.m.Sounds5 )
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
		if (this.getContainer().hasEffect(::Legends.Effect.LegendSummonedWolfEffect))
		{
			return false;
		}

		if (this.m.Entity != null || !this.legend_unleash_animal_skill.isUsable())
		{
			return false;
		}

		return true;
	}

	function onVerifyTarget( _originTile, _targetTile ) {
		return this.legend_unleash_animal_skill.onVerifyTarget(_originTile, _targetTile) && _targetTile.IsEmpty;
	}

	function onUse( _user, _targetTile )
	{
		::Legends.Effects.grant(_user, ::Legends.Effect.LegendSummonedWolfEffect);
		local entity = this.Tactical.spawnEntity(this.m.Script, _targetTile.Coords.X, _targetTile.Coords.Y);
		entity.setFaction(this.Const.Faction.PlayerAnimals);
		entity.setName(this.m.EntityName);

		if (this.getContainer().hasSkill(::Legends.Backgrounds.getID(::Legends.Background.Houndmaster)))
		{
			entity.setMoraleState(this.Const.MoraleState.Confident);
		}

		this.addAnimalSkills(entity);

		return true;
	}

	function onCombatFinished()
	{
		this.m.Entity = null;
	}

});
