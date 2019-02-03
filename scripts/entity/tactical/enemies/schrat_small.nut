this.schrat_small <- this.inherit("scripts/entity/tactical/actor", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.SchratSmall;
		this.m.BloodType = this.Const.BloodType.Wood;
		this.m.XP = this.Const.Tactical.Actor.SchratSmall.XP;
		this.m.BloodSplatterOffset = this.createVec(0, -20);
		this.m.DecapitateSplatterOffset = this.createVec(-10, -25);
		this.m.DecapitateBloodAmount = 1.0;
		this.m.DeathBloodAmount = 0.35;
		this.m.ConfidentMoraleBrush = "icon_confident_orcs";
		this.actor.create();
		this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/schrat_hurt_shield_up_01.wav",
			"sounds/enemies/schrat_hurt_shield_up_02.wav",
			"sounds/enemies/schrat_hurt_shield_up_03.wav",
			"sounds/enemies/schrat_hurt_shield_up_04.wav",
			"sounds/enemies/schrat_hurt_shield_up_05.wav",
			"sounds/enemies/schrat_hurt_shield_up_06.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Resurrect] = [
			"sounds/enemies/schrat_regrowth_01.wav",
			"sounds/enemies/schrat_regrowth_02.wav",
			"sounds/enemies/schrat_regrowth_03.wav",
			"sounds/enemies/schrat_regrowth_04.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/sapling_death_01.wav",
			"sounds/enemies/sapling_death_02.wav",
			"sounds/enemies/sapling_death_03.wav",
			"sounds/enemies/sapling_death_04.wav",
			"sounds/enemies/sapling_death_05.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/schrat_idle_01.wav",
			"sounds/enemies/schrat_idle_02.wav",
			"sounds/enemies/schrat_idle_03.wav",
			"sounds/enemies/schrat_idle_04.wav",
			"sounds/enemies/schrat_idle_05.wav",
			"sounds/enemies/schrat_idle_06.wav",
			"sounds/enemies/schrat_idle_07.wav",
			"sounds/enemies/schrat_idle_08.wav",
			"sounds/enemies/schrat_idle_09.wav",
			"sounds/ambience/terrain/forest_branch_crack_00.wav",
			"sounds/ambience/terrain/forest_branch_crack_01.wav",
			"sounds/ambience/terrain/forest_branch_crack_02.wav",
			"sounds/ambience/terrain/forest_branch_crack_03.wav",
			"sounds/ambience/terrain/forest_branch_crack_04.wav",
			"sounds/ambience/terrain/forest_branch_crack_05.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Move] = this.m.Sound[this.Const.Sound.ActorEvent.Idle];
		this.m.SoundVolume[this.Const.Sound.ActorEvent.DamageReceived] = 4.0;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Resurrect] = 4.0;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Death] = 4.0;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Idle] = 1.5;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Move] = 1.5;
		this.m.SoundPitch = this.Math.rand(101, 110) * 0.01;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/direwolf_agent");
		this.m.AIAgent.setActor(this);
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		if (_tile != null)
		{
			local flip = this.Math.rand(0, 100) < 50;
			local decal;
			this.m.IsCorpseFlipped = flip;
			local body = this.getSprite("body");
			decal = _tile.spawnDetail("bust_schrat_body_small_01_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
			decal.Color = body.Color;
			decal.Saturation = body.Saturation;
			decal.Scale = 0.95;
			this.spawnTerrainDropdownEffect(_tile);
			local corpse = clone this.Const.Corpse;
			corpse.CorpseName = "A " + this.getName();
			corpse.IsHeadAttached = true;
			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);
		}

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function onInit()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.SchratSmall);
		b.IsImmuneToBleeding = true;
		b.IsImmuneToPoison = true;
		b.IsImmuneToKnockBackAndGrab = true;
		b.IsImmuneToStun = true;
		b.IsImmuneToRoot = true;
		b.IsIgnoringArmorOnAttack = true;
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		body.setBrush("bust_schrat_body_small_01");
		body.varySaturation(0.2);
		body.varyColor(0.05, 0.05, 0.05);
		this.m.BloodColor = body.Color;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.54;
		this.setSpriteOffset("status_rooted", this.createVec(0, 0));
		this.setSpriteOffset("status_stunned", this.createVec(-10, -10));
		this.setSpriteOffset("arrow", this.createVec(-10, -10));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
		this.m.Skills.add(this.new("scripts/skills/actives/uproot_small_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/uproot_small_zoc_skill"));
	}

	function onDamageReceived( _attacker, _skill, _hitInfo )
	{
		_hitInfo.BodyPart = this.Const.BodyPart.Body;
		return this.actor.onDamageReceived(_attacker, _skill, _hitInfo);
	}

	function onUpdateInjuryLayer()
	{
		local body = this.getSprite("body");
		local p = this.m.Hitpoints / this.getHitpointsMax();

		if (p >= 0.5)
		{
			body.setBrush("bust_schrat_body_small_01");
		}
		else
		{
			body.setBrush("bust_schrat_body_small_01_injured");
		}

		this.setDirty(true);
	}

});
