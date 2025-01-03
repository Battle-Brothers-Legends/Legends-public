this.legend_kobold <- this.inherit("scripts/entity/tactical/actor", {
	m = {},
	function create()
	{
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.BloodSplatterOffset = this.createVec(-10, 15);
		this.m.DecapitateSplatterOffset = this.createVec(20, -20);
		this.m.ConfidentMoraleBrush = "icon_confident_orcs";
		this.actor.create();
		this.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/kobold_death_01.wav",
			"sounds/enemies/kobold_death_02.wav",
			"sounds/enemies/kobold_death_03.wav",
			"sounds/enemies/kobold_death_04.wav",
			"sounds/enemies/kobold_death_05.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Flee] = [
			"sounds/enemies/kobold_flee_01.wav",
			"sounds/enemies/kobold_flee_02.wav",
			"sounds/enemies/kobold_flee_03.wav",
			"sounds/enemies/kobold_flee_04.wav",
			"sounds/enemies/kobold_flee_05.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/kobold_hurt_01.wav",
			"sounds/enemies/kobold_hurt_02.wav",
			"sounds/enemies/kobold_hurt_03.wav",
			"sounds/enemies/kobold_hurt_04.wav",
			"sounds/enemies/kobold_hurt_05.wav",
			"sounds/enemies/kobold_hurt_06.wav",
			"sounds/enemies/kobold_hurt_07.wav",
			"sounds/enemies/kobold_hurt_08.wav",
			"sounds/enemies/kobold_hurt_09.wav",
			"sounds/enemies/kobold_hurt_10.wav",
			"sounds/enemies/kobold_hurt_11.wav",
			"sounds/enemies/kobold_hurt_12.wav",
			"sounds/enemies/kobold_hurt_13.wav",
			"sounds/enemies/kobold_hurt_14.wav",
			"sounds/enemies/kobold_hurt_15.wav",
			"sounds/enemies/kobold_hurt_16.wav",
			"sounds/enemies/kobold_hurt_17.wav",
			"sounds/enemies/kobold_hurt_18.wav",
			"sounds/enemies/kobold_hurt_19.wav",
			"sounds/enemies/kobold_hurt_20.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Attack] = [
			"sounds/enemies/kobold_attack_01.wav",
			"sounds/enemies/kobold_attack_02.wav",
			"sounds/enemies/kobold_attack_03.wav",
			"sounds/enemies/kobold_attack_04.wav",
			"sounds/enemies/kobold_attack_05.wav",
			"sounds/enemies/kobold_attack_06.wav",
			"sounds/enemies/kobold_attack_07.wav",
			"sounds/enemies/kobold_attack_08.wav",
			"sounds/enemies/kobold_attack_09.wav",
			"sounds/enemies/kobold_attack_10.wav",
			"sounds/enemies/kobold_attack_11.wav",
			"sounds/enemies/kobold_attack_12.wav",
			"sounds/enemies/kobold_attack_13.wav",
			"sounds/enemies/kobold_attack_14.wav",
			"sounds/enemies/kobold_attack_15.wav",
			"sounds/enemies/kobold_attack_16.wav",
			"sounds/enemies/kobold_attack_17.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/kobold_idle_01.wav",
			"sounds/enemies/kobold_idle_02.wav",
			"sounds/enemies/kobold_idle_03.wav",
			"sounds/enemies/kobold_idle_04.wav",
			"sounds/enemies/kobold_idle_05.wav",
			"sounds/enemies/kobold_idle_06.wav",
			"sounds/enemies/kobold_idle_07.wav",
			"sounds/enemies/kobold_idle_08.wav",
			"sounds/enemies/kobold_idle_09.wav",
			"sounds/enemies/kobold_idle_10.wav",
			"sounds/enemies/kobold_idle_11.wav",
			"sounds/enemies/kobold_idle_12.wav",
			"sounds/enemies/kobold_idle_13.wav",
			"sounds/enemies/kobold_idle_14.wav",
			"sounds/enemies/kobold_idle_15.wav",
			"sounds/enemies/kobold_idle_16.wav",
			"sounds/enemies/kobold_idle_17.wav",
			"sounds/enemies/kobold_idle_18.wav",
			"sounds/enemies/kobold_idle_19.wav",
			"sounds/enemies/kobold_idle_20.wav",
			"sounds/enemies/kobold_idle_21.wav"
		];
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Death] = 0.9;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Flee] = 1.0;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.DamageReceived] = 0.5;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Idle] = 1.25;
		this.m.SoundPitch = this.Math.rand(150, 160) * 0.01;
		this.m.Flags.add("goblin");
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		local flip = this.Math.rand(1, 100) < 50;

		if (_tile != null)
		{
			this.m.IsCorpseFlipped = flip;
			local decal;
			local skin = this.getSprite("body");
			decal = _tile.spawnDetail(this.getSprite("body").getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
			decal.Color = skin.Color;
			decal.Saturation = skin.Saturation;
			decal.setBrightness(0.9);
			decal.Scale = 0.95;
			_tile.spawnDetail(this.getItems().getAppearance().CorpseArmor, this.Const.Tactical.DetailFlag.Corpse, flip);

			if (_fatalityType != this.Const.FatalityType.Decapitated)
			{
				if (!this.getItems().getAppearance().HideCorpseHead)
				{
					decal = _tile.spawnDetail(this.getSprite("head").getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
					decal.Color = skin.Color;
					decal.Saturation = skin.Saturation;
					decal.setBrightness(0.9);
					decal.Scale = 0.95;
				}

				if (this.getItems().getAppearance().HelmetCorpse != "")
				{
					decal = _tile.spawnDetail(this.getItems().getAppearance().HelmetCorpse, this.Const.Tactical.DetailFlag.Corpse, flip);
					decal.setBrightness(0.9);
					decal.Scale = 0.95;
				}
			}
			else if (_fatalityType == this.Const.FatalityType.Decapitated)
			{
				local layers = [
					this.getSprite("head").getBrush().Name + "_dead",
					this.getItems().getAppearance().HelmetCorpse
				];
				local decap = this.Tactical.spawnHeadEffect(this.getTile(), layers, this.createVec(-50, 30), 180.0, this.getSprite("head").getBrush().Name + "_dead_bloodpool");
				decap[0].Color = skin.Color;
				decap[0].Saturation = skin.Saturation;
				decap[0].setBrightness(0.9);
				decap[0].Scale = 0.95;

				if (decap.len() >= 2)
				{
					decap[1].setBrightness(0.9);
				}
			}

			if (_fatalityType == this.Const.FatalityType.Disemboweled)
			{
				local decal = _tile.spawnDetail("bust_goblin_body_dead_guts", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.95;
			}
			else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Arrow)
			{
				decal = _tile.spawnDetail("bust_body_19_dead_arrows", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.95;
			}
			else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Javelin)
			{
				decal = _tile.spawnDetail("bust_body_19_dead_javelin", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.95;
			}

			this.spawnTerrainDropdownEffect(_tile);
			local corpse = clone this.Const.Corpse;
			corpse.CorpseName = "A " + this.getName();
			corpse.Tile = _tile;
			corpse.IsResurrectable = false;
			corpse.IsConsumable = true;
			corpse.Items = this.getItems();
			corpse.IsHeadAttached = _fatalityType != this.Const.FatalityType.Decapitated;
			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);
		}

		this.getItems().dropAll(_tile, _killer, flip);
		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function onAppearanceChanged( _appearance, _setDirty = true )
	{
		_appearance.Quiver = "bust_goblin_quiver";
		this.actor.onAppearanceChanged(_appearance, _setDirty);
	}

	function onFactionChanged()
	{
		this.actor.onFactionChanged();
	}

	function onInit()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.GoblinAmbusher);
		b.IsFleetfooted = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.m.Items.getAppearance().Body = "bust_kobold_01";
		this.addSprite("socket").setBrush("bust_base_goblins");
		local quiver = this.addSprite("quiver");
		quiver.Visible = false;
		local variant = this.Math.rand(1,5);
		local body = this.addSprite("body");
		body.setBrush("bust_kobold_0" + variant);
		body.varySaturation(0.3);
		body.varyColor(0.1, 0.1, 0.1);
		local injury_body = this.addSprite("injury_body");
		injury_body.Visible = false;
		injury_body.setBrush("bust_kobold_0" + variant + "_damaged");
		local head = this.addSprite("head");
		head.Saturation = body.Saturation;
		head.Color = body.Color;
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_goblin_01_head_injured");
		local body_blood = this.addSprite("body_blood");
		body_blood.Visible = false;
		this.m.Skills.add(this.new("scripts/skills/racial/legend_kobold_racial"));
		this.m.Skills.add(this.new("scripts/skills/effects/captain_effect"));
		this.m.Skills.add(this.new("scripts/skills/special/double_grip"));
		this.m.Skills.add(this.new("scripts/skills/actives/hand_to_hand"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_boondock_blade"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_tumble"));
		this.m.Skills.add(this.new("scripts/skills/actives/wake_ally_skill"));
	}

	function onAfterInit()
	{
		this.getSprite("status_rooted").Scale = 0.47;
		this.setSpriteOffset("status_rooted", this.createVec(0, -5));
		this.actor.onAfterInit();
	}

});

