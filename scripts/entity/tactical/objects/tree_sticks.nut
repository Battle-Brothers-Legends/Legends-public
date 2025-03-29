this.tree_sticks <- this.inherit("scripts/entity/tactical/entity", {
	m = {
		IsSticks = true
		},
	function getName()
	{
		return "Pile of sticks";
	}

	function getDescription()
	{
		return "A pile of sticks from a chopped tree.";
	}

	function onInit()
	{
		local body = this.addSprite("body");
		body.setBrush("chopped_wood_0" + this.Math.rand(1, 8));
		body.setHorizontalFlipping(this.Math.rand(0, 100) < 50);
		body.Color = this.createColor("#dbdef0");
		body.varyColor(0.05, 0.05, 0.05);
		body.Scale = 0.7 + this.Math.rand(0, 30) / 100.0;
	}

});

