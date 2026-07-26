this.profession_legend_bandage_bales <- this.inherit("scripts/skills/legend_profession_skill", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendBandageBales);
	}

	function getDynamicTooltip(_def, _active) {
		local ret = [
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png"
				text = "Extra medicine slots"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/plus.png"
				text = "Current: [color=%positive%]" + (::Legends.Professions.getProfessionEffect(_def, 0)) + "[/color]"
			},
		];

		if (!_active) {
			ret.push({
				id = 12,
				type = "text",
				icon = "ui/icons/level_dark.png"
				text = "Next: [color=%positive%]" + ::Legends.Professions.getProfessionEffect(_def, 1) + "[/color]"
			});
		}

		return ret;
	}

	function onAdded() {
		this.legend_profession_skill.onAdded();
		if (::World.State.getPlayer() == null) {
			return;
		}
		::World.State.getPlayer().calculateMedsModifier();
	}

	function onRemoved() {
		this.legend_profession_skill.onRemoved();
		if (::World.State.getPlayer() == null) {
			return;
		}
		::World.State.getPlayer().calculateMedsModifier();
	}
});
