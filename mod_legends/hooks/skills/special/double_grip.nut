::mods_hookExactClass("skills/special/double_grip", function (o) {
	o.m.DirectDamageAdd <- 0;

	local create = o.create;
	o.create = function () {
		create();
		this.m.Description = "With the second hand free, this character can get a firm double grip on %their% weapon.";
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function () {
		local tooltip = getTooltip();
		local bonus = ::Math.floor(this.getContainer().getActor().getCurrentProperties().MeleeSkill * 0.25);
		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/direct_damage.png",
			text = "[color=%positive%]" + bonus + "%[/color] of any damage ignores armor ([color=%positive%]25%[/color] of Melee Skill)"
		});

		return tooltip;
	}

	o.canDoubleGrip = function () {
		return this.getContainer().getActor().canDoubleGrip();
	}

	o.onUpdate = function (_properties) {
		this.m.DirectDamageAdd += ::Math.floor(_properties.MeleeSkill * 0.25) * 0.01;
	}

	o.onAnySkillUsed <- function (_skill, _targetEntity, _properties) {
		if (this.canDoubleGrip() && _skill.isAttack() && !_skill.isRanged() && _skill.m.IsWeaponSkill) {
			_properties.DamageDirectAdd += this.m.DirectDamageAdd;
			_properties.MeleeDamageMult *= ::Const.Combat.DoubleGripDamageMult;
		}
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%positive%]+25%[/color] " + ::Legends.Text.inlineIcons("damage_dealt") + ", [color=%positive%]+" + ::Math.floor(this.getContainer().getActor().getCurrentProperties().MeleeSkill * 0.25) + "%[/color] " + ::Legends.Text.inlineIcons("direct_damage");
	}
});
