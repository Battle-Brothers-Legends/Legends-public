this.legend_bandit_thug <- this.inherit("scripts/entity/tactical/legend_randomized_unit_abstract", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.BanditThug;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.BanditThug.XP;
		this.legend_randomized_unit_abstract.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Raider;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bandit_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.legend_randomized_unit_abstract.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.BanditThug);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");
		if (this.Math.rand(1, 100) <= 10)
		{
			local pox = this.getSprite("tattoo_head");
			pox.Visible = true;
			pox.setBrush("bust_head_pox_01");
		}
		else if (this.Math.rand(1, 100) <= 15)
		{
			local pox = this.getSprite("tattoo_head");
			pox.Visible = true;
			pox.setBrush("bust_head_darkeyes_01");
		}
		else
		{
			local dirt = this.getSprite("dirt");
			dirt.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 25)
		{
			this.getSprite("eye_rings").Visible = true;
		}

		this.setArmorSaturation(0.8);
		this.getSprite("shield_icon").setBrightness(0.9);

		// if (::Legends.isLegendaryDifficulty())
		// 	{
		// 	::Legends.Perks.grant(this, ::Legends.Perk.Relentless);
		// 	::Legends.Perks.grant(this, ::Legends.Perk.Dodge);
		// 	::Legends.Perks.grant(this, ::Legends.Perk.LegendStrengthInNumbers);
		// 	::Legends.Perks.grant(this, ::Legends.Perk.Underdog);
		// 	this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));

		// 	}

	}

	function onAppearanceChanged( _appearance, _setDirty = true )
	{
		this.actor.onAppearanceChanged(_appearance, false);
		this.setDirty(true);
	}

	function assignRandomEquipment()
	{
		this.legend_randomized_unit_abstract.assignRandomEquipment();
	}

	// function assignRandomEquipment()
	// {
	// 	local r = this.Math.rand(1, 15);

	// 	if (r == 1)
	// 	{
	// 		if (this.Const.DLC.Unhold)
	// 		{
	// 			r = this.Math.rand(1, 3);

	// 			if (r == 1)
	// 			{
	// 				this.m.Items.equip(this.new("scripts/items/weapons/woodcutters_axe"));
	// 					if (::Legends.isLegendaryDifficulty())
	// 						{

	// 							::Legends.Perks.grant(this, ::Legends.Perk.LegendSmashingShields);
	// 						}
	// 			}
	// 			else if (r == 2)
	// 			{
	// 				this.m.Items.equip(this.new("scripts/items/weapons/goedendag"));
	// 					if (::Legends.isLegendaryDifficulty())
	// 						{
	// 							::Legends.Perks.grant(this, ::Legends.Perk.Relentless);
	// 						}
	// 			}
	// 			else if (r == 3)
	// 			{
	// 				this.m.Items.equip(this.new("scripts/items/weapons/pitchfork"));
	// 					 if (::Legends.isLegendaryDifficulty())
	// 						{
	// 							::Legends.Perks.grant(this, ::Legends.Perk.CoupDeGrace);
	// 						}

	// 			}
	// 		}
	// 		else
	// 		{
	// 			r = this.Math.rand(1, 2);

	// 			if (r == 1)
	// 			{
	// 				this.m.Items.equip(this.new("scripts/items/weapons/woodcutters_axe"));
	// 					if (::Legends.isLegendaryDifficulty())
	// 						{
	// 							::Legends.Perks.grant(this, ::Legends.Perk.LegendSmashingShields);
	// 						}
	// 			}
	// 			else if (r == 2)
	// 			{
	// 				this.m.Items.equip(this.new("scripts/items/weapons/pitchfork"));
	// 					 if (::Legends.isLegendaryDifficulty())
	// 						{
	// 							::Legends.Perks.grant(this, ::Legends.Perk.CoupDeGrace);
	// 						}
	// 			}
	// 		}
	// 	}
	// 	else
	// 	{
	// 		if (r == 2)
	// 		{
	// 			this.m.Items.equip(this.new("scripts/items/weapons/shortsword"));
	// 					 if (::Legends.isLegendaryDifficulty())
	// 						{
	// 							::Legends.Perks.grant(this, ::Legends.Perk.Duelist);
	// 						}
	// 		}
	// 		else if (r == 3)
	// 		{
	// 			this.m.Items.equip(this.new("scripts/items/weapons/hatchet"));
	// 					if (::Legends.isLegendaryDifficulty())
	// 						{
	// 							::Legends.Perks.grant(this, ::Legends.Perk.LegendSmashingShields);
	// 						}
	// 		}
	// 		else if (r == 4)
	// 		{
	// 			this.m.Items.equip(this.new("scripts/items/weapons/bludgeon"));
	// 					if (::Legends.isLegendaryDifficulty())
	// 						{
	// 							::Legends.Perks.grant(this, ::Legends.Perk.Relentless);
	// 						}
	// 		}
	// 		else if (r == 5)
	// 		{
	// 			this.m.Items.equip(this.new("scripts/items/weapons/militia_spear"));
	// 				if (::Legends.isLegendaryDifficulty())
	// 					{
	// 						::Legends.Perks.grant(this, ::Legends.Perk.Overwhelm);
	// 					}
	// 		}
	// 		else if (r == 6)
	// 		{
	// 			this.m.Items.equip(this.new("scripts/items/weapons/pickaxe"));
	// 			if (::Legends.isLegendaryDifficulty())
	// 				{
	// 					::Legends.Perks.grant(this, ::Legends.Perk.LegendSmackdown);
	// 				}
	// 		}
	// 		else if (r == 7)
	// 		{
	// 			this.m.Items.equip(this.new("scripts/items/weapons/reinforced_wooden_flail"));
	// 				if (::Legends.isLegendaryDifficulty())
	// 					{
	// 						::Legends.Perks.grant(this, ::Legends.Perk.HeadHunter);
	// 					}
	// 		}
	// 		else if (r == 8)
	// 		{
	// 			this.m.Items.equip(this.new("scripts/items/weapons/wooden_flail"));
	// 				if (::Legends.isLegendaryDifficulty())
	// 					{
	// 						::Legends.Perks.grant(this, ::Legends.Perk.HeadHunter);
	// 					}
	// 		}
	// 		else if (r == 9)
	// 		{
	// 			this.m.Items.equip(this.new("scripts/items/weapons/butchers_cleaver"));
	// 				if (::Legends.isLegendaryDifficulty())
	// 					{
	// 						::Legends.Perks.grant(this, ::Legends.Perk.LegendBloodbath);
	// 					}
	// 		}
	// 		else if (r == 10)
	// 		{
	// 			this.m.Items.equip(this.new("scripts/items/weapons/dagger"));
	// 				if (::Legends.isLegendaryDifficulty())
	// 					{
	// 						::Legends.Perks.grant(this, ::Legends.Perk.Duelist);
	// 					}
	// 		}
	// 		else if (r == 11)
	// 		{
	// 			this.m.Items.equip(this.new("scripts/items/weapons/legend_scythe"));
	// 					if (::Legends.isLegendaryDifficulty())
	// 					{
	// 						::Legends.Perks.grant(this, ::Legends.Perk.CoupDeGrace);
	// 					}
	// 		}
	// 		else if (r == 12)
	// 		{
	// 			this.m.Items.equip(this.new("scripts/items/weapons/legend_tipstaff"));
	// 					if (::Legends.isLegendaryDifficulty())
	// 					{
	// 						::Legends.Perks.grant(this, ::Legends.Perk.LegendReturnFavor);
	// 					}
	// 		}
	// 		else if (r == 13)
	// 		{
	// 			this.m.Items.equip(this.new("scripts/items/weapons/legend_militia_glaive"));
	// 			if (::Legends.isLegendaryDifficulty())
	// 			{
	// 				::Legends.Perks.grant(this, ::Legends.Perk.KillingFrenzy);
	// 			}
	// 		}
	// 		else if (r == 14)
	// 		{
	// 			this.m.Items.equip(this.new("scripts/items/weapons/legend_tipstaff"));
	// 			if (::Legends.isLegendaryDifficulty())
	// 			{
	// 				::Legends.Perks.grant(this, ::Legends.Perk.KillingFrenzy);
	// 			}
	// 		}
	// 		else if (r == 15)
	// 		{
	// 			this.m.Items.equip(this.new("scripts/items/weapons/legend_ranged_wooden_flail"));
	// 			if (::Legends.isLegendaryDifficulty())
	// 			{
	// 				::Legends.Perks.grant(this, ::Legends.Perk.KillingFrenzy);
	// 			}
	// 		}

	// 		local chance = 33;
	// 			if (::Legends.isLegendaryDifficulty())
	// 					{
	// 					chance = 100;
	// 					}
	// 		if (this.Math.rand(1, 100) <= chance)
	// 		{
	// 			local r = this.Math.rand(1, 2);

	// 			if (r == 1)
	// 			{
	// 				this.m.Items.equip(this.new("scripts/items/shields/wooden_shield"));
	// 			}
	// 			else if (r == 2)
	// 			{
	// 				this.m.Items.equip(this.new("scripts/items/shields/buckler_shield"));
	// 			}
	// 		}
	// 	}

	// 	local item;
	// 	if (::Legends.isLegendaryDifficulty())
	// 	{

	// 		 item = this.Const.World.Common.pickArmor([
	// 			[20, "blotched_gambeson"],
	// 			[20, "bandit_armor_light"],
	// 			[20, "ragged_surcoat"],
	// 			[20, "padded_surcoat"],
	// 			[20, "gambeson"]
	// 		])
	// 	}
	// 	else
	// 	{
	// 		item = this.Const.World.Common.pickArmor([
	// 			[20, "leather_wraps"],
	// 			[20, "thick_tunic"],
	// 			[20, "monk_robe"],
	// 			[20, "bandit_armor_light"],
	// 			[20, "tattered_sackcloth"],
	// 			[20, "leather_tunic"],
	// 			[20, "blotched_gambeson"],
	// 			[20, "ragged_surcoat"],
	// 			[20, "padded_surcoat"],
	// 			[20, "gambeson"]
	// 		])
	// 	}
	// 	this.m.Items.equip(item);



	// 	local chance = 40;
	// 	if (::Legends.isLegendaryDifficulty())
	// 	{
	// 		chance = 100;
	// 	}
	// 	if (this.Math.rand(1, 100) <= chance)
	// 	{
	// 		local item = this.Const.World.Common.pickHelmet([
	// 			[1, "hood"],
	// 			[1, "open_leather_cap"],
	// 			[1, "headscarf"],
	// 			[1, "mouth_piece"],
	// 			[1, "full_leather_cap"],
	// 			[1, "aketon_cap"]
	// 		])
	// 		if (item != null)
	// 		{
	// 			this.m.Items.equip(item);
	// 		}
	// 	}
	// }

});

