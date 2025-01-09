::mods_hookExactClass("entity/tactical/humans/bounty_hunter_ranged", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();

		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.Nimble);
			::Legends.Perks.grant(this, ::Legends.Perk.Pathfinder);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendBigGameHunter);
			::Legends.Perks.grant(this, ::Legends.Perk.HeadHunter);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendBackToBasics);
			::Legends.Perks.grant(this, ::Legends.Perk.LoneWolf);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendOnslaught);
			::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
	}

	o.assignRandomEquipment = function ()
	{
		local r = this.Math.rand(1, 2);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/hunting_bow"));
			this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/crossbow"));
			this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		}

		r = this.Math.rand(1, 4);

		if (r == 1)
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/dagger"));
		}
		else if (r == 2)
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/scramasax"));
		}
		else if (r == 3)
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/hatchet"));
		}
		else if (r == 4)
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/bludgeon"));
		}

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "thick_tunic"],
			[1, "padded_surcoat"],
			[1, "leather_lamellar"],
			[1, "basic_mail_shirt"],
			[1, "ragged_surcoat"],
			[1, "basic_mail_shirt"]
		]));

		if (this.Math.rand(1, 100) <= 50)
		{
			local item = this.Const.World.Common.pickHelmet([
				[1, "hood"],
				[1, "full_aketon_cap"],
				[1, "headscarf"],
				[1, "mouth_piece"],
				[1, "full_leather_cap"],
				[1, "aketon_cap"]
			]);
			if (item != null)
			{
				this.m.Items.equip(item);
			}
		}
	}
});
