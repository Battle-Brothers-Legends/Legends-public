this.legends_skeleton_high <- this.inherit("scripts/entity/tactical/legend_skeleton", {
	m = {},

	function onInit()
	{
		this.m.SpawnType = this.Const.Tactical.Actor.LegendSkeletonHeavy;
		this.legend_skeleton.onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.ReachAdvantage);
		::Legends.Perks.grant(this, ::Legends.Perk.BattleForged);
		::Legends.Perks.grant(this, ::Legends.Perk.Fearsome);
		::Legends.Perks.grant(this, ::Legends.Perk.ShieldExpert);
		::Legends.Perks.grant(this, ::Legends.Perk.ReachAdvantage);
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
			"weapons/ancient/crypt_cleaver",
			"weapons/ancient/rhomphaia",
			"weapons/ancient/khopesh",
			"weapons/ancient/warscythe",
			"weapons/ancient/legend_gladius",
		];

		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

		if (this.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
		{
			this.m.Items.equip(this.new("scripts/items/shields/ancient/tower_shield"));
		}

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Ancient.ancient_plated_scale_hauberk],
			[1, ::Legends.Armor.Ancient.ancient_scale_coat],
			[1, ::Legends.Armor.Ancient.ancient_plate_harness],
			[1, ::Legends.Armor.Ancient.ancient_plated_mail_hauberk]
		]));

		this.m.Items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Ancient.ancient_honorguard_helmet]
		]))

	}

});
