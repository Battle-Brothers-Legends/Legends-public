::mods_hookExactClass("entity/tactical/humans/gunner", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		this.m.Skills.add(this.new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
	}

	o.assignRandomEquipment = function ()
	{
		local r;
		local banner = 3;
		r = this.Math.rand(1, 2);

		if (r == 1)
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/oriental/light_southern_mace"));
		}
		else if (r == 2)
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/oriental/saif"));
		}
		this.m.Items.equip(this.new("scripts/items/weapons/oriental/handgonne"));
		this.m.Items.equip(this.new("scripts/items/ammo/powder_bag"));

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "oriental/padded_vest"]
		]));
		local helm =this.Const.World.Common.pickHelmet([
				[1, "oriental/gunner_hat"]
		]);
		this.m.Items.equip(helm);
	}
});
