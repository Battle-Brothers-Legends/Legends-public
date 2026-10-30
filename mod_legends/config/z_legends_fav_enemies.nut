::Legends.FavoriteEnemy <- {};

::Legends.FavoriteEnemy.Types <- {
	Beast = "Beast",
	Civilization = "Civilization",
	Greenskin = "Greenskin",
	Occult = "Occult",
	Outlaw = "Outlaw",
	Swordmaster = "Swordmaster",
	Undead = "Undead"
}

::Legends.FavoriteEnemy.TypeOverride <- {
	Beast = [
		::Const.EntityType.BarbarianUnhold,
		::Const.EntityType.BarbarianUnholdFrost
	],
	Civilization = [
		::Const.EntityType.ArmoredWardog,
		::Const.EntityType.MasterArcher,
		::Const.EntityType.Oathbringer,
		::Const.EntityType.Swordmaster,
		::Const.EntityType.Wardog
	],
	Greenskin = [
		::Const.EntityType.GreenskinCatapult
	],
	Occult = [
		::Const.EntityType.Alp,
		::Const.EntityType.FaultFinder,
		::Const.EntityType.Ghost,
		::Const.EntityType.GrandDiviner,
		::Const.EntityType.Hexe,
		::Const.EntityType.Necromancer,
		::Const.EntityType.Schrat,
		::Const.EntityType.SchratSmall,
		::Const.EntityType.SandGolem,
		::Const.EntityType.LegendBanshee,
		::Const.EntityType.LegendDemonAlp,
		::Const.EntityType.LegendDemonHound,
		::Const.EntityType.LegendGreenwoodSchrat,
		::Const.EntityType.LegendGreenwoodSchratSmall,
		::Const.EntityType.LegendHexeLeader,
		::Const.EntityType.LegendWicht,
	],
	Outlaw = [
		::Const.EntityType.BountyHunter,
		::Const.EntityType.Cultist,
		::Const.EntityType.HedgeKnight,
		::Const.EntityType.Mercenary,
		::Const.EntityType.MercenaryRanged,
		::Const.EntityType.Warhound,
	],
	Undead = [
		::Const.EntityType.FleshCradle,
		::Const.EntityType.SkeletonPhylactery
	]
}

::Legends.FavoriteEnemy.getCategory <- function (_entity, _entityType = null) {
	if (_entityType == null) {
		_entityType = _entity.getType();
	}

	if (_entity != null && _entity.m.IsMiniboss && ::MSU.isKindOf(_entity, "human")) {
		return ::Legends.FavoriteEnemy.Types.Swordmaster;
	}

	foreach (categoryName, types in ::Legends.FavoriteEnemy.TypeOverride) {
		foreach (t in types) {
			if (t == _entityType) {
				return categoryName;
			}
		}
	}

	local faction = ::Const.EntityType.getDefaultFaction(_entityType);
	switch (faction) {
		case ::Const.FactionType.Beasts:
			return ::Legends.FavoriteEnemy.Types.Beast;

		case ::Const.FactionType.Settlement:
		case ::Const.FactionType.NobleHouse:
		case ::Const.FactionType.OrientalCityState:
			return ::Legends.FavoriteEnemy.Types.Civilization;

		case ::Const.FactionType.Orcs:
		case ::Const.FactionType.Goblins:
			return ::Legends.FavoriteEnemy.Types.Greenskin;

		case ::Const.FactionType.Bandits:
		case ::Const.FactionType.Barbarians:
		case ::Const.FactionType.OrientalBandits:
			return ::Legends.FavoriteEnemy.Types.Outlaw;

		case ::Const.FactionType.Undead:
		case ::Const.FactionType.Zombies:
			return ::Legends.FavoriteEnemy.Types.Undead;
	}

	return null;
}

::Legends.FavoriteEnemy.recordKill <- function (_actor, _entity, _xp) {
	local category = ::Legends.FavoriteEnemy.getCategory(_entity);
	if (category != null) {
		local stats = _actor.getLifetimeStats();
		stats.Tags.increment("Enemy_Kills_" + category, 1);
		stats.Tags.increment("Enemy_XP_" + category, ::Math.floor(_xp));
	}
}

::Legends.FavoriteEnemy.recordXP <- function (_actor, _entity, _xp) {
	local category = ::Legends.FavoriteEnemy.getCategory(_entity);
	if (category != null) {
		_actor.getLifetimeStats().Tags.increment("Enemy_XP_" + category, ::Math.floor(_xp));
	}
}

::Legends.FavoriteEnemy.getFavoriteEnemyStats <- function (_actor, _category) {
	if (_actor == null || _category == null) {
		return {
			Kills = 0,
			XP = 0,
			Strength = 0,
			HitChance = 0,
			HitMult = 1.0
		}
	}

	local stats = _actor.getLifetimeStats();
	local kills = stats.Tags.get("Enemy_Kills_" + _category) || 0;
	local xp = stats.Tags.get("Enemy_XP_" + _category) || 0;

	local str = xp / 1000.0;
	local hitChance = 5 + ::Math.min(::Math.floor(str), 20); // base bonus of 5 and cap total at 25
	local hitMult = 1.0 + (0.01 * hitChance);
	return {
		Kills = kills,
		XP = xp,
		Strength = str,
		HitChance = hitChance,
		HitMult = hitMult
	}
}

::Legends.FavoriteEnemy.getFavEnemyBossChance <- function (_type) {
	local category = ::Legends.FavoriteEnemy.getCategory(null, _type);
	if (category == null) {
		return 0;
	}

	local bonus = 0;
	foreach (bro in ::World.getPlayerRoster().getAll().filter(@(_, _bro)(::Legends.Professions.has(_bro, ::Legends.Profession["LegendFavouredEnemy" + category])))) {
		bonus += ::Math.floor((::Legends.FavoriteEnemy.getFavoriteEnemyStats(bro, category).Kills * 1.0) / 10.0);
	}
	return bonus;
}
