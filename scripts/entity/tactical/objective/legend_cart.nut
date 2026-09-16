this.legend_cart <- this.inherit("scripts/entity/tactical/actor", {
	m = {},
	function create()
	{
		this.m.IsActingEachTurn = false;
		this.m.IsNonCombatant = true;
		this.m.IsShakingOnHit = false;
		this.m.Type = ::Const.EntityType.CaravanDonkey;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.MoraleState = ::Const.MoraleState.Ignore;
		this.m.XP = ::Const.Tactical.Actor.Donkey.XP;
		this.m.BloodSplatterOffset = this.createVec(0, 0);
		this.actor.create();
		this.m.Name = "Caravan Donkey";
		this.m.Sound[::Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/misc/donkey_hurt_01.wav",
			"sounds/misc/donkey_hurt_02.wav",
			"sounds/misc/donkey_hurt_03.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.Death] = [
			"sounds/misc/donkey_death_01.wav",
			"sounds/misc/donkey_death_02.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.Idle] = [
			"sounds/misc/donkey_idle_01.wav",
			"sounds/misc/donkey_idle_02.wav",
			"sounds/misc/donkey_idle_03.wav",
			"sounds/misc/donkey_idle_04.wav",
			"sounds/misc/donkey_idle_05.wav",
			"sounds/misc/donkey_idle_06.wav",
			"sounds/misc/donkey_idle_07.wav",
			"sounds/misc/donkey_idle_08.wav"
		];
		this.m.SoundVolume[::Const.Sound.ActorEvent.Idle] = 0.35;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/donkey_agent");
		this.m.AIAgent.setActor(this);
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		local flip = ::Math.rand(0, 100) < 50;

		if (_tile != null)
		{
			local decal;
			local skin = this.getSprite("body");
			decal = _tile.spawnDetail("donkey_tactical_dead", ::Const.Tactical.DetailFlag.Corpse, flip);
			decal.Color = skin.Color;
			decal.Saturation = skin.Saturation;

			if (_skill && _skill.getProjectileType() == ::Const.ProjectileType.Arrow)
			{
				_tile.spawnDetail("donkey_tactical_dead_arrows", ::Const.Tactical.DetailFlag.Corpse, flip);
			}
			else if (_skill && _skill.getProjectileType() == ::Const.ProjectileType.Javelin)
			{
				_tile.spawnDetail("donkey_tactical_dead_javelin", ::Const.Tactical.DetailFlag.Corpse, flip);
			}

			this.spawnTerrainDropdownEffect(_tile);
			local corpse = clone ::Const.Corpse;
			corpse.CorpseName = "A Donkey";
			corpse.Tile = _tile;
			corpse.Value = 1.0;
			corpse.IsResurrectable = false;
			corpse.IsConsumable = true;
			corpse.IsHeadAttached = true;
			_tile.Properties.set("Corpse", corpse);
			::Tactical.Entities.addCorpse(_tile);
		}

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);

		if (this.m.WorldTroop != null && ("Party" in this.m.WorldTroop) && this.m.WorldTroop.Party != null)
		{
			local numDonkeys = 0;
			local troops = this.m.WorldTroop.Party.getTroops();

			foreach( t in troops )
			{
				if (t.Script == "scripts/entity/tactical/objective/donkey")
				{
					numDonkeys = ++numDonkeys;
				}
			}
		}
	}

	function onDamageReceived( _attacker, _skill, _hitInfo )
	{
		_hitInfo.BodyPart = ::Const.BodyPart.Body;
		return this.actor.onDamageReceived(_attacker, _skill, _hitInfo);
	}

	function setFlipped( _f )
	{
		this.getSprite("body").setHorizontalFlipping(_f);
		this.getSprite("injury").setHorizontalFlipping(_f);
	}

	function onInit()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.Donkey);
		b.IsImmuneToKnockBackAndGrab = true;
		b.IsImmuneToStun = true;
		b.IsImmuneToRoot = true;
		b.IsImmuneToBleeding = true;
		b.IsImmuneToPoison = true;
		b.IsAffectedByNight = false;
		b.IsMovable = false;
		b.TargetAttractionMult = 1.5;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		local body = this.addSprite("body");
		body.setBrush("donkey_tactical");
		body.varySaturation(0.4);
		body.varyColor(0.035, 0.035, 0.035);
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("donkey_tactical_injured");
		this.addDefaultStatusSprites();
		this.m.Skills.update();
	}

	function onPlacedOnMap()
	{
		this.actor.onPlacedOnMap();
		local directionPriority = [
			::Const.Direction.NW,
			::Const.Direction.NE,
			::Const.Direction.N,
			::Const.Direction.SW,
			::Const.Direction.S,
			::Const.Direction.SE
		];
		local myTile = this.getTile();
		local tile;
		local dir = -1;

		for( local i = 0; i < 6; i = ++i )
		{
			if (!myTile.hasNextTile(directionPriority[i]))
			{
			}
			else
			{
				local nextTile = myTile.getNextTile(directionPriority[i]);

				if (!nextTile.IsEmpty || ::Math.abs(nextTile.Level - myTile.Level) > 1)
				{
				}
				else
				{
					tile = nextTile;
					dir = i;
					break;
				}
			}
		}

		if (tile != null)
		{
			local cart = ::Tactical.spawnEntity("scripts/entity/tactical/objects/cart", tile.Coords);

			if (directionPriority[dir] == ::Const.Direction.NE)
			{
				cart.setFlipped(true);
				this.setFlipped(true);
			}
			else if (directionPriority[dir] == ::Const.Direction.SE)
			{
				cart.setFlipped(true);
			}
		}
	}

});
