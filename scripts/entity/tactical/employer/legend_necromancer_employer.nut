this.legend_necromancer_employer <- ::inherit("scripts/entity/tactical/human", {
	m = {},
	function create() {
		this.m.Type = this.Const.EntityType.Necromancer;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.Necromancer.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.Necromancer;
		this.m.Hairs = this.Const.Hair.Necromancer;
		this.m.HairColors = this.Const.HairColors.Zombie;
		this.m.Beards = this.Const.Beards.Raider;
	}

	function onInit() {
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Necromancer);
		b.TargetAttractionMult = 3.0;
		b.IsAffectedByNight = false;
		b.Vision = 8;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_undead");
		this.getSprite("head").Color = this.createColor("#ffffff");
		this.getSprite("head").Saturation = 1.0;
		this.getSprite("body").Saturation = 0.6;
	}

	function assignRandomEquipment() {
		local item = this.Const.World.Common.pickArmor([
			[1, "ragged_dark_surcoat"],
			[1, "thick_dark_tunic"]
		]);
		this.m.Items.equip(item);

		local item = this.Const.World.Common.pickHelmet([
			[1, "witchhunter_hat"],
			[1, "dark_cowl"],
			[1, "hood", 63]
		]);
		this.m.Items.equip(item);
	}
});
