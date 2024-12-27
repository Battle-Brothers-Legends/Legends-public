::mods_hookExactClass("entity/world/settlements/buildings/armorsmith_building", function(o)
{
	o.onUpdateShopList = function ()
	{
		local list = [
			{
				R = 20,
				P = 1.0,
				S = "armor/padded_leather"
			},
			{
				R = 20,
				P = 1.0,
				S = "armor/basic_mail_shirt"
			},
			{
				R = 30,
				P = 1.0,
				S = "armor/mail_shirt"
			},
			{
				R = 50,
				P = 1.0,
				S = "helmets/mail_coif"
			},
			{
				R = 60,
				P = 1.0,
				S = "helmets/closed_mail_coif"
			},
			{
				R = 60,
				P = 1.0,
				S = "helmets/nasal_helmet"
			},
			{
				R = 65,
				P = 1.0,
				S = "helmets/kettle_hat"
			},
			{
				R = 15,
				P = 1.0,
				S = "shields/buckler_shield"
			},
			{
				R = 30,
				P = 1.0,
				S = "shields/wooden_shield"
			},
			{
				R = 30,
				P = 1.0,
				S = "shields/wooden_shield"
			},
			{
				R = 30,
				P = 1.0,
				S = "shields/wooden_shield"
			},
			{
				R = 50,
				P = 1.0,
				S = "shields/heater_shield"
			},
			{
				R = 75,
				P = 1.0,
				S = "shields/legend_tower_shield"
			},
			{
				R = 45,
				P = 1.0,
				S = "shields/kite_shield"
			},
			{
				R = 30,
				P = 1.0,
				S = "armor/leather_lamellar"
			},
			{
				R = 40,
				P = 1.0,
				S = "armor/mail_hauberk"
			},
			{
				R = 50,
				P = 1.0,
				S = "armor/reinforced_mail_hauberk"
			},
			{
				R = 75,
				P = 1.0,
				S = "armor/lamellar_harness"
			},
			{
				R = 50,
				P = 1.0,
				S = "helmets/padded_nasal_helmet"
			},
			{
				R = 55,
				P = 1.0,
				S = "helmets/padded_kettle_hat"
			},
			{
				R = 60,
				P = 1.0,
				S = "helmets/padded_flat_top_helmet"
			},
			{
				R = 80,
				P = 1.0,
				S = "tents/legend_tent_scrap"
			},
			{
				R = 50,
				P = 1.0,
				S = "armor/leather_lamellar"
			},
			{
				R = 40,
				P = 1.0,
				S = "armor/mail_hauberk"
			},
			{
				R = 50,
				P = 1.0,
				S = "armor/reinforced_mail_hauberk"
			},
			{
				R = 75,
				P = 1.0,
				S = "armor/lamellar_harness"
			},
			{
				R = 50,
				P = 1.0,
				S = "helmets/padded_nasal_helmet"
			},
			{
				R = 55,
				P = 1.0,
				S = "helmets/padded_kettle_hat"
			},
			{
				R = 60,
				P = 1.0,
				S = "helmets/padded_flat_top_helmet"
			},
			{
				R = 70,
				P = 1.0,
				S = "armor/scale_armor"
			},
			{
				R = 75,
				P = 1.0,
				S = "armor/heavy_lamellar_armor"
			},
			{
				R = 60,
				P = 1.0,
				S = "helmets/nasal_helmet_with_mail"
			},
			{
				R = 60,
				P = 1.0,
				S = "helmets/bascinet_with_mail"
			},
			{
				R = 60,
				P = 1.0,
				S = "helmets/kettle_hat_with_mail"
			},
			{
				R = 75,
				P = 1.0,
				S = "helmets/kettle_hat_with_closed_mail"
			},
			{
				R = 75,
				P = 1.0,
				S = "helmets/nasal_helmet_with_closed_mail"
			},
			{
				R = 45,
				P = 1.0,
				S = "helmets/reinforced_mail_coif"
			},
			{
				R = 80,
				P = 1.0,
				S = "helmets/legend_enclave_vanilla_skullcap_01"
			},
			{

				R = 80,
				P = 1.0,
				S = "helmets/legend_enclave_vanilla_great_helm_01"
			},
			{

				R = 80,
				P = 1.0,
				S = "helmets/legend_enclave_vanilla_great_bascinet_01"
			},
			{

				R = 80,
				P = 1.0,
				S = "helmets/legend_enclave_vanilla_great_bascinet_02"
			},
			{

				R = 80,
				P = 1.0,
				S = "helmets/legend_enclave_vanilla_armet_01"
			},
			{

				R = 80,
				P = 1.0,
				S = "helmets/legend_enclave_vanilla_kettle_sallet_01"
			},
			{

				R = 80,
				P = 1.0,
				S = "helmets/wallace_sallet"
			},
			{

				R = 80,
				P = 1.0,
				S = "helmets/deep_sallet"
			},
			{

				R = 80,
				P = 1.0,
				S = "helmets/scale_helm"
			},
			{

				R = 80,
				P = 1.0,
				S = "helmets/rondel_helm"
			},
			{

				R = 80,
				P = 1.0,
				S = "helmets/rondel_helm"
			},
			{

				R = 80,
				P = 1.0,
				S = "legend_armor/armor_upgrades/legend_armor_skull_chain_upgrade"
			},
			{

				R = 80,
				P = 1.0,
				S = "legend_armor/armor_upgrades/legend_armor_sacred_shield_upgrade"
			},
			{

				R = 80,
				P = 1.0,
				S = "legend_armor/armor_upgrades/legend_armor_chain_and_mail_upgrade"
			},
			{

				R = 80,
				P = 1.0,
				S = "legend_armor/armor_upgrades/legend_armor_spiked_collar_upgrade"
			},
			{

				R = 80,
				P = 1.0,
				S = "legend_armor/armor_upgrades/legend_pauldron_upgrade"
			},
			{

				R = 80,
				P = 1.0,
				S = "legend_armor/armor_upgrades/legend_pauldron_heavy_upgrade"
			},
			{

				R = 80,
				P = 1.0,
				S = "legend_armor/armor_upgrades/legend_pauldron_strong_upgrade"
			},
			{

				R = 80,
				P = 1.0,
				S = "legend_armor/armor_upgrades/legend_pauldron_stag_upgrade"
			},
			{

				R = 80,
				P = 1.0,
				S = "legend_armor/armor_upgrades/legend_pauldron_swan_upgrade"
			},
			{

				R = 80,
				P = 1.0,
				S = "legend_armor/armor_upgrades/legend_heavy_gladiator_upgrade"
			},
			{

				R = 80,
				P = 1.0,
				S = "legend_armor/armor_upgrades/legend_light_gladiator_upgrade"
			},
			{

				R = 80,
				P = 1.0,
				S = "legend_armor/armor_upgrades/legend_light_padding_replacement_upgrade"
			},
			{
				R = 80,
				P = 1.0,
				S = "helmets/legend_enclave_vanilla_skullcap_01"
			},
			{

				R = 80,
				P = 1.0,
				S = "helmets/legend_enclave_vanilla_great_helm_01"
			},
			{

				R = 80,
				P = 1.0,
				S = "helmets/legend_enclave_vanilla_great_bascinet_01"
			},
			{

				R = 80,
				P = 1.0,
				S = "helmets/legend_enclave_vanilla_great_bascinet_02"
			},
			{

				R = 80,
				P = 1.0,
				S = "helmets/legend_enclave_vanilla_armet_01"
			},
			{

				R = 80,
				P = 1.0,
				S = "helmets/legend_enclave_vanilla_kettle_sallet_01"
			},
			{

				R = 80,
				P = 1.0,
				S = "helmets/wallace_sallet"
			},
			{

				R = 80,
				P = 1.0,
				S = "helmets/deep_sallet"
			},
			{

				R = 80,
				P = 1.0,
				S = "helmets/scale_helm"
			},
			{

				R = 80,
				P = 1.0,
				S = "helmets/rondel_helm"
			},
			{

				R = 80,
				P = 1.0,
				S = "helmets/rondel_helm"
			},
			{

				R = 80,
				P = 1.0,
				S = "legend_armor/armor_upgrades/legend_armor_skull_chain_upgrade"
			},
			{

				R = 80,
				P = 1.0,
				S = "legend_armor/armor_upgrades/legend_armor_sacred_shield_upgrade"
			},
			{

				R = 80,
				P = 1.0,
				S = "legend_armor/armor_upgrades/legend_armor_chain_and_mail_upgrade"
			},
			{

				R = 80,
				P = 1.0,
				S = "legend_armor/armor_upgrades/legend_armor_spiked_collar_upgrade"
			},
			{

				R = 80,
				P = 1.0,
				S = "legend_armor/armor_upgrades/legend_pauldron_upgrade"
			},
			{

				R = 80,
				P = 1.0,
				S = "legend_armor/armor_upgrades/legend_pauldron_heavy_upgrade"
			},
			{

				R = 80,
				P = 1.0,
				S = "legend_armor/armor_upgrades/legend_pauldron_strong_upgrade"
			},
			{

				R = 80,
				P = 1.0,
				S = "legend_armor/armor_upgrades/legend_pauldron_stag_upgrade"
			},
			{

				R = 80,
				P = 1.0,
				S = "legend_armor/armor_upgrades/legend_pauldron_swan_upgrade"
			},
			{

				R = 80,
				P = 1.0,
				S = "legend_armor/armor_upgrades/legend_heavy_gladiator_upgrade"
			},
			{

				R = 80,
				P = 1.0,
				S = "legend_armor/armor_upgrades/legend_light_gladiator_upgrade"
			},
			{

				R = 80,
				P = 1.0,
				S = "legend_armor/armor_upgrades/legend_light_padding_replacement_upgrade"
			},
			{
				R = 45,
				P = 1.0,
				S = "armor/leather_scale_armor"
			},
			{

				R = 55,
				P = 1.0,
				S = "armor/light_scale_armor"
			},
			{

				R = 90,
				P = 1.0,
				S = "armor/noble_mail_armor"
			},
			{

				R = 60,
				P = 1.0,
				S = "armor/sellsword_armor"
			},
			{

				R = 50,
				P = 1.0,
				S = "armor/footman_armor"
			},
			{

				R = 70,
				P = 1.0,
				S = "helmets/sallet_helmet"
			},
			{

				R = 80,
				P = 1.0,
				S = "helmets/barbute_helmet"
			},
			{
				R = 85,
				P = 1.25,
				S = "legend_armor/armor_upgrades/legend_metal_plating_upgrade"
			},
			{

				R = 85,
				P = 1.25,
				S = "legend_armor/armor_upgrades/legend_metal_pauldrons_upgrade"
			},
			{

				R = 85,
				P = 1.25,
				S = "legend_armor/armor_upgrades/legend_mail_patch_upgrade"
			},
			{

				R = 85,
				P = 1.25,
				S = "legend_armor/armor_upgrades/legend_leather_shoulderguards_upgrade"
			},
			{

				R = 85,
				P = 1.25,
				S = "legend_armor/armor_upgrades/legend_leather_neckguard_upgrade"
			},
			{

				R = 85,
				P = 1.25,
				S = "legend_armor/armor_upgrades/legend_joint_cover_upgrade"
			},
			{

				R = 85,
				P = 1.25,
				S = "legend_armor/armor_upgrades/legend_heraldic_plates_upgrade"
			},
			{

				R = 85,
				P = 1.25,
				S = "legend_armor/armor_upgrades/legend_double_mail_upgrade"
			},
			{
				R = 90,
				P = 1.0,
				S = "legend_armor/cloth/legend_knightly_robe"
			},
			{
				R = 60,
				P = 1.0,
				S = "legend_armor/cloth/wanderers_coat"
			},
			{
				R = 70,
				P = 1.0,
				S = "legend_armor/armor_upgrades/legend_pauldron_upgrade"
			},
			{
				R = 70,
				P = 1.0,
				S = "legend_armor/armor_upgrades/legend_pauldron_strong_upgrade"
			},
			{
				R = 70,
				P = 1.0,
				S = "legend_armor/armor_upgrades/legend_pauldron_heavy_upgrade"
			},
			{
				R = 70,
				P = 1.0,
				S = "accessory/legend_spiked_gauntlets_item"
			}
		]

		foreach( i in this.Const.Items.LegendNamedArmorLayers )
		{
			if (this.Math.rand(1, 100) <= 33)
			{
				list.push({
					R = 99,
					P = 2.0,
					S = i
				});
			}
		}

		foreach( i in this.Const.Items.LegendNamedHelmetLayers )
		{
			if (this.Math.rand(1, 100) <= 33)
			{
				list.push({
					R = 99,
					P = 2.0,
					S = i
				});
			}
		}

		foreach( i in this.Const.Items.NamedArmors )
		{
			if (this.Math.rand(1, 100) <= 33)
			{
				list.push({
					R = 99,
					P = 2.0,
					S = i
				});
			}
		}

		foreach( i in this.Const.Items.NamedHelmets )
		{
			if (this.Math.rand(1, 100) <= 33)
			{
				list.push({
					R = 99,
					P = 2.0,
					S = i
				});
			}
		}

		foreach( i in this.Const.Items.NamedShields )
		{
			if (this.Math.rand(1, 100) <= 33)
			{
				list.push({
					R = 99,
					P = 2.0,
					S = i
				});
			}
		}

		if (this.m.Settlement.getTile().SquareCoords.Y > this.World.getMapSize().Y * 0.7)
		{
			list.extend([
			{
				R = 70,
				P = 1.0,
				S = "helmets/nordic_helmet"
			},
			{

				R = 70,
				P = 1.0,
				S = "helmets/steppe_helmet_with_mail"
			},
			{

				R = 75,
				P = 1.0,
				S = "helmets/conic_helmet_with_closed_mail"
			},
			{

				R = 75,
				P = 1.0,
				S = "helmets/conic_helmet_with_closed_mail"
			},
			{

				R = 75,
				P = 1.0,
				S = "helmets/nordic_helmet_with_closed_mail"
			},
			{

				R = 80,
				P = 1.0,
				S = "helmets/conic_helmet_with_faceguard"
			}]);
		}
		else
		{
			list.extend([
			{
				R = 70,
				P = 1.0,
				S = "helmets/flat_top_helmet"
			},

			{

				R = 75,
				P = 1.0,
				S = "helmets/flat_top_with_mail"
			},

			{

				R = 75,
				P = 1.0,
				S = "helmets/flat_top_with_closed_mail"
			}]);
		}

		this.m.Settlement.onUpdateShopList(this.m.ID, list);
		this.fillStash(list, this.m.Stash, 1.25, false);
	}
});
