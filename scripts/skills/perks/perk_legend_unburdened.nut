this.perk_legend_unburdened <- this.inherit("scripts/skills/skill", {
	m = {
		DamageMult = 0.4,
		IsHidden = false
	},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendUnburdened);
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
	}

	function getDescription() {
		return "True berserkers prefer to shed their armor, trusting fully in their sharp instincts while reveling in the unadulterated primal slaughter.";
	}

	function getTooltip() {
		local items = this.getContainer().getActor();
		local tooltip = this.skill.getTooltip();

		if (items.getItemAtSlot(::Const.ItemSlot.Body) == null && items.getItemAtSlot(::Const.ItemSlot.Head) == null) {
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Only receive [color=%positive%]" + ::Math.round(this.m.DamageMult * 100) + "%[/color] of any damage to hitpoints from attacks"
			});
		} else {
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Effect disabled as the character is currently using armor.[/color]"
			});
		}

		return tooltip;
	}

	function onBeforeDamageReceived(_attacker, _skill, _hitInfo, _properties) {
		local items = this.getContainer().getActor();

		if (items.getItemAtSlot(::Const.ItemSlot.Body) != null || items.getItemAtSlot(::Const.ItemSlot.Head) != null) {
			return;
		}

		if (_attacker != null && _attacker.getID() == this.getContainer().getActor().getID() || _skill == null || !_skill.isAttack() || !_skill.isUsingHitchance()) {
			return;
		}

		_properties.DamageReceivedRegularMult *= this.m.DamageMult;
	}
});
