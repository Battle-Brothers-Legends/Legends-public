::mods_hookExactClass("entity/tactical/humans/peasant_armed", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		local b = this.m.BaseProperties;
		if(::Legends.isLegendaryDifficulty())
		{
			this.m.Hitpoints = b.Hitpoints * 1.5;
			::Legends.Perks.grant(this, ::Legends.Perk.Nimble);
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
	}

	o.assignRandomEquipment = function ()
	{
		local r;
		r = this.Math.rand(1, 4);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/knife"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/pitchfork"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/wooden_stick"));
		}
		else if (r == 4)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/pickaxe"));
		}

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "sackcloth"],
			[1, "thick_tunic"],
			[1, "apron"],
			[1, "tattered_sackcloth"],
			[6, "linen_tunic"]
		]));

		if (this.Math.rand(1, 100) <= 33)
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "straw_hat"],
				[1, "hood"],
				[1, "headscarf"],
				[1, "feathered_hat"]
			]))
		}
	}
});
