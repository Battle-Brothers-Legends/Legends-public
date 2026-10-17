this.legend_apothecary_mushrooms_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Stacks = 4,
		TurnsLeft = 4
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendApothecaryMushrooms);
		this.m.Description = "I can see infinity! This character is in a mushroom-induced trance and seems to barely be tied to reality. They move gracefully, avoiding attacks and barely feeling pain, but seem hesitant to hurt anything or anyone.";
		this.m.SoundOnUse = ::Legends.S.setSounds("sounds/combat/rage", 2);
		this.m.Type = ::Const.SkillType.StatusEffect | ::Const.SkillType.DrugEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=%negative%]-" + 10 * this.m.Stacks + "%[/color] Damage in Melee"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=%positive%]+" + 10 * this.m.Stacks + "%[/color] Melee Defense"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%positive%]+" + 10 * this.m.Stacks + "%[/color] Ranged Defense"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/morale.png",
				text = "No morale check triggered upon losing hitpoints"
			}
		]);
		return tooltip;
	}

	function resetTime() {
		this.m.TurnsLeft = 4;
		this.m.Stacks = this.m.TurnsLeft;
	}

	function onUpdate(_properties) {
		_properties.MeleeDefenseMult *= 1.0 + 0.1 * this.m.Stacks;
		_properties.RangedDefenseMult *= 1.0 + 0.1 * this.m.Stacks;
	}

	function onAnySkillUsed(_skill, _targetEntity, _properties) {
		if (_skill.isAttack() && !_skill.isRanged()) {
			_properties.DamageTotalMult *= 1.0 - 0.1 * this.m.Stacks;
		}
	}

	function onTurnEnd() {
		this.m.TurnsLeft--;
		this.m.Stacks = this.m.TurnsLeft;
		if (this.m.TurnsLeft <= 0) {
			this.applySideEffects();
			this.removeSelf();
		}
	}

	function onTargetHit(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor) {
		::Sound.play(this.m.SoundOnUse[::Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.Actor, this.getContainer().getActor().getPos(), ::Math.rand(100, 115) * 0.01 * this.getContainer().getActor().getSoundPitch());
	}

	function onTargetMissed(_skill, _targetEntity) {
		::Sound.play(this.m.SoundOnUse[::Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.Actor, this.getContainer().getActor().getPos(), ::Math.rand(100, 115) * 0.01 * this.getContainer().getActor().getSoundPitch());
	}

	function onCombatFinished() {
		this.applySideEffects();
		this.skill.onCombatFinished();
	}

	function applySideEffects() {
		local chance = 20;
		local bro = this.getContainer().getActor();

		if (::Legends.Backgrounds.has(bro, ::Legends.Background.Wildman)) {
			chance -= 10;
		}

		if (bro.getSkills().hasTrait(::Legends.Trait.Strong)) {
			chance -= 10;
		}

		if (bro.getSkills().hasTrait(::Legends.Trait.Tough)) {
			chance -= 10;
		}

		if (bro.getSkills().hasTrait(::Legends.Trait.Athletic)) {
			chance -= 10;
		}

		if (bro.getSkills().hasTrait(::Legends.Trait.Survivor)) {
			chance -= 10;
		}

		if (bro.getSkills().hasTrait(::Legends.Trait.Fragile)) {
			chance = chance + 10;
		}

		if (bro.getSkills().hasTrait(::Legends.Trait.Gluttonous)) {
			chance = chance + 10;
		}

		if (bro.getSkills().hasTrait(::Legends.Trait.Old)) {
			chance = chance + 10;
		}

		if (bro.getSkills().hasTrait(::Legends.Trait.Spartan)) {
			chance = chance + 10;
		}

		if (bro.getSkills().hasTrait(::Legends.Trait.Tiny)) {
			chance = chance + 10;
		}

		if (bro.getSkills().hasTrait(::Legends.Trait.Huge)) {
			chance -= 10;
		}

		if (bro.getSkills().hasTrait(::Legends.Trait.Ailing)) {
			chance += 10;
		}

		if (bro.getSkills().hasTrait(::Legends.Trait.Lucky)) {
			chance -= 10;
		}

		if (::Math.rand(1, 100) <= ::Math.max(5, chance)) {
			this.getContainer().getActor().getSkills().add(::new("scripts/skills/injury/sickness_injury"));
			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " is now sick");
		}
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%negative%]-" + (10 * this.m.Stacks) + "%[/color] Melee " + ::Legends.S.inlineIcon("damage_dealt") + ", " + "[color=%positive%]+" + (10 * this.m.Stacks) + "[/color] " + ::Legends.S.inlineIcon("melee_defense") + ::Legends.S.inlineIcon("ranged_defense") + ", no morale check upon losing HP";
	}
});
