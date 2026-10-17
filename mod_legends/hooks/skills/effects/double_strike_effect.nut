::mods_hookExactClass("skills/effects/double_strike_effect", function (o) {
	o.m.DamageBonus <- 25;
	o.m.TurnsLeft <- 1;

	local create = o.create;
	o.create = function () {
		create();
		::Legends.Effects.onCreate(this, ::Legends.Effect.DoubleStrike);
	}

	o.getDescription = function () {
		return "Having just landed a hit, this character is motivated to do even more harm!";
	}

	o.getTooltip <- function () {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 3,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "Deal [color=%positive%]" + this.m.DamageBonus + "%[/color] more Damage"
			},
			{
				id = 4,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Recover [color=%positive%]1-2[/color] Fatigue per hit"
			}
		]);
		return tooltip;
	}

	o.onAdded = function () {}

	o.onAnySkillUsed = function (_skill, _targetEntity, _properties) {}

	o.onUpdate <- function (_properties) {
		local actor = this.getContainer().getActor();
		this.m.DamageBonus = 25;
		if (::Legends.Weapons.isDualWieldingWeaponType(actor, ::Const.Items.WeaponType.Dagger)) {
			this.m.DamageBonus = 35;
		}
		_properties.DamageTotalMult *= 1.0 + this.m.DamageBonus * 0.01;
	}

	o.onTurnEnd <- function () {
		this.removeSelf();
	}

	o.onTargetHit <- function (_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor) {
		local actor = this.getContainer().getActor();
		if (!::Legends.S.isEntityNullOrDead(actor)) {
			actor.setFatigue(::Math.max(0, actor.getFatigue() - ::Math.rand(1, 2)));
			actor.setDirty(true);
		}
	}

	o.onTargetMissed <- function (_skill, _targetEntity) {
		this.removeSelf();
		local actor = _skill.getContainer().getActor();
		if (!::Legends.S.isEntityNullOrDead(actor)) {
			actor.setDirty(true);
		}
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%positive%]" + this.m.DamageBonus + "[/color] " + ::Legends.S.inlineIcon("damage_dealt") + ", [color=%positive%]1-2[/color] " + ::Legends.S.inlineIcon("fatigue") + " per hit";
	}
});
