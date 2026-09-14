this.legend_barbarian_employer <- ::inherit("scripts/entity/tactical/human", {
	m = {},
	function create() {
		this.m.Type = this.Const.EntityType.Knight;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.BarbarianChampion.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.WildMale;
		this.m.Hairs = this.Const.Hair.WildMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.WildExtended;
	}

	function onInit() {
		this.human.onInit();
		local tattoos = [3, 4, 5, 6];
		if (this.Math.rand(1, 100) <= 66) {
			local tattoo_body = this.actor.getSprite("tattoo_body");
			local body = this.actor.getSprite("body");
			tattoo_body.setBrush("tattoo_0" + tattoos[this.Math.rand(0, tattoos.len() - 1)] + "_" + body.getBrush().Name);
			tattoo_body.Visible = true;
		}
		if (this.Math.rand(1, 100) <= 50) {
			local tattoo_head = this.actor.getSprite("tattoo_head");
			tattoo_head.setBrush("tattoo_0" + tattoos[this.Math.rand(0, tattoos.len() - 1)] + "_head");
			tattoo_head.Visible = true;
		}
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_wildmen_01");
	}

	function assignRandomEquipment() {
		local armor = [
			[33, "barbarians/rugged_scale_armor"],
			[34, "barbarians/heavy_iron_armor"],
			[33, "barbarians/thick_plated_barbarian_armor"]
		];
		armor.push([5, "barbarians/reinforced_heavy_iron_armor"]);

		this.m.Items.equip(this.Const.World.Common.pickArmor(armor));

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head)) {
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[1, "barbarians/crude_faceguard_helmet"],
				[1, "barbarians/closed_scrap_metal_helmet"],
				[1, "barbarians/crude_metal_helmet"]
			]));
		}
	}
});
