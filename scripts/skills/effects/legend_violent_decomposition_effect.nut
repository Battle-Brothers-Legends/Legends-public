this.legend_violent_decomposition_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 1,
		DamageData = null,
		ActorID = null,
	},
	function setDamage( _data )
	{
		this.m.DamageData = _data;
	}

	function setActorID( _id )
	{
		this.m.ActorID = _id
	}

	function getAttacker()
	{
		if (this.m.ActorID != null)
		{
			local e = this.Tactical.getEntityByID(this.m.ActorID);

			if (e != null && e.isPlacedOnMap() && e.isAlive() && !e.isDying())
			{
				return e;
			}
		}

		return this.getContainer().getActor();
	}

	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendViolentDecompositionEffect);
		this.m.Icon = "skills/status_effect_78.png";
		this.m.IconMini = "status_effect_78_mini";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.SoundOnUse = [
			"sounds/enemies/ghoul_death_fullbelly_01.wav",
			"sounds/enemies/ghoul_death_fullbelly_02.wav",
			"sounds/enemies/ghoul_death_fullbelly_03.wav"
		];
		this.m.IsActive = false;
		this.m.IsStacking = true;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This summon is set to explode in [color=%negative%]" + this.m.TurnsLeft + "[/color] turn(s).";
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
			}
		];

		return ret;
	}

	function onAdded()
	{
		if (this.getContainer().getActor().getFlags().has("skeleton"))
		{
			// change explosion sound for skeleton minion
			this.m.SoundOnUse = [
				"sounds/enemies/dlc6/skull_bang_01.wav",
				"sounds/enemies/dlc6/skull_bang_02.wav",
				"sounds/enemies/dlc6/skull_bang_03.wav",
				"sounds/enemies/dlc6/skull_bang_04.wav"
			];
		}

		this.m.TurnsLeft = 1;

		if (this.m.SoundOnUse.len() != 0)
		{
			this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.25, this.getContainer().getActor().getPos());
		}
	}

	function applyDamage()
	{
		if (this.m.TurnsLeft > 0 || this.m.DamageData == null)
		{
			return;
		}

		//BLOW UP
		local actor = this.getContainer().getActor();
		local ownTile = actor.getTile();
		local mult = 2 - actor.getHitpointsPct(); // for every percentage of missing hp, increasing the equal amount percentage of bonus damage
		local data = this.m.DamageData;
		local attacker = this.getAttacker();

		if ("TotalDamageMult" in data)
		{
			mult *= data.TotalDamageMult;
		}

		//this.spawnIcon("status_effect_78", actor.getTile());

		this.spawnEffectOnTile(ownTile);
		for( local i = 5; i >= 0; i = --i )
		{
			if (!ownTile.hasNextTile(i))
			{
				continue;
			}

			local tile = ownTile.getNextTile(i);

			if (!tile.IsEmpty && tile.getEntity().isAttackable() && this.Math.abs(tile.Level - ownTile.Level) <= 1)
			{
				local damage = this.Math.rand(data.MinDamage, data.MaxDamage) * mult;
				local hitInfo = clone this.Const.Tactical.HitInfo;
				hitInfo.DamageRegular = damage;
				hitInfo.DamageArmor = damage * data.ArmorDamageMult;
				hitInfo.DamageDirect = data.DirectDamageMult;
				hitInfo.BodyPart = this.Const.BodyPart.Body;
				tile.getEntity().onDamageReceived(attacker, this, hitInfo);
			}
		}

		actor.kill(null, null, this.Const.FatalityType.Suicide, false);
	}

	function onUpdate( _properties )
	{
	}

	function onNewRound()
	{
		--this.m.TurnsLeft;
	}

	function onTurnEnd()
	{
		this.applyDamage();
	}

	function onWaitTurn()
	{
		this.applyDamage();
	}

	function spawnEffectOnTile( _tile )
	{
		// explosion effect
		local effect = {
			Delay = 0,
			Quantity = 80,
			LifeTimeQuantity = 80,
			SpawnRate = 400,
			Brushes = [
				"blood_splatter_bones_01",
				"blood_splatter_bones_03",
				"blood_splatter_bones_04",
				"blood_splatter_bones_05",
				"blood_splatter_bones_06"
			],
			Stages = [
				{
					LifeTimeMin = 1.0,
					LifeTimeMax = 1.0,
					ColorMin = this.createColor("ffffffff"),
					ColorMax = this.createColor("ffffffff"),
					ScaleMin = 1.0,
					ScaleMax = 1.5,
					RotationMin = 0,
					RotationMax = 0,
					VelocityMin = 200,
					VelocityMax = 300,
					DirectionMin = this.createVec(-1.0, -1.0),
					DirectionMax = this.createVec(1.0, 1.0),
					SpawnOffsetMin = this.createVec(0, 0),
					SpawnOffsetMax = this.createVec(0, 0),
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				},
				{
					LifeTimeMin = 0.75,
					LifeTimeMax = 1.0,
					ColorMin = this.createColor("ffffff8f"),
					ColorMax = this.createColor("ffffff8f"),
					ScaleMin = 0.9,
					ScaleMax = 0.9,
					RotationMin = 0,
					RotationMax = 0,
					VelocityMin = 200,
					VelocityMax = 300,
					DirectionMin = this.createVec(-1.0, -1.0),
					DirectionMax = this.createVec(1.0, 1.0),
					ForceMin = this.createVec(0, -100),
					ForceMax = this.createVec(0, -100)
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
					VelocityMin = 200,
					VelocityMax = 300,
					DirectionMin = this.createVec(-1.0, -1.0),
					DirectionMax = this.createVec(1.0, 1.0),
					ForceMin = this.createVec(0, -100),
					ForceMax = this.createVec(0, -100)
				}
			]
		};
		this.Tactical.spawnParticleEffect(false, effect.Brushes, _tile, effect.Delay, effect.Quantity, effect.LifeTimeQuantity, effect.SpawnRate, effect.Stages, this.createVec(0, 50));
	}

});
