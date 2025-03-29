::mods_hookExactClass("entity/tactical/humans/peasant_southern", function(o)
{
	o.assignRandomEquipment = function ()
	{
		local r;
		r = this.Math.rand(1, 10);

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
		else if (r == 5)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/wooden_stick"));
		}
		else if (r == 6)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/butchers_cleaver"));
		}


		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "sackcloth"],
			[1, "apron"],
			[1, "tattered_sackcloth"],
			[7, "oriental/cloth_sash"]
		]));

		if (this.Math.rand(1, 100) <= 50)
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[2, "oriental/southern_head_wrap"],
				[1, "oriental/nomad_head_wrap"]
			]));
		}
	}
});
