this.legend_prepare_bullet_effect <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendPrepareBullet);
		this.m.Description = "This character is preparing a shot with a sling, increasing velocity and damage.";
	}

	function getTooltip() {
		local bonus = this.getBonus();
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
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=%positive%]+" + bonus + "[/color] Ranged Damage"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/direct_damage.png",
				text = "[color=%positive%]" + bonus + "%[/color] Armor Penetration"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "[color=%positive%]+1[/color] Sling Stone range"
			},
			{
				id = 14,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "Switching your weapon or receiving damage will remove this effect"
			}
		];
		return ret;
	}

	function getBonus() {
		return this.getContainer().getActor().getCurrentProperties().Initiative * 0.1;
	}

	function onUpdate(_properties) {
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || !weapon.isWeaponType(::Const.Items.WeaponType.Sling) || !weapon.isItemType(::Const.Items.ItemType.OneHanded)) {
			this.removeSelf();
		}
	}

	function onTargetHit(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor) {
		this.removeSelf();
	}

	function onTargetMissed(_skill, _targetEntity) {
		this.removeSelf();
	}

	function onDamageReceived(_attacker, _damageHitpoints, _damageArmor) {
		this.removeSelf();
	}

	function onAnySkillUsed(_skill, _targetEntity, _properties) {
		if (_skill.isGarbage() || _skill.getID() != ::Legends.Actives.getID(::Legends.Active.SlingStone)) {
			return;
		}
		local bonus = this.getBonus();
		_properties.DamageRegularMin += bonus;
		_properties.DamageRegularMax += bonus;
		_properties.DamageDirectAdd += bonus * 0.01;
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		local bonus = this.getBonus();
		return "[color=%positive%]+" + bonus + "[/color] " + ::Legends.S.inlineIcon("regular_damage") + ", [color=%positive%]+" + bonus + "%[/color] " + ::Legends.S.inlineIcon("direct_damage") + ", [color=%positive%]+1%[/color] Sling Stone range";
	}
});
