::mods_hookExactClass("entity/tactical/enemies/goblin_wolfrider", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		if("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
	}

	o.assignRandomEquipment = function ()
	{
		local r;
		r = this.Math.rand(1, 2);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/greenskins/goblin_spear"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/greenskins/goblin_falchion"));
		}

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
