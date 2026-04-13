if (!("Perks" in ::Const))
{
	::Const.Perks <- {};
}

::Const.Perks.BardMagicTree <- {
	ID = "BardMagicTree",
	Name = "Bard",
	Icon = "ui/perks/perk_music_mastery.png",
	Descriptions = [
		"entertaining"
	],
	Tree = [
		[
			::Legends.Perk.LegendCheerOn,
			::Legends.Perk.LegendSpecialistMusician
		],
		[
			::Legends.Perk.LegendDaze
		],
		[
			::Legends.Perk.LegendEntice
		],
		[
			::Legends.Perk.LegendMasteryMusic
		],
		[
			::Legends.Perk.LegendPush
		],
		[
			::Legends.Perk.LegendMinnesanger
		],
		[
			::Legends.Perk.LegendMeistersanger
		]
	]
};

::Const.Perks.StavesMagicTree <- {
	ID = "StavesMagicTree",
	Name = "Staves",
	Icon = "ui/perks/staffmastery.png",
	Descriptions = [
		"staves"
	],
	Tree = [
		[::Legends.Perk.LegendSpecialistSelfdefense],
		[],
		[],
		[::Legends.Perk.LegendMasteryStaves],
		[],
		[],
		[]
	]
};

::Const.Perks.ImmortalMagicTree <- {
	ID = "ImmortalMagicTree",
	Name = "Immortal",
	Icon = "ui/perks/lionheart.png",
	Descriptions = [
		"combat"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[
			::Legends.Perk.LegendLionheart,
			::Legends.Perk.LegendBattleheart
		],
		[],
		[]
	]
};

::Const.Perks.ValaChantMagicTree <- {
	ID = "ValaChantMagicTree",
	Name = "Vala Chant",
	Icon = "ui/perks/legend_vala_chanting_mastery.png",
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
	Icon = "ui/perks/legend_vala_trance_mastery.png",
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
		[],
		[],
		[],
		[],
		[],
		[],
		[],
	]
};

::Const.Perks.ValaSpiritMagicTree <- {
	ID = "ValaSpiritMagicTree",
	Name = "Vala Spirits",
	Icon = "ui/perks/legend_vala_spiritual_bond.png",
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
	Icon = "ui/perks/legend_inventor_anatomy.png",
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
	Icon = "ui/perks/lookout_circle.png",
	Descriptions = [
		"hunting big game"
	],
	Tree = [
		[
			::Legends.Perk.LegendSummonHound
		],
		[
			::Legends.Perk.LegendNightvision
		],
		[
			::Legends.Perk.LegendSummonFalcon,
			::Legends.Perk.DevastatingStrikes
		],
		[
			::Legends.Perk.LegendSpecPoison
		],
		[
			::Legends.Perk.LegendSummonWolf
		],
		[],
		[
			::Legends.Perk.LegendBigGameHunter,
		]
	]
};

::Const.Perks.ArcherCommandTree <- {
	ID = "ArcherCommandTree",
	Name = "ArcherCommand",
	Icon = "ui/perks/coordinated_volleys_circle.png",
	Descriptions = [
		"archer command"
	],
	Tree = [
		[],
		[],
		[
			::Legends.Perk.LegendAmmoBinding
		],
		[
			::Legends.Perk.LegendIncoming
		],
		[
			::Legends.Perk.LegendAmmoBundles
		],
		[
			::Legends.Perk.LegendCoordinatedVolleys
		],
		[]
	]
};

::Const.Perks.MasterArcherTree <- {
	ID = "MasterArcherTree",
	Name = "Deadeye",
	Icon = "ui/perks/triplestrike56.png",
	Descriptions = [
		"archery"
	],
	Tree = [
		[
			::Legends.Perk.LegendBlendIn,
			::Legends.Perk.CoupDeGrace
		],
		[
			::Legends.Perk.BagsAndBelts,
		],
		[],
		[],
		[],
		[
			::Legends.Perk.LegendEvasion
		],
		[
			::Legends.Perk.KillingFrenzy,
			::Legends.Perk.LegendPerfectFocus
		]
	]
};

::Const.Perks.AssassinLeftoverTree <- {
	ID = "AssassinLeftoverTree",
	Name = "Cutthroat",
	Icon = "ui/perks/perk_04.png",
	Descriptions = [
		"Sneaky"
	],
	Tree = [
		[
			::Legends.Perk.Pathfinder,
			::Legends.Perk.BagsAndBelts,
			::Legends.Perk.DevastatingStrikes
		],
		[],
		[
			::Legends.Perk.HoldOut,
			::Legends.Perk.LegendFavouredEnemyOutlaw
		],
		[],
		[],
		[
			::Legends.Perk.LegendWindReader
		],
		[
			::Legends.Perk.KillingFrenzy,
			::Legends.Perk.LegendFavouredEnemySwordmaster
		]
	]
};

::Const.Perks.BasicNecroMagicTree <- {
	ID = "BasicNecroMagicTree",
	Name = "Necromancy",
	Icon = "ui/perks/raisedead2_circle.png",
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
	Icon = "ui/perks/siphon_circle.png",
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
	Icon = "ui/perks/darkflight_circle.png",
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
	Icon = "ui/perks/remake_man_circle.png",
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
	Icon = "ui/perks/rebuild_skeleton_circle.png",
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
	Icon = "ui/perks/perk_35.png",
	Descriptions = [
		"berserking"
	],
	Tree = [
		[::Legends.Perk.Colossus, ::Legends.Perk.Adrenaline],
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
	Icon = "ui/perks/perk_28.png",
	Descriptions = [
		"leading"
	],
	Tree = [
		[::Legends.Perk.LegendBackToBasics],
		[
			// ::Legends.Perk.LegendComposure
		],
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
	Icon = "ui/perks/entice_circle_56.png",
	Descriptions = [
		"illusion"
	],
	Tree = [
		[::Legends.Perk.LegendPush],
		[::Legends.Perk.LegendMagicDaze],
		[::Legends.Perk.LegendEntice],
		[
			::Legends.Perk.LegendHorrify,
			::Legends.Perk.LegendStun
		],
		[::Legends.Perk.LegendTerrifyingVisage],
		[],
		[]
	]
};

::Const.Perks.DivinationMagicTree <- {
	ID = "DivinationMagicTree",
	Name = "Divination",
	Icon = "ui/perks/scry_perk.png",
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
	Icon = "ui/perks/cat_circle.png",
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
	Icon = "ui/perks/roots_circle.png",
	Descriptions = [
		"druidic arts"
	],
	Tree = [
		[::Legends.Perk.LegendWither],
		[::Legends.Perk.LegendRoots],
		[::Legends.Perk.LegendPrayerOfLife],
		[],
		[::Legends.Perk.LegendSummonStorm],
		[],
		[::Legends.Perk.LegendInsects]
	]
};

::Const.Perks.DruidTransformTree <- {
	ID = "DruidTransformTree",
	Name = "Druidic transformation",
	Icon = "ui/perks/bear2_circle.png",
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
	Icon = "ui/perks/potion_circle.png",
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
	Icon = "ui/perks/storm_circle.png",
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

::Const.Perks.SeerMagicTree <- {
	ID = "SeerMagicTree",
	Name = "Seer",
	Icon = "ui/perks/levitate.png",
	Descriptions = [
		"seer"
	],
	Tree = [
		[
			::Legends.Perk.LegendMagicMissile
		],
		[],
		[],
		[
			::Legends.Perk.LegendMagicMissileFocus
		],
		[
			::Legends.Perk.LegendChainLightning,
			::Legends.Perk.LegendMagicSleep
		],
		[
			::Legends.Perk.LegendLevitate,
			::Legends.Perk.LegendScry
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
	Icon = "ui/perks/assassinate_circle.png",
	Descriptions = [
		"assassination"
	],
	Tree = [
		[],
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
	Icon = "ui/perks/scry_trance_circle.png",
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
	Icon = "ui/perks/scholar_circle.png",
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
	Icon = "ui/perks/perk_34.png",
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

::Const.Perks.TherianthropyMagicTree <- {
	ID = "TherianthropyMagicTree",
	Name = "Therianthropy",
	Icon = "ui/perks/true_form_circle.png",
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
	GroupsCategory = "Magic",
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
		::Const.Perks.AssassinMagicTree,
		::Const.Perks.BardMagicTree,
		::Const.Perks.StavesMagicTree

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
