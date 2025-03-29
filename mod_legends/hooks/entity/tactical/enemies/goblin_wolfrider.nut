::mods_hookExactClass("entity/tactical/enemies/goblin_wolfrider", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.FastAdaption);
			::Legends.Perks.grant(this, ::Legends.Perk.Overwhelm);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
	}

	o.assignRandomEquipment = function ()
	{
		local weapons = [
			"weapons/greenskins/goblin_falchion",
			"weapons/greenskins/goblin_spear",
			"weapons/greenskins/legend_goblin_longaxe",
		];

		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

		local item = this.Const.World.Common.pickArmor([
			[3, "greenskins/goblin_medium_armor"],
			[1, "greenskins/goblin_heavy_armor"]
		]);
		this.m.Items.equip(item);



		local item = this.Const.World.Common.pickHelmet([
			[75, "greenskins/goblin_light_helmet"],
			[25, "greenskins/goblin_heavy_helmet"]
		]);
		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}
});
