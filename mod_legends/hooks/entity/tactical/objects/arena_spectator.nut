::mods_hookExactClass("entity/tactical/objects/arena_spectator", function(o) 
{
	o.onInit = function ()
	{
		local bodies = ::Const.Bodies.SouthernMale;
		local heads = ::Const.Faces.SouthernMale;
		local beards = ::Const.Beards.Southern;
		local hairs = ::Const.Hair.SouthernMale;
		local armors = [
				"bust_desert_noble_01",
				"bust_desert_noble_02",
				"bust_body_01",
				"bust_body_02",
				"bust_body_03",
				"bust_body_04",
				"bust_body_05",
				"bust_body_08",
				"bust_body_southern_03",
				"bust_body_southern_05",
				"bust_body_southern_06",
				"bust_body_southern_12",
				"bust_body_southern_12",
				"bust_body_southern_18",
				"bust_body_southern_19",
				"bust_body_southern_13",
				"bust_body_southern_14",
				"bust_body_southern_16",
				"bust_body_southern_17"
		];
		local helmets = [
			"bust_helmet_southern_07",
			"bust_helmet_southern_08",
			"bust_helmet_southern_09",
			"bust_helmet_southern_12",
			"bust_helmet_southern_16",
			"bust_helmet_southern_18_damaged",
			"helmet_desert_noble_01",
			"helmet_desert_noble_02",
			"helmet_desert_noble_03"
		];

		if (::Legends.Mod.ModSettings.getSetting("FemaleGenderPercent").getValue() > 0 && ::Math.rand(1, 100) >= 50)
		{
			bodies = ::Const.Bodies.SouthernFemale;
			heads = ::Const.Faces.SouthernFemale;
			hairs = ::Const.Hair.SouthernFemale;
			beards = null;
		}



		local body = this.addSprite("body");
		body.setBrush(bodies[::Math.rand(0, bodies.len() - 1)]);
		body.varyColor(0.05, 0.05, 0.05);
		body.varySaturation(0.1);
		local armor = this.addSprite("armor");

		if (::Math.rand(1, 100) <= 95)
		{
			armor.setBrush(armors[::Math.rand(0, armors.len() - 1)]);
		}

		local head = this.addSprite("head");
		head.setBrush(heads[::Math.rand(0, heads.len() - 1)]);
		head.Color = body.Color;
		head.Saturation = body.Saturation;
		local beard = this.addSprite("beard");

		if (beards != null && ::Math.rand(1, 100) <= 60)
		{
			beard.setBrush("beard_brown_" + beards[::Math.rand(0, beards.len() - 1)]);
			beard.Saturation = 0.8;
			beard.setBrightness(0.4);
		}

		local hair = this.addSprite("hair");
		local helmet = this.addSprite("helmet");

		if (!beard.HasBrush)
		{
			helmet.setBrush(helmets[::Math.rand(0, helmets.len() - 1)]);
		}
		else if (::Math.rand(1, 100) <= 95)
		{
			hair.setBrush("hair_brown_" + hairs[::Math.rand(0, hairs.len() - 1)]);
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