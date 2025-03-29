this.blackmarket_building <- this.inherit("scripts/entity/world/settlements/buildings/building", {
	m = {
		Stash = null
	},
	function getStash()
	{
		return this.m.Stash;
	}

	function create()
	{
		this.building.create();
		this.m.ID = "building.blackmarket";
		this.m.Name = ::MSU.Array.rand([
			"The Black Market",
			"The Shadow Trade",
			"The Dusk Traders",
			"The Smuggler\'s Den",
			"The Rogues\'s Harbor",
			"The Highwayman\'s Haunt",
			"Thieves Kitchen",
			"Doxy\'s Dive",
			"Wraith\'s Cache",
			"The Gorgon Galley",
			"The Den",
			"The Underground",
			"The Hidden Warehouse",
			"Slayer\'s Stash",
			"The Schleichhandel",
			"The Undercroft",
			"The Rookery",
			"The Bagman",
			"The Collector",
			"The Trinketry",
			"The Requistionary",
			"Scavenger\'s Finds",
			"Shadow Peddler",
			"Nightfall\'s Nook",
			"Nightfang Exchange",
			"Darkblood Reliquary",
			"Twilight Treasure",
			"The Warren",
			"The Undermarket",
			"The Secret Supplier",
			"The Dark Butcher",
			"The Veiled Exchange",
			"The Monster\'s End",
			"The Schwarzmarkt"
		]);
		this.m.Description = "Psssst! Over \'ere!";
		this.m.UIImage = "ui/settlements/blackmarket_day";
		this.m.UIImageNight = "ui/settlements/blackmarket_night";
		this.m.Tooltip = "world-town-screen.main-dialog-module.Blackmarket";
		this.m.TooltipIcon = "ui/icons/buildings/blackmarket.png";
		this.m.IsClosedAtDay = true;
		this.m.IsClosedAtNight = false;
		this.m.Stash = this.new("scripts/items/stash_container");
		this.m.Stash.setID("shop");
		this.m.Stash.setResizable(true);
		this.m.Sounds = [
			{
				File = "ambience/blackmarket/blackmarket_01.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_02.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_03.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_04.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_05.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_06.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_07.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_08.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_09.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_10.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_11.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_12.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_13.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_14.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_15.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_16.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_17.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_18.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_19.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_20.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_21.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_22.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_23.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_24.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_25.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_26.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_27.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_28.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_29.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_30.ogg",
				Volume = 0.2,
				Pitch = 1.0
			}
		];
		this.m.SoundsAtNight = [ //change these sounds at some point
			{
				File = "ambience/blackmarket/blackmarket_01.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_02.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_03.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_04.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_05.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_06.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_07.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_08.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_09.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_10.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_11.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_12.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_13.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_14.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_15.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_16.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_17.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_18.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_19.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_20.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_21.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_22.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_23.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_24.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_25.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_26.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_27.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_28.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_29.ogg",
				Volume = 0.2,
				Pitch = 1.0
			},
			{
				File = "ambience/blackmarket/blackmarket_30.ogg",
				Volume = 0.2,
				Pitch = 1.0
			}
		];
	}

	function onClicked( _townScreen )
	{
		_townScreen.getShopDialogModule().setShop(this);
		_townScreen.showShopDialog();
		this.pushUIMenuStack();
	}

	function onSettlementEntered()
	{
		foreach( item in this.m.Stash.getItems() )
		{
			if (item != null)
			{
				item.setSold(false);
				item.setTransactionPrice(null);
			}
		}
	}

	function onUpdateShopList() //R = rarity (higher = more rare out of 1-99%) || P = price modifier (1.0 = normal price) || S = script of the item that will appear
	{
		local list = [
			{
				R = 50,
				P = 1.5,
				S = "loot/white_pearls_item"
			},
			{
				R = 50,
				P = 1.0,
				S = "loot/gemstones_item"
			},
			{
				R = 70,
				P = 6.0,
				S = "misc/legend_skin_ghoul_skin_item"
			},
			{
				R = 90,
				P = 6.0,
				S = "misc/legend_demon_third_eye_item"
			},
			{
				R = 99,
				P = 15.0,
				S = "misc/legend_ancient_scroll_item"
			},
			{
				R = 50,
				P = 6.0,
				S = "misc/legend_banshee_essence_item"
			},
			{
				R = 90,
				P = 6.0,
				S = "misc/legend_demon_alp_skin_item"
			},
			{
				R = 30,
				P = 5.0,
				S = "misc/legend_mistletoe_item"
			},
			{
				R = 95,
				P = 6.0,
				S = "misc/legend_redback_poison_gland_item"
			},
			{
				R = 50,
				P = 6.0,
				S = "misc/legend_demon_hound_bones_item"
			},
			{
				R = 99,
				P = 6.0,
				S = "misc/legend_rock_unhold_bones_item"
			},
			{
				R = 99,
				P = 6.0,
				S = "misc/legend_rock_unhold_hide_item"
			},
				{
				R = 99,
				P = 10.0,
				S = "misc/legend_stollwurm_blood_item"
			},
			{
				R = 99,
				P = 10.0,
				S = "misc/legend_stollwurm_scales_item"
			},
			{
				R = 75,
				P = 8.0,
				S = "misc/legend_white_wolf_pelt_item"
			},
			{
				R = 40,
				P = 4.0,
				S = "misc/lindwurm_blood_item"
			},
			{
				R = 40,
				P = 4.0,
				S = "misc/witch_hair_item"
			},
			{
				R = 35,
				P = 4.0,
				S = "misc/lindwurm_bones_item"
			},
			{
				R = 25,
				P = 4.0,
				S = "misc/lindwurm_scales_item"
			},
			{
				R = 15,
				P = 3.0,
				S = "misc/miracle_drug_item"
			},
			{
				R = 20,
				P = 4.0,
				S = "misc/petrified_scream_item"
			},
			{
				R = 10,
				P = 4.0,
				S = "misc/poison_gland_item"
			},
			{
				R = 10,
				P = 2.0,
				S = "misc/snake_oil_item"
			},
			{
				R = 35,
				P = 4.0,
				S = "misc/poisoned_apple_item"
			},
			{
				R = 70,
				P = 2.0,
				S = "supplies/fermented_unhold_heart_item"
			},
			{
				R = 10,
				P = 2.0,
				S = "supplies/strange_meat_item"
			},
			{
				R = 99,
				P = 20.0,
				S = "special/spiritual_reward_item"
			},
			{
				R = 99,
				P = 20.0,
				S = "special/bodily_reward_item"
			},
			{
				R = 90,
				P = 20.0,
				S = "legend_armor/runes/legend_rune_safety"
			},
			{
				R = 90,
				P = 20.0,
				S = "legend_armor/runes/legend_rune_endurance"
			},
			{
				R = 90,
				P = 20.0,
				S = "legend_helmets/runes/legend_rune_luck"
			},
			{
				R = 90,
				P = 20.0,
				S = "legend_helmets/runes/legend_rune_bravery"
			},
			{
				R = 90,
				P = 20.0,
				S = "legend_helmets/runes/legend_rune_clarity"
			},
			{
				R = 30,
				P = 3.0,
				S = "legend_armor/cloak/legend_animal_pelt"
			},
			{
				R = 60,
				P = 5.0,
				S = "legend_armor/cloak/fur_cloak"
			},
			{
				R = 70,
				P = 3.0,
				S = "helmets/oriental/engineer_hat"
			},
			{
				R = 80,
				P = 5.0,
				S = "legend_armor/cloak/cursed_cloak"
			},
			{
				R = 80,
				P = 3.0,
				S = "legend_helmets/vanity/legend_helmet_warlock_hood"
			},
			{
				R = 80,
				P = 3.0,
				S = "legend_helmets/vanity/legend_helmet_wizard_cowl"
			},
			{
				R = 70,
				P = 3.0,
				S = "legend_helmets/vanity/legend_helmet_physicians_hood"
			},
			{
				R = 70,
				P = 3.0,
				S = "legend_helmets/vanity/legend_helmet_undertakers_hat"
			},
			{
				R = 60,
				P = 3.0,
				S = "legend_helmets/vanity/legend_helmet_impaled_head"
			},
			{
				R = 60,
				P = 3.0,
				S = "legend_helmets/vanity/legend_helmet_impaled_head"
			},
			{
				R = 60,
				P = 3.0,
				S = "legend_helmets/vanity/legend_helmet_beret"
			},
			{
				R = 60,
				P = 2.0,
				S = "legend_helmets/vanity/legend_helmet_sack"
			},
			{
				R = 60,
				P = 3.0,
				S = "legend_helmets/top/legend_helmet_cult_hood"
			},
			{
				R = 80,
				P = 3.0,
				S = "legend_helmets/top/legend_helmet_mask_beak"
			},
			{
				R = 50,
				P = 3.0,
				S = "legend_helmets/vanity/legend_helmet_crown"
			},
			{
				R = 60,
				P = 3.0,
				S = "legend_helmets/vanity/legend_helmet_antler"
			},
			{
				R = 30,
				P = 1.0,
				S = "weapons/lute"
			},
			{
				R = 30,
				P = 2.0,
				S = "weapons/legend_drum"
			},
			{
				R = 30,
				P = 5.0,
				S = "misc/happy_powder_item"
			},
			{
				R = 45,
				P = 2.0,
				S = "weapons/legend_staff_vala"
			},
			{
				R = 70,
				P = 2.0,
				S = "legend_armor/cloth/legend_robes_wizard"
			},
			{
				R = 70,
				P = 2.0,
				S = "legend_armor/cloth/legend_robes_magic"
			},
			{
				R = 70,
				P = 3.0,
				S = "weapons/legend_mystic_staff"
			},
			{
				R = 95,
				P = 3.0,
				S = "weapons/legend_hand_crossbow"
			},
			{
				R = 95,
				P = 3.0,
				S = "weapons/legend_crusader_sword"
			},
			{
				R = 80,
				P = 2.0,
				S = "shields/ancient/legend_mummy_tower_shield"
			},
			{
				R = 60,
				P = 2.0,
				S = "tools/holy_water_item"
			},
			{
				R = 30,
				P = 1.0,
				S = "supplies/legend_liquor_item"
			},
			{
				R = 30,
				P = 2.0,
				S = "tools/reinforced_throwing_net"
			},
			{
				R = 25,
				P = 2.0,
				S = "accessory/legend_pack_small"
			},
			{
				R = 40,
				P = 2.0,
				S = "accessory/legend_pack_large"
			},
			{
				R = 80,
				P = 3.0,
				S = "accessory/legend_cestus_item"
			},
			{
				R = 80,
				P = 3.0,
				S = "accessory/legend_spiked_gauntlets_item"
			}

		];

		foreach( i in this.Const.Items.NamedMeleeWeapons )
		{
			if (this.Math.rand(1, 100) <= 50)
			{
				list.push({
					R = 60,
					P = 3.0,
					S = i
				});
			}
		}

		foreach( i in this.Const.Items.NamedRangedWeapons )
		{
			if (this.Math.rand(1, 100) <= 50)
			{
				list.push({
					R = 60,
					P = 3.0,
					S = i
				});
			}
		}

		this.m.Settlement.onUpdateShopList(this.m.ID, list);
		this.fillStash(list, this.m.Stash, 1.25, false);
	}

	function onSerialize( _out )
	{
		this.building.onSerialize(_out);
		this.m.Stash.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.building.onDeserialize(_in);
		this.m.Stash.onDeserialize(_in);
	}

});

