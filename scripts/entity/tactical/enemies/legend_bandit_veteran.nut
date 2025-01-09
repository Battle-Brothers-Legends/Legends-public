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
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/legend_bandit_melee_agent_less_flanking");
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
		this.setArmorSaturation(0.6);
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

				switch(this.World.Assets.getCombatDifficulty())
				{
				case this.Const.Difficulty.Easy:
					dateToSkip = 360;
					break;

				case this.Const.Difficulty.Normal:
					dateToSkip = 270;
					break;

				case this.Const.Difficulty.Hard:
					dateToSkip = 180;
					break;

				case this.Const.Difficulty.Legendary:
					dateToSkip = 90;
					break;
				}

				if (this.World.getTime().Days >= dateToSkip)
				{
					local bonus = this.Math.min(1, this.Math.floor((this.World.getTime().Days - dateToSkip) / 20.0));
					b.MeleeSkill += bonus;
					b.RangedSkill += bonus;
					b.Hitpoints += bonus;
				}
			}
		}

		::Legends.Perks.grant(this, ::Legends.Perk.Brawny);
		::Legends.Perks.grant(this, ::Legends.Perk.CoupDeGrace);
		::Legends.Perks.grant(this, ::Legends.Perk.Bullseye);
		::Legends.Perks.grant(this, ::Legends.Perk.Rotation);
		::Legends.Perks.grant(this, ::Legends.Perk.Recover);
		::Legends.Perks.grant(this, ::Legends.Perk.BattleForged);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendLithe);
		this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));

		if (::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.LegendFullForce);
			::Legends.Perks.grant(this, ::Legends.Perk.SteelBrow);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendOnslaught);
			::Legends.Perks.grant(this, ::Legends.Perk.Dodge);
			::Legends.Perks.grant(this, ::Legends.Perk.Backstabber);
			::Legends.Perks.grant(this, ::Legends.Perk.Underdog);
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
				r = this.Math.rand(0, 10);

				if (r == 0)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/legend_infantry_axe"));
					::Legends.Perks.grant(this, ::Legends.Perk.LegendSmashingShields);

					if (::Legends.isLegendaryDifficulty())
					{
						::Legends.Perks.grant(this, ::Legends.Perk.KillingFrenzy);
					}
				}
				else if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/hooked_blade"));
					::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);

					if (::Legends.isLegendaryDifficulty())
					{
						::Legends.Perks.grant(this, ::Legends.Perk.Fearsome);
					}
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/pike"));
					::Legends.Perks.grant(this, ::Legends.Perk.ReachAdvantage);

					if (::Legends.isLegendaryDifficulty())
					{
						::Legends.Perks.grant(this, ::Legends.Perk.Backstabber);
					}
				}
				else if (r == 3)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/warbrand"));
					::Legends.Perks.grant(this, ::Legends.Perk.LegendBloodyHarvest);

					if (::Legends.isLegendaryDifficulty())
					{
						::Legends.Perks.grant(this, ::Legends.Perk.LegendForcefulSwing);
					}
				}
				else if (r == 4)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/longaxe"));
					::Legends.Perks.grant(this, ::Legends.Perk.KillingFrenzy);

					if (::Legends.isLegendaryDifficulty())
					{
						::Legends.Perks.grant(this, ::Legends.Perk.Backstabber);
					}
				}
				else if (r == 5)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/two_handed_wooden_hammer"));
					::Legends.Perks.grant(this, ::Legends.Perk.LegendSmackdown);

					if (::Legends.isLegendaryDifficulty())
					{
						::Legends.Perks.grant(this, ::Legends.Perk.LegendSmackdown);
					}
				}
				else if (r == 6)
				{
					local weapons = [
						"weapons/two_handed_wooden_flail",
						"weapons/legend_reinforced_flail",
					];

					this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
					::Legends.Perks.grant(this, ::Legends.Perk.HeadHunter);

					if (::Legends.isLegendaryDifficulty())
					{
						::Legends.Perks.grant(this, ::Legends.Perk.BattleFlow);
					}
				}
				else if (r == 7)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/two_handed_mace"));
					::Legends.Perks.grant(this, ::Legends.Perk.Colossus);

					if (::Legends.isLegendaryDifficulty())
					{
						::Legends.Perks.grant(this, ::Legends.Perk.LegendOnslaught);
					}
				}
				else if (r == 8)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/longsword"));
					::Legends.Perks.grant(this, ::Legends.Perk.LegendVengeance);

					if (::Legends.isLegendaryDifficulty())
					{
						::Legends.Perks.grant(this, ::Legends.Perk.LegendFeint);
					}
				}
				else if (r == 9)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/legend_longsword"));
					::Legends.Perks.grant(this, ::Legends.Perk.LegendForcefulSwing);

					if (::Legends.isLegendaryDifficulty())
					{
						::Legends.Perks.grant(this, ::Legends.Perk.LegendBloodyHarvest);
					}
				}
				else if (r == 10)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/legend_two_handed_club"));
					::Legends.Perks.grant(this, ::Legends.Perk.Colossus);

					if (::Legends.isLegendaryDifficulty())
					{
						::Legends.Perks.grant(this, ::Legends.Perk.LegendOnslaught);
					}
				}
			}
			else
			{
				r = this.Math.rand(0, 4);

				if (r == 0)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/legend_infantry_axe"));
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
				::Legends.Perks.grant(this, ::Legends.Perk.Duelist);

				if (::Legends.isLegendaryDifficulty())
				{
					::Legends.Perks.grant(this, ::Legends.Perk.LegendFeint);
				}
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/hand_axe"));
				::Legends.Perks.grant(this, ::Legends.Perk.LegendSmashingShields);

				if (::Legends.isLegendaryDifficulty())
				{
					::Legends.Perks.grant(this, ::Legends.Perk.KillingFrenzy);
				}
			}
			else if (r == 4)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/boar_spear"));
				::Legends.Perks.grant(this, ::Legends.Perk.Overwhelm);

				if (::Legends.isLegendaryDifficulty())
				{
					::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecSpearThrust);
				}
			}
			else if (r == 5)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/morning_star"));
				::Legends.Perks.grant(this, ::Legends.Perk.LegendOnslaught);

				if (::Legends.isLegendaryDifficulty())
				{
					::Legends.Perks.grant(this, ::Legends.Perk.HeadHunter);
				}
			}
			else if (r == 6)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/falchion"));
				::Legends.Perks.grant(this, ::Legends.Perk.Duelist);

				if (::Legends.isLegendaryDifficulty())
				{
					::Legends.Perks.grant(this, ::Legends.Perk.Fearsome);
				}
			}
			else if (r == 7)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/arming_sword"));
				::Legends.Perks.grant(this, ::Legends.Perk.LegendFeint);

				if (::Legends.isLegendaryDifficulty())
				{
					::Legends.Perks.grant(this, ::Legends.Perk.Duelist);
				}
			}
			else if (r == 8)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/flail"));
				::Legends.Perks.grant(this, ::Legends.Perk.HeadHunter);

				if (::Legends.isLegendaryDifficulty())
				{
					::Legends.Perks.grant(this, ::Legends.Perk.BattleFlow);
				}
			}
			else if (r == 9)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/scramasax"));
				::Legends.Perks.grant(this, ::Legends.Perk.LegendBloodbath);

				if (::Legends.isLegendaryDifficulty())
				{
					::Legends.Perks.grant(this, ::Legends.Perk.Fearsome);
				}
			}
			else if (r == 10)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/military_pick"));
				::Legends.Perks.grant(this, ::Legends.Perk.LegendSmackdown);

				if (::Legends.isLegendaryDifficulty())
				{
					::Legends.Perks.grant(this, ::Legends.Perk.LegendSmackdown);
				}
			}
			else if (r == 11)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/legend_glaive"));
				::Legends.Perks.grant(this, ::Legends.Perk.KillingFrenzy);

				if (::Legends.isLegendaryDifficulty())
				{
					::Legends.Perks.grant(this, ::Legends.Perk.Fearsome);
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

		local item = this.Const.World.Common.pickArmor([
			[1, "reinforced_mail_hauberk"],
			[1, "scale_armor"],
			[2, "heavy_lamellar_armor"],
			[2, "bandit_armor_heavy"],
			[3, "bandit_armor_ultraheavy"]
		])
		this.m.Items.equip(item);

		if (this.Math.rand(1, 100) <= 85)
		{
			local item = this.Const.World.Common.pickHelmet([
				[1, "nasal_helmet"],
				[1, "rondel_helm"],
				[1, "barbute_helmet"],
				[1, "legend_enclave_vanilla_skullcap_01"],
				[1, "legend_enclave_vanilla_kettle_sallet_01"],
				[1, "scale_helm"],
				[1, "deep_sallet"],
				[1, "dented_nasal_helmet"],
				[1, "nasal_helmet_with_rusty_mail"],
				[1, "rusty_mail_coif"],
				[1, "headscarf"]
			])
			if (item != null)
			{
				this.m.Items.equip(item);
			}
		}
	}

});

