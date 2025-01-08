::mods_hookExactClass("entity/tactical/enemies/skeleton_medium_polearm", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_poison_immunity"));
		if(::Legends.isLegendaryDifficulty())
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
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
