this.legend_bandit_veteran <- this.inherit("scripts/entity/tactical/human", {
	m = {
		IsLow = false
	},
	function create()
	{
		this.m.Type = this.Const.EntityType.BanditVeteran;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.BanditVeteran.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Raider;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bandit_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.BanditVeteran);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = this.Math.rand(150, 255);
		this.getSprite("armor").Saturation = 0.6;
		this.getSprite("helmet").Saturation = 0.6;
		this.getSprite("helmet_damage").Saturation = 0.6;
		this.getSprite("shield_icon").Saturation = 0.6;
		this.getSprite("shield_icon").setBrightness(0.85);

		if (!this.m.IsLow)
		{
			b.IsSpecializedInSwords = true;
			b.IsSpecializedInAxes = true;
			b.IsSpecializedInMaces = true;
			b.IsSpecializedInFlails = true;
			b.IsSpecializedInPolearms = true;
			b.IsSpecializedInThrowing = true;
			b.IsSpecializedInHammers = true;
			b.IsSpecializedInSpears = true;
			b.IsSpecializedInCleavers = true;

			if (!this.Tactical.State.isScenarioMode())
			{
				local dateToSkip = 0;
				switch (this.World.Assets.getCombatDifficulty())
				{
					case this.Const.Difficulty.Easy:
						dateToSkip = 120;
						break;
					case this.Const.Difficulty.Normal:
						dateToSkip = 90
						break;
					case this.Const.Difficulty.Hard:
						dateToSkip = 60
						break;
					case this.Const.Difficulty.Legendary:
						dateToSkip = 30
						break;
				}

				if (this.World.getTime().Days >= dateToSkip)
				{
					local bonus = this.Math.min(1, this.Math.floor( (this.World.getTime().Days - dateToSkip) / 20.0));
					b.MeleeSkill += bonus;
					b.RangedSkill += bonus;
					b.Hitpoints += bonus;
				}
			}
		}

		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));
		this.m.Skills.add(this.new("scripts/skills/actives/rotation"));
		this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_lithe"));
		this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));

		 if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_full_force"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_dodge"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
		}

	}

	function onAppearanceChanged( _appearance, _setDirty = true )
	{
		this.actor.onAppearanceChanged(_appearance, false);
		this.setDirty(true);
	}

	function assignRandomEquipment()
	{
		local r;

		if (this.Math.rand(1, 100) <= 20)
		{
			if (this.Const.DLC.Unhold)
			{
				r = this.Math.rand(0, 9);

				if (r == 0)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/woodcutters_axe"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smashing_shields"));
						if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
								{
								this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
								}
				}
				else if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/hooked_blade"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
						if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
							{
								this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
							}
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/pike"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_reach_advantage"));
						if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
							{
								this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
							}
				}
				else if (r == 3)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/warbrand"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_bloody_harvest"));
						if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
							{
								this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_forceful_swing"));
							}
				}
				else if (r == 4)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/longaxe"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
						if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
							{
							this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
							}
				}
				else if (r == 5)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/two_handed_wooden_hammer"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_sundering_strikes"));
						if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
							{
								this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smackdown"));
							}
				}
				else if (r == 6)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/two_handed_wooden_flail"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));
						if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
							{
								this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_flow"));
							}
				}
				else if (r == 7)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/two_handed_mace"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));
						if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
							{
								this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_onslaught"));
							}
				}
				else if (r == 8)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/longsword"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_vengeance"));
						if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
							{
								this.m.Skills.add(this.new("scripts/skills/perks/perk_feint"));
							}
				}
				else if (r == 9)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/legend_bastardsword"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_forceful_swing"));
						if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
							{
								this.m.Skills.add(this.new("scripts/skills/perks/perk_bloody_harvest"));
							}
				}
			}
			else
			{
				r = this.Math.rand(0, 4);

				if (r == 0)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/woodcutters_axe"));
				}
				else if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/hooked_blade"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/pike"));
				}
				else if (r == 3)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/warbrand"));
				}
				else if (r == 4)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/longaxe"));
				}
			}
		}
		else
		{
			r = this.Math.rand(2, 11);

			if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/shortsword"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
					 if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
							{
								this.m.Skills.add(this.new("scripts/skills/perks/perk_feint"));
							}
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/hand_axe"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smashing_shields"));
						if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
							{
							this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
							}
			}
			else if (r == 4)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/boar_spear"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
					if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
						{
							this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_spearthrust"));
						}
			}
			else if (r == 5)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/morning_star"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_onslaught"));
					if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
							{
								this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));
							}
			}
			else if (r == 6)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/falchion"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
					 if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
							{
								this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
							}
			}
			else if (r == 7)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/arming_sword"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_feint"));
							 if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
							{
								this.m.Skills.add(this.new("scripts/skills/perks/perk_deulist"));
							}
			}
			else if (r == 8)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/flail"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));
						if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
						{
							this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_flow"));
						}
			}
			else if (r == 9)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/scramasax"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_bloodbath"));
						if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
						{
							this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
						}
			}
			else if (r == 10)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/military_pick"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_sundering_strikes"));

						if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
						{
							this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smackdown"));
						}
			}
			else if (r == 11)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/legend_glaive"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
						if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
						{
							this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
						}
			}

			if (this.Math.rand(1, 100) <= 75)
			{
				if (this.Math.rand(1, 100) <= 75)
				{
					this.m.Items.equip(this.new("scripts/items/shields/kite_shield"));
				}
				else
				{
					this.m.Items.equip(this.new("scripts/items/shields/legend_tower_shield"));
				}
			}
		}

		if (this.getIdealRange() == 1 && this.Math.rand(1, 100) <= 35)
		{
			if (this.Const.DLC.Unhold)
			{
				r = this.Math.rand(1, 3);

				if (r == 1)
				{
					this.m.Items.addToBag(this.new("scripts/items/weapons/throwing_axe"));
				}
				else if (r == 2)
				{
					this.m.Items.addToBag(this.new("scripts/items/weapons/javelin"));
				}
				else if (r == 3)
				{
					this.m.Items.addToBag(this.new("scripts/items/weapons/throwing_spear"));
				}
			}
			else
			{
				r = this.Math.rand(1, 2);

				if (r == 1)
				{
					this.m.Items.addToBag(this.new("scripts/items/weapons/throwing_axe"));
				}
				else if (r == 2)
				{
					this.m.Items.addToBag(this.new("scripts/items/weapons/javelin"));
				}
			}
		}

		if (this.Const.LegendMod.Configs.LegendArmorsEnabled())
		{
			local cloths = [
				[0, ""],
				[1, "cloth/legend_gambeson"],
				[1, "cloth/legend_gambeson_plain"],
				[0, "cloth/legend_gambeson_wolf"],
				[0, "cloth/legend_padded_surcoat"],
				[0, "cloth/legend_robes"],
				[0, "cloth/legend_apron_butcher"],
				[0, "cloth/legend_robes_nun"],
				[0, "cloth/legend_apron_smith"],
				[0, "cloth/legend_robes_wizard"],
				[0, "cloth/legend_sackcloth"],
				[0, "cloth/legend_sackcloth_patched"],
				[0, "cloth/legend_sackcloth_tattered"],
				[0, "cloth/legend_tunic"],
				[0, "cloth/legend_tunic_noble"]
			];
			local armor = this.Const.World.Common.pickLegendArmor(cloths)

			if (armor != null)
			{
				local chains = [
					[1, ""],
					[1, "chain/legend_armor_mail_shirt"],
					[0, "chain/legend_armor_mail_shirt_simple"],
					[0, "chain/legend_armor_rusty_mail_shirt"],
					[0, "chain/legend_armor_ancient_double_mail"],
					[0, "chain/legend_armor_ancient_mail"],
					[1, "chain/legend_armor_basic_mail"],
					[0, "chain/legend_armor_hauberk"],
					[0, "chain/legend_armor_hauberk_full"],
					[0, "chain/legend_armor_hauberk_sleevless"],
					[1, "chain/legend_armor_reinforced_mail"],
					[1, "chain/legend_armor_reinforced_mail_shirt"],
					[0, "chain/legend_armor_reinforced_rotten_mail_shirt"],
					[0, "chain/legend_armor_reinforced_worn_mail"],
					[0, "chain/legend_armor_reinforced_worn_mail_shirt"],
					[1, "chain/legend_armor_short_mail"]
				]

				local chain = this.Const.World.Common.pickLegendArmor(chains)
				if (chain != null)
				{
					armor.setUpgrade(chain)
				}

				local plates = [
					[3, ""],
					[1, "plate/legend_armor_leather_brigandine"],
					[0, "plate/legend_armor_leather_brigandine_hardened"],
					[0, "plate/legend_armor_leather_brigandine_hardened_full"],
					[0, "plate/legend_armor_leather_jacket"],
					[0, "plate/legend_armor_leather_jacket_simple"],
					[1, "plate/legend_armor_leather_lamellar"],
					[1, "plate/legend_armor_leather_lamellar_harness_heavy"],
					[1, "plate/legend_armor_leather_lamellar_harness_reinforced"],
					[0, "plate/legend_armor_leather_lamellar_heavy"],
					[0, "plate/legend_armor_leather_lamellar_reinforced"],
					[0, "plate/legend_armor_leather_noble"],
					[1, "plate/legend_armor_leather_padded"],
					[0, "plate/legend_armor_leather_riveted"],
					[0, "plate/legend_armor_leather_riveted_light"],
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
					[0, "plate/legend_armor_plate_full"],
					[0, "plate/legend_armor_scale"],
					[0, "plate/legend_armor_scale_coat"],
					[0, "plate/legend_armor_scale_coat_rotten"],
					[0, "plate/legend_armor_scale_shirt"]
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
			r = this.Math.rand(2, 7);
			local armor;

			if (r == 2)
			{
				armor = this.new("scripts/items/armor/ragged_surcoat");
			}
			else if (r == 3)
			{
				armor = this.new("scripts/items/armor/padded_leather");
			}
			else if (r == 4)
			{
				armor = this.new("scripts/items/armor/worn_mail_shirt");
			}
			else if (r == 5)
			{
				armor = this.new("scripts/items/armor/patched_mail_shirt");
			}
			else if (r == 6)
			{
				armor = this.new("scripts/items/armor/leather_lamellar");
			}
			else if (r == 7)
			{
				armor = this.new("scripts/items/armor/basic_mail_shirt");
			}

			this.m.Items.equip(armor);

		}


		if (this.Math.rand(1, 100) <= 85)
		{
			local r = this.Math.rand(1, 5);

			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/nasal_helmet"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/dented_nasal_helmet"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/nasal_helmet_with_rusty_mail"));
			}
			else if (r == 4)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/rusty_mail_coif"));
			}
			else if (r == 5)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/headscarf"));
			}
		}
	}

});

