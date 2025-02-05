if (!("Perks" in ::Const))
{
	::Const.Perks <- {};
}

::Const.Perks.ValaChantMagicTree <- {
	ID = "ValaChantMagicTree",
	Name = "Vala Chant",
	Descriptions = [
		"chants"
	],
	Tree = [
		[],
		[],
		[::Const.Perks.PerkDefs.LegendValaChantSenses],
		[::Const.Perks.PerkDefs.LegendValaChantMastery],
		[::Const.Perks.PerkDefs.LegendValaChantDisharmony],
		[::Const.Perks.PerkDefs.LegendHerbcraft],
		[
			::Const.Perks.PerkDefs.LegendPotionBrewer,
			::Const.Perks.PerkDefs.LegendValaChantFury
		]
	]
};

::Const.Perks.ValaTranceMagicTree <- {
	ID = "ValaTranceMagicTree",
	Name = "Vala Trance",
	Descriptions = [
		"trances"
	],
	Tree = [
		[],
		[::Const.Perks.PerkDefs.LegendValaTranceMalevolent],
		[],
		[::Const.Perks.PerkDefs.LegendValaTranceMastery],
		[::Const.Perks.PerkDefs.LegendGatherer],
		[::Const.Perks.PerkDefs.LegendValaThreads],
		[]
	]
};

::Const.Perks.ValaRuneMagicTree <- {
	ID = "ValaRuneMagicTree",
	Name = "Vala Rune"
	Descriptions = [
		"runes"
	],
	Tree = [
		[], // [::Const.Perks.PerkDefs.LegendValaInscribeShield], todo, removed ? - chopeks
		[],
		[], // [::Const.Perks.PerkDefs.LegendValaInscribeHelmet], todo, removed ? - chopeks
	[], // [::Const.Perks.PerkDefs.LegendValaInscriptionMastery], todo, removed ? - chopeks
		[], // [::Const.Perks.PerkDefs.LegendValaInscribeArmor],  todo, removed ? - chopeks
		[],
		[], // [::Const.Perks.PerkDefs.LegendValaInscribeWeapon]  todo, removed ? - chopeks
	]
};

::Const.Perks.ValaSpiritMagicTree <- {
	ID = "ValaSpiritMagicTree",
	Name = "Vala Spirits",
	Descriptions = [
		"spirits"
	],
	Tree = [
		[::Const.Perks.PerkDefs.LegendValaWarden],
		[],
		[::Const.Perks.PerkDefs.LegendValaPremonition],
		[],
		[],
		[::Const.Perks.PerkDefs.LegendValaSpiritualBond],
		[]
	]
};

::Const.Perks.InventorMagicTree <- {
	ID = "InventorMagicTree",
	Name = "Inventor",
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
		[::Const.Perks.PerkDefs.LegendInventorAnatomy]
	]
};


::Const.Perks.RangerHuntMagicTree <- {
	ID = "RangerHuntMagicTree",
	Name = "Ranger",
	Descriptions = [
		"hunting"
	],
	Tree = [
		[::Const.Perks.PerkDefs.LegendMarkTarget],
		[],
		[],
		[::Const.Perks.PerkDefs.LegendSpecPoison],
		[],
		[::Const.Perks.PerkDefs.LegendFavouredEnemyArcher],
		[::Const.Perks.PerkDefs.LegendBigGameHunter]
	]
};

::Const.Perks.BasicNecroMagicTree <- {
	ID = "BasicNecroMagicTree",
	Name = "Necromancy",
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
		[::Const.Perks.PerkDefs.LegendRaiseUndead]
	]
};

::Const.Perks.WarlockMagicTree <- {
	ID = "WarlockMagicTree",
	Name = "Sorcery",
	Descriptions = [
		"sorcery"
	],
	Tree = [
		[::Const.Perks.PerkDefs.LegendWither],
		[::Const.Perks.PerkDefs.LegendRust],
		[],
		[],
		[::Const.Perks.PerkDefs.LegendInsects],
		[::Const.Perks.PerkDefs.LegendSiphon],
		[::Const.Perks.PerkDefs.LegendMiasma]
	]
};

::Const.Perks.VampireMagicTree <- {
	ID = "VampireMagicTree",
	Name = "Vampire",
	Descriptions = [
		"undeath"
	],
	Tree = [
		[::Const.Perks.PerkDefs.LegendPrepareBleed],
		[::Const.Perks.PerkDefs.LegendDebilitate],
		[],
		[::Const.Perks.PerkDefs.LegendBloodbath],
		[::Const.Perks.PerkDefs.LegendSlaughter],
		[::Const.Perks.PerkDefs.LegendGruesomeFeast],
		[::Const.Perks.PerkDefs.LegendDarkflight]
	]
};

::Const.Perks.ZombieMagicTree <- {
	ID = "ZombieMagicTree",
	Name = "Zombie",
	Descriptions = [
		"weidergangers"
	],
	Tree = [
		[
		::Const.Perks.PerkDefs.LegendSpawnZombieLow,
		],
		[],
		[::Const.Perks.PerkDefs.LegendExtendendAura],
		[::Const.Perks.PerkDefs.LegendSpawnZombieMed,],
		[::Const.Perks.PerkDefs.LegendReclamation],
		[::Const.Perks.PerkDefs.LegendViolentDecomposition,],
		[
		::Const.Perks.PerkDefs.LegendSpawnZombieHigh,
		]
	]
};

::Const.Perks.SkeletonMagicTree <- {
	ID = "SkeletonMagicTree",
	Name = "Skeleton",
	Descriptions = [
		"ancient undead"
	],
	Tree = [
		[::Const.Perks.PerkDefs.LegendSpawnSkeletonLow],
		[],
		[],
		[::Const.Perks.PerkDefs.LegendSpawnSkeletonMed],
		[::Const.Perks.PerkDefs.LegendConservation,],
		[
		::Const.Perks.PerkDefs.LegendChanneledPower,
		::Const.Perks.PerkDefs.LegendPossession
		],
		[::Const.Perks.PerkDefs.LegendSpawnSkeletonHigh]
	]
};

::Const.Perks.BerserkerMagicTree <- {
	ID = "BerserkerMagicTree",
	Name = "Berserker",
	Descriptions = [
		"berserking"
	],
	Tree = [
		[::Const.Perks.PerkDefs.Colossus],
		[::Const.Perks.PerkDefs.DevastatingStrikes],
		[::Const.Perks.PerkDefs.Brawny],
		[],
		[::Const.Perks.PerkDefs.LegendMuscularity],
		[::Const.Perks.PerkDefs.Berserk],
		[
		::Const.Perks.PerkDefs.LegendBerserkerRage,
		::Const.Perks.PerkDefs.LegendUberNimble
		]
	]
};

::Const.Perks.CaptainMagicTree <- {
	ID = "CaptainMagicTree",
	Name = "Leadership",
	Descriptions = [
		"leading"
	],
	Tree = [
		[::Const.Perks.PerkDefs.LegendBackToBasics],
		// [::Const.Perks.PerkDefs.LegendComposure],
		[::Const.Perks.PerkDefs.InspiringPresence],
		[::Const.Perks.PerkDefs.LegendShieldsUp],
		[::Const.Perks.PerkDefs.LegendHoldTheLine],
		[::Const.Perks.PerkDefs.LegendForwardPush],
		[::Const.Perks.PerkDefs.LegendInspire]
	]
};

::Const.Perks.IllusionistMagicTree <- {
	ID = "IllusionistMagicTree",
	Name = "Illusion",
	Descriptions = [
		"illusion"
	],
	Tree = [
		[::Const.Perks.PerkDefs.LegendPush],
		[::Const.Perks.PerkDefs.LegendDaze],
		[::Const.Perks.PerkDefs.LegendEntice],
		[::Const.Perks.PerkDefs.LegendHorrify],
		[::Const.Perks.PerkDefs.LegendTerrifyingVisage],
		[],
		[::Const.Perks.PerkDefs.LegendStunned]
	]
};

::Const.Perks.DivinationMagicTree <- {
	ID = "DivinationMagicTree",
	Name = "Divination",
	Descriptions = [
		"divination"
	],
	Tree = [
		[::Const.Perks.PerkDefs.LegendPush],
		[::Const.Perks.PerkDefs.LegendMagicDaze],
		[::Const.Perks.PerkDefs.LegendScry],
		[::Const.Perks.PerkDefs.LegendEntice],
		[::Const.Perks.PerkDefs.LegendMagicWebBolt],
		[::Const.Perks.PerkDefs.LegendMagicPsybeam],
		[::Const.Perks.PerkDefs.LegendMagicSleep]
	]
};

::Const.Perks.ConjurationMagicTree <- {
	ID = "ConjurationMagicTree",
	Name = "Conjuration",
	Descriptions = [
		"conjuration"
	],
	Tree = [
		[::Const.Perks.PerkDefs.LegendSummonCat],
		[::Const.Perks.PerkDefs.LegendSummonHound],
		[::Const.Perks.PerkDefs.LegendSummonFalcon],
		[],
		[::Const.Perks.PerkDefs.LegendSummonWolf],
		[],
		[::Const.Perks.PerkDefs.LegendSummonBear]
	]
};

::Const.Perks.DruidMagicTree <- {
	ID = "DruidMagicTree",
	Name = "Druidic Arts",
	Descriptions = [
		"druidic arts"
	],
	Tree = [
		[::Const.Perks.PerkDefs.LegendWither],
		[::Const.Perks.PerkDefs.LegendRoots],
		[::Const.Perks.PerkDefs.LegendPrayerOfLife],
		[],
		[::Const.Perks.PerkDefs.LegendSummonStorm],
		[::Const.Perks.PerkDefs.LegendDrumsOfLife],
		[::Const.Perks.PerkDefs.LegendInsects]
	]
};

::Const.Perks.DruidTransformTree <- {
	ID = "DruidTransformTree",
	Name = "Druidic transformation",
	Descriptions = [
		"druidic transformation"
	],
	Tree = [
		[],
		[],
		[],
		[::Const.Perks.PerkDefs.LegendWolfform],
		[::Const.Perks.PerkDefs.LegendBearform],
		[],
		[::Const.Perks.PerkDefs.LegendTrueForm]
	]
};


::Const.Perks.TransmutationMagicTree <- {
	ID = "TransmutationMagicTree",
	Name = "Transmutation",
	Descriptions = [
		"transmutation"
	],
	Tree = [
		[],
		[::Const.Perks.PerkDefs.LegendGatherer],
		[],
		[],
		[::Const.Perks.PerkDefs.LegendPotionBrewer],
		[::Const.Perks.PerkDefs.LegendRoots],
		[::Const.Perks.PerkDefs.LegendTeleport]
	]
};

::Const.Perks.EvocationMagicTree <- {
	ID = "EvocationMagicTree",
	Name = "Evocation",
	Descriptions = [
		"evocation"
	],
	Tree = [
		[
		::Const.Perks.PerkDefs.LegendMagicMissile
		],
		[
		//::Const.Perks.PerkDefs.LegendMagicBurningHands
		],
		[
		//::Const.Perks.PerkDefs.LegendMagicHailstone
		],
		[
		::Const.Perks.PerkDefs.LegendMagicMissileFocus
		],
		[
		::Const.Perks.PerkDefs.LegendChainLightning,
		//::Const.Perks.PerkDefs.LegendMasteryBurningHands
		],
		[
		//::Const.Perks.PerkDefs.LegendMagicPsybeam,
		//::Const.Perks.PerkDefs.LegendMasteryHailstone
		],
		[
		::Const.Perks.PerkDefs.LegendMagicMissileMastery,
		::Const.Perks.PerkDefs.LegendFirefield
		]
	]
};

::Const.Perks.AssassinMagicTree <- {
	ID = "AssassinMagicTree",
	Name = "Assassin",
	Descriptions = [
		"assassination"
	],
	Tree = [
		[::Const.Perks.PerkDefs.LegendKnifeplay],
		[::Const.Perks.PerkDefs.LegendOpportunist],
		[::Const.Perks.PerkDefs.LegendPrepared],
		[],
		[::Const.Perks.PerkDefs.LegendLurker],
		[::Const.Perks.PerkDefs.LegendNightRaider],
		[::Const.Perks.PerkDefs.LegendAssassinate]
	]
};

::Const.Perks.PremonitionMagicTree <- {
	ID = "PremonitionMagicTree",
	Name = "Premonition",
	Descriptions = [
		"premonition"
	],
	Tree = [
		[],
		[::Const.Perks.PerkDefs.LegendScryTrance],
		[],
		[],
		[::Const.Perks.PerkDefs.LegendReadOmensTrance],
		[::Const.Perks.PerkDefs.LegendDistantVisions],
		[]
	]
}

::Const.Perks.PhilosophyMagicTree <- {
	ID = "PhilosophyMagicTree",
	Name = "Philosophy",
	Descriptions = [
		"philosophy"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[::Const.Perks.PerkDefs.LegendScholar],
		[::Const.Perks.PerkDefs.LegendScrollIngredients]
	]
}

::Const.Perks.AlchemyMagicTree <- {
	ID = "AlchemyMagicTree"
	Name = "Alchemy",
	Descriptions = [
		"alchemy"
	],
	Tree = [
		[],
		[],
		[],
		[::Const.Perks.PerkDefs.LegendCitrinitas],
		[
		::Const.Perks.PerkDefs.LegendAlbedo,
		::Const.Perks.PerkDefs.LegendNigredo
		],
		[]
	]
}

::Const.Perks.TherianthropyTree <- {
	ID = "TherianthropyMagicTree",
	Name = "Therianthropy",
	Descriptions = [
		"therianthropy"
	],
	Tree = [
		[::Const.Perks.PerkDefs.LegendTrueForm],
		[],
		[::Const.Perks.PerkDefs.LegendSurpressUrges],
		[],
		[::Const.Perks.PerkDefs.LegendControlInstincts],
		[],
		[::Const.Perks.PerkDefs.LegendMasterAnger]
	]
};

::Const.Perks.MagicTrees <- {
	Tree = [
		::Const.Perks.ValaChantMagicTree,
		::Const.Perks.ValaTranceMagicTree,
		//::Const.Perks.HealerMagicTree,
		//::Const.Perks.ValaRuneMagicTree,
		// ::Const.Perks.ValaSpiritMagicTree,
		::Const.Perks.RangerHuntMagicTree,
		::Const.Perks.BasicNecroMagicTree,
		::Const.Perks.WarlockMagicTree,
		::Const.Perks.VampireMagicTree,
		::Const.Perks.ZombieMagicTree,
		::Const.Perks.SkeletonMagicTree,
		::Const.Perks.BerserkerMagicTree,
		::Const.Perks.DruidMagicTree,
		// ::Const.Perks.DruidTransformTree,
		::Const.Perks.CaptainMagicTree,
		::Const.Perks.IllusionistMagicTree,
		::Const.Perks.ConjurationMagicTree,
		::Const.Perks.TransmutationMagicTree,
		::Const.Perks.EvocationMagicTree,
		// ::Const.Perks.AssassinMagicTree,
		// ::Const.Perks.PremonitionMagicTree,
		// ::Const.Perks.AlchemyMagicTree,
		// ::Const.Perks.TherianthropyMagicTree,
		::Const.Perks.PhilosophyMagicTree,
		::Const.Perks.AssassinMagicTree

	],
	function getRandom(_exclude)
	{
		local L = [];
		foreach (i, t in this.Tree)
		{
			if (_exclude != null && _exclude.find(t.ID))
			{
				continue;
			}
			L.push(i);
		}

		local r = this.Math.rand(0, L.len() - 1);
		return this.Tree[L[r]];
	}


	function getRandomPerk()
	{
		local tree = this.getRandom(null);
		local L = [];
		foreach (row in tree.Tree)
		{
			foreach (p in row)
			{
				L.push(p);
			}
		}

		local r = this.Math.rand(0, L.len() - 1);
		return L[r];
	}
};
