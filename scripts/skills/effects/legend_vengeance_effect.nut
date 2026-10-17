this.legend_vengeance_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Stacks = 1
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendVengeance);
		this.m.Description = "Having just received a blow, this character is determined to fight even harder!";
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/damage_dealt.png",
			text = "[color=%positive%]20%[/color] increased Damage Dealt"
		});
		return tooltip;
	}

	function onUpdate(_properties) {
		_properties.DamageTotalMult *= 1.2;
	}

	function onAnySkillExecuted(_skill, _targetTile, _targetEntity, _forFree) {
		if (_skill.isAttack()) {
			this.m.Stacks -= 1;
		}
		if (this.m.Stacks <= 0) {
			this.removeSelf();
		}
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%positive%]+20%[/color] " + ::Legends.S.inlineIcon("damage_dealt");
	}
});
