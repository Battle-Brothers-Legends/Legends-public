::mods_hookExactClass("entity/tactical/enemies/greater_flesh_golem", function(o)
{
	// todo, remove when vanilla fixes arror brush for this one
	local onDeath = o.onDeath;
	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		local sprite_body = this.getSprite("body");
		if (sprite_body.getBrush().Name.find("02") == null)
			return onDeath(_killer, _skill, _tile, _fatalityType);

		local skillsToClear = [
			"actives.flurry_skill",
			"actives.spike_skill",
			"actives.corpse_hurl_skill"
		];

		foreach( skillID in skillsToClear )
		{
			if (this.getSkills().hasSkill(skillID) && "clearAffectedTiles" in this.getSkills().getSkillByID(skillID))
			{
				this.getSkills().getSkillByID(skillID).clearAffectedTiles();
			}
		}

		local flip = this.Math.rand(1, 100) < 50;

		if (_tile != null)
		{
			this.m.IsCorpseFlipped = flip;
			this.spawnBloodPool(_tile, 1);
			local decal;
			local appearance = this.getItems().getAppearance();
			local sprite_body = this.getSprite("body");
			local sprite_head = this.getSprite("head");
			decal = _tile.spawnDetail("bust_greater_flesh_golem_body_01_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
			decal.Color = sprite_body.Color;
			decal.Saturation = sprite_body.Saturation;
			decal.Scale = 0.9;
			decal.setBrightness(0.9);

			if (appearance.CorpseArmor != "")
			{
				decal = _tile.spawnDetail(appearance.CorpseArmor, this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.9;
				decal.setBrightness(0.9);
			}

			if (_fatalityType != this.Const.FatalityType.Decapitated)
			{
				if (!appearance.HideCorpseHead)
				{
					decal = _tile.spawnDetail(sprite_head.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
					decal.Color = sprite_head.Color;
					decal.Saturation = sprite_head.Saturation;
					decal.Scale = 0.9;
					decal.setBrightness(0.9);
				}

				if (appearance.HelmetCorpse.len() != 0)
				{
					decal = _tile.spawnDetail(appearance.HelmetCorpse, this.Const.Tactical.DetailFlag.Corpse, flip);
					decal.Scale = 0.9;
					decal.setBrightness(0.9);
				}
			}
			else if (_fatalityType == this.Const.FatalityType.Decapitated)
			{
				local layers = [];

				if (!appearance.HideCorpseHead)
				{
					layers.push(sprite_head.getBrush().Name + "_dead");
				}

				if (appearance.HelmetCorpse.len() != 0)
				{
					layers.push(appearance.HelmetCorpse);
				}

				local decap = this.Tactical.spawnHeadEffect(this.getTile(), layers, this.createVec(-75, 50), 90.0, sprite_head.getBrush().Name + "_dead_bloodpool");
				local idx = 0;

				if (!appearance.HideCorpseHead)
				{
					decap[idx].Color = sprite_head.Color;
					decap[idx].Saturation = sprite_head.Saturation;
					decap[idx].Scale = 0.9;
					decap[idx].setBrightness(0.9);
					idx = ++idx;
				}

				if (appearance.HelmetCorpse.len() != 0)
				{
					decap[idx].Scale = 0.9;
					decap[idx].setBrightness(0.9);
					idx = ++idx;
				}
			}

			if (_fatalityType == this.Const.FatalityType.Disemboweled)
			{
				decal = _tile.spawnDetail("guts_flesh_golem_body_02_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.9;
			}
			else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Arrow)
			{
				decal = _tile.spawnDetail(sprite_body.getBrush().Name + "_arrows", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.9;
			}
			else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Javelin)
			{
				decal = _tile.spawnDetail(sprite_body.getBrush().Name + "_dead_javelin", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.9;
			}

			this.spawnTerrainDropdownEffect(_tile);
		}

		local deathLoot = this.getItems().getDroppableLoot(_killer);
		local tileLoot = this.getLootForTile(_killer, deathLoot);
		local corpse = this.generateCorpse(_tile, _fatalityType);
		this.dropLoot(_tile, tileLoot, !flip);

		if (_tile == null)
		{
			this.Tactical.Entities.addUnplacedCorpse(corpse);
		}
		else
		{
			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);
		}

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}
});
