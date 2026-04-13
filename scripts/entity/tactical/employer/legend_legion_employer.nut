this.legend_legion_employer <- ::inherit("scripts/entity/tactical/skeleton", {
	m = {},
	function create() {
		this.m.Type = this.Const.EntityType.SkeletonLight;
		this.m.BloodType = this.Const.BloodType.Bones;
		this.m.XP = this.Const.Tactical.Actor.SkeletonLight.XP;
		this.skeleton.create();
	}

	function assignRandomEquipment()
	{
		local item = this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Legendary.emperors_armor_fake]
		]);
		this.m.Items.equip(item);

		local item = this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Ancient.ancient_laurels]
		]);
		this.m.Items.equip(item);
	}
});
