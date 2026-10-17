this.legend_infatuated_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 5,
		OriginalFaction = 0,
		OriginalAgent = null,
		OriginalSocket = null,
		MasterFaction = 0,
		Master = null
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendInfatuated);
		this.m.Description = "Charmed and no longer in any control over %their% actions, a puppet with no choice but to obey %their% master.";
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/enemies/dlc2/hexe_charm_chimes", 4);
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "This character is under the control of a master"
			},
		]);
		return tooltip;
	}

	function setMasterFaction(_f) {
		this.m.MasterFaction = _f;
	}

	function setMaster(_f) {
		this.m.Master = _f;
	}

	function addTurns(_t) {
		this.m.TurnsLeft += _t;
	}

	function onAdded() {
		this.m.TurnsLeft = ::Math.max(1, 5 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
		local actor = this.getContainer().getActor();

		if (actor.isPlayerControlled()) {
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

		if (this.m.SoundOnUse.len() != 0) {
			::Sound.play(this.m.SoundOnUse[::Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.Skill * 1.0, actor.getPos());
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
		::Tactical.spawnParticleEffect(false, effect.Brushes, actor.getTile(), effect.Delay, effect.Quantity, effect.LifeTimeQuantity, effect.SpawnRate, effect.Stages, this.createVec(0, 40));
	}

	function onRemoved() {
		local actor = this.getContainer().getActor();

		if (this.m.SoundOnUse.len() != 0) {
			::Sound.play(this.m.SoundOnUse[::Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.Skill * 1.0, actor.getPos());
		}

		if (this.m.OriginalAgent != null) {
			actor.setAIAgent(this.m.OriginalAgent);
		}

		actor.setFaction(this.m.OriginalFaction);
		actor.getSprite("socket").setBrush(this.m.OriginalSocket);
		actor.getFlags().set("Charmed", false);
		actor.setDirty(true);

		if (this.m.Master != null) {
			this.m.Master.removeSlave(actor.getID());
			this.m.Master = null;
		}
	}

	function onDeath(_fatalityType) {
		this.onRemoved();
	}

	function onTurnEnd() {
		if (--this.m.TurnsLeft <= 0) {
			this.removeSelf();
		}
	}

	function onTurnStart() {
		if (this.m.Master != null) {
			if (!this.m.Master.isAlive()) {
				this.removeSelf();
			}
		}
	}

	function onCombatFinished() {
		local actor = this.getContainer().getActor();

		if (::Tactical.Entities.getInstancesNum(::Const.Faction.Player) == 0) {
			actor.kill(null, null, ::Const.FatalityType.Suicide);
		}

		this.skill.onCombatFinished();
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "Under the control of a master";
	}
});
