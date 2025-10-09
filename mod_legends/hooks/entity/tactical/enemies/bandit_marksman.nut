::mods_hookExactClass("entity/tactical/enemies/bandit_marksman", function(o)
{
	o.onInit = function ()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.BanditMarksman);
		b.TargetAttractionMult = 1.1;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");

		if (this.Math.rand(1, 100) <= 20)
		{
			local pox = this.getSprite("tattoo_head");
			pox.Visible = true;
			pox.setBrush("bust_head_darkeyes_01");
		}
		else
		{
			local dirt = this.getSprite("dirt");
			dirt.Visible = true;
			dirt.Alpha = this.Math.rand(150, 255);
		}

		this.setArmorSaturation(0.85);
		this.getSprite("shield_icon").setBrightness(0.85);

		if (!this.m.IsLow)
		{
			b.IsSpecializedInBows = true;
			b.IsSpecializedInCrossbows = true;
			b.IsSpecializedInSlings = true;
			b.Vision = 8;
		}

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 40)
		{
			b.RangedDefense += 5;
		}

		::Legends.Perks.grant(this, ::Legends.Perk.Rotation);
		::Legends.Perks.grant(this, ::Legends.Perk.Recover);

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 20)
		{
			::Legends.Perks.grant(this, ::Legends.Perk.Bullseye);
		}

		if (::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.LegendBallistics);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendPointBlank);
			::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
			::Legends.Perks.grant(this, ::Legends.Perk.LoneWolf);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
	}

	o.onAppearanceChanged = function ( _appearance, _setDirty = true )
	{
		this.actor.onAppearanceChanged(_appearance, false);
		this.setArmorBrightness(0.9);
		this.setDirty(true);
	}

	o.assignRandomEquipment = function ()
	{
		local r = this.Math.rand(1, 6);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/short_bow"));
			this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/hunting_bow"));
			this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/crossbow"));
			this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		}
		else if (r == 4)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/light_crossbow"));
			this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		}
		else if (r == 5)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_sturdy_sling"));
		}
		else if (r == 6)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/staff_sling"));
		}

		r = this.Math.rand(1, 4);

		if (r == 1)
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/dagger"));
		}
		else if (r == 2)
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/knife"));
		}
		else if (r == 3)
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/hatchet"));
		}
		else if (r == 4)
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/bludgeon"));
		}

		local item = this.Const.World.Common.pickArmor([
			[20, ::Legends.Armor.Standard.thick_tunic],
			[20, ::Legends.Armor.Standard.padded_surcoat],
			[20, ::Legends.Armor.Standard.leather_wraps],
			[20, ::Legends.Armor.Standard.blotched_gambeson]
		]);
		this.m.Items.equip(item);

		if (this.Math.rand(1, 100) <= 50)
		{
			local item = this.Const.World.Common.pickHelmet([
				[20, ::Legends.Helmet.Standard.hood],
				[20, ::Legends.Helmet.Standard.open_leather_cap],
				[20, ::Legends.Helmet.Standard.headscarf],
				[20, ::Legends.Helmet.Standard.full_leather_cap],
				[20, ::Legends.Helmet.Standard.mouth_piece]
			]);
			if (item != null)
			{
				this.m.Items.equip(item);
			}
		}
	}
});
