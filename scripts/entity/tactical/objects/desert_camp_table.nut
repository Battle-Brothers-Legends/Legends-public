this.desert_camp_table <- this.inherit("scripts/entity/tactical/entity", {
	m = {},
	function getName()
	{
		return "Table";
	}

	function getDescription()
	{
		return "Wooden table for this camp\'s inhabitants.";
	}

	function onInit()
	{
		local variants = [
			"04"
		];
		local body = this.addSprite("body");
		body.setBrush("desert_camp_" + variants[this.Math.rand(0, variants.len() - 1)]);
	}

});

