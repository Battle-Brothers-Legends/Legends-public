this.wall <- this.inherit("scripts/entity/tactical/entity", {
	m = {},

	function getName() {
		return "Wall";
	}

	function getDescription() {
		return "A solid rock wall. Blocks movement and line of sight.";
	}

	function onInit() {
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
