::mods_hookExactClass("entity/tactical/enemies/skeleton_medium_polearm", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendPoisonImmunity);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.BattleForged);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.CripplingStrikes);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.CoupDeGrace);
		}
	}

	o.assignRandomEquipment = function ()
	{
		if (!this.Tactical.State.isScenarioMode() && this.Math.rand(1, 100) <= this.Math.max(10, 60 - this.World.getTime().Days))
		{
			this.m.Items.equip(this.new("scripts/items/weapons/ancient/broken_bladed_pike"));
		}
		else
		{
			this.m.Items.equip(this.new("scripts/items/weapons/ancient/bladed_pike"));
		}

		local armor = [
			[1, "ancient/ancient_scale_harness"],
			[1, "ancient/ancient_mail"],
			[1, "ancient/ancient_double_layer_mail"]
		];
		local item = this.Const.World.Common.pickArmor(armor);
		this.m.Items.equip(item);

		local item = this.Const.World.Common.pickHelmet([
			[66, "ancient/ancient_legionary_helmet"]
		]);
		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}
});
