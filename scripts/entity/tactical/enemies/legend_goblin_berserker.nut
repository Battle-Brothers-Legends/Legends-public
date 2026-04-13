this.legend_goblin_berserker <- this.inherit("scripts/entity/tactical/enemies/goblin_fighter", {
	m = {},

	function create()
	{
		this.m.Type = ::Const.EntityType.LegendGoblinBerserker;
		this.m.XP = ::Const.Tactical.Actor.LegendGoblinBerserker.XP;
		this.goblin.create();
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/orc_berserker_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.goblin_fighter.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.LegendGoblinBerserker);
		::Legends.Actives.remove(this, ::Legends.Active.Footwork);
		::Legends.Perks.grant(this, ::Legends.Perk.Backstabber);
		::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
		::Legends.Perks.grant(this, ::Legends.Perk.Nimble);
		::Legends.Perks.grant(this, ::Legends.Perk.Berserk);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.LegendUberNimble);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendVengeance);
		}
		this.m.Skills.update();
	}

	function onDeath(_killer, _skill, _tile, _fatalityType)
	{
		local flip = Math.rand(1, 100) < 50;

		// spawn corpse
		if(_tile != null)
		{
			m.IsCorpseFlipped = flip;
			
			local decal;
			local skin = getSprite("body");

			decal = _tile.spawnDetail("bust_goblin_body_dead", Const.Tactical.DetailFlag.Corpse, flip);
			decal.Color = skin.Color;
			decal.Saturation = skin.Saturation;
			decal.setBrightness(0.9);
			decal.Scale = 0.95;

			_tile.spawnDetail(getItems().getAppearance().CorpseArmor, Const.Tactical.DetailFlag.Corpse, flip);
			
			// spawn head?
			if(_fatalityType != Const.FatalityType.Decapitated)
			{
				if(!getItems().getAppearance().HideCorpseHead)
				{
					decal = _tile.spawnDetail(getSprite("head").getBrush().Name + "_dead", Const.Tactical.DetailFlag.Corpse, flip);
					decal.Color = skin.Color;
					decal.Saturation = skin.Saturation;
					decal.setBrightness(0.9);
					decal.Scale = 0.95;
				}

				if(getItems().getAppearance().HelmetCorpse != "")
				{
					decal = _tile.spawnDetail(getItems().getAppearance().HelmetCorpse, Const.Tactical.DetailFlag.Corpse, flip);
					decal.setBrightness(0.9);
					decal.Scale = 0.95;
				}
			}

			// decapitated
			else if(_fatalityType == Const.FatalityType.Decapitated)
			{
				local layers = [ getSprite("head").getBrush().Name + "_dead", getItems().getAppearance().HelmetCorpse ];
				local decap = Tactical.spawnHeadEffect(getTile(), layers, createVec(-50, 30), 180.0, getSprite("head").getBrush().Name + "_dead_bloodpool");

				decap[0].Color			= skin.Color;
				decap[0].Saturation		= skin.Saturation;
				decap[0].setBrightness(0.9);
				decap[0].Scale = 0.95;

				if(decap.len() >= 2)
					decap[1].setBrightness(0.9);
			}

			// disemboweled
			if(_fatalityType == Const.FatalityType.Disemboweled)
			{
				local decal = _tile.spawnDetail("bust_goblin_body_dead_guts", Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.95;
			}

 			else if(_skill && _skill.getProjectileType() == Const.ProjectileType.Arrow)
 			{
				decal = _tile.spawnDetail("bust_goblin_01_armor_02_dead_arrows", Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.95;
			}
 
  			else if(_skill && _skill.getProjectileType() == Const.ProjectileType.Javelin)
 			{
				decal = _tile.spawnDetail("bust_goblin_01_armor_02_dead_javelin", Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.95;
			}

			spawnTerrainDropdownEffect(_tile);

			local corpse = clone Const.Corpse;
			corpse.CorpseName		= "A " + getName();
			corpse.Tile				= _tile;
			corpse.IsResurrectable	= false;
			corpse.IsConsumable		= true;
			corpse.Items			= getItems();
			corpse.IsHeadAttached	= _fatalityType != Const.FatalityType.Decapitated;

			_tile.Properties.set("Corpse", corpse);
			Tactical.Entities.addCorpse(_tile);
		}

		// drop items
		getItems().dropAll(_tile, _killer, flip);

		// die
		actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function assignRandomEquipment()
	{
		local r;
		r = this.Math.rand(1, 4);
		if (r <= 1)
		{
			this.m.Items.equip(::new("scripts/items/weapons/greenskins/goblin_pike"));
		}
		else if (r <= 2)
		{
			this.m.Items.equip(::new("scripts/items/weapons/greenskins/legend_goblin_infantry_axe"));
		}
		else
		{
			this.m.Items.equip(::new("scripts/items/weapons/warbrand"));
		}
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = [
			"weapons/named/legend_named_goblin_axe_2h",
			"weapons/named/named_goblin_pike",
			"weapons/named/named_warbrand"
		];
		this.m.Items.equip(::new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		::Legends.Perks.grant(this, ::Legends.Perk.Relentless);
		::Legends.Perks.grant(this, ::Legends.Perk.Steadfast);
		::Legends.Perks.grant(this, ::Legends.Perk.NineLives);
		return true;
	}

});
