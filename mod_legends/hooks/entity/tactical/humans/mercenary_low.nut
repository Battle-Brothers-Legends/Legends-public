::mods_hookExactClass("entity/tactical/humans/mercenary_low", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		local b = this.m.BaseProperties;
		::Legends.Perks.remove(this, ::Legends.Perk.BattleForged);
		::Legends.Perks.grant(this, ::Legends.Perk.Nimble);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendStrengthInNumbers);
		::Legends.Perks.grant(this, ::Legends.Perk.Overwhelm);
		::Legends.Perks.grant(this, ::Legends.Perk.Rotation);
		::Legends.Perks.grant(this, ::Legends.Perk.Recover);

		if (::Legends.isLegendaryDifficulty())
		{
			this.m.Hitpoints = b.Hitpoints * 2;
			::Legends.Perks.grant(this, ::Legends.Perk.BattleForged);
			::Legends.Perks.grant(this, ::Legends.Perk.Pathfinder);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
	}

	o.assignRandomEquipment = function ()
	{
		local r = this.Math.rand(0, 7);

		if (r <= 1)
		{
			r = this.Math.rand(1, 3);

			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/billhook"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/pike"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/warbrand"));
			}
		}
		else
		{
			r = this.Math.rand(1, 6);

			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/hand_axe"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/boar_spear"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/morning_star"));
			}
			else if (r == 4)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/falchion"));
			}
			else if (r == 5)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/arming_sword"));
			}
			else if (r == 6)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/flail"));
			}

			if (this.Math.rand(1, 100) <= 75)
			{
				r = this.Math.rand(0, 2);

				if (r == 0)
				{
					this.m.Items.equip(this.new("scripts/items/shields/wooden_shield"));
				}
				else if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/shields/heater_shield"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/shields/kite_shield"));
				}
			}
			else
			{
				this.m.Items.equip(this.new("scripts/items/tools/throwing_net"));
			}
		}

		if (this.getIdealRange() == 1 && this.Math.rand(1, 100) <= 50)
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

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[5, "gambeson"],
			[2, "werewolf_mail_armor"],
			[1, "northern_mercenary_armor_00"],
			[3, "northern_mercenary_armor_01"],
			[3, "padded_surcoat"],
			[4, "basic_mail_shirt"],
			[4, "mail_shirt"],
			[4, "mail_hauberk"]
		]));

		if (this.Math.rand(1, 100) <= 90)
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "padded_nasal_helmet"],
				[1, "rondel_helm"],
				[1, "scale_helm"],
				[1, "nasal_helmet"],
				[1, "closed_mail_coif"],
				[1, "mail_coif"],
				[1, "headscarf"],
				[1, "padded_kettle_hat"],
				[1, "kettle_hat"],
				[1, "flat_top_helmet"],
				[1, "padded_flat_top_helmet"],
				[1, ""]
			]))
		}
	}
});

