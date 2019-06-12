local gt = this.getroottable();

if (!("Perks" in gt.Const))
{
	gt.Const.Perks <- {};
}

local Tree = [
	[
		gt.Const.Perks.PerkDefs.FastAdaption,
		gt.Const.Perks.PerkDefs.CripplingStrikes,
		gt.Const.Perks.PerkDefs.BagsAndBelts,
		gt.Const.Perks.PerkDefs.Student,
		gt.Const.Perks.PerkDefs.NineLives,
		gt.Const.Perks.PerkDefs.Pathfinder,
		gt.Const.Perks.PerkDefs.Adrenalin,
		gt.Const.Perks.PerkDefs.Recover,
		gt.Const.Perks.PerkDefs.LegendSpecialistShortbowSkill
	],
	[
		gt.Const.Perks.PerkDefs.CoupDeGrace,
		gt.Const.Perks.PerkDefs.Bullseye,
		gt.Const.Perks.PerkDefs.Dodge,
		gt.Const.Perks.PerkDefs.FortifiedMind,
		gt.Const.Perks.PerkDefs.HoldOut,
		gt.Const.Perks.PerkDefs.SteelBrow,
		gt.Const.Perks.PerkDefs.Lookout,
		gt.Const.Perks.PerkDefs.QuickHands,
		gt.Const.Perks.PerkDefs.Gifted,
		gt.Const.Perks.PerkDefs.LegendFavouredEnemyDirewolf,
		gt.Const.Perks.PerkDefs.LegendFavouredEnemySpider
	],
	[
		gt.Const.Perks.PerkDefs.Backstabber,	
		gt.Const.Perks.PerkDefs.Anticipation,
		gt.Const.Perks.PerkDefs.ShieldExpert,
		gt.Const.Perks.PerkDefs.Relentless,
		gt.Const.Perks.PerkDefs.Rotation,
		gt.Const.Perks.PerkDefs.RallyTheTroops,
		gt.Const.Perks.PerkDefs.Taunt,
		gt.Const.Perks.PerkDefs.LegendSpecialistShortbowDamage
	],
	[
		gt.Const.Perks.PerkDefs.SpecAxe,
		gt.Const.Perks.PerkDefs.SpecCleaver,
		gt.Const.Perks.PerkDefs.SpecSword,
		gt.Const.Perks.PerkDefs.SpecDagger,
		gt.Const.Perks.PerkDefs.SpecPolearm,
		gt.Const.Perks.PerkDefs.SpecSpear,
		gt.Const.Perks.PerkDefs.SpecCrossbow,
		gt.Const.Perks.PerkDefs.SpecBow,
		gt.Const.Perks.PerkDefs.LegendMasterySlings,
		gt.Const.Perks.PerkDefs.SpecThrowing

	],
	[
		gt.Const.Perks.PerkDefs.Underdog,
		gt.Const.Perks.PerkDefs.ReachAdvantage,
		gt.Const.Perks.PerkDefs.LoneWolf,
		gt.Const.Perks.PerkDefs.Overwhelm,
		gt.Const.Perks.PerkDefs.Sprint,
		gt.Const.Perks.PerkDefs.Footwork,
		gt.Const.Perks.PerkDefs.LegendFavouredEnemyGoblin

	],
	[
		gt.Const.Perks.PerkDefs.HeadHunter,
		gt.Const.Perks.PerkDefs.Berserk,
		gt.Const.Perks.PerkDefs.Nimble,
		gt.Const.Perks.PerkDefs.Debilitate,
		gt.Const.Perks.PerkDefs.LegendFavouredEnemySchrat

	],
	[
		gt.Const.Perks.PerkDefs.Fearsome,
		gt.Const.Perks.PerkDefs.Duelist,
		gt.Const.Perks.PerkDefs.KillingFrenzy,
		gt.Const.Perks.PerkDefs.Indomitable,
		gt.Const.Perks.PerkDefs.DoubleStrike
	],
	[],
	[],
	[],
	[]	
];

gt.Const.Perks.PerksTreeShortbow <- gt.Const.Perks.BuildCustomPerkTree(Tree)