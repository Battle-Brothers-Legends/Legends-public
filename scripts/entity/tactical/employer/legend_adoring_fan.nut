this.legend_adoring_fan <- ::inherit("scripts/entity/tactical/human", {
	m = {},
	function create() {
		this.m.Type = ::Const.EntityType.Mercenary;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.BanditLeader.XP;
		this.human.create();
		this.m.Faces = ["bust_head_18"];
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.BeardChance = 0;
		this.setGender(0);
	}

	function onInit() {
		this.human.onInit();
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = this.Math.rand(150, 255);
		this.setArmorSaturation(0.85);
		this.getSprite("shield_icon").setBrightness(0.85);
	}

	function onAppearanceChanged(_appearance, _setDirty = true) {
		this.actor.onAppearanceChanged(_appearance, false);
		this.setArmorBrightness(0.9);
		this.setDirty(true);
	}

	function setAppearance () {
		this.human.setAppearance();
		this.getSprite("hair").setBrush("hair_fan");
		this.getSprite("hair").Visible = true;
	}

	function assignRandomEquipment() {
		if (this.getItems().getItemAtSlot(this.Const.ItemSlot.Body) == null) {
			this.getItems().equip(this.Const.World.Common.pickArmor([
				[1, ::Legends.Armor.Standard.leather_wraps]
			]));
		}
	}
});
