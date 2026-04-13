this.legend_intensely_charmed_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 5,
		OriginalFaction = 0,
		OriginalAgent = null,
		OriginalSocket = null,
		MasterFaction = 0,
		Master = null
	},
	function setMasterFaction( _f )
	{
		this.m.MasterFaction = _f;
	}

	function setMaster( _f )
	{
		this.m.Master = _f;
	}

	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendIntenselyCharmed);
		this.m.Icon = "skills/status_effect_85.png";
		this.m.IconMini = "status_effect_85_mini";
		this.m.Overlay = "status_effect_85";
		this.m.SoundOnUse = [
			"sounds/enemies/dlc2/hexe_charm_chimes_01.wav",
			"sounds/enemies/dlc2/hexe_charm_chimes_02.wav",
			"sounds/enemies/dlc2/hexe_charm_chimes_03.wav",
			"sounds/enemies/dlc2/hexe_charm_chimes_04.wav"
		];
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character has been charmed. They no longer have any control over their actions and are a puppet with no choice but to obey their master. Wears off in [color=%negative%]" + this.m.TurnsLeft + "[/color] turn(s).\n\nThe higher a character\'s resolve, the higher the chance to resist being charmed.";
	}

	function addTurns( _t )
	{
		this.m.TurnsLeft += _t;
	}

	function onAdded()
	{
		this.m.TurnsLeft = this.Math.max(1, 5 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
		local actor = this.getContainer().getActor();

		if (actor.isPlayerControlled())
		{
			this.m.OriginalAgent = actor.getAIAgent();
			actor.setAIAgent(this.new("scripts/ai/tactical/agents/charmed_player_agent"));
			actor.getAIAgent().setActor(actor);
		}

		this.m.OriginalFaction = actor.getFaction();
		actor.setFaction(this.m.MasterFaction);
		this.m.OriginalSocket = actor.getSprite("socket").getBrush().Name;
		actor.getSprite("socket").setBrush("bust_base_beasts");
		actor.getFlags().set("Charmed", true);
		actor.setDirty(true);

		if (this.m.SoundOnUse.len() != 0)
		{
			this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.Skill * 1.0, actor.getPos());
		}

		local effect = {
			Delay = 0,
			Quantity = 100,
			LifeTimeQuantity = 100,
			SpawnRate = 1000,
			Brushes = [
				"effect_heart_01"
			],
			Stages = [
				{
					LifeTimeMin = 2.0,
					LifeTimeMax = 2.0,
					ColorMin = this.createColor("fff3e50f"),
					ColorMax = this.createColor("ffffff5f"),
					ScaleMin = 1.0,
					ScaleMax = 1.0,
					RotationMin = 0,
					RotationMax = 0,
					VelocityMin = 80,
					VelocityMax = 100,
					DirectionMin = this.createVec(-0.5, 0.0),
					DirectionMax = this.createVec(0.5, 1.0),
					SpawnOffsetMin = this.createVec(-30, -70),
					SpawnOffsetMax = this.createVec(30, 30),
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				},
				{
					LifeTimeMin = 0.3,
					LifeTimeMax = 0.3,
					ColorMin = this.createColor("fff3e500"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.3,
					ScaleMax = 0.3,
					RotationMin = 0,
					RotationMax = 0,
					VelocityMin = 80,
					VelocityMax = 100,
					DirectionMin = this.createVec(-0.5, 0.0),
					DirectionMax = this.createVec(0.5, 1.0),
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				}
			]
		};
		this.Tactical.spawnParticleEffect(false, effect.Brushes, actor.getTile(), effect.Delay, effect.Quantity, effect.LifeTimeQuantity, effect.SpawnRate, effect.Stages, this.createVec(0, 40));
	}

	function onRemoved()
	{
		local actor = this.getContainer().getActor();

		if (this.m.SoundOnUse.len() != 0)
		{
			this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.Skill * 1.0, actor.getPos());
		}

		if (this.m.OriginalAgent != null)
		{
			actor.setAIAgent(this.m.OriginalAgent);
		}

		actor.setFaction(this.m.OriginalFaction);
		actor.getSprite("socket").setBrush(this.m.OriginalSocket);
		actor.getFlags().set("Charmed", false);
		actor.setDirty(true);

		if (this.m.Master != null)
		{
			this.m.Master.removeSlave(actor.getID());
			this.m.Master = null;
		}
	}

	function onDeath( _fatalityType )
	{
		this.onRemoved();
	}

	function onTurnEnd()
	{
		local actor = this.getContainer().getActor();

		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

	function onTurnStart()
	{
		if (this.m.Master != null)
		{
			if (!this.m.Master.isAlive())
			{
				this.removeSelf();
			}
		}
	}

	function onCombatFinished()
	{
		local actor = this.getContainer().getActor();

		if (this.Tactical.Entities.getInstancesNum(this.Const.Faction.Player) == 0)
		{
			actor.kill(null, null, this.Const.FatalityType.Suicide);
		}

		this.skill.onCombatFinished();
	}

});

