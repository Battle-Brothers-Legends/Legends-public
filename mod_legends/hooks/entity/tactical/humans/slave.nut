::mods_hookExactClass("entity/tactical/humans/slave", function(o)
{
	o.assignRandomEquipment = function ()
	{
		local r;
		r = this.Math.rand(1, 6);

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
			this.m.Items.equip(this.new("scripts/items/weapons/butchers_cleaver"));
		}
		else if (r == 5)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/militia_spear"));
		}
		else if (r == 6)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/pickaxe"));
		}

		if (this.Math.rand(1, 100) <= 66)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[2, "sackcloth"],
				[1, "indebted_armor_rags"],
				[2, "tattered_sackcloth"]
			]));
		}


		local helmet = [
			[1, "oriental/southern_head_wrap"],
			[2, ""]
		];
		this.m.Items.equip(this.Const.World.Common.pickHelmet(helmet));
	}
});
