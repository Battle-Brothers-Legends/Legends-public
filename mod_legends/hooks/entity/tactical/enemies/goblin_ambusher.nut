::mods_hookExactClass("entity/tactical/enemies/goblin_ambusher", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		if (::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.LegendBallistics);
			::Legends.Perks.grant(this, ::Legends.Perk.Pathfinder);
			::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
		}
	}

	o.assignRandomEquipment = function ()
	{
		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand) == null)
		{
			local r = this.Math.rand(1, 2);

			if (r == 1 || !this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/greenskins/goblin_heavy_bow"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/greenskins/goblin_bow"));
			}
		}

		this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		this.m.Items.addToBag(this.new("scripts/items/weapons/greenskins/goblin_notched_blade"));

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body) == null)
		{
			local item = this.Const.World.Common.pickArmor([
				[1, ::Legends.Armor.Greenskin.goblin_skirmisher_armor]
			]);
			this.m.Items.equip(item);
		}

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head) == null)
		{
			local item = this.Const.World.Common.pickHelmet([
				[1, ::Legends.Helmet.Greenskin.goblin_skirmisher_helmet]
			]);
			this.m.Items.equip(item);
		}

		if (this.Math.rand(1, 100) <= 10)
		{
			this.m.Items.addToBag(this.new("scripts/items/accessory/poison_item"));
		}
		if(::Legends.isLegendaryDifficulty())
		{
			this.m.Items.addToBag(this.new("scripts/items/accessory/poison_item"));
		}

	}
});
