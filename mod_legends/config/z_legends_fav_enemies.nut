if (!("LegendMod" in ::Const))
	::Const.LegendMod <- {};

::Const.LegendMod.FavoriteZombies <- [
	::Const.EntityType.ZombieYeoman,
	::Const.EntityType.Zombie,
	::Const.EntityType.ZombieBetrayer,
	::Const.EntityType.ZombieBoss,
	::Const.EntityType.ZombieKnight,
	::Const.EntityType.Necromancer,
	::Const.EntityType.ZombieTreasureHunter
];

::Const.LegendMod.FavoriteAlps <- [
	::Const.EntityType.Alp,
	::Const.EntityType.AlpShadow,
	::Const.EntityType.LegendDemonAlp
];

::Const.LegendMod.FavoriteDirewolf <- [
	::Const.EntityType.Hyena,
	::Const.EntityType.Direwolf,
	// ::Const.EntityType.Wolf,
	// ::Const.EntityType.GoblinWolfrider,
	// ::Const.EntityType.KoboldWolfrider, //Not used currently
	::Const.EntityType.LegendWhiteDirewolf
];

::Const.LegendMod.FavoriteGhoul <- [
	::Const.EntityType.Ghoul,
	::Const.EntityType.LegendSkinGhoul
];

::Const.LegendMod.FavoriteGoblin <- [
	::Const.EntityType.GoblinFighter,
	::Const.EntityType.GoblinAmbusher,
	::Const.EntityType.GoblinLeader,
	::Const.EntityType.GoblinShaman,
	::Const.EntityType.GoblinWolfrider,
//	::Const.EntityType.KoboldWolfrider, //Not used currently
//	::Const.EntityType.KoboldFighter //Not used currently
];

::Const.LegendMod.FavoriteHexe <- [
	::Const.EntityType.Hexe,
	::Const.EntityType.LegendHexeLeader
];

::Const.LegendMod.FavoriteLindwurm <- [
	::Const.EntityType.Serpent,
	::Const.EntityType.Lindwurm,
	::Const.EntityType.LegendStollwurm
];

::Const.LegendMod.FavoriteOrc <- [
	::Const.EntityType.OrcBerserker,
	::Const.EntityType.OrcYoung,
	::Const.EntityType.OrcWarrior,
	::Const.EntityType.OrcWarlord,
	::Const.EntityType.LegendOrcBehemoth,
	::Const.EntityType.LegendOrcElite
];

::Const.LegendMod.FavoriteSchrat <- [
	::Const.EntityType.SandGolem,
	::Const.EntityType.Schrat,
	::Const.EntityType.SchratSmall,
	::Const.EntityType.LegendGreenwoodSchrat,
	::Const.EntityType.LegendGreenwoodSchratSmall
];

::Const.LegendMod.FavoriteSkeleton <- [
	::Const.EntityType.SkeletonLight,
	::Const.EntityType.SkeletonMedium,
	::Const.EntityType.SkeletonHeavy,
	::Const.EntityType.SkeletonBoss,
	::Const.EntityType.SkeletonPriest,
	::Const.EntityType.SkeletonLich,
	::Const.EntityType.SkeletonLichMirrorImage,
	::Const.EntityType.SkeletonPhylactery,
	::Const.EntityType.SkeletonGladiator,
	::Const.EntityType.FlyingSkull
];
::Const.LegendMod.FavoriteSpider <- [
	this.Const.EntityType.Spider,
	this.Const.EntityType.LegendSpiderCluster,
	//this.Const.EntityType.SpiderBodyguard,
	this.Const.EntityType.SpiderEggs,
	this.Const.EntityType.LegendRedbackSpider
];
::Const.LegendMod.FavoriteUnhold <- [
	::Const.EntityType.Unhold,
	::Const.EntityType.UnholdBog,
	::Const.EntityType.UnholdFrost,
	::Const.EntityType.BarbarianUnhold,
	::Const.EntityType.BarbarianUnholdFrost,
	::Const.EntityType.LegendRockUnhold
];
::Const.LegendMod.FavoriteVampire <- [
	::Const.EntityType.Vampire,
	::Const.EntityType.Ghost,
	::Const.EntityType.LegendDemonHound,
	::Const.EntityType.LegendVampireLord,
	::Const.EntityType.LegendBanshee,
	::Const.EntityType.LegendMummyLight,
	::Const.EntityType.LegendMummyMedium,
	::Const.EntityType.LegendMummyHeavy,
	::Const.EntityType.LegendMummyQueen,
	::Const.EntityType.LegendMummyPriest
];
::Const.LegendMod.FavoriteSwordmaster <- [
	::Const.EntityType.HedgeKnight,
	::Const.EntityType.Knight,
	::Const.EntityType.Greatsword,
	::Const.EntityType.Swordmaster,
	::Const.EntityType.BanditLeader,
	// ::Const.EntityType.BanditVeteran,
	::Const.EntityType.BanditWarlord,
	::Const.EntityType.BarbarianChampion,
	::Const.EntityType.BarbarianChosen, //King
	::Const.EntityType.Sergeant,
	::Const.EntityType.Officer,
	::Const.EntityType.Gladiator,
	::Const.EntityType.Assassin,
	::Const.EntityType.NomadLeader,
	::Const.EntityType.Executioner,
	::Const.EntityType.DesertDevil,
	::Const.EntityType.LegendFencer
];
::Const.LegendMod.FavoriteArcher <- [
	::Const.EntityType.MasterArcher,
	::Const.EntityType.BanditMarksman,
	::Const.EntityType.BanditRabblePoacher,
	::Const.EntityType.BanditPoacher,
	::Const.EntityType.MilitiaRanged,
	::Const.EntityType.Arbalester,
	::Const.EntityType.LegendSlinger,
	::Const.EntityType.GoblinAmbusher,
	::Const.EntityType.NomadSlinger,
	::Const.EntityType.NomadArcher,
	::Const.EntityType.Gunner,
	::Const.EntityType.DesertStalker
];
::Const.LegendMod.FavoriteBarbarian <- [
	::Const.EntityType.Warhound,
	::Const.EntityType.BarbarianThrall,
	::Const.EntityType.BarbarianMarauder,
	::Const.EntityType.BarbarianChampion,
	::Const.EntityType.BarbarianChosen,
	::Const.EntityType.BarbarianDrummer,
	::Const.EntityType.BarbarianBeastmaster
];
::Const.LegendMod.FavoriteBandit <- [
	::Const.EntityType.BanditRabble,
	::Const.EntityType.BanditRabblePoacher,
	::Const.EntityType.BanditThug,
	::Const.EntityType.BanditPoacher,
	::Const.EntityType.BanditMarksman,
	::Const.EntityType.BanditRaider,
	::Const.EntityType.BanditVeteran,
	::Const.EntityType.BanditWarlord,
	::Const.EntityType.BanditLeader
];
::Const.LegendMod.FavoriteCaravan <- [
	::Const.EntityType.Peasant,
	::Const.EntityType.LegendPeasantButcher,
	::Const.EntityType.LegendPeasantBlacksmith,
	::Const.EntityType.LegendPeasantMonk,
	::Const.EntityType.LegendPeasantFarmhand,
	::Const.EntityType.LegendPeasantMinstrel,
	::Const.EntityType.LegendPeasantPoacher,
	::Const.EntityType.LegendPeasantMiner,
	::Const.EntityType.LegendPeasantSquire,
	::Const.EntityType.LegendPeasantWitchHunter,
	::Const.EntityType.CaravanHand,
	::Const.EntityType.CaravanGuard,
	::Const.EntityType.LegendCaravanPolearm,
	::Const.EntityType.Militia,
	::Const.EntityType.MilitiaVeteran,
	::Const.EntityType.MilitiaCaptain,
	::Const.EntityType.MilitiaRanged,
	// ::Const.EntityType.Slave,
	// ::Const.EntityType.Engineer,
	::Const.EntityType.PeasantSouthern
];
::Const.LegendMod.FavoriteNoble <- [
	::Const.EntityType.Footman,
	::Const.EntityType.LegendNobleGuard,
	::Const.EntityType.LegendManAtArms,
	::Const.EntityType.Greatsword,
	::Const.EntityType.Billman,
	::Const.EntityType.Arbalester,
	::Const.EntityType.StandardBearer,
	::Const.EntityType.Sergeant,
	::Const.EntityType.LegendFencer,
	::Const.EntityType.LegendHalberdier,
	::Const.EntityType.LegendSlinger,
	::Const.EntityType.NobleEliteFootman,
	::Const.EntityType.NoblePollax,
	::Const.EntityType.NobleSureshot,
	::Const.EntityType.Knight
];
::Const.LegendMod.FavoriteMercenary <- [
	::Const.EntityType.Wardog,
	::Const.EntityType.ArmoredWardog,
	::Const.EntityType.Mercenary, //Contains LOW varient
	::Const.EntityType.MercenaryRanged,
	::Const.EntityType.BountyHunter,
	// ::Const.EntityType.Swordmaster,
	// ::Const.EntityType.HedgeKnight,
	// ::Const.EntityType.MasterArcher,
	::Const.EntityType.FreeCompanyArcher, //Not used
	::Const.EntityType.FreeCompanyCrossbow, //Not used
	::Const.EntityType.FreeCompanyLongbow, //Not used
	::Const.EntityType.FreeCompanyBillman, //Not used
	::Const.EntityType.FreeCompanyPikeman, //Not used
	::Const.EntityType.FreeCompanyInfantry, //Not used
	::Const.EntityType.FreeCompanyLeader, //Not used
	::Const.EntityType.FreeCompanyLeaderLow //Not used
];
::Const.LegendMod.FavoriteSoutherners <- [
	::Const.EntityType.Slave,
	::Const.EntityType.Conscript,
	::Const.EntityType.Gunner,
	::Const.EntityType.Officer,
	::Const.EntityType.Engineer,
	::Const.EntityType.Assassin,
	::Const.EntityType.LegendManhunter,
	::Const.EntityType.LegendManhunterVeteran
	// ::Const.EntityType.Gladiator,
	// ::Const.EntityType.PeasantSouthern
];
::Const.LegendMod.FavoriteNomad <- [
	::Const.EntityType.Slave,
	// ::Const.EntityType.Gladiator,
	::Const.EntityType.NomadCutthroat,
	::Const.EntityType.NomadOutlaw,
	::Const.EntityType.NomadSlinger,
	::Const.EntityType.NomadArcher,
	::Const.EntityType.NomadLeader
	// ::Const.EntityType.DesertStalker,
	// ::Const.EntityType.Executioner,
	// ::Const.EntityType.DesertDevil
	// ::Const.EntityType.PeasantSouthern
];

::Const.LegendMod.GetFavoriteEnemyValue <- function ( _type ) //Number = how many you need to kill to attain 1% towards a fav. enemy multiplier. | EG, 1 = 1%, 4 = 0.25%, etc. | 1 / <return number> = how many needed to gain 1%.
{
	switch(_type) //Basically, use anything that is NOT a prime number.
	{
	case ::Const.EntityType.Lindwurm :
		return 1;

	case ::Const.EntityType.Serpent :
		return 4;

	case ::Const.EntityType.LegendStollwurm :
		return 0.4;

	case ::Const.EntityType.Alp :
		return 4;

	case ::Const.EntityType.LegendDemonAlp :
		return 1;

	case ::Const.EntityType.LegendGreenwoodSchrat :
		return 1;

	case ::Const.EntityType.LegendGreenwoodSchratSmall :
		return 2.5;

	case ::Const.EntityType.SandGolem :
		return 8;

	case ::Const.EntityType.Schrat :
		return 1;

	case ::Const.EntityType.SchratSmall :
		return 5;

	case ::Const.EntityType.LegendRockUnhold :
		return 0.5;

	case ::Const.EntityType.Unhold :
		return 2;

	case ::Const.EntityType.UnholdBog :
		return 2;

	case ::Const.EntityType.UnholdFrost :
		return 2;

	case ::Const.EntityType.Hexe :
		return 2;

	case ::Const.EntityType.LegendHexeLeader :
		return 0.5;

	case ::Const.EntityType.Spider :
		return 8;

	// case ::Const.EntityType.SpiderBodyguard :
	// 	return 8;

	case ::Const.EntityType.SpiderEggs :
		return 2;

	case ::Const.EntityType.LegendRedbackSpider :
		return 1;

	case ::Const.EntityType.Ghoul :
		return 6;

	case ::Const.EntityType.LegendSkinGhoul :
		return 2;

	case ::Const.EntityType.Hyena :
		return 5;

	case ::Const.EntityType.Direwolf :
		return 5;

	case ::Const.EntityType.LegendWhiteDirewolf :
		return 0.5;

	case ::Const.EntityType.Vampire :
		return 4;

	case ::Const.EntityType.LegendVampireLord :
		return 2;

	case ::Const.EntityType.LegendMummyLight :
		return 4;

	case ::Const.EntityType.LegendMummyMedium :
		return 2;

	case ::Const.EntityType.LegendMummyHeavy :
		return 1;

	case ::Const.EntityType.LegendMummyQueen :
		return 0.5;

	case ::Const.EntityType.LegendMummyPriest :
		return 0.8;

	case ::Const.EntityType.SkeletonGladiator :
		return 2;

	case ::Const.EntityType.SkeletonPriest :
		return 2;

	case ::Const.EntityType.SkeletonHeavy :
		return 2;

	case ::Const.EntityType.SkeletonMedium :
		return 5;

	case ::Const.EntityType.SkeletonLight :
		return 10;

	case ::Const.EntityType.LegendDemonHound :
		return 8;

	case ::Const.EntityType.Ghost :
		return 8;

	case ::Const.EntityType.LegendBanshee :
		return 4;

	case ::Const.EntityType.ZombieBoss :
		return 1;

	case ::Const.EntityType.ZombieBetrayer :
		return 5;

	case ::Const.EntityType.ZombieKnight :
		return 5;

	case ::Const.EntityType.ZombieYeoman :
		return 10;

	case ::Const.EntityType.Zombie :
		return 20;

	case ::Const.EntityType.Necromancer :
		return 4;

	case ::Const.EntityType.GoblinWolfrider :
		return 5;

	case ::Const.EntityType.GoblinShaman :
		return 4;

	case ::Const.EntityType.GoblinLeader :
		return 4;

	case ::Const.EntityType.GoblinFighter :
		return 8;

	case ::Const.EntityType.GoblinAmbusher :
		return 8;

	case ::Const.EntityType.OrcYoung :
		return 6;

	case ::Const.EntityType.OrcBerserker :
		return 5;

	case ::Const.EntityType.LegendOrcElite :
		return 4;

	case ::Const.EntityType.OrcWarlord :
		return 1;

	case ::Const.EntityType.LegendOrcBehemoth :
		return 2;

	case ::Const.EntityType.OrcWarrior :
		return 5;

	case ::Const.EntityType.Militia :
		return 20;

	case ::Const.EntityType.MilitiaRanged :
		return 20;

	case ::Const.EntityType.MilitiaCaptain :
		return 4;

	case ::Const.EntityType.MilitiaVeteran :
		return 5;

	case ::Const.EntityType.BountyHunter :
		return 4;

	case ::Const.EntityType.LegendPeasantButcher :
	case ::Const.EntityType.LegendPeasantBlacksmith :
	case ::Const.EntityType.LegendPeasantMonk :
	case ::Const.EntityType.LegendPeasantFarmhand :
	case ::Const.EntityType.LegendPeasantMinstrel :
	case ::Const.EntityType.LegendPeasantPoacher :
	case ::Const.EntityType.LegendPeasantMiner :
	case ::Const.EntityType.LegendPeasantSquire :
	case ::Const.EntityType.LegendPeasantWitchHunter :
	case ::Const.EntityType.Peasant :
		return 25; //Just using this for now, they are all pretty much the same in strength aside from the witchunter and squire anyway.

	case ::Const.EntityType.LegendCaravanPolearm:
	case ::Const.EntityType.CaravanHand :
		return 10;

	case ::Const.EntityType.CaravanGuard :
		return 8;

	case ::Const.EntityType.Wardog :
	case ::Const.EntityType.ArmoredWardog :
		return 16;

	case ::Const.EntityType.Mercenary :
	case ::Const.EntityType.MercenaryRanged :
		return 2;

	case ::Const.EntityType.HedgeKnight :
		return 4;

	case ::Const.EntityType.MasterArcher :
		return 2;

	case ::Const.EntityType.Footman :
	case ::Const.EntityType.NobleEliteFootman :
	case ::Const.EntityType.NoblePollax :
	case ::Const.EntityType.NobleSureshot :
		return 8;

	case ::Const.EntityType.Greatsword :
		return 4;

	case ::Const.EntityType.Swordmaster :
		return 2;

	case ::Const.EntityType.Billman :
		return 8;

	case ::Const.EntityType.Arbalester :
		return 4;

	case ::Const.EntityType.StandardBearer :
		return 2;

	case ::Const.EntityType.Sergeant :
		return 8;

	case ::Const.EntityType.Knight :
		return 1;

	case ::Const.EntityType.LegendSlinger :
		return 8;

	case ::Const.EntityType.LegendHalberdier :
		return 4;

	case ::Const.EntityType.LegendFencer :
		return 4;

	case ::Const.EntityType.BanditRabble :
	case ::Const.EntityType.BanditRabblePoacher :
		return 40;

	case ::Const.EntityType.BanditThug :
		return 16;

	case ::Const.EntityType.BanditPoacher :
		return 16;

	case ::Const.EntityType.BanditMarksman :
		return 8;

	case ::Const.EntityType.BanditRaider :
		return 8;

	case ::Const.EntityType.BanditVeteran :
		return 5;

	case ::Const.EntityType.BanditLeader :
		return 4;

	case ::Const.EntityType.BanditWarlord :
		return 1;

	case ::Const.EntityType.Warhound :
		return 16;

	case ::Const.EntityType.BarbarianThrall :
		return 10;

	case ::Const.EntityType.BarbarianMarauder :
		return 8;

	case ::Const.EntityType.BarbarianChosen: //Barbarian King
	case ::Const.EntityType.BarbarianChampion:
		return 1;

	case ::Const.EntityType.BarbarianDrummer :
		return 4;

	case ::Const.EntityType.BarbarianUnhold :
		return 2;

	case ::Const.EntityType.BarbarianUnholdFrost :
		return 2;

	case ::Const.EntityType.BarbarianBeastmaster :
		return 4;

	case ::Const.EntityType.BarbarianMadman :
		return 1;

	case ::Const.EntityType.Conscript :
		return 8;

	case ::Const.EntityType.Gunner :
		return 4;

	case ::Const.EntityType.Officer :
		return 2;

	case ::Const.EntityType.Engineer :
		return 1;

	case ::Const.EntityType.Assassin :
		return 2;

	case ::Const.EntityType.Slave :
		return 25;

	case ::Const.EntityType.Gladiator :
		return 2;

	case ::Const.EntityType.NomadCutthroat :
		return 16;

	case ::Const.EntityType.NomadOutlaw :
		return 8;

	case ::Const.EntityType.NomadSlinger :
		return 10;

	case ::Const.EntityType.NomadArcher :
		return 8;

	case ::Const.EntityType.NomadLeader :
		return 4;

	case ::Const.EntityType.DesertStalker :
		return 2;

	case ::Const.EntityType.Executioner :
		return 2;

	case ::Const.EntityType.DesertDevil :
		return 2;

	case ::Const.EntityType.PeasantSouthern :
		return 25;

	case ::Const.EntityType.LegendManhunter :
	case ::Const.EntityType.LegendManhunterRanged : //only for escaped slaves origin. Makes sense they are higher %
		return 4;

	case ::Const.EntityType.LegendManhunterVeteran :
	case ::Const.EntityType.LegendManhunterVeteranRanged : //only for escaped slaves origin. Makes sense they are higher %
		return 2;

	case ::Const.EntityType.SkeletonLich :
		return 1;

	case ::Const.EntityType.SkeletonLichMirrorImage :
		return 0.5;

	case ::Const.EntityType.SkeletonPhylactery :
		return 1;

	case ::Const.EntityType.SkeletonBoss :
		return 0.25;

	case ::Const.EntityType.ZombieTreasureHunter :
		return 5;

	case ::Const.EntityType.FlyingSkull :
		return 25;

	default:
		return 10;
	}
};
::Const.LegendMod.SetFavoriteEnemyKill <- function ( _actor, _target )
{
	local favKey = "Enemy" + _target.getType();
	_actor.getLifetimeStats().Tags.increment(favKey, 1);
}

::Const.LegendMod.GetFavoriteEnemyStats <- function ( _actor, _types )
{
	if (_actor == null)
	{
		return {
			Kills = 0,
			Strength = 0,
			HitChance = 0,
			HitMult = 0
		}
	}

	local kills = 0;
	local str = 0;
	foreach (t in _types)
	{
		local mKills = 0;
		local favKey = "Enemy" + t;
		mKills = _actor.getLifetimeStats().Tags.get(favKey);
		if (mKills && mKills > 0)
		{
			kills += mKills;
			str += (mKills * 1.0 / ::Const.LegendMod.GetFavoriteEnemyValue(t));
		}
	}
	local hitChance = 5 + this.Math.min(this.Math.floor(str), 20); // base bonus of 5 and cap total at 25
	local hitMult = 1.0 + (0.01 * hitChance);
	return {
		Kills = kills,
		Strength = str,
		HitChance = hitChance,
		HitMult = hitMult
	}
}

::Const.LegendMod.FavEnemyPerkMap <- {
	Enemy1 = []

	function getPerks( _id)
	{
		local key = "Enemy" + _id;
		if (!(key in this))
		{
			return [];
		}
		return this[key];
	}

	function addPerk( _key, _perk)
	{
		local p = this[_key];
		foreach (perk in p)
		{
			if (_perk == perk)
			{
				return;
			}
		}
		p.push(_perk);
	}

	function addEnemies( _enemies, _perk)
	{
		foreach (_e in _enemies)
		{
			local key = "Enemy" + _e;
			if (!(key in this))
			{
				this[key] <- [];
			}
			this.addPerk(key, _perk);
		}

	}
}

::Const.LegendMod.GetFavEnemyBossChance <- function (_id)
{
	local perks = ::Const.LegendMod.FavEnemyPerkMap.getPerks(_id);
	if( perks.len() == 0)
	{
		return 0;
	}

	local bonus = 0;
	local roster = this.World.getPlayerRoster().getAll();
	foreach (bro in roster)
	{
		foreach (perk in perks)
		{
			if (!bro.getSkills().hasSkill(perk))
			{
				continue
			}

			local P = bro.getSkills().getSkillByID(perk);

			local stats = ::Const.LegendMod.GetFavoriteEnemyStats(bro, P.m.ValidTypes);
			bonus += this.Math.floor((stats.Kills * 1.0) / 10.0);
			break;
		}
	}
	return bonus;
}

