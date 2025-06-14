::mods_hookExactClass("entity/tactical/humans/militia_captain", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.Recover);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.LegendComposure);
			::Legends.Perks.grant(this, ::Legends.Perk.BattleForged);
			::Legends.Perks.grant(this, ::Legends.Perk.Rotation);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecialistShieldSkill);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendSmashingShields);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendBackToBasics);
			::Legends.Perks.grant(this, ::Legends.Perk.ShieldBash);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendImmovableObject);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);

		}
	}

	o.assignRandomEquipment = function ()
	{
		local r = this.Math.rand(1, 7);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/billhook"));
		}
		else
		{
			if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/arming_sword"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/hand_axe"));
			}
			else if (r == 4)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/military_cleaver"));
			}
			else if (r == 5)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/boar_spear"));
			}
			else if (r == 6)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/falchion"));
			}
			else if (r == 7)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/shortsword"));
			}

			if (this.Math.rand(1, 100) <= 75)
			{
				r = this.Math.rand(1, 2);

				if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/shields/wooden_shield"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/shields/kite_shield"));
				}
			}
		}

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.basic_mail_shirt],
			[1, ::Legends.Armor.Standard.padded_leather],
			[1, ::Legends.Armor.Standard.mail_shirt]
		]));

		this.m.Items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Standard.nasal_helmet_with_mail],
			[1, ::Legends.Helmet.Standard.mail_coif],
			[1, ::Legends.Helmet.Standard.feathered_hat],
			[1, ::Legends.Helmet.Standard.kettle_hat]
		]))
	}
});
