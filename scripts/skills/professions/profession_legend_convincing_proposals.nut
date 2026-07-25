this.profession_legend_convincing_proposals <- this.inherit("scripts/skills/legend_profession_skill", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendConvincingProposals);
	}

	function getDynamicTooltip(_def, _active) {
		local ret = [
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png"
				text = "Extra barter"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/plus.png"
				text = "Current: [color=" + ::Const.UI.Color.PositiveValue + "]" + (::Legends.Professions.getProfessionEffect(_def, 0)) * 100 + "%[/color]"
			},
		];

		if (!_active) {
			ret.push({
				id = 12,
				type = "text",
				icon = "ui/icons/level_dark.png"
				text = "Next: [color=" + ::Const.UI.Color.PositiveValue + "]" + ::Legends.Professions.getProfessionEffect(_def, 1) * 100 + "%[/color]"
			});
		}

		return ret;
	}

	function onAdded() {
		this.legend_profession_skill.onAdded();
		if (::World.State.getPlayer() == null) {
			return;
		}
		::World.State.getPlayer().calculateBarterMult();
	}

	function onRemoved() {
		this.legend_profession_skill.onRemoved();
		if (::World.State.getPlayer() == null) {
			return;
		}
		::World.State.getPlayer().calculateBarterMult();
	}

	function onUpdate( _properties ) {
		_properties.DailyWageMult *= 1.25;
	}
});
