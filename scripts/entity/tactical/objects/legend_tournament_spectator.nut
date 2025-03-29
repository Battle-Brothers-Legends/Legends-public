this.legend_tournament_spectator <- this.inherit("scripts/entity/tactical/entity", {
	m = {},
	function getName()
	{
		return "Spectator";
	}

	function getDescription()
	{
		return "A spectator cheering for the tournament fight";
	}

	function setFlipped( _flip )
	{
		this.getSprite("body").setHorizontalFlipping(_flip);
		this.getSprite("head").setHorizontalFlipping(_flip);
		this.getSprite("armor").setHorizontalFlipping(_flip);
		this.getSprite("beard").setHorizontalFlipping(_flip);
		this.getSprite("helmet").setHorizontalFlipping(_flip);
		this.getSprite("hair").setHorizontalFlipping(_flip);
		this.getSprite("beard_top").setHorizontalFlipping(_flip);
	}

	function onInit()
	{
		local bodies = this.Const.Bodies.AllMale;
		local heads = this.Const.Faces.AllHuman;
		local beards = this.Const.Beards.All;
		local hairs = this.Const.Hair.Barber;
		local armors = [
				"bust_desert_noble_01",
				"bust_desert_noble_02",
				"bust_desert_noble_03",
				"bust_desert_noble_04",
				"bust_body_noble_01",
				"bust_body_noble_02",
				"bust_body_noble_03",
				"bust_body_noble_04",
				"bust_body_noble_05",
				"bust_body_noble_06",
				"bust_body_noble_07",
				"bust_body_noble_08",
				"bust_body_noble_09",
				"bust_body_noble_10",
				"bust_body_noble_11",
				"bust_body_12",
				"bust_body_13",
				"bust_body_28",
				"bust_body_29",
				"bust_body_30",
				"bust_body_31",
				"bust_body_32",
				"bust_body_33",
				"bust_body_36",
				"bust_body_37",
				"bust_body_38",
				"bust_body_39",
				"bust_body_40",
				"bust_body_41",
				"bust_body_42",
				"bust_body_44",
				"bust_body_08",
				"bust_body_46",
				"bust_body_43",
				"bust_body_45",
				"bust_body_54",
				"bust_body_57",
				"bust_body_60",
				"bust_body_82",
				"bust_body_83",
				"bust_body_84",
				"bust_body_85",
				"bust_body_86",
				"bust_body_87",
				"bust_body_88",
				"bust_body_89",
				"bust_body_98",
				"bust_body_102",
				"bust_body_103",
				"bust_body_105",
				"bust_body_508",
				"bust_body_512",
				"bust_body_southern_01",
				"bust_body_southern_02",
				"bust_body_southern_03",
				"bust_body_southern_named_01",
				"bust_body_southern_named_02"
		];
		local helmets = [
			"bust_helmet_noble_01",
			"bust_helmet_noble_02",
			"bust_helmet_noble_03",
			"bust_helmet_noble_04",
			"bust_helmet_noble_05",
			"bust_helmet_04",
			"bust_helmet_18",
			"bust_helmet_23",
			"bust_helmet_35",
			"bust_helmet_39",
			"bust_helmet_49",
			"bust_helmet_50",
			"bust_helmet_51",
			"bust_helmet_52",
			"bust_helmet_53",
			"bust_helmet_55",
			"bust_helmet_56",
			"bust_helmet_58",
			"bust_helmet_62",
			"bust_helmet_63",
			"bust_helmet_83",
			"bust_helmet_200",
			"bust_helmet_158",
			"bust_helmet_204",
			"bust_helmet_205",
			"bust_helmet_206",
			"bust_helmet_236",
			"legend_frogmouth_01",
			"legend_frogmouth_02",
			"legend_frogmouth_03",
			"legend_frogmouth_04",
			"bust_helmet_04_bearded",
			"bust_helmet_04_full",
			"bust_helmet_04_curved",
			"bust_helmet_04_breaths",
			"bust_helmet_04_short",
			"bust_helmet_04_wings",
			"bust_helmet_04_full_named",
			"bust_helmet_04_wings_named",
			"helmet_desert_noble_01",
			"helmet_desert_noble_02",
			"helmet_desert_noble_03",
			"helmet_southern_03",
			"helmet_southern_13",
			"helmet_southern_14",
			"helmet_southern_15",
			"bust_helmet_southern_named_01",
			"bust_helmet_southern_named_02",
			"bust_helmet_198",
			"bust_helmet_232",
			"bust_helmet_233",
			"bust_helmet_234",
			"faction_helmet_01",
			"faction_helmet_02",
			"faction_helmet_03",
			"faction_helmet_04",
			"faction_helmet_05",
			"faction_helmet_06",
			"faction_helmet_07",
			"faction_helmet_08",
			"faction_helmet_09",
			"faction_helmet_10",
			"faction_helmet_11"
		];

		if (::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled" && this.Math.rand(1, 100) >= 50)
		{
			beards = null;
		}



		local body = this.addSprite("body");
		body.setBrush(heads[this.Math.rand(0, heads.len() - 1)]);
		body.varyColor(0.05, 0.05, 0.05);
		body.varySaturation(0.1);
		local armor = this.addSprite("armor");

		armor.setBrush(armors[this.Math.rand(0, armors.len() - 1)]);

		local head = this.addSprite("head");
		head.setBrush(heads[this.Math.rand(0, heads.len() - 1)]);
		head.Color = body.Color;
		head.Saturation = body.Saturation;
		local beard = this.addSprite("beard");

		if (beards != null && this.Math.rand(1, 100) <= 60)
		{
			beard.setBrush("beard_brown_" + beards[this.Math.rand(0, beards.len() - 1)]);
			beard.Saturation = 0.8;
			beard.setBrightness(0.4);
		}

		local hair = this.addSprite("hair");
		local helmet = this.addSprite("helmet");

		if (!beard.HasBrush)
		{
			helmet.setBrush(helmets[this.Math.rand(0, helmets.len() - 1)]);
		}
		else if (this.Math.rand(1, 100) <= 95)
		{
			hair.setBrush("hair_brown_" + hairs[this.Math.rand(0, hairs.len() - 1)]);
			hair.Saturation = 0.8;
			hair.setBrightness(0.4);
		}

		local beard_top = this.addSprite("beard_top");

		if (beard.HasBrush && this.doesBrushExist(beard.getBrush().Name + "_top"))
		{
			beard_top.setBrush(beard.getBrush().Name + "_top");
			beard_top.Saturation = 0.8;
			beard_top.setBrightness(0.4);
		}
	}

});

