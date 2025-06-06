this.legend_dawg <- this.inherit("scripts/entity/tactical/actor", {

	m = {
		Name = "Dawg"
	}

	function create() {
		this.actor.create();
		m.Type				= this.Const.EntityType.Wardog;
		m.BloodType			= this.Const.BloodType.Red;
		m.XP				= this.Const.Tactical.Actor.Wardog.XP;

		m.IsActingImmediately		= true;
		m.BloodSplatterOffset		= createVec(0, 0);
		m.DecapitateSplatterOffset	= createVec(-4, -25);
		m.DecapitateBloodAmount		= 0.5;

		m.Sound[Const.Sound.ActorEvent.DamageReceived]	= [ "sounds/enemies/wardog_hurt_00.wav", "sounds/enemies/wardog_hurt_01.wav", "sounds/enemies/wardog_hurt_02.wav", "sounds/enemies/wardog_hurt_03.wav", "sounds/enemies/wardog_hurt_04.wav", "sounds/enemies/wardog_hurt_05.wav" ];
		m.Sound[Const.Sound.ActorEvent.Death]			= [ "sounds/enemies/wardog_death_00.wav", "sounds/enemies/wardog_death_01.wav", "sounds/enemies/wardog_death_02.wav", "sounds/enemies/wardog_death_03.wav" ];
		m.Sound[Const.Sound.ActorEvent.Flee]			= [ "sounds/enemies/wardog_flee_00.wav", "sounds/enemies/wardog_flee_01.wav", "sounds/enemies/wardog_flee_02.wav", "sounds/enemies/wardog_flee_03.wav", "sounds/enemies/wardog_flee_04.wav" ];
		m.Sound[Const.Sound.ActorEvent.Idle]			= [ "sounds/enemies/wardog_idle_01.wav", "sounds/enemies/wardog_idle_02.wav", "sounds/enemies/wardog_idle_03.wav", "sounds/enemies/wardog_idle_04.wav", "sounds/enemies/wardog_idle_05.wav" ];
		m.Sound[Const.Sound.ActorEvent.Move]			= [ "sounds/enemies/wardog_charge_00.wav", "sounds/enemies/wardog_charge_01.wav", "sounds/enemies/wardog_charge_02.wav" ];

		// create AI agent
		m.AIAgent = new("scripts/ai/tactical/agents/wardog_agent");
		m.AIAgent.setActor(this);
	}

	function setVariant(_v) {
		::logInfo("Dawg: setVariant=" + _v);
		local variants = ["1", "2"];
		local variant = variants[_v % variants.len()];
		getSprite("body").setBrush("bust_dawg_01_body_0" + variant);
		getSprite("head").setBrush("bust_dawg_01_head_0" + variant);
		setDirty(true);
	}

	function onDeath(_killer, _skill, _tile, _fatalityType) {
		// spawn corpse
		if(_tile != null)
		{
			local flip = Math.rand(0, 100) < 50;
			local appearance = getItems().getAppearance();
			local decal;
			this.m.IsCorpseFlipped = flip;

			decal = _tile.spawnDetail(getSprite("body").getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
			decal.setBrightness(0.9);
			decal.Scale = 0.95;

			if (appearance.CorpseArmor != "") {
				decal = _tile.spawnDetail(appearance.CorpseArmor, this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.setBrightness(0.9);
				decal.Scale = 0.95;
			}

			if (_fatalityType != this.Const.FatalityType.Decapitated) {
				// no fatality
				decal = _tile.spawnDetail(getSprite("head").getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.setBrightness(0.9);
				decal.Scale = 0.95;
			} else if(_fatalityType == this.Const.FatalityType.Decapitated) {
				// decapitated
				local layers = [ getSprite("head").getBrush().Name + "_dead" ];
				local decap = Tactical.spawnHeadEffect(getTile(), layers, createVec(-15, 5), 0.0, getSprite("head").getBrush().Name + "_dead_bloodpool");

				decap[0].setBrightness(0.9);
				decap[0].Scale = 0.95;
				decap[0].setHorizontalFlipping(true);
			}

			if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Arrow) {
				_tile.spawnDetail(getSprite("body").getBrush().Name + "_dead_arrows", this.Const.Tactical.DetailFlag.Corpse, flip);
			} else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Javelin) {
				_tile.spawnDetail(getSprite("body").getBrush().Name + "_dead_javelin", this.Const.Tactical.DetailFlag.Corpse, flip);
			}

			spawnTerrainDropdownEffect(_tile);

			local corpse = clone this.Const.Corpse;
			corpse.CorpseName		= getName();
			corpse.IsHeadAttached	= _fatalityType != this.Const.FatalityType.Decapitated;
			corpse.IsResurrectable	= false;

			_tile.Properties.set("Corpse", corpse);
			Tactical.Entities.addCorpse(_tile);
		}

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function onFactionChanged() {
		this.actor.onFactionChanged();

		local flip = !isAlliedWithPlayer();
		getSprite("body").setHorizontalFlipping(flip);
		getSprite("armor").setHorizontalFlipping(flip);
		getSprite("head").setHorizontalFlipping(flip);
		getSprite("injury").setHorizontalFlipping(flip);
		getSprite("closed_eyes").setHorizontalFlipping(flip);

		if (!Tactical.State.isScenarioMode()) {
			local f = World.FactionManager.getFaction(getFaction());
			if (f != null) {
				getSprite("socket").setBrush(f.getTacticalBase());
			}
		} else {
			getSprite("socket").setBrush(Const.FactionBase[getFaction()]);
		}
	}

	function onActorKilled(_actor, _tile, _skill)
	{
		actor.onActorKilled(_actor, _tile, _skill);

		if(getFaction() == this.Const.Faction.Player || getFaction() == this.Const.Faction.PlayerAnimals) {
			local XPgroup = _actor.getXPValue();

			local brothers = Tactical.Entities.getInstancesOfFaction(Const.Faction.Player);
			foreach (bro in brothers) {
				if (bro.getCurrentProperties().IsAllyXPBlocked) {
					return;
				}

				bro.addXP(Math.max(1, Math.floor(XPgroup / brothers.len())));
			}
		}
	}


	//////////////////////////////////////////////////////
	// C++ Interface
	//////////////////////////////////////////////////////

	function onInit() {
		actor.onInit();

		// stats
		local b = m.BaseProperties;
		b.setValues(Const.Tactical.Actor.Wardog);
		b.TargetAttractionMult	= 0.1;
		b.IsAffectedByInjuries	= false;
		b.IsImmuneToDisarm		= true;

		m.ActionPoints			= b.ActionPoints;
		m.Hitpoints				= b.Hitpoints;
		m.CurrentProperties 	= clone b;

		m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		m.FatigueCosts = this.Const.DefaultMovementFatigueCost;

		local variant = Math.rand(1, 2);

		// inventory
		m.Items.getAppearance().Body = "bust_dawg_01_body_0" + variant;

		// appearance
		addSprite("socket").setBrush("bust_base_player");

		local body = addSprite("body");
		body.setBrush("bust_dawg_01_body_0" + variant);

		local armor = addSprite("armor");

		addSprite("head").setBrush("bust_dawg_01_head_0" + variant);

		local closed_eyes = addSprite("closed_eyes");
		closed_eyes.setBrush("bust_dawg_01_body_0" + variant + "_eyes_closed");
		closed_eyes.Visible = false;

		local injury = addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_awg_01_injured");

		// add default status sprites
		addDefaultStatusSprites();

		getSprite("status_rooted").Scale = 0.46;
		setSpriteOffset("status_rooted", createVec(8, -15));

		setSpriteOffset("status_stunned", createVec(0, -25));
		setSpriteOffset("arrow", createVec(0, -25));

		// skills
		m.Skills.add(new("scripts/skills/actives/wardog_bite"));
		m.Skills.add(new("scripts/skills/perks/perk_pathfinder"));
		m.Skills.add(new("scripts/skills/perks/perk_steel_brow"));
		m.Skills.add(new("scripts/skills/perks/perk_overwhelm"));
	}


})
