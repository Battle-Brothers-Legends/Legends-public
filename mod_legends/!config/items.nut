::Const.Items.NamedArmors.extend([
	"armor/named/named_sellswords_armor"
]);

::Const.Items.LegendNamedClothLayers <- [
	"legend_armor/cloth/legend_gambeson_named",
	"legend_armor/cloth/legend_tunic_noble_named"
];

::Const.Items.LegendNamedChainLayers <- [
	"legend_armor/chain/legend_armor_hauberk_full_named",
];

::Const.Items.LegendNamedPlateLayers <- [
	"legend_armor/plate/legend_armor_plate_full_greaves_painted",
	"legend_armor/plate/legend_armor_plate_full_greaves_named",
	"legend_armor/plate/legend_armor_leather_jacket_named",
	"legend_armor/plate/legend_armor_leather_studded_jacket_named",
	"legend_armor/plate/legend_armor_leather_lamellar_heavy_named",
	"legend_armor/plate/legend_armor_leather_brigandine_named",
	"legend_armor/plate/legend_armor_scale_coat_named",
	"legend_armor/plate/legend_southern_named_golden_plates",
	"legend_armor/plate/legend_southern_named_plates"
];

::Const.Items.LegendNamedTabardLayers <- [
	"legend_armor/named/legend_armor_named_tabard",
];

::Const.Items.LegendNamedCloakLayers <- [
	"legend_armor/named/legend_armor_cloak_rich",
	// "legend_armor/named/legend_armor_cloak_emperors"
];

::Const.Items.LegendNamedSouthernArmorLayers <- [
	"legend_armor/plate/legend_southern_named_golden_plates",
	"legend_armor/plate/legend_southern_named_plates"
];

::Const.Items.LegendNamedHoodLayers <- [
];

::Const.Items.LegendNamedHelmLayers <- [
	"legend_helmets/helm/legend_helmet_italo_norman_helm_named",
	"legend_helmets/helm/legend_helmet_barbute_named",
	"legend_helmets/helm/legend_helmet_bascinet_named",
	"legend_helmets/helm/legend_helmet_kettle_helm_named",
	"legend_helmets/helm/legend_helmet_wallace_sallet_named",
	"legend_helmets/helm/legend_helmet_deep_sallet_named",
	"legend_helmets/helm/legend_helmet_stag_helm",
	"legend_helmets/helm/legend_helmet_swan_helm"
];

::Const.Items.LegendNamedTopLayers <- [
	"legend_helmets/top/legend_helmet_bascinet_visor_named",
	"legend_helmets/top/legend_helmet_wallace_sallet_visor_named"
];

::Const.Items.LegendNamedVanityLayers <- [
];


::Const.Items.LegendNamedArmorLayers <- [];
::Const.Items.LegendNamedArmorLayers.extend(this.Const.Items.LegendNamedClothLayers);
::Const.Items.LegendNamedArmorLayers.extend(this.Const.Items.LegendNamedChainLayers);
::Const.Items.LegendNamedArmorLayers.extend(this.Const.Items.LegendNamedPlateLayers);
::Const.Items.LegendNamedArmorLayers.extend(this.Const.Items.LegendNamedTabardLayers);
::Const.Items.LegendNamedArmorLayers.extend(this.Const.Items.LegendNamedCloakLayers);


::Const.Items.LegendNamedHelmetLayers <- [];
::Const.Items.LegendNamedHelmetLayers.extend(this.Const.Items.LegendNamedHoodLayers);
::Const.Items.LegendNamedHelmetLayers.extend(this.Const.Items.LegendNamedHelmLayers);
::Const.Items.LegendNamedHelmetLayers.extend(this.Const.Items.LegendNamedTopLayers);
::Const.Items.LegendNamedHelmetLayers.extend(this.Const.Items.LegendNamedVanityLayers);

// removing helms before extending
local garbage = [];
for (local i = 0; i < ::Const.Items.NamedHelmets.len(); i++)
{
	switch (::Const.Items.NamedHelmets[i])
	{
		case "helmets/named/golden_feathers_helmet":
		case "helmets/named/sallet_green_helmet":
		case "helmets/named/lindwurm_helmet":
		case "helmets/named/norse_helmet":
			garbage.push(i);
	}
}
garbage.reverse();
foreach (i in garbage)
	::Const.Items.NamedHelmets.remove(i);


::Const.Items.NamedHelmets.extend([
	"helmets/named/legend_frogmouth_helm_crested_painted",
	"helmets/named/legend_frogmouth_helm_decorated",
	"helmets/named/wallace_sallet_named",
	"helmets/named/barbute_named",
	"helmets/named/bascinet_named",
	"helmets/named/kettle_helm_named",
	"helmets/named/italo_norman_helm_named",
	"helmets/named/legend_helm_stag_named",
	"helmets/named/legend_helm_swan_named",
]);

::Const.Items.NamedBanditShields.extend([
	"weapons/named/legend_named_parrying_dagger"
]);

::Const.Items.NamedSouthernShields <- [
	"shields/named/named_sipar_shield"
];

::Const.Items.NamedOrcWeapons.extend([
	"weapons/named/legend_named_orc_axe_2h",
	"weapons/named/legend_named_orc_flail_2h"
]);

::Const.Items.NamedMeleeWeapons.extend([
	"weapons/named/named_fencing_sword",
	"weapons/named/legend_named_longsword",
	"weapons/named/legend_named_longsword",
	"weapons/named/legend_named_estoc",
	"weapons/named/legend_named_glaive",
	"weapons/named/legend_named_swordstaff",
	"weapons/named/legend_named_halberd",
	"weapons/named/legend_named_blacksmith_hammer",
	"weapons/named/legend_named_sickle",
	"weapons/named/legend_named_shovel",
	"weapons/named/legend_named_flail",
	"weapons/named/legend_named_infantry_axe",
	"weapons/named/legend_named_warhammer",
	"weapons/named/legend_named_gladius",
	"weapons/named/legend_named_military_goedendag",
	"weapons/named/legend_named_parrying_dagger"
]);

::Const.Items.NamedRangedWeapons.extend([
	"weapons/named/legend_named_northern_sling"
]);
::Const.Items.NamedWeapons <- clone ::Const.Items.NamedMeleeWeapons;
::Const.Items.NamedWeapons.extend(::Const.Items.NamedRangedWeapons);

::Const.Items.NamedSouthernWeapons.extend([
	"weapons/named/named_heavy_southern_mace"
]);

::Const.Items.NamedUndeadWeapons.extend([
	"weapons/named/legend_named_great_khopesh"
]);

::Const.Items.ArmorUpgrades <- {
	Chain = 0,
	Plate = 1,
	Tabbard = 2,
	Cloak = 3,
	Attachment = 4,
	Rune = 5
	COUNT = 6
};

::Const.Items.HelmetUpgrades <- {
	Helm = 0,
	Top = 1,
	Vanity = 2,
	ExtraVanity = 3,
	Rune = 4,
	//Extra spot for second vanity
	COUNT = 5
};


::Const.Items.LegendItemWithSpearwall <- [
	"weapon.legend_mage_swordstaff",
	"weapon.legend_named_swordstaff",
	"weapon.legend_swordstaff",
];
