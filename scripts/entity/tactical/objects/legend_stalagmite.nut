this.legend_stalagmite <- this.inherit("scripts/entity/tactical/entity", {
	m = {},

	function getName() {
		return "Stalagmite";
	}

	function getDescription() {
		return "A solid rock wall. Blocks movement and line of sight.";
	}

	function onInit() {
		local body = this.addSprite("body");
		body.setBrush("legend_stalagmite");
		body.setHorizontalFlipping(::Math.rand(0, 100) < 50);
		body.varyColor(0.03, 0.03, 0.03);
		body.Scale = 0.65 + ::Math.rand(0, 35) / 100.0;
		this.setSpriteOcclusion("body", 1, -2, -2);
		this.setBlockSight(true);
	}

	function onFinish() {}

	function onSerialize(_out) {
		this.entity.onSerialize(_out);
	}

	function onDeserialize(_in) {
		this.entity.onDeserialize(_in);
	}
});
