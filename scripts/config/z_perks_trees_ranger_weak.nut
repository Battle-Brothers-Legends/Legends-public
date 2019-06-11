local gt = this.getroottable();

if (!("Perks" in gt.Const))
{
	gt.Const.Perks <- {};
}

local Tree = [
	[
		gt.Const.Perks.PerkDefs.CripplingStrikes,
		gt.Const.Perks.PerkDefs.FastAdaptation,
		gt.Const.Perks.PerkDefs.BagsAndBelts,
		gt.Const.Perks.PerkDefs.Student,
		gt.Const.Perks.PerkDefs.Recover,
		gt.Const.Perks.PerkDefs.Pathfinder,
		gt.Const.Perks.PerkDefs.Lookout,
		gt.Const.Perks.PerkDefs.LegendMarkTarget
	],
	[
		gt.Const.Perks.PerkDefs.CoupDeGrace,
		gt.Const.Perks.PerkDefs.Bullseye,
		gt.Const.Perks.PerkDefs.Dodge,
		gt.Const.Perks.PerkDefs.QuickHands,
		gt.Const.Perks.PerkDefs.Gifted,
		gt.Const.Perks.PerkDefs.LegendNightvision,
		gt.Const.Perks.PerkDefs.Debilitate,
		gt.Const.Perks.PerkDefs.Sprint,
		gt.Const.Perks.PerkDefs.LegendFavouredEnemyDirewolf,
		gt.Const.Perks.PerkDefs.LegendFavouredEnemySpider
	],
	[
		gt.Const.Perks.PerkDefs.BackStabber,
		gt.Const.Perks.PerkDefs.Anticipation,
		gt.Const.Perks.PerkDefs.Rotation,
		gt.Const.Perks.PerkDefs.Relentless,
		gt.Const.Perks.PerkDefs.DoubleStrike,
		gt.Const.Perks.PerkDefs.LegendAmmoBinding,
		gt.Const.Perks.PerkDefs.LegendFavouredEnemyDirewolf,
		gt.Const.Perks.PerkDefs.DevastatingStrikes
	],
	[
		gt.Const.Perks.PerkDefs.MasteryAxe,
		gt.Const.Perks.PerkDefs.MasterySword,
		gt.Const.Perks.PerkDefs.MasteryDagger,
		gt.Const.Perks.PerkDefs.MasteryCrossbow,
		gt.Const.Perks.PerkDefs.MasteryBow,
		gt.Const.Perks.PerkDefs.LegendMasteryNets,
		gt.Const.Perks.PerkDefs.MasteryPoison,
		gt.Const.Perks.PerkDefs.MasteryThrowing
	],
	[
		gt.Const.Perks.PerkDefs.Overwhelm,
		gt.Const.Perks.PerkDefs.LoneWolf,
		gt.Const.Perks.PerkDefs.Footwork,
		gt.Const.Perks.PerkDefs.CloseCombatArcher,
		gt.Const.Perks.PerkDefs.Ballistics,
		gt.Const.Perks.PerkDefs.LegendFavouredEnemyOrk,
		gt.Const.Perks.PerkDefs.LegendFavouredEnemyGoblin
	],
	[
		gt.Const.Perks.PerkDefs.Berserk,
		gt.Const.Perks.PerkDefs.HeadHunter,
		gt.Const.Perks.PerkDefs.Nimble,
		gt.Const.Perks.PerkDefs.Rebound,
		gt.Const.Perks.PerkDefs.LegendCascade,
		gt.Const.Perks.PerkDefs.LegendPiercingShot,
		gt.Const.Perks.PerkDefs.LegendSecondWind,
		gt.Const.Perks.PerkDefs.LegendFavouredEnemySchrat,
		gt.Const.Perks.PerkDefs.LegendFavouredEnemyUnhold,
		gt.Const.Perks.PerkDefs.LegendFavouredEnemyLindwurm
	],
	[
		gt.Const.Perks.PerkDefs.KillingFrenzy,
		gt.Const.Perks.PerkDefs.LegendPerfectFocus,
		gt.Const.Perks.PerkDefs.BattleFlow,
		gt.Const.Perks.PerkDefs.CoordinatedVolleys,
		gt.Const.Perks.PerkDefs.LegendEvasion,
		gt.Const.Perks.PerkDefs.LegendFavouredEnemyUnhold,
		gt.Const.Perks.PerkDefs.LegendBigGameHunter
	],
	[],
	[],
	[],
	[]
];

gt.Const.Perks.PerksTreeRangerWeak <- gt.Const.Perks.BuildCustomPerkTree(Tree)