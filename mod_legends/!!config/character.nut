::Const.Corpse.isHuman <- 0;
::Const.BackgroundTypeName <- {
	None = "None",
	Crusader = "Crusader",
	Combat = "Combat",
	ConvertedCultist = "Converted Cultist",
	Druid = "Druid",
	Educated = "Educated",
	Female = "Female",
	Noble = "Noble",
	Lowborn = "Lowborn",
	OffendedByViolence = "Offended By Violence",
	Outlaw = "Outlaw",
	Performing = "Performing",
	Scenario = "Scenario",
	Ranger = "Ranger",
	Stabled = "Stabled",
	Untalented = "Untalented",
	Cultist = "Cultist",
	ExpertHunter = "Expert Hunter",
};

// Note: due to limitations of 32-Bit Signed Integers, we can only have up to 31 types
::Const.BackgroundType <- {
	None = 0,
	Crusader = 1,
	Combat = 2,
	ConvertedCultist = 4,
	Druid = 8,
	Educated = 16,
	Female = 32,
	Noble = 64,
	Lowborn = 128,
	OffendedByViolence = 256,
	Outlaw = 512,
	Performing = 1024,
	Scenario = 2048,
	Ranger = 4096,
	Stabled = 8192,
	Untalented = 16384,
	Cultist = 32768,
	ExpertHunter = 65536,
};

::Const.addNewBackgroundType <- function( _typeKey )
{
	local max = 0;
	foreach (btype, value in this.Const.BackgroundType)
	{
		if (max < value)
		{
			max = value;
		}
	}

	this.Const.BackgroundType[_typeKey] <- max << 1;
}

::Const.ProjectileType.Missile <- 11;
::Const.ProjectileType.Blood <- 12;
::Const.ProjectileType.Dart <- 13;
::Const.ProjectileType.COUNT = 14;

::Const.ProjectileSprite.extend([
	"projectile_missile",
	"projectile_blood",
	"projectile_dart"
]);

::Const.HorseMovementAPCost <- [
	0,
	1,
	1,
	3,
	3,
	5,
	5,
	5,
	5
];

::Const.HorsePassageMovementAPCost <- [
	0,
	1,
	1,
	2,
	2,
	4,
	4,
	4,
	4
];

::Const.LegendFlightMovementAPCost <- [
	0,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1
];

::Const.CatapultMovementAPCost <- [
	0,
	10,
	10,
	10,
	10,
	10,
	10,
	10,
	10
];

::Const.HorseMovementFatigueCost <- [
	0,
	1,
	1,
	4,
	4,
	6,
	12,
	10,
	10
];

::Const.HorsePassageMovementFatigueCost <- [
	0,
	1,
	1,
	2,
	2,
	3,
	6,
	5,
	5
];

::Const.LegendFlightMovementFatigueCost <- [
	0,
	2,
	2,
	2,
	2,
	2,
	2,
	2,
	2
];

::Const.CatapultMovementFatigueCost <- [
	0,
	4,
	8,
	12,
	12,
	16,
	28,
	24,
	24
];

::Const.CharacterProperties.FatigueLossOnBeingMissedMult <- 1.0;
::Const.CharacterProperties.IsParrying <- false;
::Const.CharacterProperties.IsEvadingAllAttacks <- false;
::Const.CharacterProperties.IsAffectedByRain <- true;
::Const.CharacterProperties.SurvivesAsUndead <- false;
::Const.CharacterProperties.IsSpecializedInOneHandedSwords <- false;
::Const.CharacterProperties.IsSpecializedInSpearThrust <- false;
::Const.CharacterProperties.IsSpecializedInShieldPush <- false;
::Const.CharacterProperties.IsSpecializedInNets <- false;
::Const.CharacterProperties.IsSpecializedInNetCasting <- false;
::Const.CharacterProperties.IsSpecializedInFists <- false;
::Const.CharacterProperties.IsSpecializedInSlings <- false;
::Const.CharacterProperties.IsSpecializedInStaves <- false;
::Const.CharacterProperties.IsSpecializedInStaffStun <- false;
::Const.CharacterProperties.IsSpecializedInSummons <- false;
::Const.CharacterProperties.DamageInitiativeMin <- 0;
::Const.CharacterProperties.DamageInitiativeMax <- 0;
::Const.CharacterProperties.DamageInitiativeCutoff <- 100;
::Const.CharacterProperties.FlatOnKillOtherActorModifier <- 0;
::Const.CharacterProperties.PercentOnKillOtherActorModifier <- 1.0;

::Const.CharacterProperties.getInitiativeMinDamage <- function ()
{
	return this.DamageInitiativeMin + this.Math.max(0, this.getInitiative() - this.DamageInitiativeCutoff);
};

::Const.CharacterProperties.getInitiativeMaxDamage <- function ()
{
	return this.DamageInitiativeMax + this.Math.max(0, this.getInitiative() - this.DamageInitiativeCutoff);
};
