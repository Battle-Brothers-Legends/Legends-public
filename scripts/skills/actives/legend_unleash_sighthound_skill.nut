this.legend_unleash_sighthound_skill <- this.inherit("scripts/skills/actives/legend_unleash_animal_skill", {
	m = {
		Entity = null,
		EntityName = "Sighthound",
		Script = "scripts/entity/tactical/legend_sighthound",
		Sounds0 = [
			"sounds/enemies/wardog_hurt_00.wav",
			"sounds/enemies/wardog_hurt_01.wav",
			"sounds/enemies/wardog_hurt_02.wav",
			"sounds/enemies/wardog_hurt_03.wav",
			"sounds/enemies/wardog_hurt_04.wav",
			"sounds/enemies/wardog_hurt_05.wav"
		],
		Sounds1 = [
			"sounds/enemies/wardog_death_00.wav",
			"sounds/enemies/wardog_death_01.wav",
			"sounds/enemies/wardog_death_02.wav",
			"sounds/enemies/wardog_death_03.wav"
		],
		Sounds2 = [
			"sounds/enemies/wardog_flee_00.wav",
			"sounds/enemies/wardog_flee_01.wav",
			"sounds/enemies/wardog_flee_02.wav",
			"sounds/enemies/wardog_flee_03.wav",
			"sounds/enemies/wardog_flee_04.wav"
		],
		Sounds3 = [
			"sounds/enemies/wardog_idle_01.wav",
			"sounds/enemies/wardog_idle_02.wav",
			"sounds/enemies/wardog_idle_03.wav",
			"sounds/enemies/wardog_idle_04.wav",
			"sounds/enemies/wardog_idle_05.wav"
		],
		Sounds4 = [
			"sounds/enemies/wardog_charge_00.wav",
			"sounds/enemies/wardog_charge_01.wav",
			"sounds/enemies/wardog_charge_02.wav"
		],
		Sounds5 = [
			"sounds/enemies/wardog_charge_00.wav",
			"sounds/enemies/wardog_charge_01.wav",
			"sounds/enemies/wardog_charge_02.wav"
		]
	},

	function setItem(_i) {
		this.m.Item = this.WeakTableRef(_i);
	}

	function create() {
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendUnleashSighthound);
		this.m.Description = "Summon a faithful sighthound. Needs a free tile adjacent. Can only summon one per combat.";
		this.m.Icon = "skills/unleash_dawg.png";
		this.m.IconDisabled = "skills/unleash_dawg_sw.png";
		this.m.Overlay = "unleash_dawg";
		this.m.SoundOnUse = [
			"sounds/combat/unleash_wardog_01.wav",
			"sounds/combat/unleash_wardog_02.wav",
			"sounds/combat/unleash_wardog_03.wav",
			"sounds/combat/unleash_wardog_04.wav"
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

	function addResources() {
		this.legend_unleash_animal_skill.addResources();
		foreach (r in m.Sounds0) {
			this.Tactical.addResource(r);
		}
		foreach (r in m.Sounds1) {
			this.Tactical.addResource(r);
		}
		foreach (r in m.Sounds2) {
			this.Tactical.addResource(r);
		}
		foreach (r in m.Sounds3) {
			this.Tactical.addResource(r);
		}
		foreach (r in m.Sounds4) {
			this.Tactical.addResource(r);
		}
		foreach (r in m.Sounds5) {
			this.Tactical.addResource(r);
		}
	}

	function getTooltip() {
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

	function isUsable() {
		if (this.getContainer().hasEffect(::Legends.Effect.LegendSummonedSighthoundEffect)) {
			return false;
		}

		if (this.m.Entity != null || !this.legend_unleash_animal_skill.isUsable()) {
			return false;
		}

		return true;
	}

	function onVerifyTarget(_originTile, _targetTile) {
		local actor = this.getContainer().getActor();
		return this.legend_unleash_animal_skill.onVerifyTarget(_originTile, _targetTile)
			&& _targetTile.IsEmpty;
	}

	function onUse(_user, _targetTile) {
		::Legends.Effects.grant(_user, ::Legends.Effect.LegendSummonedSighthoundEffect);
		local entity = this.Tactical.spawnEntity(this.m.Script, _targetTile.Coords.X, _targetTile.Coords.Y);
		entity.setFaction(this.Const.Faction.PlayerAnimals);
		entity.setItem(this.m.Item);
		entity.setName(this.m.Item.getName());
		entity.setVariant(this.m.Item.getVariant());
		this.m.Item.setEntity(entity);

		if (this.m.Item.getArmorScript() != null) {
			local item = this.new(this.m.Item.getArmorScript());
			entity.getItems().equip(item);
		}

		if (this.getContainer().hasSkill("background.houndmaster")) {
			entity.setMoraleState(this.Const.MoraleState.Confident);
		}

		this.addAnimalSkills(entity);

		if (!this.World.getTime().IsDaytime) {
			::Legends.Effects.grant(entity, ::Legends.Effect.Night);
		}

		return true;
	}

	function onCombatFinished() {
		this.m.Entity = null;
	}

});
