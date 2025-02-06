this.legend_bandit_raider_wolf <- this.inherit("scripts/entity/tactical/enemies/legend_bandit_raider", {
	m = {},
	function create()
	{
		this.legend_bandit_raider.create();
		this.m.Name = "Disguised Bandit";
	}

	function onInit()
	{
		this.legend_bandit_raider.onInit();
	}

	function assignRandomEquipment()
	{
		local r = this.Math.rand(0, 9);

		if (r <= 1)
		{
			r = this.Math.rand(0, 3);

			if (r == 0)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/woodcutters_axe"));
			}
			else if (r == 1)
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
			if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/shortsword"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/hand_axe"));
			}
			else if (r == 4)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/boar_spear"));
			}
			else if (r == 5)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/morning_star"));
			}
			else if (r == 6)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/falchion"));
			}
			else if (r == 7)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/arming_sword"));
			}
			else if (r == 8)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/flail"));
			}
			else if (r == 9)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/legend_glaive"));
			}

			if (this.Math.rand(1, 100) <= 75)
			{
				if (this.Math.rand(1, 100) <= 75)
				{
					this.m.Items.equip(this.new("scripts/items/shields/wooden_shield"));
				}
				else
				{
					this.m.Items.equip(this.new("scripts/items/shields/kite_shield"));
				}
			}
		}

		if (this.Math.rand(1, 100) <= 33)
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

		local item = this.Const.World.Common.pickArmor([
			[20, "ragged_surcoat"],
			[20, "padded_leather"],
			[20, "worn_mail_shirt"],
			[20, "patched_mail_shirt"],
			[20, "leather_lamellar"],
			[20, "basic_mail_shirt"]
		]);
		item.setUpgrade(this.new("scripts/items/legend_armor/armor_upgrades/legend_direwolf_pelt_upgrade"));
		this.m.Items.equip(item);

		if (this.Math.rand(1, 100) <= 75)
		{
			local item = this.Const.World.Common.pickHelmet([
				[1, "nasal_helmet"],
				[1, "dented_nasal_helmet"],
				[1, "rusty_mail_coif"],
				[1, "headscarf"],
				[1, "nasal_helmet_with_rusty_mail"]
			]);
			if (item != null)
			{
				this.m.Items.equip(item);
			}
		}
	}

});

