::mods_hookExactClass("entity/tactical/enemies/skeleton_medium", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendPoisonImmunity);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.ShieldExpert);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.BattleForged);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.CripplingStrikes);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.CoupDeGrace);
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
			[1, "ancient/ancient_scale_harness"],
			[1, "ancient/ancient_breastplate"],
			[1, "ancient/ancient_mail"],
			[1, "ancient/ancient_double_layer_mail"]
		];
		local item = this.Const.World.Common.pickArmor(armor);
		this.m.Items.equip(item);

		local item = this.Const.World.Common.pickHelmet([
			[99, "ancient/ancient_honorguard_helmet"],
			[1, "ancient/legend_ancient_legionary_helmet_restored"]
		]);
		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}
});
