::mods_hookExactClass("entity/tactical/enemies/skeleton_medium", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.LegendPoisonImmunity);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.ShieldExpert);
			::Legends.Perks.grant(this, ::Legends.Perk.BattleForged);
			::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
			::Legends.Perks.grant(this, ::Legends.Perk.CoupDeGrace);
		}
	}

	o.assignRandomEquipment = function ()
	{
		local weapons = [
			[1, "weapons/ancient/broken_ancient_sword"],
			[2, "weapons/ancient/ancient_sword"],
			[1, "weapons/ancient/legend_gladius"],
		];
		this.m.Items.equip(this.Const.World.Common.pickItem(weapons, "scripts/items/"));

		if (this.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
		{
			if (this.Math.rand(1, 100) <= 66)
			{
				this.m.Items.equip(this.new("scripts/items/shields/ancient/coffin_shield"));
			}
			else
			{
				this.m.Items.equip(this.new("scripts/items/shields/ancient/tower_shield"));
			}
		}

		local armor = [
			[1, ::Legends.Armor.Ancient.ancient_scale_harness],
			[1, ::Legends.Armor.Ancient.ancient_breastplate],
			[1, ::Legends.Armor.Ancient.ancient_mail],
			[1, ::Legends.Armor.Ancient.ancient_double_layer_mail]
		];
		local item = this.Const.World.Common.pickArmor(armor);
		this.m.Items.equip(item);

		local item = this.Const.World.Common.pickHelmet([
			[99, ::Legends.Helmet.Ancient.ancient_honorguard_helmet],
			[1, ::Legends.Helmet.Ancient.legend_ancient_legionary_helmet_restored]
		]);
		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}
});
