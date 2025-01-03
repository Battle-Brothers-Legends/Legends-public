if (!("LegendMod" in ::Const))
{
	::Const.LegendMod <- {};
}

::Const.LegendMod.FavoriteZombies <- [
	this.Const.EntityType.ZombieYeoman,
	this.Const.EntityType.Zombie,
	this.Const.EntityType.ZombieBetrayer,
	this.Const.EntityType.ZombieBoss,
	this.Const.EntityType.ZombieKnight,
	this.Const.EntityType.Necromancer,
	this.Const.EntityType.ZombieTreasureHunter
];

::Const.LegendMod.FavoriteAlps <- [
	this.Const.EntityType.Alp,
	this.Const.EntityType.AlpShadow,
	this.Const.EntityType.LegendDemonAlp
];

::Const.LegendMod.FavoriteDirewolf <- [
	this.Const.EntityType.Hyena,
	this.Const.EntityType.Direwolf,
	// this.Const.EntityType.Wolf,
	// this.Const.EntityType.GoblinWolfrider,
	// this.Const.EntityType.KoboldWolfrider, //Not used currently
	this.Const.EntityType.LegendWhiteDirewolf
];

::Const.LegendMod.FavoriteGhoul <- [
	this.Const.EntityType.Ghoul,
	this.Const.EntityType.LegendSkinGhoul
];

::Const.LegendMod.FavoriteGoblin <- [
	this.Const.EntityType.GoblinFighter,
	this.Const.EntityType.GoblinAmbusher,
	this.Const.EntityType.GoblinLeader,
	this.Const.EntityType.GoblinShaman,
	this.Const.EntityType.GoblinWolfrider,
	this.Const.EntityType.KoboldWolfrider, //Not used currently
	this.Const.EntityType.KoboldFighter //Not used currently
];

::Const.LegendMod.FavoriteHexe <- [
	this.Const.EntityType.Hexe,
	this.Const.EntityType.LegendHexeLeader
];

::Const.LegendMod.FavoriteLindwurm <- [
	this.Const.EntityType.Serpent,
	this.Const.EntityType.Lindwurm,
	this.Const.EntityType.LegendStollwurm
];

::Const.LegendMod.FavoriteOrc <- [
	this.Const.EntityType.OrcBerserker,
	this.Const.EntityType.OrcYoung,
	this.Const.EntityType.OrcWarrior,
	this.Const.EntityType.OrcWarlord,
	this.Const.EntityType.LegendOrcBehemoth,
	this.Const.EntityType.LegendOrcElite
];

::Const.LegendMod.FavoriteSchrat <- [
	this.Const.EntityType.SandGolem,
	this.Const.EntityType.Schrat,
	this.Const.EntityType.SchratSmall,
	this.Const.EntityType.LegendGreenwoodSchrat,
	this.Const.EntityType.LegendGreenwoodSchratSmall
];

::Const.LegendMod.FavoriteSkeleton <- [
	this.Const.EntityType.SkeletonLight,
	this.Const.EntityType.SkeletonMedium,
	this.Const.EntityType.SkeletonHeavy,
	this.Const.EntityType.SkeletonBoss,
	this.Const.EntityType.SkeletonPriest,
	this.Const.EntityType.SkeletonLich,
	this.Const.EntityType.SkeletonLichMirrorImage,
	this.Const.EntityType.SkeletonPhylactery,
	this.Const.EntityType.SkeletonGladiator,
	this.Const.EntityType.FlyingSkull
];
::Const.LegendMod.FavoriteSpider <- [
	this.Const.EntityType.Spider,
	//this.Const.EntityType.SpiderBodyguard,
	this.Const.EntityType.SpiderEggs,
	this.Const.EntityType.LegendRedbackSpider
];
::Const.LegendMod.FavoriteUnhold <- [
	this.Const.EntityType.Unhold,
	this.Const.EntityType.UnholdBog,
	this.Const.EntityType.UnholdFrost,
	this.Const.EntityType.BarbarianUnhold,
	this.Const.EntityType.BarbarianUnholdFrost,
	this.Const.EntityType.LegendRockUnhold
];
::Const.LegendMod.FavoriteVampire <- [
	this.Const.EntityType.Vampire,
	this.Const.EntityType.Ghost,
	this.Const.EntityType.LegendDemonHound,
	this.Const.EntityType.LegendVampireLord,
	this.Const.EntityType.LegendBanshee,
	this.Const.EntityType.LegendMummyLight,
	this.Const.EntityType.LegendMummyMedium,
	this.Const.EntityType.LegendMummyHeavy,
	this.Const.EntityType.LegendMummyQueen,
	this.Const.EntityType.LegendMummyPriest
];
::Const.LegendMod.FavoriteSwordmaster <- [
	this.Const.EntityType.HedgeKnight,
	this.Const.EntityType.Knight,
	this.Const.EntityType.Greatsword,
	this.Const.EntityType.Swordmaster,
	this.Const.EntityType.BanditLeader,
	// this.Const.EntityType.BanditVeteran,
	this.Const.EntityType.BanditWarlord,
	this.Const.EntityType.BarbarianChampion, //King
	this.Const.EntityType.Sergeant,
	this.Const.EntityType.Officer,
	this.Const.EntityType.Gladiator,
	this.Const.EntityType.Assassin,
	this.Const.EntityType.NomadLeader,
	this.Const.EntityType.Executioner,
	this.Const.EntityType.DesertDevil,
	this.Const.EntityType.LegendFencer
];
::Const.LegendMod.FavoriteArcher <- [
	this.Const.EntityType.MasterArcher,
	this.Const.EntityType.BanditMarksman,
	this.Const.EntityType.BanditRabblePoacher,
	this.Const.EntityType.BanditPoacher,
	this.Const.EntityType.MilitiaRanged,
	this.Const.EntityType.Arbalester,
	this.Const.EntityType.LegendSlinger,
	this.Const.EntityType.GoblinAmbusher,
	this.Const.EntityType.NomadSlinger,
	this.Const.EntityType.NomadArcher,
	this.Const.EntityType.Gunner,
	this.Const.EntityType.DesertStalker
];
::Const.LegendMod.FavoriteBarbarian <- [
	this.Const.EntityType.Warhound,
	this.Const.EntityType.BarbarianThrall,
	this.Const.EntityType.BarbarianMarauder,
	this.Const.EntityType.BarbarianChampion,
	this.Const.EntityType.BarbarianChosen,
	this.Const.EntityType.BarbarianDrummer,
	this.Const.EntityType.BarbarianBeastmaster
];
::Const.LegendMod.FavoriteBandit <- [
	this.Const.EntityType.BanditRabble,
	this.Const.EntityType.BanditRabblePoacher,
	this.Const.EntityType.BanditThug,
	this.Const.EntityType.BanditPoacher,
	this.Const.EntityType.BanditMarksman,
	this.Const.EntityType.BanditRaider,
	this.Const.EntityType.BanditVeteran,
	this.Const.EntityType.BanditWarlord,
	this.Const.EntityType.BanditLeader
];
::Const.LegendMod.FavoriteCaravan <- [
	this.Const.EntityType.Peasant,
	this.Const.EntityType.LegendPeasantButcher,
	this.Const.EntityType.LegendPeasantBlacksmith,
	this.Const.EntityType.LegendPeasantMonk,
	this.Const.EntityType.LegendPeasantFarmhand,
	this.Const.EntityType.LegendPeasantMinstrel,
	this.Const.EntityType.LegendPeasantPoacher,
	this.Const.EntityType.LegendPeasantMiner,
	this.Const.EntityType.LegendPeasantSquire,
	this.Const.EntityType.LegendPeasantWitchHunter,
	this.Const.EntityType.CaravanHand,
	this.Const.EntityType.CaravanGuard,
	this.Const.EntityType.LegendCaravanPolearm,
	this.Const.EntityType.Militia,
	this.Const.EntityType.MilitiaVeteran,
	this.Const.EntityType.MilitiaCaptain,
	this.Const.EntityType.MilitiaRanged,
	// this.Const.EntityType.Slave,
	// this.Const.EntityType.Engineer,
	this.Const.EntityType.PeasantSouthern
];
::Const.LegendMod.FavoriteNoble <- [
	this.Const.EntityType.Footman,
	this.Const.EntityType.LegendNobleGuard,
	this.Const.EntityType.LegendManAtArms,
	this.Const.EntityType.Greatsword,
	this.Const.EntityType.Billman,
	this.Const.EntityType.Arbalester,
	this.Const.EntityType.StandardBearer,
	this.Const.EntityType.Sergeant,
	this.Const.EntityType.LegendFencer,
	this.Const.EntityType.LegendHalberdier,
	this.Const.EntityType.LegendSlinger,
	this.Const.EntityType.NobleEliteFootman,
	this.Const.EntityType.NoblePollax,
	this.Const.EntityType.NobleSureshot,
	this.Const.EntityType.Knight
];
::Const.LegendMod.FavoriteMercenary <- [
	this.Const.EntityType.Wardog,
	this.Const.EntityType.ArmoredWardog,
	this.Const.EntityType.Mercenary, //Contains LOW varient
	this.Const.EntityType.MercenaryRanged,
	this.Const.EntityType.BountyHunter,
	// this.Const.EntityType.Swordmaster,
	// this.Const.EntityType.HedgeKnight,
	// this.Const.EntityType.MasterArcher,
	this.Const.EntityType.FreeCompanyArcher, //Not used
	this.Const.EntityType.FreeCompanyCrossbow, //Not used
	this.Const.EntityType.FreeCompanyLongbow, //Not used
	this.Const.EntityType.FreeCompanyBillman, //Not used
	this.Const.EntityType.FreeCompanyPikeman, //Not used
	this.Const.EntityType.FreeCompanyInfantry, //Not used
	this.Const.EntityType.FreeCompanyLeader, //Not used
	this.Const.EntityType.FreeCompanyLeaderLow //Not used
];
::Const.LegendMod.FavoriteSoutherners <- [
	this.Const.EntityType.Slave,
	this.Const.EntityType.Conscript,
	this.Const.EntityType.Gunner,
	this.Const.EntityType.Officer,
	this.Const.EntityType.Engineer,
	this.Const.EntityType.Assassin,
	this.Const.EntityType.SatoManhunter,
	this.Const.EntityType.SatoManhunterVeteran
	// this.Const.EntityType.Gladiator,
	// this.Const.EntityType.PeasantSouthern
];
::Const.LegendMod.FavoriteNomad <- [
	this.Const.EntityType.Slave,
	// this.Const.EntityType.Gladiator,
	this.Const.EntityType.NomadCutthroat,
	this.Const.EntityType.NomadOutlaw,
	this.Const.EntityType.NomadSlinger,
	this.Const.EntityType.NomadArcher,
	this.Const.EntityType.NomadLeader
	// this.Const.EntityType.DesertStalker,
	// this.Const.EntityType.Executioner,
	// this.Const.EntityType.DesertDevil
	// this.Const.EntityType.PeasantSouthern
];
::Const.LegendMod.GetFavoriteEnemyValue <- function ( _type ) //Number = how many you need to kill to attain 1% towards a fav. enemy multiplier. | EG, 1 = 1%, 4 = 0.25%, etc. | 1 / <return number> = how many needed to gain 1%.
{
	switch(_type) //Basically, use anything that is NOT a prime number.
	{
	case this.Const.EntityType.Lindwurm :
		return 1;

	case this.Const.EntityType.Serpent :
		return 4;

	case this.Const.EntityType.LegendStollwurm :
		return 0.4;

	case this.Const.EntityType.Alp :
		return 4;

	case this.Const.EntityType.LegendDemonAlp :
		return 1;

	case this.Const.EntityType.LegendGreenwoodSchrat :
		return 1;

	case this.Const.EntityType.LegendGreenwoodSchratSmall :
		return 2.5;

	case this.Const.EntityType.SandGolem :
		return 8;

	case this.Const.EntityType.Schrat :
		return 1;

	case this.Const.EntityType.SchratSmall :
		return 5;

	case this.Const.EntityType.LegendRockUnhold :
		return 0.5;

	case this.Const.EntityType.Unhold :
		return 2;

	case this.Const.EntityType.UnholdBog :
		return 2;

	case this.Const.EntityType.UnholdFrost :
		return 2;

	case this.Const.EntityType.Hexe :
		return 2;

	case this.Const.EntityType.LegendHexeLeader :
		return 0.5;

	case this.Const.EntityType.Spider :
		return 8;

	// case this.Const.EntityType.SpiderBodyguard :
	// 	return 8;

	case this.Const.EntityType.SpiderEggs :
		return 2;

	case this.Const.EntityType.LegendRedbackSpider :
		return 1;

	case this.Const.EntityType.Ghoul :
		return 6;

	case this.Const.EntityType.LegendSkinGhoul :
		return 2;

	case this.Const.EntityType.Hyena :
		return 5;

	case this.Const.EntityType.Direwolf :
		return 5;

	case this.Const.EntityType.LegendWhiteDirewolf :
		return 0.5;

	case this.Const.EntityType.Vampire :
		return 4;

	case this.Const.EntityType.LegendVampireLord :
		return 2;

	case this.Const.EntityType.LegendMummyLight :
		return 4;

	case this.Const.EntityType.LegendMummyMedium :
		return 2;

	case this.Const.EntityType.LegendMummyHeavy :
		return 1;

	case this.Const.EntityType.LegendMummyQueen :
		return 0.5;

	case this.Const.EntityType.LegendMummyPriest :
		return 0.8;

	case this.Const.EntityType.SkeletonGladiator :
		return 2;

	case this.Const.EntityType.SkeletonPriest :
		return 2;

	case this.Const.EntityType.SkeletonHeavy :
		return 2;

	case this.Const.EntityType.SkeletonMedium :
		return 5;

	case this.Const.EntityType.SkeletonLight :
		return 10;

	case this.Const.EntityType.LegendDemonHound :
		return 8;

	case this.Const.EntityType.Ghost :
		return 8;

	case this.Const.EntityType.LegendBanshee :
		return 4;

	case this.Const.EntityType.ZombieBoss :
		return 1;

	case this.Const.EntityType.ZombieBetrayer :
		return 5;

	case this.Const.EntityType.ZombieKnight :
		return 5;

	case this.Const.EntityType.ZombieYeoman :
		return 10;

	case this.Const.EntityType.Zombie :
		return 20;

	case this.Const.EntityType.Necromancer :
		return 4;

	case this.Const.EntityType.GoblinWolfrider :
		return 5;

	case this.Const.EntityType.GoblinShaman :
		return 4;

	case this.Const.EntityType.GoblinLeader :
		return 4;

	case this.Const.EntityType.GoblinFighter :
		return 8;

	case this.Const.EntityType.GoblinAmbusher :
		return 8;

	case this.Const.EntityType.OrcYoung :
		return 6;

	case this.Const.EntityType.OrcBerserker :
		return 5;

	case this.Const.EntityType.LegendOrcElite :
		return 4;

	case this.Const.EntityType.OrcWarlord :
		return 1;

	case this.Const.EntityType.LegendOrcBehemoth :
		return 2;

	case this.Const.EntityType.OrcWarrior :
		return 5;

	case this.Const.EntityType.Militia :
		return 20;

	case this.Const.EntityType.MilitiaRanged :
		return 20;

	case this.Const.EntityType.MilitiaCaptain :
		return 4;

	case this.Const.EntityType.MilitiaVeteran :
		return 5;

	case this.Const.EntityType.BountyHunter :
		return 4;

	case this.Const.EntityType.LegendPeasantButcher :
	case this.Const.EntityType.LegendPeasantBlacksmith :
	case this.Const.EntityType.LegendPeasantMonk :
	case this.Const.EntityType.LegendPeasantFarmhand :
	case this.Const.EntityType.LegendPeasantMinstrel :
	case this.Const.EntityType.LegendPeasantPoacher :
	case this.Const.EntityType.LegendPeasantMiner :
	case this.Const.EntityType.LegendPeasantSquire :
	case this.Const.EntityType.LegendPeasantWitchHunter :
	case this.Const.EntityType.Peasant :
		return 25; //Just using this for now, they are all pretty much the same in strength aside from the witchunter and squire anyway.

	case this.Const.EntityType.LegendCaravanPolearm:
	case this.Const.EntityType.CaravanHand :
		return 10;

	case this.Const.EntityType.CaravanGuard :
		return 8;

	case this.Const.EntityType.Wardog :
	case this.Const.EntityType.ArmoredWardog :
		return 16;

	case this.Const.EntityType.Mercenary :
	case this.Const.EntityType.MercenaryRanged :
		return 2;

	case this.Const.EntityType.HedgeKnight :
		return 4;

	case this.Const.EntityType.MasterArcher :
		return 2;

	case this.Const.EntityType.Footman :
	case this.Const.EntityType.NobleEliteFootman :
	case this.Const.EntityType.NoblePollax :
	case this.Const.EntityType.NobleSureshot :
		return 8;

	case this.Const.EntityType.Greatsword :
		return 4;

	case this.Const.EntityType.Swordmaster :
		return 2;

	case this.Const.EntityType.Billman :
		return 8;

	case this.Const.EntityType.Arbalester :
		return 4;

	case this.Const.EntityType.StandardBearer :
		return 2;

	case this.Const.EntityType.Sergeant :
		return 8;

	case this.Const.EntityType.Knight :
		return 1;

	case this.Const.EntityType.LegendSlinger :
		return 8;

	case this.Const.EntityType.LegendHalberdier :
		return 4;

	case this.Const.EntityType.LegendFencer :
		return 4;

	case this.Const.EntityType.BanditRabble :
	case this.Const.EntityType.BanditRabblePoacher :
		return 40;

	case this.Const.EntityType.BanditThug :
		return 16;

	case this.Const.EntityType.BanditPoacher :
		return 16;

	case this.Const.EntityType.BanditMarksman :
		return 8;

	case this.Const.EntityType.BanditRaider :
		return 8;

	case this.Const.EntityType.BanditVeteran :
		return 5;

	case this.Const.EntityType.BanditLeader :
		return 4;

	case this.Const.EntityType.BanditWarlord :
		return 1;

	case this.Const.EntityType.Warhound :
		return 16;

	case this.Const.EntityType.BarbarianThrall :
		return 10;

	case this.Const.EntityType.BarbarianMarauder :
		return 8;

	case this.Const.EntityType.BarbarianChampion : //Barbarian King
		return 1;

	case this.Const.EntityType.BarbarianChosen :
		return 4;

	case this.Const.EntityType.BarbarianDrummer :
		return 4;

	case this.Const.EntityType.BarbarianUnhold :
		return 2;

	case this.Const.EntityType.BarbarianUnholdFrost :
		return 2;

	case this.Const.EntityType.BarbarianBeastmaster :
		return 4;

	case this.Const.EntityType.BarbarianMadman :
		return 1;

	case this.Const.EntityType.Conscript :
		return 8;

	case this.Const.EntityType.Gunner :
		return 4;

	case this.Const.EntityType.Officer :
		return 2;

	case this.Const.EntityType.Engineer :
		return 1;

	case this.Const.EntityType.Assassin :
		return 2;

	case this.Const.EntityType.Slave :
		return 25;

	case this.Const.EntityType.Gladiator :
		return 2;

	case this.Const.EntityType.NomadCutthroat :
		return 16;

	case this.Const.EntityType.NomadOutlaw :
		return 8;

	case this.Const.EntityType.NomadSlinger :
		return 10;

	case this.Const.EntityType.NomadArcher :
		return 8;

	case this.Const.EntityType.NomadLeader :
		return 4;

	case this.Const.EntityType.DesertStalker :
		return 2;

	case this.Const.EntityType.Executioner :
		return 2;

	case this.Const.EntityType.DesertDevil :
		return 2;

	case this.Const.EntityType.PeasantSouthern :
		return 25;

	case this.Const.EntityType.SatoManhunter :
	case this.Const.EntityType.SatoManhunterRanged : //only for escaped slaves origin. Makes sense they are higher %
		return 4;

	case this.Const.EntityType.SatoManhunterVeteran :
	case this.Const.EntityType.SatoManhunterVeteranRanged : //only for escaped slaves origin. Makes sense they are higher %
		return 2;

	case this.Const.EntityType.SkeletonLich :
		return 1;

	case this.Const.EntityType.SkeletonLichMirrorImage :
		return 0.5;

	case this.Const.EntityType.SkeletonPhylactery :
		return 1;

	case this.Const.EntityType.SkeletonBoss :
		return 0.25;

	case this.Const.EntityType.ZombieTreasureHunter :
		return 5;

	case this.Const.EntityType.FlyingSkull :
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
		mKills = _actor.getLifetimeStats().Tags.get(favKey)
		if (mKills && mKills > 0)
		{
			kills += mKills;
			str += (mKills * 1.0 / this.Const.LegendMod.GetFavoriteEnemyValue(t));
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
	if (!this.Const.DLC.Wildmen)
	{
		return 0;
	}

	local perks = this.Const.LegendMod.FavEnemyPerkMap.getPerks(_id)
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

			local P = bro.getSkills().getSkillByID(perk)

			local stats = this.Const.LegendMod.GetFavoriteEnemyStats(bro, P.m.ValidTypes);
			bonus += this.Math.floor((stats.Kills * 1.0) / 10.0)
			break;
		}
	}
	return bonus;
}

