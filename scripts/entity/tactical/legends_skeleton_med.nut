this.legends_skeleton_med <- this.inherit("scripts/entity/tactical/legend_skeleton", {
	m = {},

	function onInit()
	{
		this.m.SpawnType = this.Const.Tactical.Actor.LegendSkeletonMedium;
		this.legend_skeleton.onInit();
		this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
		this.m.Skills.add(this.new("scripts/skills/traits/legend_fleshless_trait"));
		if(::Legends.isLegendaryDifficulty())
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		}
		this.m.Skills.update();
	}

	function assignRandomEquipment()
	{
		local weapons = [
			"weapons/ancient/ancient_sword",
			"weapons/ancient/broken_ancient_sword",
			"weapons/ancient/falx",
			"weapons/ancient/ancient_spear",
			"weapons/ancient/legend_gladius",
		];

		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

		if (this.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
		{
			local shields = [
				[1, ""],
				[1, "shields/ancient/auxiliary_shield"],
				[1, "shields/ancient/coffin_shield"],
				[1, "shields/ancient/tower_shield"],
			];
			this.m.Items.equip(this.Const.World.Common.pickItem(shields, "scripts/items/"))
		}

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "ancient/ancient_scale_harness"],
			[1, "ancient/ancient_breastplate"],
			[1, "ancient/ancient_mail"],
			[1, "ancient/ancient_double_layer_mail"]
		]));


		local item = this.Const.World.Common.pickHelmet([
			[34, ""],
			[66, "ancient/ancient_household_helmet"]
		]);

		if (item != null)
		{
			this.m.Items.equip(item);
		}

	}

});
