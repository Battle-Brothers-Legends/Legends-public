this.desert_camp_ottoman <- this.inherit("scripts/entity/tactical/entity", {
	m = {},
	function getName()
	{
		return "Foot stool";
	}

	function getDescription()
	{
		return "Soft footstool for this camp\'s inhabitants.";
	}

	function onInit()
	{
		local variants = [
			"01",
			"02",
			"03",
			"04",
			"05",
			"06",
			"07",
			"08",
			"09",
			"10"
		];
		local body = this.addSprite("body");
		body.setBrush("desert_camp_ottoman_" + variants[this.Math.rand(0, variants.len() - 1)]);
	}

});

