if (!("EnemyPerks" in ::Const))
	::Const.EnemyPerks <- {};

::Const.EnemyPerks.Default <- []

::Const.EnemyPerks.FreeCompanyArcher <- [
	[3, [::Const.Perks.PerkDefs.LegendSpecialistShortbowSkill, ::Const.Perks.PerkDefs.LegendSpecialistShortbowDamage], 4],
	[1, ::Const.Perks.PerkDefs.Rotation, 2],
	[1, ::Const.Perks.PerkDefs.Anticipation, 2],
	[1, ::Const.Perks.PerkDefs.Bullseye, 1],
	[2, ::Const.Perks.PerkDefs.FastAdaption, 1],
	[1, ::Const.Perks.PerkDefs.Pathfinder, 1],
	[1, ::Const.Perks.PerkDefs.Relentless, 1],
	[1, ::Const.Perks.PerkDefs.QuickHands, 0]
]

::Const.EnemyPerks.FreeCompanyCrossbow <- [
	[2, ::Const.Perks.PerkDefs.LegendBallistics, 3],
	[1, ::Const.Perks.PerkDefs.Anticipation, 2],
	[1, ::Const.Perks.PerkDefs.Rotation, 2],
	[2, ::Const.Perks.PerkDefs.Bullseye, 1],
	[1, ::Const.Perks.PerkDefs.FastAdaption, 1],
	[1, ::Const.Perks.PerkDefs.Pathfinder, 1],
	[1, ::Const.Perks.PerkDefs.Relentless, 1],
	[1, ::Const.Perks.PerkDefs.QuickHands, 0]
]

::Const.EnemyPerks.FreeCompanyLongbow <- [
	[3, ::Const.Perks.PerkDefs.Berserk, 4],
	[3, ::Const.Perks.PerkDefs.HeadHunter, 3],
	[3, ::Const.Perks.PerkDefs.Overwhelm, 3],
	[4, ::Const.Perks.PerkDefs.LegendAlert, 2],
	[3, ::Const.Perks.PerkDefs.Anticipation, 2],
	[2, ::Const.Perks.PerkDefs.LegendBallistics, 2],
	[2, ::Const.Perks.PerkDefs.Rotation, 2],
	[2, ::Const.Perks.PerkDefs.Bullseye, 1],
	[1, ::Const.Perks.PerkDefs.FastAdaption, 1],
	[1, ::Const.Perks.PerkDefs.Pathfinder, 1],
	[1, ::Const.Perks.PerkDefs.Relentless, 1],
	[1, ::Const.Perks.PerkDefs.QuickHands, 0]
]

::Const.EnemyPerks.FreeCompanySpearman <- [
	[4, [::Const.Perks.PerkDefs.LegendSpecialistMilitiaSkill, ::Const.Perks.PerkDefs.LegendSpecialistMilitiaDamage], 4],
	[2, ::Const.Perks.PerkDefs.Underdog, 3],
	[2, ::Const.Perks.PerkDefs.Backstabber, 2],
	[2, ::Const.Perks.PerkDefs.ShieldExpert, 2],
	[1, ::Const.Perks.PerkDefs.CripplingStrikes, 1],
	[1, ::Const.Perks.PerkDefs.FortifiedMind, 1],
	[1, ::Const.Perks.PerkDefs.HoldOut, 1],
	[1, ::Const.Perks.PerkDefs.SteelBrow, 1],
	[1, ::Const.Perks.PerkDefs.Recover, 0]
]

::Const.EnemyPerks.FreeCompanySlayer <- [
	[2, [::Const.Perks.PerkDefs.LegendAlert, ::Const.Perks.PerkDefs.Relentless, ::Const.Perks.PerkDefs.Overwhelm], 5],
	[4, ::Const.Perks.PerkDefs.Berserk, 3],
	[2, ::Const.Perks.PerkDefs.CoupDeGrace, 3],
	[3, ::Const.Perks.PerkDefs.BattleForged, 3],
	[2, ::Const.Perks.PerkDefs.LegendBigGameHunter, 3],
	[3, ::Const.Perks.PerkDefs.LegendMuscularity, 3],
	[2, ::Const.Perks.PerkDefs.Adrenaline, 2],
	[2, ::Const.Perks.PerkDefs.CripplingStrikes, 2],
	[4, ::Const.Perks.PerkDefs.LegendHairSplitter, 2],
	[1, ::Const.Perks.PerkDefs.Backstabber, 1],
	[1, ::Const.Perks.PerkDefs.QuickHands, 1],
	[1, ::Const.Perks.PerkDefs.HoldOut, 0],
	[1, ::Const.Perks.PerkDefs.SteelBrow, 0]
]

::Const.EnemyPerks.FreeCompanyFootman <- [
	[2, [::Const.Perks.PerkDefs.CripplingStrikes, ::Const.Perks.PerkDefs.CoupDeGrace], 4],
	[3, ::Const.Perks.PerkDefs.BattleForged, 3],
	[3, ::Const.Perks.PerkDefs.LegendMuscularity, 3],
	[2, ::Const.Perks.PerkDefs.LegendAlert, 2],
	[2, ::Const.Perks.PerkDefs.Adrenaline, 2],
	[1, ::Const.Perks.PerkDefs.Overwhelm, 2],
	[1, ::Const.Perks.PerkDefs.FortifiedMind, 1],
	[1, ::Const.Perks.PerkDefs.HoldOut, 1],
	[1, ::Const.Perks.PerkDefs.SteelBrow, 1],
	[1, ::Const.Perks.PerkDefs.Brawny, 0]
]

::Const.EnemyPerks.FreeCompanyPikeman <- [
	[2, ::Const.Perks.PerkDefs.CoupDeGrace, 3],
	[3, ::Const.Perks.PerkDefs.LegendMuscularity, 3],
	[2, ::Const.Perks.PerkDefs.Backstabber, 2],
	[1, ::Const.Perks.PerkDefs.Footwork, 2],
	[1, ::Const.Perks.PerkDefs.Overwhelm, 2],
	[1, ::Const.Perks.PerkDefs.Anticipation, 1],
	[1, ::Const.Perks.PerkDefs.FortifiedMind, 1],
	[1, ::Const.Perks.PerkDefs.HoldOut, 1],
	[1, ::Const.Perks.PerkDefs.Relentless, 1],
	[1, ::Const.Perks.PerkDefs.SteelBrow, 0],
]

::Const.EnemyPerks.FreeCompanyBillman <- [
	[3, ::Const.Perks.PerkDefs.CoupDeGrace, 3],
	[2, ::Const.Perks.PerkDefs.LegendMuscularity, 3],
	[2, ::Const.Perks.PerkDefs.Backstabber, 2],
	[1, ::Const.Perks.PerkDefs.Footwork, 2],
	[1, ::Const.Perks.PerkDefs.Overwhelm, 2],
	[1, ::Const.Perks.PerkDefs.Anticipation, 1],
	[1, ::Const.Perks.PerkDefs.FortifiedMind, 1],
	[1, ::Const.Perks.PerkDefs.Relentless, 1],
	[1, ::Const.Perks.PerkDefs.SteelBrow, 1],
	[1, ::Const.Perks.PerkDefs.Colossus, 1],
	[1, ::Const.Perks.PerkDefs.HoldOut, 0]
]

::Const.EnemyPerks.FreeCompanyInfantry <- [
	[3, ::Const.Perks.PerkDefs.BattleForged, 3],
	[3, ::Const.Perks.PerkDefs.LegendMuscularity, 3],
	[2, ::Const.Perks.PerkDefs.LegendComposure, 2],
	[3, ::Const.Perks.PerkDefs.LegendDoubleStrike, 2],
	[3, ::Const.Perks.PerkDefs.LegendSmackdown, 2],
	[1, ::Const.Perks.PerkDefs.Backstabber, 1],
	[1, ::Const.Perks.PerkDefs.Colossus, 1],
	[1, ::Const.Perks.PerkDefs.QuickHands, 1],
	[1, ::Const.Perks.PerkDefs.CoupDeGrace, 0],
	[1, ::Const.Perks.PerkDefs.HoldOut, 0],
	[1, ::Const.Perks.PerkDefs.SteelBrow, 0]
]

::Const.EnemyPerks.FreeCompanyLeader <- [
	[4, ::Const.Perks.PerkDefs.Berserk, 3],
	[3, ::Const.Perks.PerkDefs.LegendDoubleStrike, 2],
	[1, [::Const.Perks.PerkDefs.Footwork, ::Const.Perks.PerkDefs.LegendTumble], 2],
	[2, ::Const.Perks.PerkDefs.ReachAdvantage, 2],
	[3, ::Const.Perks.PerkDefs.LegendSmackdown, 2],
	[1, ::Const.Perks.PerkDefs.Backstabber, 1],
	[2, ::Const.Perks.PerkDefs.Colossus, 1],
	[1, ::Const.Perks.PerkDefs.FastAdaption, 1],
	[1, ::Const.Perks.PerkDefs.RallyTheTroops, 0],
	[1, ::Const.Perks.PerkDefs.QuickHands, 0],
	[1, ::Const.Perks.PerkDefs.BattleForged, 0]
]
