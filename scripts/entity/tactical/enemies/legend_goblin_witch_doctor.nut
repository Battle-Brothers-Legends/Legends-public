this.legend_goblin_witch_doctor <- this.inherit("scripts/entity/tactical/goblin", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.LegendGoblinWitchDoctor;
		this.m.XP = this.Const.Tactical.Actor.LegendGoblinWitchDoctor.XP;
		this.goblin.create();
		this.m.SoundPitch = this.Math.rand(90, 100) * 0.01;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/goblin_shaman_agent");
		this.m.AIAgent.setActor(this);
		local rolls = ::Legends.S.extraLootChance(1);
		for(local i = 0; i < rolls; i++)
			this.m.OnDeathLootTable.push([5, "scripts/items/misc/legend_ancient_scroll_item"]);
	}

	function onInit()
	{
		this.goblin.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendGoblinWitchDoctor);
		b.Vision = 8;
		b.TargetAttractionMult = 2.0;
		b.IsAffectedByNight = false;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.getSprite("head").setBrush("bust_goblin_02_head_01");
		this.addDefaultStatusSprites();
		::Legends.Perks.grant(this, ::Legends.Perk.LegendTrueBeliever);
		::Legends.Traits.grant(this, ::Legends.Trait.RacialGoblinShaman);
		::Legends.Actives.grant(this, ::Legends.Active.Insects);
		::Legends.Actives.grant(this, ::Legends.Active.Root);
		::Legends.Actives.grant(this, ::Legends.Active.GrantNightVision);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.Pathfinder);
			::Legends.Perks.grant(this, ::Legends.Perk.Anticipation);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		if (!this.Tactical.State.isScenarioMode() && _killer != null && _killer.isPlayerControlled())
		{
			this.updateAchievement("Wildgrowth", 1, 1);
		}

		this.goblin.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function assignRandomEquipment()
	{
		local r;
		this.m.Items.equip(this.new("scripts/items/weapons/greenskins/goblin_staff"));
		local item = this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Greenskin.goblin_shaman_armor]
		]);
		this.m.Items.equip(item);
		local item = this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Greenskin.goblin_shaman_helmet]
		]);
		this.m.Items.equip(item);
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		this.m.Items.equip(this.new("scripts/items/weapons/named/legend_named_goblin_staff"));
		::Legends.Perks.grant(this, ::Legends.Perk.Nimble);
		::Legends.Perks.grant(this, ::Legends.Perk.Dodge);
		::Legends.Perks.grant(this, ::Legends.Perk.Relentless);
		return true;
	}

});

