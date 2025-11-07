this.legend_white_warwolf <- this.inherit("scripts/entity/tactical/actor", {
	m = {
		Item = null,
		Name = "White Warwolf"
	},
	function setItem( _i )
	{
		if (typeof _i == "instance")
		{
			this.m.Item = _i;
		}
		else
		{
			this.m.Item = this.WeakTableRef(_i);
		}
	}

	function setName( _n )
	{
		this.m.Name = _n;
	}

	function getName()
	{
		return this.m.Name;
	}

	function create()
	{
		this.m.Type = this.Const.EntityType.LegendWhiteWarwolf;
		this.m.XP = this.Const.Tactical.Actor.LegendWhiteWarwolf.XP;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.IsActingImmediately = true;
		this.m.BloodSplatterOffset = this.createVec(0, 0);
		this.m.DecapitateSplatterOffset = this.createVec(-4, -25);
		this.m.DecapitateBloodAmount = 0.5;
		this.actor.create();
		this.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/wolf_death_00.wav",
			"sounds/enemies/wolf_death_01.wav",
			"sounds/enemies/wolf_death_02.wav",
			"sounds/enemies/wolf_death_03.wav",
			"sounds/enemies/wolf_death_04.wav",
			"sounds/enemies/wolf_death_05.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Flee] = [
			"sounds/enemies/wolf_flee_00.wav",
			"sounds/enemies/wolf_flee_01.wav",
			"sounds/enemies/wolf_flee_02.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/wolf_hurt_00.wav",
			"sounds/enemies/wolf_hurt_01.wav",
			"sounds/enemies/wolf_hurt_02.wav",
			"sounds/enemies/wolf_hurt_03.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/wolf_idle_00.wav",
			"sounds/enemies/wolf_idle_01.wav",
			"sounds/enemies/wolf_idle_02.wav",
			"sounds/enemies/wolf_idle_03.wav",
			"sounds/enemies/wolf_idle_04.wav",
			"sounds/enemies/wolf_idle_06.wav",
			"sounds/enemies/wolf_idle_07.wav",
			"sounds/enemies/wolf_idle_08.wav",
			"sounds/enemies/wolf_idle_09.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Move] = this.m.Sound[this.Const.Sound.ActorEvent.Idle];
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Death] = 0.7;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/legend_white_warwolf_agent");
		this.m.AIAgent.setActor(this);
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		if (_tile != null)
		{
			local flip = this.Math.rand(0, 100) < 50;
			local appearance = this.getItems().getAppearance();
			local decal;
			this.m.IsCorpseFlipped = flip;
			decal = _tile.spawnDetail(this.getSprite("body").getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
			decal.setBrightness(0.9);
			decal.Scale = 0.95;

			if (appearance.CorpseArmor != "")
			{
				decal = _tile.spawnDetail(appearance.CorpseArmor, this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.setBrightness(0.9);
				decal.Scale = 0.95;
			}

			if (_fatalityType != this.Const.FatalityType.Decapitated)
			{
				decal = _tile.spawnDetail(this.getSprite("head").getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.setBrightness(0.9);
				decal.Scale = 0.95;
			}
			else if (_fatalityType == this.Const.FatalityType.Decapitated)
			{
				local layers = [
					this.getSprite("head").getBrush().Name + "_dead"
				];
				local decap = this.Tactical.spawnHeadEffect(this.getTile(), layers, this.createVec(-20, 15), 0.0, "bust_wolf_head_bloodpool");
				decap[0].setBrightness(0.9);
				decap[0].Scale = 0.95;
			}
			else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Arrow)
			{
				decal = _tile.spawnDetail(this.getSprite("body").getBrush().Name + "_dead_arrows", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.95;
			}
			else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Javelin)
			{
				decal = _tile.spawnDetail(this.getSprite("body").getBrush().Name + "_dead_javelin", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.95;
			}

			this.spawnTerrainDropdownEffect(_tile);
			local corpse = clone this.Const.Corpse;
			corpse.CorpseName = this.getName();
			corpse.IsHeadAttached = _fatalityType != this.Const.FatalityType.Decapitated;
			corpse.IsResurrectable = false;
			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);
		}

		if (this.m.Item != null && !this.m.Item.isNull())
		{
			this.m.Item.setEntity(null);

			if (this.m.Item.getContainer() != null)
			{
				if (this.m.Item.getCurrentSlotType() == this.Const.ItemSlot.Bag)
				{
					this.m.Item.getContainer().removeFromBag(this.m.Item.get());
				}
				else
				{
					this.m.Item.getContainer().unequip(this.m.Item.get());
				}
			}

			this.m.Item = null;
		}

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function onFactionChanged()
	{
		this.actor.onFactionChanged();
		local flip = this.isAlliedWithPlayer();
		this.getSprite("body").setHorizontalFlipping(flip);
		// this.getSprite("armor").setHorizontalFlipping(flip);
		this.getSprite("head").setHorizontalFlipping(flip);
		this.getSprite("injury").setHorizontalFlipping(flip);

		if (!this.Tactical.State.isScenarioMode())
		{
			local f = this.World.FactionManager.getFaction(this.getFaction());

			if (f != null)
			{
				this.getSprite("socket").setBrush(f.getTacticalBase());
			}
		}
		else
		{
			this.getSprite("socket").setBrush(this.Const.FactionBase[this.getFaction()]);
		}
	}

	function onActorKilled( _actor, _tile, _skill )
	{
		this.actor.onActorKilled(_actor, _tile, _skill);

		if (this.getFaction() == this.Const.Faction.Player || this.getFaction() == this.Const.Faction.PlayerAnimals)
		{
			local XPgroup = _actor.getXPValue();
			local brothers = this.Tactical.Entities.getInstancesOfFaction(this.Const.Faction.Player);

			foreach( bro in brothers )
			{
				bro.addXP(this.Math.max(1, this.Math.floor(XPgroup / brothers.len())));
			}
		}
	}

	function setVariant(_v, _c, _s, _hp = 1.0)
	{
		this.m.Items.getAppearance().Body = "bust_direwolf_white_tame_0" + _v;
		this.m.Items.getAppearance().Armor = "bust_wolf_02_armor_01";

		local body = getSprite("body");
		body.setBrush("bust_direwolf_white_0" + _v + "_body");
		body.Color = _c;
		body.Saturation = _s;

		local head = getSprite("head");
		head.setBrush("bust_direwolf_white_0" + _v + "_head");
		head.Color = _c;
		head.Saturation = _s;

		local armor = this.addSprite("armor");
		armor.setBrush("bust_wolf_02_armor_01");
		armor.Visible = false;

		if(_hp != 1.0)
		{
			this.m.Hitpoints = this.getHitpointsMax() * _hp;
			this.m.BaseProperties.Armor[this.Const.BodyPart.Body] * _hp;
			this.m.BaseProperties.Armor[this.Const.BodyPart.Head] * _hp;
			// this.m.Properties.Armor[this.Const.BodyPart.Body] * _hp;
			// this.m.Properties.Armor[this.Const.BodyPart.Head] * _hp;
			this.onUpdateInjuryLayer();
		}
		else
		{
			this.setDirty(true);
		}
	}

	function onInit()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendWhiteWarwolf);
		b.TargetAttractionMult = 0.1;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToDisarm = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		local variant = 2;
		this.m.Items.getAppearance().Body = "bust_direwolf_white_tame_01";
		this.addSprite("socket").setBrush("bust_base_player");
		local body = this.addSprite("body");
		body.setBrush("bust_direwolf_white_01_body");
		body.varySaturation(0.15);
		body.varyColor(0.07, 0.07, 0.07);
		local head = this.addSprite("head");
		head.setBrush("bust_direwolf_white_01_head");
		head.Color = body.Color;
		head.Saturation = body.Saturation;
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_direwolf_white_injured");
		this.setAlwaysApplySpriteOffset(false);
		local offset = this.createVec(0, -10);
		this.setSpriteOffset("body", offset);
		this.setSpriteOffset("head", offset);
		this.setSpriteOffset("injury", offset);
		this.setSpriteOffset("armor", offset);
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.58;
		this.setSpriteOffset("status_rooted", this.createVec(-6, -29));
		::Legends.Actives.grant(this, ::Legends.Active.WolfBite);
		::Legends.Perks.grant(this, ::Legends.Perk.Pathfinder);
		::Legends.Perks.grant(this, ::Legends.Perk.SteelBrow);
		::Legends.Perks.grant(this, ::Legends.Perk.Rotation);
		::Legends.Perks.grant(this, ::Legends.Perk.Footwork);
		::Legends.Perks.grant(this, ::Legends.Perk.Recover);
		::Legends.Actives.grant(this, ::Legends.Active.LegendWhiteWolfHowl);
		::Legends.Perks.grant(this, ::Legends.Perk.CoupDeGrace);
		::Legends.Perks.grant(this, ::Legends.Perk.Berserk);
		::Legends.Perks.grant(this, ::Legends.Perk.Nimble);
		::Legends.Perks.grant(this, ::Legends.Perk.Overwhelm);
		::Legends.Traits.grant(this, ::Legends.Trait.RacialLegendWerewolf);
	}

});

