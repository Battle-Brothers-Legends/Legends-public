::mods_hookExactClass("entity/tactical/enemies/goblin_ambusher_low", function(o)
{
	o.assignRandomEquipment = function ()
	{
		local r;
		this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		local r = this.Math.rand(1, 1);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/greenskins/goblin_bow"));
		}

		this.m.Items.addToBag(this.new("scripts/items/weapons/greenskins/goblin_notched_blade"));
		local item = this.Const.World.Common.pickArmor([
				[1, ::Legends.Armor.Greenskin.goblin_skirmisher_armor]
			]);
			this.m.Items.equip(item);

		local item = this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Greenskin.goblin_skirmisher_helmet]
		]);
		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}
});
