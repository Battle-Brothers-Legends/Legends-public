this.legend_rain_effect <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendRain);
		this.m.Description = "The rain obscures vision and makes everything slippery";
		this.m.Type = ::Const.SkillType.StatusEffect | ::Const.SkillType.Special;
		this.m.IsActive = false;
		this.m.IsSerialized = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "[color=%negative%]-1[/color] Vision"
		});
		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/ranged_skill.png",
			text = "[color=%negative%]-10%[/color] Ranged Skill"
		});
		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/ranged_defense.png",
			text = "[color=%positive%]+10%[/color] Ranged Defense"
		});
		return ret;
	}

	function onUpdate(_properties) {

		if (_properties.IsAffectedByRain) {
			_properties.Vision -= 1;
			_properties.RangedSkillMult *= 0.9;
			_properties.RangedDefense *= 1.1;
		}
	}

	function getActorHoverTooltip (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-10%[/color] " + ::Legends.S.inlineIcon("ranged_skill") + ", [color=%positive%]+10%[/color] " + ::Legends.S.inlineIcon("ranged_defense") + ", [color=%negative%]-1[/color] " + ::Legends.S.inlineIcon("vision");
	}
});
