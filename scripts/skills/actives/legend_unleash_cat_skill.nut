this.legend_unleash_cat_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Entity = null,
		EntityName = "Cleo",
		Script = "scripts/entity/tactical/legend_cat",
		Sounds0 = [
			"sounds/enemies/cat_hurt_01.wav",
			"sounds/enemies/cat_hurt_02.wav",
			"sounds/enemies/cat_hurt_03.wav",
			"sounds/enemies/cat_hurt_04.wav",
			"sounds/enemies/cat_hurt_05.wav",
			"sounds/enemies/cat_hurt_06.wav",
			"sounds/enemies/cat_hurt_07.wav"
		],
		Sounds1 = [
			"sounds/enemies/cat_death_01.wav",
			"sounds/enemies/cat_death_02.wav",
			"sounds/enemies/cat_death_03.wav",
			"sounds/enemies/cat_death_04.wav",
			"sounds/enemies/cat_death_05.wav"
		],
		Sounds2 = [
			"sounds/enemies/cat_flee_01.wav",
			"sounds/enemies/cat_flee_02.wav",
			"sounds/enemies/cat_flee_03.wav"
		],
		Sounds3 = [
			"sounds/enemies/cat_idle_01.wav",
			"sounds/enemies/cat_idle_02.wav",
			"sounds/enemies/cat_idle_03.wav"
		],
		Sounds4 = [
			"sounds/enemies/cat_attack_01.wav",
			"sounds/enemies/cat_attack_02.wav",
			"sounds/enemies/cat_attack_03.wav",
			"sounds/enemies/cat_attack_04.wav"
		],
		Sounds5 = [
			"sounds/enemies/cat_attack_01.wav",
			"sounds/enemies/cat_attack_02.wav",
			"sounds/enemies/cat_attack_03.wav",
			"sounds/enemies/cat_attack_04.wav",
			"sounds/enemies/cat_attack_05.wav"
		]
	},
	function setItem( _i )
	{
		this.m.Item = this.WeakTableRef(_i);
	}

	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendUnleashCat);
		this.m.Description = "Summon your cat. Hopefully it won\'t just run away. Needs a free tile adjacent.";
		this.m.Icon = "skills/cat_square.png";
		this.m.IconDisabled = "skills/cat_square_bw.png";
		this.m.Overlay = "cat_square";
		this.m.SoundOnUse = [
			"sounds/enemies/cat_purr_01.wav",
			"sounds/enemies/cat_purr_02.wav"
		];
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

	function onVerifyTarget( _originTile, _targetTile )
	{
		local actor = this.getContainer().getActor();
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
