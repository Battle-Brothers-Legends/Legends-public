this.legend_unleash_cat_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Entity = null,
		EntityName = "Cleo",
		Script = "scripts/entity/tactical/legend_cat",
		Sounds0 = ::Legends.S.setSounds("sounds/enemies/cat_hurt", 7),
		Sounds1 = ::Legends.S.setSounds("sounds/enemies/cat_death", 5),
		Sounds2 = ::Legends.S.setSounds("sounds/enemies/cat_flee", 3),
		Sounds3 = ::Legends.S.setSounds("sounds/enemies/cat_idle", 3),
		Sounds4 = ::Legends.S.setSounds("sounds/enemies/cat_attack", 4),
		Sounds5 = ::Legends.S.setSounds("sounds/enemies/cat_attack", 5)
	},
	function setItem( _i )
	{
		this.m.Item = this.WeakTableRef(_i);
	}

	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendUnleashCat);
		this.m.Description = "Summon your cat. Hopefully it won\'t just run away. Needs a free tile adjacent.";
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/enemies/cat_purr", 2);
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
		this.skill.addResources();

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
		if (this.m.Entity != null || !this.skill.isUsable())
		{
			return false;
		}

		return true;
	}

	function onVerifyTarget( _originTile, _targetTile )	{
		return this.skill.onVerifyTarget(_originTile, _targetTile) && _targetTile.IsEmpty;
	}

	function onUse( _user, _targetTile )
	{
		local entity = this.Tactical.spawnEntity(this.m.Script, _targetTile.Coords.X, _targetTile.Coords.Y);
		entity.setFaction(this.Const.Faction.PlayerAnimals);
		entity.setName(this.m.EntityName);

		//And cats are cocky too I believe!
		entity.setMoraleState(this.Const.MoraleState.Confident);

		this.m.Entity = entity;
		//Cats are nocturnal right!
		if (!this.World.getTime().IsDaytime)
		{
			::Legends.Effects.grant(entity, ::Legends.Effect.Night);
		}

		return true;
	}

	function onCombatFinished()
	{
		this.m.Entity = null;
	}

});
