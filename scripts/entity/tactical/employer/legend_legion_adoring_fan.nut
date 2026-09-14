this.legend_legion_adoring_fan <- ::inherit("scripts/entity/tactical/skeleton", {
	m = {},
	function create() {
		this.m.Type = this.Const.EntityType.SkeletonLight;
		this.m.BloodType = this.Const.BloodType.Bones;
		this.m.XP = this.Const.Tactical.Actor.SkeletonLight.XP;
		this.skeleton.create();
	}

	function assignRandomEquipment() {
		local item = ::Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Ancient.ancient_breastplate]
		]);
		this.m.Items.equip(item);
	}

	function isAlliedWithPlayer() {
		return true;
	}

	function onInit() {
		this.skeleton.onInit();
		this.getSprite("hair").setBrush("hair_fan");
		this.getSprite("hair").Visible = true;
		this.getSprite("hair").setHorizontalFlipping(false);
	}

	function onFactionChanged() {
		this.skeleton.onFactionChanged();
		this.getSprite("hair").setHorizontalFlipping(false);
	}

});
