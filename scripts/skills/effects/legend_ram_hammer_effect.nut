this.legend_ram_hammer_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Stacks = 0
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendRamHammer);
		this.m.Description = "This character is being bolstered by the Ram Hammer upon successful consecutive hits.";
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
		return [
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
				id = 11,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "Grants[color=%positive%]+" + (50 * this.m.Stacks) + "%[/color] Damage."
			},
			// hiding this part as regularly weapon effects are hidden, instead the effect will show the stacking part only
			/*{
				id = 12,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Grants[color=%positive%]Hammer Specialization[/color] when equipped."
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Grants[color=%positive%]Disarm immunity[/color] when equipped."
			}*/
		];
	}

	function onAnySkillUsed(_skill, _targetEntity, _properties) {
		if (_skill.IsWeaponSkill) {
			_properties.DamageTotalMult *= 1.0 + (0.5 * this.m.Stacks);
		}
	}

	function onTargetMissed(_skill, _targetEntity) {
		if (_targetEntity == null || !_targetEntity.isAttackable() || !_skill.isAttack()) {
			return;
		}

		this.m.Stacks = 0;
	}

	function onTargetHit(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor) {
		if (_skill.isAttack() && _skill.IsWeaponSkill) {
			// still needs to check for instance? or is it supposed to stack faster on AoE?
			this.m.Stacks += 1;
		}
	}

	function onCombatStarted() {
		this.m.Stacks = 0;
	}

	function onCombatFinished() {
		this.m.Stacks = 0;
	}

	function onTurnEnd() {
		this.m.Stacks = 0;
	}

	function onUpdate(_properties) {
		_properties.IsSpecializedInHammers = true;
		_properties.IsImmuneToDisarm = true;
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%positive%]+" + 50 * this.m.Stacks + "%[/color] " + ::Legends.S.inlineIcon("damage_dealt");
	}
});
