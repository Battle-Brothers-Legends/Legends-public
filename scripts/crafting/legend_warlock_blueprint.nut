this.legend_warlock_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		this.blueprint.create();
	}

	function hasWarlock() {
		local bgs = [
			"background.legend_preserver",
			"background.legend_puppet_master",
			"background.legend_warlock_summoner",
			"background.legend_commander_necro"
		];

		foreach (bro in this.World.getPlayerRoster().getAll()) {
			foreach (bg in bgs) {
				if (bro.getSkills().hasSkill(bg)) {
					return true;
				}
			}
		}

		return false;
	}

	function isCraftable() {
		if (!this.hasWarlock()) {
			return false;
		}
		return this.blueprint.isCraftable();
	}

	function isPartlyCraftable() {
		if (!this.hasWarlock()) {
			return false;
		}
		return this.blueprint.isPartlyCraftable();
	}

	function getIngredients() {
		local ret = [
			{
				InstanceID = "req_warlock",
				ImagePath = "ui/backgrounds/warlock_01.png",
				IsMissing = !this.hasWarlock(),
				IsSkill = 1
			}
		];
		ret.extend(this.blueprint.getIngredients());

		return ret;
	}

	function getTooltipForSkill(_idx) {
		if (_idx == "req_warlock") {
			return [
				{
					id = 1,
					type = "title",
					text = "Background: Necromancer"
				},
				{
					id = 2,
					type = "description",
					text = "Requires a Necromancer to craft."
				}
			];
		}
		return this.blueprint.getTooltipForSkill(_idx);
	}
});
