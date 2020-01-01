this.legend_noble_halberdier <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.LegendHalberdier;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.LegendHalberdier.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Tidy;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendHalberdier);
		b.IsSpecializedInSwords = true;
		b.IsSpecializedInAxes = true;
		b.IsSpecializedInMaces = true;
		b.IsSpecializedInFlails = true;
		b.IsSpecializedInPolearms = true;
		b.IsSpecializedInThrowing = true;
		b.IsSpecializedInHammers = true;
		b.IsSpecializedInSpears = true;
		b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_reach_advantage"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_polearm"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
		this.m.Skills.add(this.new("scripts/skills/actives/rotation"));
		this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
		if("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
			{
			this.m.Hitpoints = b.Hitpoints * 2;
			this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_flow"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
			}
	}

	function assignRandomEquipment()
	{
		local r;
		local banner = 3;

		if (!this.Tactical.State.isScenarioMode())
		{
			banner = this.World.FactionManager.getFaction(this.getFaction()).getBanner();
		}
		else
		{
			banner = this.getFaction();
		}

		this.m.Surcoat = banner;

		if (this.Math.rand(1, 100) <= 90)
		{
			this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));
		}


		r = this.Math.rand(0, 3);

		if (r <= 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_halberd"));

		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_voulge"));	
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_military_voulge"));
		}


		if (this.Const.LegendMod.Configs.LegendArmorsEnabled())
		{
			local cloths = [
				[0, ""],
				[0, "cloth/legend_gambeson"],
				[0, "cloth/legend_gambeson_plain"],
				[1, "cloth/legend_gambeson_rare_color"],
				[2, "cloth/legend_gambeson_common_color"],
				[0, "cloth/legend_gambeson_wolf"],
				[1, "cloth/legend_padded_surcoat"],
				[0, "cloth/legend_robes"],
				[0, "cloth/legend_apron_butcher"],
				[0, "cloth/legend_robes_nun"],
				[0, "cloth/legend_apron_smith"],
				[0, "cloth/legend_robes_wizard"],
				[0, "cloth/legend_sackcloth"],
				[0, "cloth/legend_sackcloth_patched"],
				[0, "cloth/legend_sackcloth_tattered"],
				[1, "cloth/legend_thick_tunic"],
				[0, "cloth/legend_tunic"],
				[0, "cloth/legend_tunic_noble"]
			];
			local armor = this.Const.World.Common.pickLegendArmor(cloths)

			if (armor != null)
			{
				local chains = [
					[0, ""],
					[0, "chain/legend_armor_mail_shirt"],
					[1, "chain/legend_armor_mail_shirt_simple"],
					[0, "chain/legend_armor_rusty_mail_shirt"],
					[0, "chain/legend_armor_ancient_double_mail"],
					[0, "chain/legend_armor_ancient_mail"],
					[1, "chain/legend_armor_basic_mail"],
					[2, "chain/legend_armor_hauberk"],
					[0, "chain/legend_armor_hauberk_full"],
					[4, "chain/legend_armor_hauberk_sleevless"],
					[0, "chain/legend_armor_reinforced_mail"],
					[2, "chain/legend_armor_reinforced_mail_shirt"],
					[0, "chain/legend_armor_reinforced_rotten_mail_shirt"],
					[0, "chain/legend_armor_reinforced_worn_mail"],
					[0, "chain/legend_armor_reinforced_worn_mail_shirt"],
					[0, "chain/legend_armor_short_mail"]
				]

				local chain = this.Const.World.Common.pickLegendArmor(chains)
				if (chain != null)
				{
					armor.setUpgrade(chain)
				}

				local plates = [
					[0, ""],
					[0, "plate/legend_armor_leather_brigandine"],
					[2, "plate/legend_armor_leather_brigandine_hardened"],
					[0, "plate/legend_armor_leather_brigandine_hardened_full"],
					[0, "plate/legend_armor_leather_jacket"],
					[0, "plate/legend_armor_leather_jacket_simple"],
					[0, "plate/legend_armor_leather_lamellar"],
					[0, "plate/legend_armor_leather_lamellar_harness_heavy"],
					[0, "plate/legend_armor_leather_lamellar_harness_reinforced"],
					[4, "plate/legend_armor_leather_lamellar_heavy"],
					[1, "plate/legend_armor_leather_lamellar_reinforced"],
					[0, "plate/legend_armor_leather_noble"],
					[0, "plate/legend_armor_leather_padded"],
					[0, "plate/legend_armor_leather_riveted"],
					[1, "plate/legend_armor_leather_riveted_light"],
					[0, "plate/legend_armor_leather_scale"],
					[0, "plate/legend_armor_plate_ancient_chest"],
					[0, "plate/legend_armor_plate_ancient_harness"],
					[0, "plate/legend_armor_plate_ancient_mail"],
					[0, "plate/legend_armor_plate_ancient_scale"],
					[0, "plate/legend_armor_plate_ancient_scale_coat"],
					[0, "plate/legend_armor_plate_ancient_scale_harness"],
					[0, "plate/legend_armor_plate_chest"],
					[0, "plate/legend_armor_plate_chest_rotten"],
					[0, "plate/legend_armor_plate_cuirass"],
					[1, "plate/legend_armor_plate_full"],
					[1, "plate/legend_armor_plate_full_greaves"],
					[1, "plate/legend_armor_scale"],
					[0, "plate/legend_armor_scale_coat"],
					[0, "plate/legend_armor_scale_coat_rotten"],
					[2, "plate/legend_armor_scale_shirt"]
				]
				local plate = this.Const.World.Common.pickLegendArmor(plates)
				if (plate != null)
				{
					armor.setUpgrade(plate)
				}

				this.m.Items.equip(armor);
			}
		}
		else
		{
			r = this.Math.rand(1, 4);

			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/armor/heavy_lamellar_armor"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/armor/mail_shirt"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/armor/leather_lamellar"));
			}
			else if (r == 4)
			{
				this.m.Items.equip(this.new("scripts/items/armor/lamellar_harness"));
			}

		}


		if (this.Math.rand(1, 100) <= 33)
		{
			local helmet;

			if (banner <= 4)
			{
				r = this.Math.rand(1, 4);

				if (r == 1)
				{
					helmet = this.new("scripts/items/helmets/kettle_hat");
				}
				else if (r == 2)
				{
					helmet = this.new("scripts/items/helmets/padded_kettle_hat");
				}
				else if (r == 3)
				{
					helmet = this.new("scripts/items/helmets/kettle_hat_with_mail");
				}
				else
				{
					helmet = this.new("scripts/items/helmets/mail_coif");
				}
			}
			else if (banner <= 7)
			{
				r = this.Math.rand(1, 4);

				if (r == 1)
				{
					helmet = this.new("scripts/items/helmets/flat_top_helmet");
				}
				else if (r == 2)
				{
					helmet = this.new("scripts/items/helmets/padded_flat_top_helmet");
				}
				else if (r == 3)
				{
					helmet = this.new("scripts/items/helmets/flat_top_with_mail");
				}
				else
				{
					helmet = this.new("scripts/items/helmets/mail_coif");
				}
			}
			else
			{
				r = this.Math.rand(1, 4);

				if (r == 1)
				{
					helmet = this.new("scripts/items/helmets/nasal_helmet");
				}
				else if (r == 2)
				{
					helmet = this.new("scripts/items/helmets/padded_nasal_helmet");
				}
				else if (r == 3)
				{
					helmet = this.new("scripts/items/helmets/nasal_helmet_with_mail");
				}
				else
				{
					helmet = this.new("scripts/items/helmets/mail_coif");
				}
			}

			helmet.setPlainVariant();
			this.m.Items.equip(helmet);
		}
		else
		{
			r = this.Math.rand(1, 5);

			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/aketon_cap"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/full_aketon_cap"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/aketon_cap"));
			}
			else if (r == 4)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/headscarf"));
			}
		}
	}

});

