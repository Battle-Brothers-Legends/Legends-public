local gt = this.getroottable();

if (!("Perks" in gt.Const))
{
	gt.Const.Perks <- {};
}

gt.Const.Perks.ValaChantMagicTree <- {
	ID = "ValaChantMagicTree",
	Descriptions = [
		"chants"
	],
	Tree = [
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendValaChantSenses],
		[gt.Const.Perks.PerkDefs.LegendValaChantMastery],
		[gt.Const.Perks.PerkDefs.LegendValaChantDisharmony],
		[],
		[gt.Const.Perks.PerkDefs.LegendValaChantDisharmony]
	]
};

gt.Const.Perks.ValaTranceMagicTree <- {
	ID = "ValaTranceMagicTree",
	Descriptions = [
		"trances"
	],
	Tree = [
		[],
		[gt.Const.Perks.PerkDefs.LegendValaTranceMalevolent],
		[],
		[gt.Const.Perks.PerkDefs.LegendValaTranceMastery],
		[],
		[gt.Const.Perks.PerkDefs.LegendValaThreads],
		[]
	]
};

gt.Const.Perks.ValaRuneMagicTree <- {
	ID = "ValaRuneMagicTree",
	Descriptions = [
		"runes"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendValaInscribeShield],
		[],
		[gt.Const.Perks.PerkDefs.LegendValaInscribeHelmet],
		[gt.Const.Perks.PerkDefs.LegendValaInscriptionMastery],
		[gt.Const.Perks.PerkDefs.LegendValaInscribeArmor],
		[],
		[gt.Const.Perks.PerkDefs.LegendValaInscribeWeapon]
	]
};

gt.Const.Perks.ValaSpiritMagicTree <- {
	ID = "ValaSpiritMagicTree",
	Descriptions = [
		"spirits"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendValaWarden],
		[],
		[gt.Const.Perks.PerkDefs.LegendValaPremonition],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendValaSpiritualBond],
		[]
	]
};

gt.Const.Perks.InventorMagicTree <- {
	ID = "InventorMagicTree",
	Descriptions = [
		"inventor"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendInventorAnatomy]
	]
};


gt.Const.Perks.RangerHuntMagicTree <- {
	ID = "RangerHuntMagicTree",
	Descriptions = [
		"hunting"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendMarkTarget],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendSpecPoison],
		[],
		[gt.Const.Perks.PerkDefs.LegendFavouredEnemyArcher],
		[gt.Const.Perks.PerkDefs.LegendBigGameHunter]
	]
};

gt.Const.Perks.BasicNecroMagicTree <- {
	ID = "BasicNecroMagicTree",
	Descriptions = [
		"necromancy"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendRaiseUndead]
	]
};

gt.Const.Perks.WarlockMagicTree <- {
	ID = "WarlockMagicTree",
	Descriptions = [
		"sorcery"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendWither],
		[gt.Const.Perks.PerkDefs.LegendRust],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendInsects],
		[gt.Const.Perks.PerkDefs.LegendSiphon],
		[gt.Const.Perks.PerkDefs.LegendMiasma]
	]
};

gt.Const.Perks.VampireMagicTree <- {
	ID = "VampireMagicTree",
	Descriptions = [
		"undeath"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendPrepareBleed],
		[gt.Const.Perks.PerkDefs.Debilitate],
		[],
		[gt.Const.Perks.PerkDefs.LegendBloodbath],
		[gt.Const.Perks.PerkDefs.LegendSlaughter],
		[gt.Const.Perks.PerkDefs.LegendGruesomeFeast],
		[gt.Const.Perks.PerkDefs.LegendDarkflight]
	]
};

gt.Const.Perks.ZombieMagicTree <- {
	ID = "ZombieMagicTree",
	Descriptions = [
		"weidergangers"
	],
	Tree = [
		[
		gt.Const.Perks.PerkDefs.LegendSpawnZombieLow,
		],
		[],
		[gt.Const.Perks.PerkDefs.LegendExtendendAura],
		[gt.Const.Perks.PerkDefs.LegendSpawnZombieMed,],
		[gt.Const.Perks.PerkDefs.LegendReclamation],
		[gt.Const.Perks.PerkDefs.LegendViolentDecomposition,],
		[
		gt.Const.Perks.PerkDefs.LegendSpawnZombieHigh,
		]
	]
};

gt.Const.Perks.SkeletonMagicTree <- {
	ID = "SkeletonMagicTree",
	Descriptions = [
		"ancient undead"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendSpawnSkeletonLow],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendSpawnSkeletonMed],
		[gt.Const.Perks.PerkDefs.LegendConservation,],
		[
		gt.Const.Perks.PerkDefs.LegendChanneledPower,
		gt.Const.Perks.PerkDefs.LegendPossession
		],
		[gt.Const.Perks.PerkDefs.LegendSpawnSkeletonHigh]
	]
};

gt.Const.Perks.BerserkerMagicTree <- {
	ID = "BerserkerMagicTree",
	Descriptions = [
		"berserking"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.Colossus],
		[gt.Const.Perks.PerkDefs.DevastatingStrikes],
		[gt.Const.Perks.PerkDefs.Brawny],
		[gt.Const.Perks.PerkDefs.LegendBearform],
		[gt.Const.Perks.PerkDefs.LegendMuscularity],
		[gt.Const.Perks.PerkDefs.Berserk],
		[
		gt.Const.Perks.PerkDefs.LegendBerserkerRage,
		gt.Const.Perks.PerkDefs.LegendUberNimble
		]
	]
};

gt.Const.Perks.CaptainMagicTree <- {
	ID = "CaptainMagicTree",
	Descriptions = [
		"leading"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendBackToBasics],
		[gt.Const.Perks.PerkDefs.LegendComposure],
		[gt.Const.Perks.PerkDefs.InspiringPresence],
		[gt.Const.Perks.PerkDefs.LegendShieldsUp],
		[gt.Const.Perks.PerkDefs.LegendHoldTheLine],
		[gt.Const.Perks.PerkDefs.LegendForwardPush],
		[gt.Const.Perks.PerkDefs.Inspire]
	]
};

gt.Const.Perks.IllusionistMagicTree <- {
	ID = "IllusionistMagicTree",
	Descriptions = [
		"illusion"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendSummonCat],
		[gt.Const.Perks.PerkDefs.LegendDaze],
		[],
		[gt.Const.Perks.PerkDefs.LegendHorrify],
		[gt.Const.Perks.PerkDefs.LegendTerrifyingVisage],
		[],
		[gt.Const.Perks.PerkDefs.LegendStunned]
	]
};

gt.Const.Perks.DivinationMagicTree <- {
	ID = "DivinationMagicTree",
	Descriptions = [
		"divination"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendPush],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendEntice],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendScry]
	]
};

gt.Const.Perks.ConjurationMagicTree <- {
	ID = "ConjurationMagicTree",
	Descriptions = [
		"conjuration"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendSummonCat],
		[gt.Const.Perks.PerkDefs.LegendSummonHound],
		[gt.Const.Perks.PerkDefs.LegendSummonFalcon],
		[],
		[gt.Const.Perks.PerkDefs.LegendSummonWolf],
		[],
		[gt.Const.Perks.PerkDefs.LegendSummonBear]
	]
};

gt.Const.Perks.DruidMagicTree <- {
	ID = "DruidMagicTree",
	Descriptions = [
		"druidic arts"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendRoots],
		[],
		[gt.Const.Perks.PerkDefs.LegendPrayerOfLife],
		[
		gt.Const.Perks.PerkDefs.LegendTreeform,
		gt.Const.Perks.PerkDefs.LegendBearform,
		gt.Const.Perks.PerkDefs.LegendWolfform
		],
		[gt.Const.Perks.PerkDefs.LegendSummonStorm],
		[gt.Const.Perks.PerkDefs.LegendDrumsOfLife],
		[
		gt.Const.Perks.PerkDefs.LegendCallLightning,
		gt.Const.Perks.PerkDefs.LegendTrueForm
		]
	]
};

gt.Const.Perks.TransmutationMagicTree <- {
	ID = "TransmutationMagicTree",
	Descriptions = [
		"transmutation"
	],
	Tree = [
		[],
		[gt.Const.Perks.PerkDefs.LegendGatherer],
		[gt.Const.Perks.PerkDefs.LegendLevitate],
		[],
		[gt.Const.Perks.PerkDefs.LegendPotionBrewer],
		[gt.Const.Perks.PerkDefs.LegendRoots],
		[gt.Const.Perks.PerkDefs.LegendTeleport]
	]
};

gt.Const.Perks.EvocationMagicTree <- {
	ID = "EvocationMagicTree",
	Descriptions = [
		"evocation"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendMagicMissile],
		[],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendChainLightning],
		[],
		[gt.Const.Perks.PerkDefs.LegendFirefield]
	]
};

gt.Const.Perks.AssassinMagicTree <- {
	ID = "AssassinMagicTree",
	Descriptions = [
		"assassination"
	],
	Tree = [
		[],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendHidden],
		[gt.Const.Perks.PerkDefs.LegendBlendIn],
		[gt.Const.Perks.PerkDefs.LegendUntouchable],
		[gt.Const.Perks.PerkDefs.LegendAssassinate]
	]
};

gt.Const.Perks.AstrologyMagicTree <- {
	ID = "AstrologyMagicTree",
	Descriptions = [
		"astrology"
	],
	Tree = [
		[],
		[gt.Const.Perks.PerkDefs.LegendScryTrance],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendReadOmensTrance],
		[gt.Const.Perks.PerkDefs.LegendDistantVisions],
		[]
	]
}

gt.Const.Perks.PhilosophyMagicTree <- {
	ID = "PhilosophyMagicTree",
	Descriptions = [
		"philosophy"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendPerkScrollIngredients]
	]
}

gt.Const.Perks.MagicTrees <- {
	Tree = [
		gt.Const.Perks.ValaChantMagicTree,
		gt.Const.Perks.ValaTranceMagicTree,
	//	gt.Const.Perks.HealerMagicTree,
		gt.Const.Perks.ValaRuneMagicTree,
		gt.Const.Perks.ValaSpiritMagicTree, 
		gt.Const.Perks.RangerHuntMagicTree,
		gt.Const.Perks.BasicNecroMagicTree,
		gt.Const.Perks.WarlockMagicTree,
		gt.Const.Perks.VampireMagicTree,
		gt.Const.Perks.ZombieMagicTree,
		gt.Const.Perks.SkeletonMagicTree,
		gt.Const.Perks.BerserkerMagicTree,
		gt.Const.Perks.DruidMagicTree,
		gt.Const.Perks.CaptainMagicTree,
		gt.Const.Perks.IllusionistMagicTree,
		gt.Const.Perks.DivinationMagicTree,
		gt.Const.Perks.ConjurationMagicTree,
		gt.Const.Perks.TransmutationMagicTree,
		gt.Const.Perks.EvocationMagicTree,
		gt.Const.Perks.AssassinMagicTree,
		gt.Const.Perks.AstrologyMagicTree
	],
	function getRandom(_exclude) 
	{
		local L = [];
		foreach (i, t in this.Tree)
		{
			if (_exclude.find(t.ID))
			{
				continue;
			}
			L.push(i);
		}

		local r = this.Math.rand(0, L.len() - 1)
		return this.Tree[L[r]];;
	}	
};