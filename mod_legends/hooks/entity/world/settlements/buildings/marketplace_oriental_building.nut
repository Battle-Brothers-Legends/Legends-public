::mods_hookExactClass("entity/world/settlements/buildings/marketplace_oriental_building", function(o)
{
	o.onUpdateShopList = function ()
	{
		local list = [
			{
				R = 10,
				P = 1.0,
				S = "weapons/militia_spear"
			},
			{
				R = 20,
				P = 1.0,
				S = "weapons/pitchfork"
			},
			{
				R = 10,
				P = 1.0,
				S = "weapons/knife"
			},
			{
				R = 30,
				P = 1.0,
				S = "weapons/short_bow"
			},
			{
				R = 60,
				P = 1.0,
				S = "weapons/oriental/composite_bow"
			},
			{
				R = 30,
				P = 1.0,
				S = "weapons/javelin"
			},
			{
				R = 40,
				P = 1.0,
				S = "weapons/oriental/saif"
			},
			{
				R = 70,
				P = 1.0,
				S = "weapons/scimitar"
			},
			{
				R = 40,
				P = 1.0,
				S = "weapons/oriental/light_southern_mace"
			},
			{
				R = 70,
				P = 1.0,
				S = "weapons/oriental/firelance"
			},
			{
				R = 30,
				P = 1.0,
				S = "ammo/quiver_of_arrows"
			},
			{
				R = 10,
				P = 1.0,
				S = "armor/oriental/cloth_sash"
			},
			{
				R = 40,
				P = 1.0,
				S = "armor/oriental/nomad_robe"
			},
			{
				R = 20,
				P = 1.0,
				S = "armor/oriental/padded_vest"
			},
			{
				R = 30,
				P = 1.0,
				S = "armor/oriental/linothorax"
			},
			{
				R = 0,
				P = 1.0,
				S = "helmets/oriental/southern_head_wrap"
			},
			{
				R = 10,
				P = 1.0,
				S = "helmets/oriental/southern_head_wrap"
			},
			{
				R = 30,
				P = 1.0,
				S = "helmets/oriental/wrapped_southern_helmet"
			},
			{
				R = 40,
				P = 1.0,
				S = "helmets/oriental/spiked_skull_cap_with_mail"
			},
			{
				R = 15,
				P = 1.0,
				S = "shields/oriental/southern_light_shield"
			},
			{
				R = 0,
				P = 1.0,
				S = "supplies/rice_item"
			},
			{
				R = 50,
				P = 1.0,
				S = "supplies/rice_item"
			},
			{
				R = 0,
				P = 1.0,
				S = "supplies/medicine_item"
			},
			{
				R = 0,
				P = 1.0,
				S = "supplies/medicine_item"
			},
			{
				R = 50,
				P = 1.0,
				S = "supplies/medicine_item"
			},
			{
				R = 0,
				P = 1.0,
				S = "supplies/ammo_item"
			},
			{
				R = 0,
				P = 1.0,
				S = "supplies/ammo_item"
			},
			{
				R = 50,
				P = 1.0,
				S = "supplies/ammo_item"
			},
			{
				R = 0,
				P = 1.0,
				S = "supplies/armor_parts_item"
			},
			{
				R = 0,
				P = 1.0,
				S = "supplies/armor_parts_item"
			},
			{
				R = 10,
				P = 1.0,
				S = "supplies/armor_parts_item"
			},
			{
				R = 50,
				P = 1.0,
				S = "supplies/armor_parts_item"
			},
			{
				R = 10,
				P = 1.0,
				S = "accessory/bandage_item"
			},
			{
				R = 20,
				P = 1.0,
				S = "tools/throwing_net"
			},
			{
				R = 60,
				P = 1.0,
				S = "helmets/legend_earings"
			},
			{
				R = 60,
				P = 1.0,
				S = "helmets/legend_headband_coin"
			},
			{
				R = 50,
				P = 1.0,
				S = "helmets/legend_southern_cloth_headress"
			},
			{
				R = 40,
				P = 1.0,
				S = "helmets/legend_southern_veil"
			},
			{
				R = 70,
				P = 1.0,
				S = "helmets/legend_headress_coin"
			},
			{
				R = 60,
				P = 1.0,
				S = "accessory/gloves/legend_hand_wraps_item"
			},
			{
				R = 90,
				P = 1.0,
				S = "weapons/two_handed_wooden_hammer"
			},
			{
				R = 80,
				P = 1.0,
				S = "weapons/throwing_spear"
			},
			{
				R = 50,
				P = 1.0,
				S = "weapons/warfork"
			},
			{
				R = 60,
				P = 1.0,
				S = "accessory/legend_sighthound_item"
			}
		];

		if (this.m.Settlement.getSize() >= 2 && !this.m.Settlement.hasAttachedLocation("attached_location.fishing_huts"))
		{
			list.push({
				R = 50,
				P = 1.0,
				S = "supplies/dried_fish_item"
			});
		}

		if (this.m.Settlement.getSize() >= 3 && !this.m.Settlement.hasAttachedLocation("attached_location.goat_herd"))
		{
			list.push({
				R = 50,
				P = 1.0,
				S = "supplies/goat_cheese_item"
			});
			list.push({
				R = 50,
				P = 1.0,
				S = "supplies/dried_lamb_item"
			});
		}

		if (this.m.Settlement.getSize() >= 2)
		{
			list.extend([
				{
					R = 50,
					P = 1.0,
					S = "misc/legend_weapon_skill_book_item"
				},
				{
					R = 50,
					P = 1.0,
					S = "misc/legend_profession_skill_book_item"
				},
				{
					R = 50,
					P = 1.0,
					S = "misc/legend_class_skill_book_item"
				},
				{
					R = 50,
					P = 1.0,
					S = "misc/legend_armor_skill_book_item"
				},
				{
					R = 50,
					P = 1.0,
					S = "misc/legend_trait_skill_book_item"
				},
				{
					R = 50,
					P = 1.0,
					S = "misc/legend_enemy_skill_book_item"
				}
			]);
		}

		if (this.m.Settlement.getSize() >= 3)
		{
			list.extend([
				{
					R = 50,
					P = 1.0,
					S = "misc/legend_weapon_skill_book_item"
				},
				{
					R = 50,
					P = 1.0,
					S = "misc/legend_profession_skill_book_item"
				},
				{
					R = 50,
					P = 1.0,
					S = "misc/legend_class_skill_book_item"
				},
				{
					R = 50,
					P = 1.0,
					S = "misc/legend_armor_skill_book_item"
				},
				{
					R = 50,
					P = 1.0,
					S = "misc/legend_trait_skill_book_item"
				},
				{
					R = 50,
					P = 1.0,
					S = "misc/legend_enemy_skill_book_item"
				}
			]);
		}

		if (this.m.Settlement.getSize() >= 3 && !this.m.Settlement.hasAttachedLocation("attached_location.plantation"))
		{
			list.push({
				R = 50,
				P = 1.0,
				S = "supplies/dates_item"
			});
		}

		if (!this.m.Settlement.hasAttachedLocation("attached_location.wheat_farm"))
		{
			list.push({
				R = 30,
				P = 1.0,
				S = "supplies/bread_item"
			});
		}

		if (this.m.Settlement.getSize() >= 3)
		{
			list.push({
				R = 60,
				P = 1.0,
				S = "supplies/cured_rations_item"
			});
		}

		if (this.m.Settlement.getSize() >= 3 || this.m.Settlement.isMilitary())
		{
			list.push({
				R = 90,
				P = 1.0,
				S = "accessory/falcon_item"
			});
		}

		this.m.Settlement.onUpdateShopList(this.m.ID, list);
		this.fillStash(list, this.m.Stash, 1.0, true);
	}
});
