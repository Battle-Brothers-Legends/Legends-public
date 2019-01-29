this.brush_forest <- this.inherit("scripts/entity/tactical/entity", {
	m = {},
	function getName()
	{
		return this.Const.Strings.Tactical.EntityName.Brush;
	}

	function getDescription()
	{
		return this.Const.Strings.Tactical.EntityDescription.Brush;
	}

	function onInit()
	{
		local body = this.addSprite("body");
		body.setBrush("brush_0" + this.Math.rand(2, 2));
		body.setHorizontalFlipping(this.Math.rand(0, 100) < 50);
		body.setBrightness(0.800000012);
		body.varyColor(0.0700000003, 0.0700000003, 0.0700000003);
		body.Scale = 0.899999976 + this.Math.rand(0, 10) / 100.0;
		local web = this.addSprite("web");
		web.setBrush("web_03");
		web.setHorizontalFlipping(this.Math.rand(0, 100) < 50);
		web.Scale = body.Scale * 0.899999976;
		web.Visible = false;
		this.setBlockSight(true);
	}

});
