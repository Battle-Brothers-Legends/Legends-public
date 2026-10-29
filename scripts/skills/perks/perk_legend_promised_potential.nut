this.perk_legend_promised_potential <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendPromisedPotential);
	}

	function getBonus(_attribute, _actor = null) {
		local actor = _actor != null ? _actor : this.getContainer().getActor();
		if (actor.m.Type != ::Const.EntityType.Player) {
			return 0;
		}
		local talents = actor.getTalents();
		if (talents.len() == 0) {
			return 0;
		}
		return ::Math.max(1, talents[_attribute] * 3);
	}

	function onUpdate(_properties) {
		foreach (key, attribute in ::Const.Attributes) {
			if (attribute == ::Const.Attributes.Fatigue) {
				_properties.Stamina += this.getBonus(::Const.Attributes.Fatigue);
			} else if (attribute != ::Const.Attributes.COUNT) {
				_properties[key] += this.getBonus(::Const.Attributes[key]);
			}
		}
	}

	function getDynamicTooltip(_actor = null) {
		return [
			{
				id = 3,
				type = "text",
				icon = "ui/icons/health.png",
				text = "[color=%positive%]+" + this.getBonus(::Const.Attributes.Hitpoints, _actor) + "[/color] Health"
			},
			{
				id = 4,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=%positive%]+" + this.getBonus(::Const.Attributes.Fatigue, _actor) + "[/color] Fatigue"
			},
			{
				id = 5,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=%positive%]+" + this.getBonus(::Const.Attributes.Bravery, _actor) + "[/color] Resolve"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=%positive%]+" + this.getBonus(::Const.Attributes.Initiative, _actor) + "[/color] Initiative"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=%positive%]+" + this.getBonus(::Const.Attributes.MeleeSkill, _actor) + "[/color] Melee Skill"
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=%positive%]+" + this.getBonus(::Const.Attributes.RangedSkill, _actor) + "[/color] Ranged Skill"
			},
			{
				id = 9,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=%positive%]+" + this.getBonus(::Const.Attributes.MeleeDefense, _actor) + "[/color] Melee Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%positive%]+" + this.getBonus(::Const.Attributes.RangedDefense, _actor) + "[/color] Ranged Defense"
			}
		];
	}
});
