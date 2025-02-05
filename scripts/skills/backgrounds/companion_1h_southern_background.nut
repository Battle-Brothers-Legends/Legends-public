this.companion_1h_southern_background <- this.inherit("scripts/skills/backgrounds/companion_1h_background", {
	m = {},
	function create()
	{
		this.companion_1h_background.create();
		this.m.Bodies = this.Const.Bodies.Gladiator;
		this.m.Faces = this.Const.Faces.SouthernMale;
		this.m.Hairs = this.Const.Hair.SouthernMale;
		this.m.HairColors = this.Const.HairColors.Southern;
		this.m.Beards = this.Const.Beards.Southern;
		this.m.BeardChance = 90;
		this.m.Ethnicity = 1;
		this.m.Excluded = [
			"trait.superstitious",
			"trait.hate_undead",
			"trait.hate_beasts",
			"trait.hate_greenskins",
			"trait.legend_hate_nobles",
			"trait.huge",
			"trait.weasel",
			"trait.fear_undead",
			"trait.fear_beasts",
			"trait.fear_greenskins",
			"trait.legend_fear_nobles",
			"trait.paranoid",
			"trait.night_blind",
			"trait.ailing",
			"trait.impatient",
			"trait.asthmatic",
			"trait.greedy",
			"trait.dumb",
			"trait.clubfooted",
			"trait.drunkard",
			"trait.disloyal",
			"trait.tiny",
			"trait.fragile",
			"trait.clumsy",
			"trait.fainthearted",
			"trait.craven",
			"trait.bleeder",
			"trait.dastard",
			"trait.insecure"
		];
		this.m.Names = this.Const.Strings.SouthernNames;
		this.m.LastNames = this.Const.Strings.SouthernNamesLast;
	}

	function onAddEquipment()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Hitpoints] = 2;
		talents[this.Const.Attributes.Fatigue] = 1;
		talents[this.Const.Attributes.Bravery] = 1;
		local items = this.getContainer().getActor().getItems();

		items.equip(this.new("scripts/items/weapons/oriental/firelance"));
		items.equip(this.new("scripts/items/shields/oriental/southern_light_shield"));
		local item = this.Const.World.Common.pickArmor([
			[1, "oriental/thick_nomad_robe"],
			[1, "oriental/padded_vest"],
			[1, "oriental/leather_nomad_robe"]
		]);
		items.equip(item);

		local helm = this.Const.World.Common.pickHelmet([
			[1, "oriental/leather_head_wrap"],
			[1, "oriental/leather_head_wrap"],
			[1, "oriental/southern_head_wrap", this.Math.rand(0, 1) == 1 ? 12 : 8]
		]);
		items.equip(helm);
	}
});

