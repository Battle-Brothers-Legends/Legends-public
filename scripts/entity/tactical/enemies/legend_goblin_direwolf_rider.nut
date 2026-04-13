this.legend_goblin_direwolf_rider <- this.inherit("scripts/entity/tactical/enemies/legend_goblin_rider_abstract", {
	m = {
		Variant = 1,
		LastBodyPartHit = this.Const.BodyPart.Body,
		Info = null,
		AssignAIAgent = "scripts/ai/tactical/agents/goblin_wolfrider_agent",
		AssignEntityType = this.Const.EntityType.LegendGoblinDirewolfRider,
		AssignActor = this.Const.Tactical.Actor.LegendGoblinDirewolfRider,
		WolfScript = "scripts/entity/tactical/enemies/direwolf",
		GoblinScript = "scripts/entity/tactical/enemies/legend_goblin_plunderer"
	},
	function create()
	{
		this.legend_goblin_rider_abstract.create();
	}

	function onInit()
	{
		this.legend_goblin_rider_abstract.onInit();
	}

	function assignSkills()
	{
		::Legends.Perks.grant(this, ::Legends.Perk.Backstabber);
		::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Effects.grant(this, ::Legends.Effect.LegendFreedomOfMovement);
			::Legends.Perks.grant(this, ::Legends.Perk.Dodge);
		}
		::Legends.Actives.grant(this, ::Legends.Active.WerewolfBite, function (_skill) {
			_skill.setRestrained(true);
			_skill.m.ActionPointCost = 0;
		}.bindenv(this));
	}

	function createSprites()
	{
		this.getSprite("head").setBrush("bust_goblin_01_head_0" + this.Math.rand(1, 3));
		this.setAlwaysApplySpriteOffset(true);
		local offset = this.createVec(8, 14);
		this.setSpriteOffset("body", offset);
		this.setSpriteOffset("armor", offset);
		this.setSpriteOffset("head", offset);
		this.setSpriteOffset("injury", offset);
		this.setSpriteOffset("helmet", offset);
		this.setSpriteOffset("helmet_damage", offset);
		this.setSpriteOffset("body_blood", offset);
		local wolf = this.addSprite("wolf");
		wolf.setBrush("bust_direwolf_0" + this.Math.rand(1, 3));
		wolf.varySaturation(0.15);
		wolf.varyColor(0.07, 0.07, 0.07);
		local wolf = this.addSprite("wolf_head");
		wolf.setBrush("bust_direwolf_0" + this.Math.rand(1, 3) + "_head");
		wolf.Saturation = wolf.Saturation;
		wolf.Color = wolf.Color;
		this.removeSprite("injury_body");
		local head_frenzy = this.addSprite("head_frenzy");
		local wolf_injury = this.addSprite("injury_body");
		wolf_injury.setBrush("bust_direwolf_injured");
		wolf_injury.Visible = false;
		local wolf_armor = this.addSprite("wolf_armor");
		wolf_armor.setBrush("bust_wolf_02_armor_01");
	}

	function spawnDeadWolf( _killer, _skill, _tile, _fatalityType )
	{
		if (_tile == null)
		{
			return;
		}

		local flip = this.Math.rand(0, 100) < 50;
		local decal;
		this.m.IsCorpseFlipped = flip;
		local body = this.getSprite("body");
		local head = this.getSprite("head");
		local head_frenzy = this.getSprite("head_frenzy");
		decal = _tile.spawnDetail("bust_direwolf_01_body_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
		decal.Color = body.Color;
		decal.Saturation = body.Saturation;
		decal.Scale = 0.95;

		if (_fatalityType != this.Const.FatalityType.Decapitated)
		{
			decal = _tile.spawnDetail(head.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
			decal.Color = head.Color;
			decal.Saturation = head.Saturation;
			decal.Scale = 0.95;

			if (head_frenzy.HasBrush)
			{
				decal = _tile.spawnDetail(head_frenzy.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.95;
			}
		}
		else if (_fatalityType == this.Const.FatalityType.Decapitated)
		{
			local layers = [
				head.getBrush().Name + "_dead"
			];

			if (head_frenzy.HasBrush)
			{
				layers.push(head_frenzy.getBrush().Name + "_dead");
			}

			local decap = this.Tactical.spawnHeadEffect(this.getTile(), layers, this.createVec(0, 0), 0.0, "bust_direwolf_head_bloodpool");
			decap[0].Color = head.Color;
			decap[0].Saturation = head.Saturation;
			decap[0].Scale = 0.95;

			if (head_frenzy.HasBrush)
			{
				decap[1].Scale = 0.95;
			}
		}

		if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Arrow)
		{
			decal = _tile.spawnDetail("bust_direwolf_01_body_dead_arrows", this.Const.Tactical.DetailFlag.Corpse, flip);
			decal.Scale = 0.95;
		}
		else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Javelin)
		{
			decal = _tile.spawnDetail("bust_direwolf_01_body_dead_javelin", this.Const.Tactical.DetailFlag.Corpse, flip);
			decal.Scale = 0.95;
		}

		this.spawnTerrainDropdownEffect(_tile);
		this.spawnFlies(_tile);

		local corpse = clone this.Const.Corpse;
		corpse.CorpseName = "A Direwolf";
		corpse.IsHeadAttached = _fatalityType != this.Const.FatalityType.Decapitated;
		corpse.IsResurrectable = false;
		_tile.Properties.set("Corpse", corpse);
		this.Tactical.Entities.addCorpse(_tile);
	}

	function assignRandomEquipment ()
	{
		local weapons = [
			"weapons/greenskins/goblin_falchion",
			"weapons/greenskins/goblin_spear",
			"weapons/greenskins/legend_goblin_infantry_axe",
			"weapons/warbrand"
		];

		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
		{
			this.m.Items.equip(this.new("scripts/items/tools/throwing_net"));
		}

		local item = this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Greenskin.goblin_medium_armor],
			[1, ::Legends.Armor.Greenskin.goblin_heavy_armor]
		]);
		this.m.Items.equip(item);



		local item = this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Greenskin.goblin_light_helmet],
			[1, ::Legends.Helmet.Greenskin.goblin_heavy_helmet]
		]);
		if (item != null)
		{
			this.m.Items.equip(item);
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
			"weapons/named/legend_named_goblin_gruesome_falchion",
			"weapons/named/named_goblin_spear",
			"weapons/named/named_warbrand"
		];
		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		::Legends.Perks.grant(this, ::Legends.Perk.Nimble);
		::Legends.Perks.grant(this, ::Legends.Perk.Relentless);
		return true;
	}

});

