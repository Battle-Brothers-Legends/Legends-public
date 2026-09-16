::mods_hookExactClass("entity/tactical/enemies/goblin_fighter_low", function(o)
{
	o.assignRandomEquipment = function ()
	{
		local r;
		r = ::Math.rand(1, 4);

		if (this.m.Items.getItemAtSlot(::Const.ItemSlot.Mainhand) == null)
		{
			local weapons = [
				"weapons/greenskins/goblin_falchion",
				"weapons/greenskins/goblin_spear",
				"weapons/legend_chain",
				"weapons/greenskins/goblin_notched_blade",
			];

			this.m.Items.equip(this.new("scripts/items/" + weapons[::Math.rand(0, weapons.len() - 1)]));
		}


		if (::Math.rand(1, 100) <= 66 && this.m.Items.getItemAtSlot(::Const.ItemSlot.Mainhand).getID() != "weapon.goblin_spear")
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/greenskins/goblin_spiked_balls"));
		}

		if (::Math.rand(1, 100) <= 66 && this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand))
		{
			if (::Math.rand(1, 100) <= 50)
			{
				this.m.Items.equip(this.new("scripts/items/tools/throwing_net"));
			}
			else
			{
				this.m.Items.equip(this.new("scripts/items/shields/greenskins/goblin_light_shield"));
			}
		}

		local item = ::Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Greenskin.goblin_light_armor],
			[1, ::Legends.Armor.Greenskin.goblin_medium_armor]
		]);
		this.m.Items.equip(item);

		if (::Math.rand(1, 100) <= 50)
		{
			local item = ::Const.World.Common.pickHelmet([
				[1, ::Legends.Helmet.Greenskin.goblin_light_helmet]
			]);
			if (item != null)
			{
				this.m.Items.equip(item);
			}
		}
	}
});
