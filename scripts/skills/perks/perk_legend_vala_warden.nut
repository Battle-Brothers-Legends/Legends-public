this.perk_legend_vala_warden <- this.inherit("scripts/skills/skill", {
	m = {
		WardenSummonSpent = false,
		WardenEntity = null
	},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendValaWarden);
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast + 10;
		this.m.IsSerialized = true;
		this.m.IsTargeted = false;
	}

	function isHidden()
	{
		return ::MSU.isNull(this.m.WardenEntity);
	}

	function getWarden()
	{
		return this.m.WardenEntity;
	}

	function getTooltip()
	{
		if (!this.isHidden())
		{
			local WardenHitpoints = this.m.WardenEntity.m.CurrentProperties.Hitpoints;
			local WardenMeleeSkill = this.m.WardenEntity.m.CurrentProperties.MeleeSkill;
			local WardenMeleeDefense = this.m.WardenEntity.m.CurrentProperties.MeleeDefense;
			local WardenRangedSkill = this.m.WardenEntity.m.CurrentProperties.RangedSkill;
			local WardenRangedDefense = this.m.WardenEntity.m.CurrentProperties.RangedDefense;
			local WardenInitiative = this.m.WardenEntity.m.CurrentProperties.Initiative;
			local SpiritualBondReduction = this.Math.round(10.0 + (this.getContainer().getActor().getBravery() / 4.0));

			if (SpiritualBondReduction >= 50)
			{
				SpiritualBondReduction = 50;
			}

			local tooltip =
			[
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

			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Hitpoints: " + WardenHitpoints + "\nMelee skill: " + WardenMeleeSkill + "\nMelee defense: " + WardenMeleeDefense + "\nRanged skill: " + WardenRangedSkill + "\nRanged defense: " + WardenRangedDefense + "\nInitiative: " + WardenInitiative
			});

			if (this.getContainer().getActor().getSkills().hasEffect(::Legends.Effect.LegendValaSpiritualBondEffect))
			{
				tooltip.push({
					id = 8,
					type = "text",
					icon = "ui/icons/special.png",
					text = "The strong bond between the Vala and her Warden makes the Warden absorb " + SpiritualBondReduction + "% of the Vala\'s incoming health damage."
				});
			}

			return tooltip;
		}
	}

	function onDeath( _fatalityType )
	{
		if (::MSU.isNull(this.m.WardenEntity))
			return;

		this.m.WardenEntity.killSilently();
		this.m.WardenEntity = null;
	}

	function findTileToSpawnWarden()
	{
		local ActorTile = this.getContainer().getActor().getTile();
		local MapSize = this.Tactical.getMapSize();
		local EmptyTiles = [];

		for( local x = 0; x < MapSize.X; x = ++x )
		{
			for( local y = 0; y < MapSize.Y; y = ++y )
			{
				local tile = this.Tactical.getTileSquare(x, y);

				if (tile.IsEmpty && tile.getDistanceTo(ActorTile) <= 3)
				{
					EmptyTiles.push(tile);
				}
			}
		}

		if (EmptyTiles.len() != 0)
		{
			local random = this.Math.rand(0, EmptyTiles.len() - 1);
			return EmptyTiles[random];
		}

		return null;
	}


	function summonWarden()
	{
		if (this.m.WardenSummonSpent == false && ::MSU.isNull(this.m.WardenEntity))
		{
			local WardenSpawnTile = this.findTileToSpawnWarden();

			if (WardenSpawnTile != null)
			{
				local entity = this.Tactical.spawnEntity("scripts/entity/tactical/legend_vala_warden_script", WardenSpawnTile.Coords.X, WardenSpawnTile.Coords.Y);
				entity.setName(this.getContainer().getActor().m.Name + "\'s Warden");
				entity.setFaction(this.Const.Faction.PlayerAnimals);
				entity.setVala(this);
				entity.setWardenStats(this.getContainer().getActor().getBravery());
				this.m.WardenEntity = ::MSU.asWeakTableRef(entity);
				this.m.WardenSummonSpent = true;

				if (this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.LegendValaSpiritualBond))
				{
					if (!this.getContainer().getActor().getSkills().hasEffect(::Legends.Effect.LegendValaSpiritualBondEffect))
					{
						::Legends.Effects.grant(this, ::Legends.Effect.LegendValaSpiritualBondEffect, function(_effect) {
							_effect.setVala(this);
						}.bindenv(this));
					}
					::Legends.Effects.grant(this.m.WardenEntity, ::Legends.Effect.LegendValaWardenDamage, function(_effect) {
						_effect.setDamageBonus(this.getContainer().getActor().getBravery());
					}.bindenv(this));
				}

				local effect = {
					Delay = 0,
					Quantity = 12,
					LifeTimeQuantity = 12,
					SpawnRate = 100,
					Brushes = [
						"bust_ghost_01"
					],
					Stages = [
						{
							LifeTimeMin = 1.0,
							LifeTimeMax = 1.0,
							ColorMin = this.createColor("ffffff5f"),
							ColorMax = this.createColor("ffffff5f"),
							ScaleMin = 1.0,
							ScaleMax = 1.0,
							RotationMin = 0,
							RotationMax = 0,
							VelocityMin = 80,
							VelocityMax = 100,
							DirectionMin = this.createVec(-1.0, -1.0),
							DirectionMax = this.createVec(1.0, 1.0),
							SpawnOffsetMin = this.createVec(-10, -10),
							SpawnOffsetMax = this.createVec(10, 10),
							ForceMin = this.createVec(0, 0),
							ForceMax = this.createVec(0, 0)
						},
						{
							LifeTimeMin = 1.0,
							LifeTimeMax = 1.0,
							ColorMin = this.createColor("ffffff2f"),
							ColorMax = this.createColor("ffffff2f"),
							ScaleMin = 0.9,
							ScaleMax = 0.9,
							RotationMin = 0,
							RotationMax = 0,
							VelocityMin = 80,
							VelocityMax = 100,
							DirectionMin = this.createVec(-1.0, -1.0),
							DirectionMax = this.createVec(1.0, 1.0),
							ForceMin = this.createVec(0, 0),
							ForceMax = this.createVec(0, 0)
						},
						{
							LifeTimeMin = 0.1,
							LifeTimeMax = 0.1,
							ColorMin = this.createColor("ffffff00"),
							ColorMax = this.createColor("ffffff00"),
							ScaleMin = 0.1,
							ScaleMax = 0.1,
							RotationMin = 0,
							RotationMax = 0,
							VelocityMin = 80,
							VelocityMax = 100,
							DirectionMin = this.createVec(-1.0, -1.0),
							DirectionMax = this.createVec(1.0, 1.0),
							ForceMin = this.createVec(0, 0),
							ForceMax = this.createVec(0, 0)
						}
					]
				};
				this.Tactical.spawnParticleEffect(false, effect.Brushes, this.m.WardenEntity.getTile(), effect.Delay, effect.Quantity, effect.LifeTimeQuantity, effect.SpawnRate, effect.Stages, this.createVec(0, 40));
				this.Sound.play("sounds/enemies/ghost_death_01.wav");
			}
		}
	}


	function onCombatStarted()
	{
		this.m.WardenSummonSpent = false;
		this.summonWarden();
	}

	function onTurnStart()
	{
		this.summonWarden();
	}

	function onCombatFinished()
	{
		this.m.WardenEntity = null;
		//::Legends.Effects.remove(this, ::Legends.Effect.LegendValaSpiritualBondEffect);
	}
});
