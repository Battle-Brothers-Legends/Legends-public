this.legend_war_catapult <- this.inherit("scripts/entity/tactical/actor", {
	m = {
		Item = null,
		Name = "Catapult"
	},
	function setItem( _i )
	{
		if (typeof _i == "instance")
		{
			this.m.Item = _i;
		}
		else
		{
			this.m.Item = this.WeakTableRef(_i);
		}
	}

	function setName( _n )
	{
		this.m.Name = _n;
	}

	function getName()
	{
		return this.m.Name;
	}

	function create()
	{
		this.m.Type = ::Const.EntityType.LegendCatapult;
		this.m.BloodType = ::Const.BloodType.Wood;
		this.m.XP = ::Const.Tactical.Actor.LegendCatapult.XP;
		this.actor.create();
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_ranged_agent");
		this.m.AIAgent.setActor(this);

		this.m.OnDeathLootTable.extend([
			[33, "scripts/items/supplies/ammo_item"]
		]);
		local rolls = ::Legends.S.extraLootChance(1);
		for(local i = 0; i < rolls; i++) {
			this.m.OnDeathLootTable.extend([
				[100, "scripts/items/trade/quality_wood_item"]
			]);
		}
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		if (_tile != null)
		{
			_tile.spawnObject("entity/tactical/objects/destroyed_greenskin_catapult");
			local offset = this.createVec(0, -10);

			for( local i = 0; i < ::Const.Tactical.BurnParticles.len(); i = ++i )
			{
				::Tactical.spawnParticleEffect(false, ::Const.Tactical.BurnParticles[i].Brushes, _tile, ::Const.Tactical.BurnParticles[i].Delay, ::Math.max(1, ::Const.Tactical.BurnParticles[i].Quantity), ::Math.max(1, ::Const.Tactical.BurnParticles[i].LifeTimeQuantity), ::Const.Tactical.BurnParticles[i].SpawnRate, ::Const.Tactical.BurnParticles[i].Stages, offset);
			}
		}

		local deathLoot = this.getItems().getDroppableLoot(_killer);
		local tileLoot = this.getLootForTile(_killer, deathLoot);
		this.dropLoot(_tile, tileLoot, !flip);

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function setFlipped( _f )
	{
		this.getSprite("body").setHorizontalFlipping(_f);
	}

	function onFactionChanged()
	{
		this.actor.onFactionChanged();
		local flip = this.isAlliedWithPlayer();
		this.getSprite("body").setHorizontalFlipping(flip);


		if (!::Tactical.State.isScenarioMode())
		{
			local f = ::World.FactionManager.getFaction(this.getFaction());

			if (f != null)
			{
				this.getSprite("socket").setBrush(f.getTacticalBase());
			}
		}
		else
		{
			this.getSprite("socket").setBrush(::Const.FactionBase[this.getFaction()]);
		}
	}

	function onActorKilled( _actor, _tile, _skill )
	{
		this.actor.onActorKilled(_actor, _tile, _skill);

		if (this.getFaction() == ::Const.Faction.Player || this.getFaction() == ::Const.Faction.PlayerAnimals)
		{
			local XPgroup = _actor.getXPValue();
			local brothers = ::Tactical.Entities.getInstancesOfFaction(::Const.Faction.Player);

			foreach( bro in brothers )
			{
				bro.addXP(::Math.max(1, ::Math.floor(XPgroup / brothers.len())));
			}
		}
	}

	function onInit()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.LegendCatapult);
		b.IsImmuneToKnockBackAndGrab = true;
		b.IsImmuneToStun = true;
		b.IsImmuneToRoot = true;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToBleeding = true;
		b.IsImmuneToPoison = true;
		b.IsAffectedByNight = false;
		b.TargetAttractionMult = 1.1;
		b.IsImmuneToDisarm = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.CatapultMovementAPCost;
		this.m.FatigueCosts = ::Const.CatapultMovementFatigueCost;
		local body = this.addSprite("body");
		body.setBrush("legend_catapult");
		body.varySaturation(0.25);
		body.varyColor(0.2, 0.2, 0.2);
		b.IsSpecializedInBows = true;
		b.IsSpecializedInCrossbows = true;
		b.IsSpecializedInSlings = true;
		this.addDefaultStatusSprites();
		this.setSpriteOffset("status_rooted", this.createVec(-10, 16));
		this.setSpriteOffset("status_stunned", this.createVec(0, 10));
		this.setSpriteOffset("arrow", this.createVec(0, 10));

		if (!::Tactical.State.isScenarioMode() && ::World.getTime().Days >= 40)
		{
			b.RangedDefense += 5;
		}

		::Legends.Actives.grant(this, ::Legends.Active.LegendCatapultBoulder);
		::Legends.Actives.grant(this, ::Legends.Active.LegendUseCatapult);

		if (!::Tactical.State.isScenarioMode() && ::World.getTime().Days >= 20)
		{
			::Legends.Perks.grant(this, ::Legends.Perk.Bullseye);
		}

		if (::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.LegendBallistics);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendPointBlank);
			::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
			::Legends.Perks.grant(this, ::Legends.Perk.LoneWolf);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
	}

});

