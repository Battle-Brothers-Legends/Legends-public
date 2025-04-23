::mods_hookExactClass("entity/tactical/humans/gunner", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.Footwork);
		::Legends.Perks.grant(this, ::Legends.Perk.Recover);
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
			[1, ::Legends.Armor.Southern.padded_vest]
		]));
		local helm =this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Southern.gunner_hat]
		]);
		this.m.Items.equip(helm);
	}
});
