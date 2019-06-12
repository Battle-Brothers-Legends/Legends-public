local gt = this.getroottable();

if (!("Perks" in gt.Const))
{
	gt.Const.Perks <- {};
}

local Tree = [
	[
		gt.Const.Perks.PerkDefs.FastAdaption,
		gt.Const.Perks.PerkDefs.BagsAndBelts,
		gt.Const.Perks.PerkDefs.NineLives,
		gt.Const.Perks.PerkDefs.Pathfinder,
		gt.Const.Perks.PerkDefs.Student,
		gt.Const.Perks.PerkDefs.Recover,
		gt.Const.Perks.PerkDefs.Lookout,
		gt.Const.Perks.PerkDefs.LegendBribe
	],
	[
		gt.Const.Perks.PerkDefs.CoupDeGrace,
		gt.Const.Perks.PerkDefs.Dodge,
		gt.Const.Perks.PerkDefs.FortifiedMind,
		gt.Const.Perks.PerkDefs.HoldOut,
		gt.Const.Perks.PerkDefs.QuickHands,
		gt.Const.Perks.PerkDefs.RallyTheTroops,
		gt.Const.Perks.PerkDefs.SteelBrow,
		gt.Const.Perks.PerkDefs.LegendComposure,
		gt.Const.Perks.PerkDefs.LegendRoster2

	],
	[
		gt.Const.Perks.PerkDefs.Backstabber,
		gt.Const.Perks.PerkDefs.Anticipation,
		gt.Const.Perks.PerkDefs.Rotation,
		gt.Const.Perks.PerkDefs.Taunt,
		gt.Const.Perks.PerkDefs.Sprint,
		gt.Const.Perks.PerkDefs.LegendDangerPay,
		gt.Const.Perks.PerkDefs.LegendRoster3
	],
	[
		gt.Const.Perks.PerkDefs.SpecCrossbow,
		gt.Const.Perks.PerkDefs.SpecPolearm,
		gt.Const.Perks.PerkDefs.SpecThrowing,
		gt.Const.Perks.PerkDefs.SpecDagger,
		gt.Const.Perks.PerkDefs.LegendEfficientPacking,
		gt.Const.Perks.PerkDefs.LegendAmmoBinding,
		gt.Const.Perks.PerkDefs.LegendMedPackages,
		gt.Const.Perks.PerkDefs.LegendToolsDrawers,
		gt.Const.Perks.PerkDefs.LegendBarterConvincing,
		gt.Const.Perks.PerkDefs.LegendRoster4
		
	],
	[
		gt.Const.Perks.PerkDefs.Overwhelm,
		gt.Const.Perks.PerkDefs.ReachAdvantage,
		gt.Const.Perks.PerkDefs.LoneWolf,
		gt.Const.Perks.PerkDefs.Footwork,
		gt.Const.Perks.PerkDefs.Underdog,
		gt.Const.Perks.PerkDefs.LegendRoster5
	],
	[
		gt.Const.Perks.PerkDefs.HeadHunter,
		gt.Const.Perks.PerkDefs.Nimble,
		gt.Const.Perks.PerkDefs.BattleForged,
		gt.Const.Perks.PerkDefs.Rebound,
		gt.Const.Perks.PerkDefs.LegendRoster6
	],
	[
		gt.Const.Perks.PerkDefs.Fearsome,
		gt.Const.Perks.PerkDefs.Duelist,
		gt.Const.Perks.PerkDefs.Indomitable,
		gt.Const.Perks.PerkDefs.LegendSkillfulStacking,
		gt.Const.Perks.PerkDefs.LegendBarterTrustworthy,
		gt.Const.Perks.PerkDefs.LegendRoster7
	],
	[],
	[],
	[],
	[]	
];


gt.Const.Perks.PerksTreeTrader <- gt.Const.Perks.BuildCustomPerkTree(Tree)