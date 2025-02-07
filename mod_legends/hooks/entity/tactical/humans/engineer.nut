::mods_hookExactClass("entity/tactical/humans/engineer", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		local b = this.m.BaseProperties;
		b.TargetAttractionMult = 2.0;
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
	}

	o.assignRandomEquipment = function ()
	{
		local r;
		local banner = 3;

		if (this.Math.rand(1, 100) <= 50)
		{
			r = this.Math.rand(1, 2);

			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/knife"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/wooden_stick"));
			}
		}
		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "oriental/padded_vest"]
		]));
		local helm =this.Const.World.Common.pickHelmet([
				[1, "oriental/engineer_hat"]
		]);
		this.m.Items.equip(helm);
	}
});
