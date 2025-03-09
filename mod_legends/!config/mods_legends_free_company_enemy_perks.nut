if (!("EnemyPerks" in ::Const))
	::Const.EnemyPerks <- {};

::Const.EnemyPerks.Default <- [];

::Const.EnemyPerks.FreeCompanyArcher <- [
	[3, [::Legends.Perk.LegendSpecialistPoacher], 4],
	[1, ::Legends.Perk.Rotation, 2],
	[1, ::Legends.Perk.Anticipation, 2],
	[1, ::Legends.Perk.Bullseye, 1],
	[2, ::Legends.Perk.FastAdaption, 1],
	[1, ::Legends.Perk.Pathfinder, 1],
	[1, ::Legends.Perk.Relentless, 1],
	[1, ::Legends.Perk.QuickHands, 0]
];

::Const.EnemyPerks.FreeCompanyCrossbow <- [
	[2, ::Legends.Perk.LegendBallistics, 3],
	[1, ::Legends.Perk.Anticipation, 2],
	[1, ::Legends.Perk.Rotation, 2],
	[2, ::Legends.Perk.Bullseye, 1],
	[1, ::Legends.Perk.FastAdaption, 1],
	[1, ::Legends.Perk.Pathfinder, 1],
	[1, ::Legends.Perk.Relentless, 1],
	[1, ::Legends.Perk.QuickHands, 0]
];

::Const.EnemyPerks.FreeCompanyLongbow <- [
	[3, ::Legends.Perk.Berserk, 4],
	[3, ::Legends.Perk.HeadHunter, 3],
	[3, ::Legends.Perk.Overwhelm, 3],
	[4, ::Legends.Perk.LegendAlert, 2],
	[3, ::Legends.Perk.Anticipation, 2],
	[2, ::Legends.Perk.LegendBallistics, 2],
	[2, ::Legends.Perk.Rotation, 2],
	[2, ::Legends.Perk.Bullseye, 1],
	[1, ::Legends.Perk.FastAdaption, 1],
	[1, ::Legends.Perk.Pathfinder, 1],
	[1, ::Legends.Perk.Relentless, 1],
	[1, ::Legends.Perk.QuickHands, 0]
];

::Const.EnemyPerks.FreeCompanySpearman <- [
	[4, [::Legends.Perk.LegendSpecialistMilitia], 4],
	[2, ::Legends.Perk.Underdog, 3],
	[2, ::Legends.Perk.LegendStrengthInNumbers, 2],
	[2, ::Legends.Perk.ShieldExpert, 2],
	[1, ::Legends.Perk.CripplingStrikes, 1],
	[1, ::Legends.Perk.FortifiedMind, 1],
	[1, ::Legends.Perk.HoldOut, 1],
	[1, ::Legends.Perk.SteelBrow, 1],
	[1, ::Legends.Perk.Recover, 0]
];

::Const.EnemyPerks.FreeCompanySlayer <- [
	[2, [::Legends.Perk.LegendAlert, ::Legends.Perk.Relentless, ::Legends.Perk.Overwhelm], 5],
	[4, ::Legends.Perk.Berserk, 3],
	[2, ::Legends.Perk.CoupDeGrace, 3],
	[3, ::Legends.Perk.BattleForged, 3],
	[2, ::Legends.Perk.LegendBigGameHunter, 3],
	[3, ::Legends.Perk.LegendMuscularity, 3],
	[2, ::Legends.Perk.Adrenaline, 2],
	[2, ::Legends.Perk.CripplingStrikes, 2],
	[4, ::Legends.Perk.LegendHairSplitter, 2],
	[1, ::Legends.Perk.LegendStrengthInNumbers, 1],
	[1, ::Legends.Perk.QuickHands, 1],
	[1, ::Legends.Perk.HoldOut, 0],
	[1, ::Legends.Perk.SteelBrow, 0]
];

::Const.EnemyPerks.FreeCompanyFootman <- [
	[2, [::Legends.Perk.CripplingStrikes, ::Legends.Perk.CoupDeGrace], 4],
	[3, ::Legends.Perk.BattleForged, 3],
	[3, ::Legends.Perk.LegendMuscularity, 3],
	[2, ::Legends.Perk.LegendAlert, 2],
	[2, ::Legends.Perk.Adrenaline, 2],
	[1, ::Legends.Perk.Overwhelm, 2],
	[1, ::Legends.Perk.FortifiedMind, 1],
	[1, ::Legends.Perk.HoldOut, 1],
	[1, ::Legends.Perk.SteelBrow, 1],
	[1, ::Legends.Perk.Brawny, 0]
];

::Const.EnemyPerks.FreeCompanyPikeman <- [
	[2, ::Legends.Perk.CoupDeGrace, 3],
	[3, ::Legends.Perk.LegendMuscularity, 3],
	[2, ::Legends.Perk.LegendStrengthInNumbers, 2],
	[1, ::Legends.Perk.Footwork, 2],
	[1, ::Legends.Perk.Overwhelm, 2],
	[1, ::Legends.Perk.Anticipation, 1],
	[1, ::Legends.Perk.FortifiedMind, 1],
	[1, ::Legends.Perk.HoldOut, 1],
	[1, ::Legends.Perk.Relentless, 1],
	[1, ::Legends.Perk.SteelBrow, 0],
];

::Const.EnemyPerks.FreeCompanyBillman <- [
	[3, ::Legends.Perk.CoupDeGrace, 3],
	[2, ::Legends.Perk.LegendMuscularity, 3],
	[2, ::Legends.Perk.LegendStrengthInNumbers, 2],
	[1, ::Legends.Perk.Footwork, 2],
	[1, ::Legends.Perk.Overwhelm, 2],
	[1, ::Legends.Perk.Anticipation, 1],
	[1, ::Legends.Perk.FortifiedMind, 1],
	[1, ::Legends.Perk.Relentless, 1],
	[1, ::Legends.Perk.SteelBrow, 1],
	[1, ::Legends.Perk.Colossus, 1],
	[1, ::Legends.Perk.HoldOut, 0]
];

::Const.EnemyPerks.FreeCompanyInfantry <- [
	[3, ::Legends.Perk.BattleForged, 3],
	[3, ::Legends.Perk.LegendMuscularity, 3],
	[2, ::Legends.Perk.LegendComposure, 2],
	[3, ::Legends.Perk.LegendDoubleStrike, 2],
	[3, ::Legends.Perk.LegendSmackdown, 2],
	[1, ::Legends.Perk.LegendStrengthInNumbers, 1],
	[1, ::Legends.Perk.Colossus, 1],
	[1, ::Legends.Perk.QuickHands, 1],
	[1, ::Legends.Perk.CoupDeGrace, 0],
	[1, ::Legends.Perk.HoldOut, 0],
	[1, ::Legends.Perk.SteelBrow, 0]
];

::Const.EnemyPerks.FreeCompanyLeader <- [
	[4, ::Legends.Perk.Berserk, 3],
	[3, ::Legends.Perk.LegendDoubleStrike, 2],
	[1, [::Legends.Perk.Footwork, ::Legends.Perk.LegendTumble], 2],
	[2, ::Legends.Perk.ReachAdvantage, 2],
	[3, ::Legends.Perk.LegendSmackdown, 2],
	[1, ::Legends.Perk.LegendStrengthInNumbers, 1],
	[2, ::Legends.Perk.Colossus, 1],
	[1, ::Legends.Perk.FastAdaption, 1],
	[1, ::Legends.Perk.RallyTheTroops, 0],
	[1, ::Legends.Perk.QuickHands, 0],
	[1, ::Legends.Perk.BattleForged, 0]
];
