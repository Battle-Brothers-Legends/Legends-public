this.legend_stollwurm <- this.inherit("scripts/entity/tactical/actor", {
	m = {
		Tail = null,
		Mode = 0,
		DroppableRunes = [
			::Legends.Rune.LegendRsaEndurance,
			::Legends.Rune.LegendRsaSafety
		],
		MovementAPSpent = 0,
		EffectsSharedWithTail = [
			::Legends.Effect.Staggered,
			::Legends.Effect.Dazed,
			::Legends.Effect.LegendDazed,
			::Legends.Effect.LegendBaffled,
			::Legends.Effect.Withered,
			::Legends.Effect.InsectSwarm
		],
		EffectsSharedWithTailLookup = {} 
	},

	function getIdealRange() {
		return 2;
	}

	function getMode() {
		return this.m.Mode;
	}

	function setMode( _m ) {
		this.m.Mode = _m;

		if (this.isPlacedOnMap())
		{
			if (this.m.Mode == 0 && _m == 1)
			{
				this.m.IsUsingZoneOfControl = true;
				this.getTile().addZoneOfControl(this.getFaction());
			}

			this.onUpdateInjuryLayer();
		}
	}

	function getImageOffsetY() {
		return 20;
	}

	function create() {
		this.m.Type = ::Const.EntityType.LegendStollwurm;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.LegendStollwurm.XP;
		this.m.BloodSplatterOffset = this.createVec(0, 0);
		this.m.DecapitateSplatterOffset = this.createVec(-30, -15);
		this.m.DecapitateBloodAmount = 2.0;
		this.m.ConfidentMoraleBrush = "icon_confident_orcs";
		this.actor.create();
		this.m.Sound[::Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/lindwurm_hurt_01.wav",
			"sounds/enemies/lindwurm_hurt_02.wav",
			"sounds/enemies/lindwurm_hurt_03.wav",
			"sounds/enemies/lindwurm_hurt_04.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/lindwurm_death_01.wav",
			"sounds/enemies/lindwurm_death_02.wav",
			"sounds/enemies/lindwurm_death_03.wav",
			"sounds/enemies/lindwurm_death_04.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.Flee] = [
			"sounds/enemies/lindwurm_flee_01.wav",
			"sounds/enemies/lindwurm_flee_02.wav",
			"sounds/enemies/lindwurm_flee_03.wav",
			"sounds/enemies/lindwurm_flee_04.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/lindwurm_idle_01.wav",
			"sounds/enemies/lindwurm_idle_02.wav",
			"sounds/enemies/lindwurm_idle_03.wav",
			"sounds/enemies/lindwurm_idle_04.wav",
			"sounds/enemies/lindwurm_idle_05.wav",
			"sounds/enemies/lindwurm_idle_06.wav",
			"sounds/enemies/lindwurm_idle_07.wav",
			"sounds/enemies/lindwurm_idle_08.wav",
			"sounds/enemies/lindwurm_idle_09.wav",
			"sounds/enemies/lindwurm_idle_10.wav",
			"sounds/enemies/lindwurm_idle_11.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.Move] = this.m.Sound[::Const.Sound.ActorEvent.Idle];
		this.m.SoundVolume[::Const.Sound.ActorEvent.DamageReceived] = 1.5;
		this.m.SoundVolume[::Const.Sound.ActorEvent.Death] = 1.5;
		this.m.SoundVolume[::Const.Sound.ActorEvent.Flee] = 1.5;
		this.m.SoundVolume[::Const.Sound.ActorEvent.Idle] = 2.0;
		this.m.SoundVolume[::Const.Sound.ActorEvent.Move] = 1.5;
		this.m.SoundPitch = ::Math.rand(95, 105) * 0.01;
		this.getFlags().add("body_immune_to_acid");
		this.getFlags().add("head_immune_to_acid");
		this.getFlags().add("lindwurm");
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/legend_stollwurm_agent");
		this.m.AIAgent.setActor(this);

		this.m.OnDeathLootTable.extend([
			[90, "scripts/items/loot/lindwurm_hoard_item"]
		]);
		local rolls = ::Legends.S.extraLootChance(2);
		for(local i = 0; i < rolls; i++) {
			this.m.OnDeathLootTable.extend([
				[100, "scripts/items/misc/legend_stollwurm_scales_item"],
				[50, "scripts/items/misc/lindwurm_bones_item"],
				[25, "scripts/items/misc/legend_stollwurm_blood_item"],
				[25, "scripts/items/misc/legend_stollwurm_scales_item"],
				[20, "scripts/items/misc/legend_stollwurm_blood_item"],
				[30,  "scripts/items/misc/lindwurm_bones_item"],
				[50,  function () {
					local selected = this.m.DroppableRunes[::Math.rand(0, this.m.DroppableRunes.len() - 1)];
					local rune = ::new(::Legends.Runes.get(selected).Script);
					rune.setRuneVariant(selected);
					rune.setRuneBonus(true);
					rune.updateRuneSigilToken();
					return rune;
				}.bindenv(this)],
			]);
		}
		foreach(def in this.m.EffectsSharedWithTail) { // you have id:def mapping here
			this.m.EffectsSharedWithTailLookup[::Legends.Effects.getID(def)] <- def
		}
	}

	function playSound( _type, _volume, _pitch = 0.5 ) {
		if (_type == ::Const.Sound.ActorEvent.Move && ::Math.rand(1, 100) <= 50)
		{
			return;
		}

		this.actor.playSound(_type, _volume, _pitch);
	}

	function onTurnStart() {
		this.actor.onTurnStart();
		this.m.MovementAPSpent = 0;
	}

	function onDeath( _killer, _skill, _tile, _fatalityType ) {
		local flip = ::Math.rand(0, 100) < 50;
		if (_tile != null)
		{
			local decal;
			this.m.IsCorpseFlipped = flip;
			local body = this.getSprite("body");
			local head = this.getSprite("head");
			decal = _tile.spawnDetail("bust_stollwurm_body_01_dead", ::Const.Tactical.DetailFlag.Corpse, flip);
			decal.Color = body.Color;
			decal.Saturation = body.Saturation;
			decal.Scale = 0.95;

			if (_fatalityType != ::Const.FatalityType.Decapitated)
			{
				decal = _tile.spawnDetail("bust_stollwurm_head_01_dead", ::Const.Tactical.DetailFlag.Corpse, flip);
				decal.Color = head.Color;
				decal.Saturation = head.Saturation;
				decal.Scale = 0.95;
			}
			else if (_fatalityType == ::Const.FatalityType.Decapitated)
			{
				local layers = [
					head.getBrush().Name + "_dead"
				];
				local decap = ::Tactical.spawnHeadEffect(this.getTile(), layers, this.createVec(0, 0), 0.0, "bust_stollwurm_head_01_bloodpool");
				decap[0].Color = head.Color;
				decap[0].Saturation = head.Saturation;
				decap[0].Scale = 0.95;
			}

			if (_skill && _skill.getProjectileType() == ::Const.ProjectileType.Arrow)
			{
				decal = _tile.spawnDetail("bust_stollwurm_body_01_dead_arrows", ::Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.95;
			}
			else if (_skill && _skill.getProjectileType() == ::Const.ProjectileType.Javelin)
			{
				decal = _tile.spawnDetail("bust_stollwurm_body_01_dead_javelin", ::Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.95;
			}

			this.spawnTerrainDropdownEffect(_tile);
			this.spawnFlies(_tile);
		}

		local tileLoot = this.getLootForTile(_killer, []);
		local corpse = this.generateCorpse(_tile, _fatalityType, _killer);
		this.dropLoot(_tile, tileLoot, !flip);

		if (_tile == null) {
			::Tactical.Entities.addUnplacedCorpse(corpse);
		} else {
			_tile.Properties.set("Corpse", corpse);
			::Tactical.Entities.addCorpse(_tile);
		}

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function generateCorpse( _tile, _fatalityType, _killer )
	{
		local corpse = clone ::Const.Corpse;
		corpse.CorpseName = "A Stollwurm";
		corpse.IsHeadAttached = _fatalityType != ::Const.FatalityType.Decapitated;
		corpse.Tile = _tile;
		corpse.Items = this.getItems().prepareItemsForCorpse(_killer);
		return corpse;
	}

	function kill( _killer = null, _skill = null, _fatalityType = ::Const.FatalityType.None, _silent = false ) {
		this.m.IsDying = true;

		if (!::Legends.S.isEntityNullOrDead(this.m.Tail)) {
			this.m.Tail.kill(_killer, _skill, _fatalityType, _silent);
			this.m.Tail = null;
		}

		this.actor.kill(_killer, _skill, _fatalityType, _silent);
		::Tactical.TurnSequenceBar.ForceRecheckNextTurnCondition();
	}

	function updateOverlay()
	{
		this.actor.updateOverlay();

		if (this.m.Tail != null && !this.m.Tail.isNull() && this.m.Tail.isAlive())
		{
			this.m.Tail.updateOverlay();
		}
	}

	function setFaction( _f )
	{
		this.actor.setFaction(_f);

		if (this.m.Tail != null && !this.m.Tail.isNull() && this.m.Tail.isAlive())
		{
			this.m.Tail.setFaction(_f);
		}
	}

	function checkMorale( _change, _difficulty, _type = ::Const.MoraleCheckType.Default, _showIconBeforeMoraleIcon = "", _noNewLine = false )
	{
		this.actor.checkMorale(_change, _difficulty, _type, _showIconBeforeMoraleIcon, _noNewLine);

		if (this.m.Tail != null && !this.m.Tail.isNull() && this.m.Tail.isAlive())
		{
			this.m.Tail.setMoraleState(this.getMoraleState());
		}
	}

	function retreat()
	{
		if (this.m.Tail != null && !this.m.Tail.isNull() && this.m.Tail.isAlive())
		{
			this.m.Tail.m.IsAlive = false;
			this.m.Tail.die();
			this.m.Tail = null;
		}

		this.actor.retreat();
	}

	function onInit()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.LegendStollwurm);
		b.IsAffectedByNight = false;
		b.IsMovable = false;
		b.IsImmuneToRoot = true;
		b.IsImmuneToDisarm = true;
		b.IsAffectedByRain = false;

		if (!::Tactical.State.isScenarioMode() && ::World.getTime().Days >= ::Const.World.Scaling.Beasts.LegendsStollwurmStatIncreaseDay)
		{
			b.MeleeSkill += 10;
			b.DamageTotalMult += 0.1;
		}

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		body.setBrush("bust_stollwurm_body_0" + ::Math.rand(1, 1));

		if (::Math.rand(0, 100) < 90)
		{
			body.varySaturation(0.2);
		}

		if (::Math.rand(0, 100) < 90)
		{
			body.varyColor(0.08, 0.08, 0.08);
		}

		local head = this.addSprite("head");
		head.setBrush("bust_stollwurm_head_0" + ::Math.rand(1, 1));
		head.Color = body.Color;
		head.Saturation = body.Saturation;
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_stollwurm_body_01_injured");
		local body_blood = this.addSprite("body_blood");
		body_blood.Visible = false;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.63;
		this.setSpriteOffset("status_rooted", this.createVec(0, 15));
		this.setSpriteOffset("status_stunned", this.createVec(-5, 30));
		this.setSpriteOffset("arrow", this.createVec(-5, 30));
		::Legends.Actives.grant(this, ::Legends.Active.Gorge);
		::Legends.Perks.grant(this, ::Legends.Perk.Pathfinder);
		// ::Legends.Perks.grant(this, ::Legends.Perk.HoldOut);
		::Legends.Traits.grant(this, ::Legends.Trait.RacialLindwurm);
		::Legends.Perks.grant(this, ::Legends.Perk.ReachAdvantage);
		::Legends.Perks.grant(this, ::Legends.Perk.Fearsome);
		::Legends.Perks.grant(this, ::Legends.Perk.Underdog);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendMuscularity);
		::Legends.Perks.grant(this, ::Legends.Perk.BattleFlow);
		::Legends.Perks.grant(this, ::Legends.Perk.Stalwart);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendComposure);
		::Legends.Actives.grant(this, ::Legends.Active.LegendStollwurmMove);

		if (::Legends.isLegendaryDifficulty())
		{
			b.Hitpoints *= 1.5;
			this.m.ActionPoints = b.ActionPoints + 5;
			::Legends.Perks.grant(this, ::Legends.Perk.Pathfinder);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendComposure);
			::Legends.Perks.grant(this, ::Legends.Perk.KillingFrenzy);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}

		::Legends.S.scaleBaseProperties(b);

		if (this.m.Tail == null)
		{
			local myTile = this.getTile();
			local spawnTile;

			if (myTile.hasNextTile(::Const.Direction.NE) && myTile.getNextTile(::Const.Direction.NE).IsEmpty)
			{
				spawnTile = myTile.getNextTile(::Const.Direction.NE);
			}
			else if (myTile.hasNextTile(::Const.Direction.SE) && myTile.getNextTile(::Const.Direction.SE).IsEmpty)
			{
				spawnTile = myTile.getNextTile(::Const.Direction.SE);
			}
			else
			{
				for( local i = 0; i < 6; i = i )
				{
					if (!myTile.hasNextTile(i))
					{
					}
					else if (myTile.getNextTile(i).IsEmpty)
					{
						spawnTile = myTile.getNextTile(i);
						break;
					}

					i = ++i;
				}
			}

			if (spawnTile != null)
			{
				this.m.Tail = this.WeakTableRef(::Tactical.spawnEntity("scripts/entity/tactical/enemies/legend_stollwurm_tail", spawnTile.Coords.X, spawnTile.Coords.Y, this.getID()));
				this.m.Tail.m.Body = this.WeakTableRef(this);
				this.m.Tail.getSprite("body").Color = body.Color;
				this.m.Tail.getSprite("body").Saturation = body.Saturation;
			}
		}

		local skills = this.getSkills();
		local skills_add = skills.add;
		skills.add = function( _skill, _order = 0 ) {
			skills_add(_skill, _order);

			local actor = this.getActor();
			if (::Legends.S.isEntityNullOrDead(actor.m.Tail))
				return;
			if (_skill.getID() in actor.m.EffectsSharedWithTailLookup) {
				::Legends.Effects.grant(actor.m.Tail, actor.m.EffectsSharedWithTailLookup[_skill.getID()], function(_effect) {
					_effect.m.IsFromHead <- true;
				});
			}
		}.bindenv(skills);
	}

	function onMovementStep( _tile, _levelDifference ) {
		local result = this.actor.onMovementStep( _tile, _levelDifference );
		if(result) {
			this.m.MovementAPSpent += ::Math.max(1, (this.m.ActionPointCosts[_tile.Type] + this.m.CurrentProperties.MovementAPCostAdditional) * this.m.CurrentProperties.MovementAPCostMult) + (_levelDifference != 0 ? this.m.LevelActionPointCost : 0);
		}
		return result;
	}

	function onMovementFinish(_tile)
	{
		this.actor.onMovementFinish(_tile);

		if (this.m.Tail != null && !this.m.Tail.isNull() && this.m.Tail.isAlive())
		{
			::Tactical.TurnSequenceBar.moveEntityToFront(this.m.Tail.getID());
		}
	}

	function onPlacedOnMap()
	{
		this.actor.onPlacedOnMap();
		this.onUpdateInjuryLayer();
	}

});
