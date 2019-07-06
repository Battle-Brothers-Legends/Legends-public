local gt = this.getroottable();

if (!("Perks" in gt.Const))
{
	gt.Const.Perks <- {};
}

gt.Const.Perks.BeastClassTree <- {
	ID = "BeastClassTree",
	Descriptions = [
		"catching beasts"
	],
	Tree = [
		[],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendMasteryNets],
		[],
		[],
		[]
	]
};

gt.Const.Perks.BardClassTree <- {
	ID = "BardClassTree",
	Descriptions = [
		"entertaining"
	],
	Tree = [
		[],
		[gt.Const.Perks.PerkDefs.LegendDaze],
		[],
		[gt.Const.Perks.PerkDefs.LegendEntice],
		[],
		[gt.Const.Perks.PerkDefs.LegendDrumsOfWar],
		[]
	]
};

gt.Const.Perks.HealerClassTree <- {
	ID = "HealerClassTree",
	Descriptions = [
		"healing"
	],
	Tree = [
		[],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendSpecBandage],
		[gt.Const.Perks.PerkDefs.LegendMedIngredients],
		[],
		[gt.Const.Perks.PerkDefs.LegendFieldTriage]
	]
};

gt.Const.Perks.FistsClassTree <- {
	ID = "FistsClassTree",
	Descriptions = [
		"unarmed combat"
	],
	Tree = [
		[],
		[gt.Const.Perks.PerkDefs.LegendKick],
		[gt.Const.Perks.PerkDefs.LegendGrapple],
		[gt.Const.Perks.PerkDefs.LegendSpecFists],
		[],
		[],
		[]
	]
};

gt.Const.Perks.ChefClassTree <- {
	ID = "ChefClassTree",
	Descriptions = [
		"cooking"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendFieldTreats]
	]
};

gt.Const.Perks.RepairClassTree <- {
	ID = "RepairClassTree",
	Descriptions = [
		"repairs"
	],
	Tree = [
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendToolsDrawers],
		[],
		[gt.Const.Perks.PerkDefs.LegendToolsSpares],
		[],
		[gt.Const.Perks.PerkDefs.LegendFieldRepairs]
	]
};

gt.Const.Perks.BarterClassTree <- {
	ID = "BarterClassTree",
	Descriptions = [
		"bartering"
	],
	Tree = [
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendBarterConvincing],
		[],
		[],
		[gt.Const.Perks.PerkDefs.LegendBarterTrustworthy],
		[gt.Const.Perks.PerkDefs.LegendBribe]
	]
};

gt.Const.Perks.KnifeClassTree <- {
	ID = "KnifeClassTree",
	Descriptions = [
		"knives"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendSpecialistKnifeSkill],
		[],
		[gt.Const.Perks.PerkDefs.LegendSpecialistKnifeDamage],
		[],
		[],
		[],
		[]
	]
};

gt.Const.Perks.ButcherClassTree <- {
	ID = "ButcherClassTree",
	Descriptions = [
		"butchery"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendSpecialistButcherSkill],
		[],
		[gt.Const.Perks.PerkDefs.LegendSpecialistButcherDamage],
		[],
		[],
		[],
		[]
	]
};

gt.Const.Perks.HammerClassTree <- {
	ID = "HammerClassTree",
	Descriptions = [
		"hammers"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendSpecialistHammerSkill],
		[],
		[gt.Const.Perks.PerkDefs.LegendSpecialistHammerDamage],
		[],
		[],
		[],
		[]
	]
};

gt.Const.Perks.MilitiaClassTree <- {
	ID = "MilitiaClassTree",
	Descriptions = [
		"militia"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendSpecialistMilitiaSkill],
		[],
		[gt.Const.Perks.PerkDefs.LegendSpecialistMilitiaDamage],
		[],
		[],
		[],
		[]
	]
};

gt.Const.Perks.PickaxeClassTree <- {
	ID = "PickaxeClassTree",
	Descriptions = [
		"pickaxes"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendSpecialistPickaxeSkill],
		[],
		[gt.Const.Perks.PerkDefs.LegendSpecialistPickaxeDamage],
		[],
		[],
		[],
		[]
	]
};

gt.Const.Perks.PitchforkClassTree <- {
	ID = "PitchforkClassTree",
	Descriptions = [
		"pitchforks"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendSpecialistPitchforkSkill],
		[],
		[gt.Const.Perks.PerkDefs.LegendSpecialistPitchforkDamage],
		[],
		[],
		[],
		[]
	]
};

gt.Const.Perks.ShortbowClassTree <- {
	ID = "ShortbowClassTree",
	Descriptions = [
		"shortbows"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendSpecialistShortbowSkill],
		[],
		[gt.Const.Perks.PerkDefs.LegendSpecialistShortbowDamage],
		[],
		[],
		[],
		[]
	]
};

gt.Const.Perks.ShovelClassTree <- {
	ID = "ShovelClassTree",
	Descriptions = [
		"shovels"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendSpecialistShovelSkill],
		[],
		[gt.Const.Perks.PerkDefs.LegendSpecialistShovelDamage],
		[],
		[],
		[],
		[]
	]
};

gt.Const.Perks.WoodaxeClassTree <- {
	ID = "WoodaxeClassTree",
	Descriptions = [
		"axes"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendSpecialistWoodaxeSkill],
		[],
		[gt.Const.Perks.PerkDefs.LegendSpecialistWoodaxeDamage],
		[],
		[],
		[],
		[]
	]
};

gt.Const.Perks.SickleClassTree <- {
	ID = "SickleClassTree",
	Descriptions = [
		"sickles"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendSpecialistWoodaxeSkill],
		[],
		[gt.Const.Perks.PerkDefs.LegendSpecialistWoodaxeDamage],
		[],
		[],
		[],
		[]
	]
};

gt.Const.Perks.NinetailsClassTree <- {
	ID = "NinetailsClassTree",
	Descriptions = [
		"ninetails"
	],
	Tree = [
		[gt.Const.Perks.PerkDefs.LegendSpecialistNinetailsSkill],
		[],
		[gt.Const.Perks.PerkDefs.LegendSpecialistNinetailsDamage],
		[],
		[],
		[],
		[]
	]
};

gt.Const.Perks.ValaChantClassTree <- {
	ID = "ValaChantClassTree",
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

gt.Const.Perks.ValaTranceClassTree <- {
	ID = "ValaTranceClassTree",
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

gt.Const.Perks.ValaRuneClassTree <- {
	ID = "ValaRuneClassTree",
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

gt.Const.Perks.ValaSpiritClassTree <- {
	ID = "ValaSpiritClassTree",
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

gt.Const.Perks.InventorClassTree <- {
	ID = "InventorClassTree",
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




gt.Const.Perks.ClassTrees <- {
	Tree = [
		gt.Const.Perks.BeastClassTree,
		gt.Const.Perks.BardClassTree,
		gt.Const.Perks.HealerClassTree,
		gt.Const.Perks.FistsClassTree,
		gt.Const.Perks.ChefClassTree, 
		gt.Const.Perks.RepairClassTree,
		gt.Const.Perks.BarterClassTree,
		gt.Const.Perks.KnifeClassTree,
		gt.Const.Perks.ButcherClassTree,
		gt.Const.Perks.HammerClassTree,
		gt.Const.Perks.MilitiaClassTree,
		gt.Const.Perks.PickaxeClassTree,
		gt.Const.Perks.PitchforkClassTree,
		gt.Const.Perks.ShortbowClassTree,
		gt.Const.Perks.WoodaxeClassTree,
		gt.Const.Perks.SickleClassTree,
		gt.Const.Perks.NinetailsClassTree
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