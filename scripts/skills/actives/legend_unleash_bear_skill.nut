this.legend_unleash_bear_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Entity = null,
		EntityName = "Bear",
		Script = "scripts/entity/tactical/legend_warbear",
		Sounds0 = ::Legends.S.setSounds("sounds/enemies/bear_hit", 2),
		Sounds1 = ["sounds/enemies/bear_dead.wav"],
		Sounds2 = ::Legends.S.setSounds("sounds/enemies/unhold_flee", 4),
		Sounds3 = ::Legends.S.setSounds("sounds/enemies/bear_idle", 2),
		Sounds4 = ::Legends.S.setSounds("sounds/enemies/bear_attack", 2),
		Sounds5 = ::Legends.S.setSounds("sounds/enemies/bear_attack", 2)
	},
	function setItem( _i )
	{
		this.m.Item = this.WeakTableRef(_i);
	}

	function create()
	{
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendUnleashBear);
		this.m.Description = "Summon a faithful bear. Needs a free tile adjacent. Only one per battle.";
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/enemies/bear_idle", 2);
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Last + 5;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsTargetingActor = false;
		this.m.ActionPointCost = 8;
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
		if (this.getContainer().hasEffect(::Legends.Effect.LegendSummonedBearEffect))
		{
			return false;
		}

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
		::Legends.Effects.grant(_user, ::Legends.Effect.LegendSummonedBearEffect);
		local entity = this.Tactical.spawnEntity(this.m.Script, _targetTile.Coords.X, _targetTile.Coords.Y);
		entity.setFaction(this.Const.Faction.PlayerAnimals);
		entity.setName(this.m.EntityName);
		if (this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.LegendDogWhisperer))
		{
			::Legends.Perks.grant(entity, ::Legends.Perk.FortifiedMind);
			::Legends.Perks.grant(entity, ::Legends.Perk.Colossus);
			::Legends.Perks.grant(entity, ::Legends.Perk.Underdog);
		}
		return true;
	}

	function onCombatFinished()
	{
		this.m.Entity = null;
	}

});
