this.legends_skeleton_med <- this.inherit("scripts/entity/tactical/legend_skeleton", {
	m = {},

	function onInit()
	{
		this.m.SpawnType = this.Const.Tactical.Actor.LegendSkeletonMedium;
		this.legend_skeleton.onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.SteelBrow);
		::Legends.Perks.grant(this, ::Legends.Perk.ShieldExpert);
		::Legends.Traits.grant(this, ::Legends.Trait.LegendFleshless);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.BattleForged);
			::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
			::Legends.Perks.grant(this, ::Legends.Perk.CoupDeGrace);
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
			[1, ::Legends.Armor.Ancient.ancient_scale_harness],
			[1, ::Legends.Armor.Ancient.ancient_breastplate],
			[1, ::Legends.Armor.Ancient.ancient_mail],
			[1, ::Legends.Armor.Ancient.ancient_double_layer_mail]
		]));


		local item = this.Const.World.Common.pickHelmet([
			[34, ::Legends.Helmet.None],
			[66, ::Legends.Helmet.Ancient.ancient_household_helmet]
		]);

		if (item != null)
		{
			this.m.Items.equip(item);
		}

	}

});
