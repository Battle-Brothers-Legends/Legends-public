this.blackmarket_building <- this.inherit("scripts/entity/world/settlements/buildings/building", {
	m = {
		Stash = null
	},
	function getStash() {
		return this.m.Stash;
	}

	function create() {
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
		this.m.IsClosedAtDay = false;
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
		this.m.SoundsAtNight = [//change these sounds at some point
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

	function onClicked(_townScreen) {
		_townScreen.getShopDialogModule().setShop(this);
		_townScreen.showShopDialog();
		this.pushUIMenuStack();
	}

	function onSettlementEntered() {
		foreach (item in this.m.Stash.getItems()) {
			if (item != null) {
				item.setSold(false);
				item.setTransactionPrice(null);
			}
		}
	}

	function getDefaultShopList() { //R = rarity (higher = more rare out of 1-99%) || P = price modifier (1.0 = normal price) || S = script of the item that will appear
		local item = @(r, p, s) {
			R = r,
			P = p,
			S = s
		}
		local list = [];
		list.extend([
			item(50, 1.0, "loot/white_pearls_item"),
			item(50, 1.0, "loot/gemstones_item"),
		]);
		list.extend([
			item(70, 6.0, "misc/legend_skin_ghoul_skin_item"),
			item(70, 6.0, "misc/potion_of_oblivion_item"),
			item(90, 6.0, "misc/legend_demon_third_eye_item"),
			item(90, 6.0, "misc/legend_demon_alp_skin_item"),
			item(50, 6.0, "misc/legend_banshee_essence_item"),
			item(50, 6.0, "misc/legend_demon_hound_bones_item"),
			item(99, 15.0, "misc/legend_ancient_scroll_item"),
			item(30, 5.0, "misc/legend_mistletoe_item"),
			item(95, 6.0, "misc/legend_redback_poison_gland_item"),
			item(99, 6.0, "misc/legend_rock_unhold_bones_item"),
			item(99, 6.0, "misc/legend_rock_unhold_hide_item"),
			item(99, 10.0, "misc/legend_stollwurm_blood_item"),
			item(99, 10.0, "misc/legend_stollwurm_scales_item"),
			item(75, 8.0, "misc/legend_white_wolf_pelt_item"),
			item(40, 4.0, "misc/lindwurm_blood_item"),
			item(40, 4.0, "misc/witch_hair_item"),
			item(35, 4.0, "misc/lindwurm_bones_item"),
			item(25, 4.0, "misc/lindwurm_scales_item"),
			item(15, 3.0, "misc/miracle_drug_item"),
			item(20, 4.0, "misc/petrified_scream_item"),
			item(10, 4.0, "misc/poison_gland_item"),
			item(35, 4.0, "misc/poisoned_apple_item"),
			item(10, 2.0, "misc/snake_oil_item"),
			item(30, 5.0, "misc/happy_powder_item"),
		]);
		list.extend([
			item(70, 2.0, "supplies/fermented_unhold_heart_item"),
			item(10, 2.0, "supplies/strange_meat_item"),
			item(30, 1.0, "supplies/legend_liquor_item"),
		]);
		list.extend([
			item(99, 20.0, "special/spiritual_reward_item"),
			item(99, 20.0, "special/bodily_reward_item"),
			item(5, 40.0, "misc/legend_map_legendary_item"),
			item(5, 4.0, "misc/legend_map_named_item"),
		]);
		list.extend([
			item(90, 20.0, "legend_armor/runes/legend_rune_safety"),
			item(90, 20.0, "legend_armor/runes/legend_rune_endurance"),
			item(90, 20.0, "legend_helmets/runes/legend_rune_luck"),
			item(90, 20.0, "legend_helmets/runes/legend_rune_bravery"),
			item(90, 20.0, "legend_helmets/runes/legend_rune_clarity"),
		]);
		list.extend([
			item(30, 3.0, "legend_armor/cloak/legend_armor_animal_pelt"),
			item(60, 5.0, "legend_armor/cloak/legend_armor_cloak_fur"),
			item(80, 5.0, "legend_armor/cloak/legend_armor_cloak_cursed"),
			item(70, 2.0, "legend_armor/cloth/legend_armor_robes_wizard"),
			item(70, 2.0, "legend_armor/cloth/legend_armor_robes_magic"),
			item(80, 3.0, "legend_helmets/vanity/legend_helmet_warlock_hood"),
			item(80, 3.0, "legend_helmets/vanity/legend_helmet_wizard_cowl"),
			item(70, 3.0, "legend_helmets/vanity/legend_helmet_physicians_hood"),
			item(70, 3.0, "legend_helmets/vanity/legend_helmet_undertakers_hat"),
			item(60, 3.0, "legend_helmets/vanity/legend_helmet_impaled_head"),
			item(60, 3.0, "legend_helmets/vanity/legend_helmet_impaled_head"),
			item(60, 3.0, "legend_helmets/vanity/legend_helmet_beret"),
			item(70, 5.0, "helmets/oriental/engineer_hat"),
			item(60, 2.0, "legend_helmets/vanity/legend_helmet_sack"),
			item(60, 3.0, "legend_helmets/top/legend_helmet_cult_hood"),
			item(80, 3.0, "legend_helmets/top/legend_helmet_mask_beak"),
			item(50, 3.0, "legend_helmets/vanity/legend_helmet_crown"),
			item(60, 3.0, "legend_helmets/vanity/legend_helmet_antler"),
		]);
		list.extend([
			item(30, 1.0, "weapons/lute"),
			item(30, 2.0, "weapons/legend_drum"),
			item(45, 2.0, "weapons/legend_staff_vala"),
			item(70, 3.0, "weapons/legend_mystic_staff"),
			item(95, 3.0, "weapons/legend_hand_crossbow"),
			item(95, 3.0, "weapons/legend_crusader_sword"),
			item(80, 2.0, "shields/ancient/legend_mummy_tower_shield"),
		]);
		list.extend([
			item(60, 2.0, "tools/holy_water_item"),
			item(30, 2.0, "tools/reinforced_throwing_net"),
		]);
		list.extend([
			item(25, 2.0, "accessory/legend_pack_small"),
			item(40, 2.0, "accessory/legend_pack_large"),
			item(80, 3.0, "accessory/gloves/legend_cestus_item"),
			item(80, 3.0, "accessory/gloves/legend_spiked_gauntlets_item"),
		]);


		foreach (i in ::Const.Items.NamedMeleeWeapons) {
			if (::Math.rand(1, 100) <= 50) {
				list.push(item(99, 2.0, i));
			}
		}

		foreach (i in ::Const.Items.NamedRangedWeapons) {
			if (::Math.rand(1, 100) <= 50) {
				list.push(item(99, 2.0, i));
			}
		}
		return list;
	}

	function onSerialize(_out) {
		this.building.onSerialize(_out);
		this.m.Stash.onSerialize(_out);
	}

	function onDeserialize(_in) {
		this.building.onDeserialize(_in);
		this.m.Stash.onDeserialize(_in);
	}

});

