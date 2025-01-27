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
		[::Legends.Perk.LegendValaChantSenses],
		[::Legends.Perk.LegendValaChantMastery],
		[::Legends.Perk.LegendValaChantDisharmony],
		[::Legends.Perk.LegendHerbcraft],
		[
			::Legends.Perk.LegendPotionBrewer,
			::Legends.Perk.LegendValaChantFury
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
		[::Legends.Perk.LegendValaTranceMalevolent],
		[],
		[::Legends.Perk.LegendValaTranceMastery],
		[::Legends.Perk.LegendGatherer],
		[::Legends.Perk.LegendValaThreads],
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
		[], // [::Legends.Perk.LegendValaInscribeShield], todo, removed ? - chopeks
		[],
		[], // [::Legends.Perk.LegendValaInscribeHelmet], todo, removed ? - chopeks
	[], // [::Legends.Perk.LegendValaInscriptionMastery], todo, removed ? - chopeks
		[], // [::Legends.Perk.LegendValaInscribeArmor],  todo, removed ? - chopeks
		[],
		[], // [::Legends.Perk.LegendValaInscribeWeapon]  todo, removed ? - chopeks
	]
};

::Const.Perks.ValaSpiritMagicTree <- {
	ID = "ValaSpiritMagicTree",
	Name = "Vala Spirits",
	Descriptions = [
		"spirits"
	],
	Tree = [
		[::Legends.Perk.LegendValaWarden],
		[],
		[::Legends.Perk.LegendValaPremonition],
		[],
		[],
		[::Legends.Perk.LegendValaSpiritualBond],
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
		[::Legends.Perk.LegendInventorAnatomy]
	]
};


::Const.Perks.RangerHuntMagicTree <- {
	ID = "RangerHuntMagicTree",
	Name = "Ranger",
	Descriptions = [
		"hunting"
	],
	Tree = [
		[],
		[],
		[],
		[::Legends.Perk.LegendSpecPoison],
		[],
		[::Legends.Perk.LegendFavouredEnemyArcher],
		[::Legends.Perk.LegendBigGameHunter]
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
		[::Legends.Perk.LegendRaiseUndead]
	]
};

::Const.Perks.WarlockMagicTree <- {
	ID = "WarlockMagicTree",
	Name = "Sorcery",
	Descriptions = [
		"sorcery"
	],
	Tree = [
		[::Legends.Perk.LegendWither],
		[::Legends.Perk.LegendRust],
		[],
		[],
		[::Legends.Perk.LegendInsects],
		[::Legends.Perk.LegendSiphon],
		[::Legends.Perk.LegendMiasma]
	]
};

::Const.Perks.VampireMagicTree <- {
	ID = "VampireMagicTree",
	Name = "Vampire",
	Descriptions = [
		"undeath"
	],
	Tree = [
		[::Legends.Perk.LegendPrepareBleed],
		[::Legends.Perk.LegendDebilitate],
		[],
		[::Legends.Perk.LegendBloodbath],
		[::Legends.Perk.LegendCarnage],
		[::Legends.Perk.LegendGruesomeFeast],
		[::Legends.Perk.LegendDarkflight]
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
		::Legends.Perk.LegendSpawnZombieLow,
		],
		[],
		[::Legends.Perk.LegendExtendendAura],
		[::Legends.Perk.LegendSpawnZombieMed,],
		[::Legends.Perk.LegendReclamation],
		[::Legends.Perk.LegendViolentDecomposition,],
		[
		::Legends.Perk.LegendSpawnZombieHigh,
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
		[::Legends.Perk.LegendSpawnSkeletonLow],
		[],
		[],
		[::Legends.Perk.LegendSpawnSkeletonMed],
		[::Legends.Perk.LegendConservation,],
		[
		::Legends.Perk.LegendChanneledPower,
		::Legends.Perk.LegendPossession
		],
		[::Legends.Perk.LegendSpawnSkeletonHigh]
	]
};

::Const.Perks.BerserkerMagicTree <- {
	ID = "BerserkerMagicTree",
	Name = "Berserker",
	Descriptions = [
		"berserking"
	],
	Tree = [
		[::Legends.Perk.Colossus],
		[::Legends.Perk.DevastatingStrikes],
		[::Legends.Perk.Brawny],
		[],
		[::Legends.Perk.LegendMuscularity],
		[::Legends.Perk.Berserk],
		[
		::Legends.Perk.LegendBerserkerRage,
		::Legends.Perk.LegendUberNimble
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
		[::Legends.Perk.LegendBackToBasics],
		// [::Legends.Perk.LegendComposure],
		[::Legends.Perk.InspiringPresence],
		[::Legends.Perk.LegendShieldsUp],
		[::Legends.Perk.LegendHoldTheLine],
		[::Legends.Perk.LegendForwardPush],
		[::Legends.Perk.LegendInspire]
	]
};

::Const.Perks.IllusionistMagicTree <- {
	ID = "IllusionistMagicTree",
	Name = "Illusion",
	Descriptions = [
		"illusion"
	],
	Tree = [
		[::Legends.Perk.LegendPush],
		[::Legends.Perk.LegendDaze],
		[::Legends.Perk.LegendEntice],
		[::Legends.Perk.LegendHorrify],
		[::Legends.Perk.LegendTerrifyingVisage],
		[],
		[::Legends.Perk.LegendStunned]
	]
};

::Const.Perks.DivinationMagicTree <- {
	ID = "DivinationMagicTree",
	Name = "Divination",
	Descriptions = [
		"divination"
	],
	Tree = [
		[::Legends.Perk.LegendPush],
		[::Legends.Perk.LegendMagicDaze],
		[::Legends.Perk.LegendScry],
		[::Legends.Perk.LegendEntice],
		[::Legends.Perk.LegendMagicWebBolt],
		[::Legends.Perk.LegendMagicPsybeam],
		[::Legends.Perk.LegendMagicSleep]
	]
};

::Const.Perks.ConjurationMagicTree <- {
	ID = "ConjurationMagicTree",
	Name = "Conjuration",
	Descriptions = [
		"conjuration"
	],
	Tree = [
		[::Legends.Perk.LegendSummonCat],
		[::Legends.Perk.LegendSummonHound],
		[::Legends.Perk.LegendSummonFalcon],
		[],
		[::Legends.Perk.LegendSummonWolf],
		[],
		[::Legends.Perk.LegendSummonBear]
	]
};

::Const.Perks.DruidMagicTree <- {
	ID = "DruidMagicTree",
	Name = "Druidic Arts",
	Descriptions = [
		"druidic arts"
	],
	Tree = [
		[::Legends.Perk.LegendWither],
		[::Legends.Perk.LegendRoots],
		[::Legends.Perk.LegendPrayerOfLife],
		[],
		[::Legends.Perk.LegendSummonStorm],
		[::Legends.Perk.LegendDrumsOfLife],
		[::Legends.Perk.LegendInsects]
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
		[::Legends.Perk.LegendWolfform],
		[::Legends.Perk.LegendBearform],
		[],
		[::Legends.Perk.LegendTrueForm]
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
		[::Legends.Perk.LegendGatherer],
		[],
		[],
		[::Legends.Perk.LegendPotionBrewer],
		[::Legends.Perk.LegendRoots],
		[::Legends.Perk.LegendTeleport]
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
		::Legends.Perk.LegendMagicMissile
		],
		[
		//::Legends.Perk.LegendMagicBurningHands
		],
		[
		//::Legends.Perk.LegendMagicHailstone
		],
		[
		::Legends.Perk.LegendMagicMissileFocus
		],
		[
		::Legends.Perk.LegendChainLightning,
		//::Legends.Perk.LegendMasteryBurningHands
		],
		[
		//::Legends.Perk.LegendMagicPsybeam,
		//::Legends.Perk.LegendMasteryHailstone
		],
		[
		::Legends.Perk.LegendMagicMissileMastery,
		::Legends.Perk.LegendFirefield
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
		[::Legends.Perk.LegendKnifeplay],
		[::Legends.Perk.LegendOpportunist],
		[::Legends.Perk.LegendPrepared],
		[],
		[::Legends.Perk.LegendLurker],
		[::Legends.Perk.LegendNightRaider],
		[::Legends.Perk.LegendAssassinate]
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
		[::Legends.Perk.LegendScryTrance],
		[],
		[],
		[::Legends.Perk.LegendReadOmensTrance],
		[::Legends.Perk.LegendDistantVisions],
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
		[::Legends.Perk.LegendScholar],
		[::Legends.Perk.LegendScrollIngredients]
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
		[::Legends.Perk.LegendCitrinitas],
		[
		::Legends.Perk.LegendAlbedo,
		::Legends.Perk.LegendNigredo
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
		[::Legends.Perk.LegendTrueForm],
		[],
		[::Legends.Perk.LegendSurpressUrges],
		[],
		[::Legends.Perk.LegendControlInstincts],
		[],
		[::Legends.Perk.LegendMasterAnger]
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

		local r = this.Math.rand(0, L.len() - 1)
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
