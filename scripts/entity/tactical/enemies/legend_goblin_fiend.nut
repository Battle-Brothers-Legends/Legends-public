this.legend_goblin_fiend <- this.inherit("scripts/entity/tactical/enemies/goblin_fighter", {
	m = {
		BodyNum = 1,
		HeadNum = 1,
		Injured = false,
		HeadInjured = false
	},

	function create() {
		this.m.Type = ::Const.EntityType.LegendGoblinFiend;
		this.m.XP = ::Const.Tactical.Actor.LegendGoblinFiend.XP;
		this.goblin.create();
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/orc_berserker_agent");
		this.m.AIAgent.setActor(this);
	}

	function onUpdateInjuryLayer() {
		if (!this.m.Injured && !this.m.HeadInjured) {
			this.goblin.onUpdateInjuryLayer()
			return;
		}

		if (this.m.HeadInjured) {
			this.getSprite("injury").Visible = true;
		}

		if (this.m.Injured) {
			this.getSprite("injury_body").Visible = true;
		}

		this.setDirty(true);
	}

	function onInit() {
		this.goblin_fighter.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.LegendGoblinFiend);

		this.m.BodyNum = 1;
		if (this.Math.rand(1, 20) != 1) {
			this.m.BodyNum = this.Math.rand(2, 3);
		}
		this.m.HeadNum = this.Math.rand(1, 3);
		this.m.Items.getAppearance().Body = "bust_goblin_02_body_0" + this.m.BodyNum;
		local body = this.getSprite("body");
		body.setBrush("bust_goblin_02_body_0" + this.m.BodyNum);
		body.varySaturation(0.1);
		body.varyColor(0.07, 0.07, 0.09);
		local injury_body = this.getSprite("injury_body");
		injury_body.Visible = false;
		this.m.Injured = this.Math.rand(1, 2) == 2 ? true : false
		injury_body.setBrush("bust_goblin_02_body_0" + this.m.BodyNum + "_body_injured");
		local head = this.getSprite("head");
		head.setBrush("bust_goblin_04_head_0" + this.m.HeadNum);
		head.Saturation = body.Saturation;
		head.Color = body.Color;
		local injury = this.getSprite("injury");
		injury.Visible = false;
		this.m.HeadInjured = this.Math.rand(1, 2) == 2 ? true : false
		injury.setBrush("bust_goblin_04_head_0" + this.m.HeadNum + "_head_injured");
		local body_blood = this.getSprite("body_blood");
		body_blood.Visible = false;

		::Legends.Actives.remove(this, ::Legends.Active.Footwork);
		::Legends.Perks.grant(this, ::Legends.Perk.Backstabber);
		::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
		::Legends.Perks.grant(this, ::Legends.Perk.Nimble);
		::Legends.Perks.grant(this, ::Legends.Perk.Berserk);
		::Legends.Perks.remove(this, ::Legends.Perk.LegendTumble);
		if(::Legends.isLegendaryDifficulty()) {
			::Legends.Perks.grant(this, ::Legends.Perk.LegendUberNimble);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendVengeance);
		}
		this.m.Skills.update();
	}

	function onDeath(_killer, _skill, _tile, _fatalityType) {
		local flip = Math.rand(1, 100) < 50;

		if(_tile != null)
		{
			m.IsCorpseFlipped = flip;
			
			local decal;
			local skin = this.getSprite("body");

			decal = _tile.spawnDetail("bust_goblin_body_dead", Const.Tactical.DetailFlag.Corpse, flip);
			decal.Color = skin.Color;
			decal.Saturation = skin.Saturation;
			decal.setBrightness(0.9);
			decal.Scale = 0.95;

			_tile.spawnDetail(this.getItems().getAppearance().CorpseArmor, Const.Tactical.DetailFlag.Corpse, flip);
			
			if(_fatalityType != Const.FatalityType.Decapitated) {
				if(!this.getItems().getAppearance().HideCorpseHead) {
					decal = _tile.spawnDetail("bust_goblin_01_head_0" + this.m.HeadNum + "_dead", Const.Tactical.DetailFlag.Corpse, flip);
					decal.Color = skin.Color;
					decal.Saturation = skin.Saturation;
					decal.setBrightness(0.9);
					decal.Scale = 0.95;
				}
			}

			else if(_fatalityType == Const.FatalityType.Decapitated) {
				local layers = [ "bust_goblin_01_head_0" + this.m.HeadNum + "_dead" ];
				local decap = Tactical.spawnHeadEffect(getTile(), layers, createVec(-50, 30), 180.0, "bust_goblin_01_head_0" + this.m.HeadNum + "_dead_bloodpool");

				decap[0].Color			= skin.Color;
				decap[0].Saturation		= skin.Saturation;
				decap[0].setBrightness(0.9);
				decap[0].Scale = 0.95;

				if(decap.len() >= 2)
					decap[1].setBrightness(0.9);
			}

			if(_fatalityType == Const.FatalityType.Disemboweled) {
				local decal = _tile.spawnDetail("bust_goblin_body_dead_guts", Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.95;
			}

 			else if(_skill && _skill.getProjectileType() == Const.ProjectileType.Arrow) {
				decal = _tile.spawnDetail("bust_goblin_01_armor_02_dead_arrows", Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.95;
			}
 
  			else if(_skill && _skill.getProjectileType() == Const.ProjectileType.Javelin) {
				decal = _tile.spawnDetail("bust_goblin_01_armor_02_dead_javelin", Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.95;
			}

			this.spawnTerrainDropdownEffect(_tile);

			local corpse = clone Const.Corpse;
			corpse.CorpseName		= "A " + getName();
			corpse.Tile				= _tile;
			corpse.IsResurrectable	= false;
			corpse.IsConsumable		= true;
			corpse.Items			= this.getItems();
			corpse.IsHeadAttached	= _fatalityType != Const.FatalityType.Decapitated;

			_tile.Properties.set("Corpse", corpse);
			::Tactical.Entities.addCorpse(_tile);
		}

		// drop items
		getItems().dropAll(_tile, _killer, flip);

		// die
		actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function assignRandomEquipment() {
		local r;
		r = this.Math.rand(1, 4);
		if (r <= 1) {
			this.m.Items.equip(::new("scripts/items/weapons/greenskins/goblin_pike"));
		}
		else if (r <= 2) {
			this.m.Items.equip(::new("scripts/items/weapons/greenskins/legend_goblin_infantry_axe"));
		}
		else {
			this.m.Items.equip(::new("scripts/items/weapons/warbrand"));
		}
	}

	function makeMiniboss() {
		if (!this.actor.makeMiniboss()) {
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
