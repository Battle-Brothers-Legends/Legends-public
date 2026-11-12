::mods_hookExactClass("skills/effects/goblin_overseer_potion_effect", function (o) {
	o.m.ApplicableSkills <- [
		::Legends.Active.LegendFullDraw,
		::Legends.Active.ShootBolt,
		::Legends.Active.ShootStake,
		::Legends.Active.QuickShot,
		::Legends.Active.LegendSlingHeavyStone,
		::Legends.Active.LegendShootPreciseStone,
		::Legends.Active.LegendShootStone,
		::Legends.Active.SlingStone,
	];

	o.getTooltip <- function () {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 11,
				type = "text",
				icon = "ui/icons/direct_damage.png",
				text = "An additional [color=" + ::Const.UI.Color.PositiveValue + "]5%[/color] of damage ignores armor when using bows, slings or crossbows"
			},
			{
				id = 12,
				type = "hint",
				icon = "ui/tooltips/warning.png",
				text = "Further mutations will cause a longer period of sickness"
			}
		]);
		return tooltip;
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%positive%]+5%[/color] bows, slings or crossbow " + ::Legends.Text.inlineIcons("direct_damage");
	}

	o.onAnySkillUsed <- function ( _skill, _targetEntity, _properties ) {
		foreach (skill in this.m.ApplicableSkills) {
			if (_skill.getID() == ::Legends.Actives.getID(skill)) {
				_properties.DamageDirectMult += 0.05;
			}
		}
	}
});
