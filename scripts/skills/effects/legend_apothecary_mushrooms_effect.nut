this.legend_apothecary_mushrooms_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 4
	},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendApothecaryMushrooms);
		this.m.Icon = "skills/status_effect_67.png";
		this.m.IconMini = "status_effect_67_mini";
		this.m.SoundOnUse = [
			"sounds/combat/rage_01.wav",
			"sounds/combat/rage_02.wav"
		];
		this.m.Type = this.Const.SkillType.StatusEffect | this.Const.SkillType.DrugEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "I can see infinity! This character is in a mushroom-induced trance and seems to barely be tied to reality. They move gracefully, avoiding attacks and barely feeling pain, but seem hesitant to hurt anything or anyone. The effect will slowly wear off over [color=%negative%]" + this.m.TurnsLeft + "[/color] more turn(s).";
	}

	function getTooltip()
	{
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
				id = 10,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=%negative%]-" + 10 * this.m.TurnsLeft + "%[/color] Damage in Melee"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=%positive%]+" + 10 * this.m.TurnsLeft + "%[/color] Melee Defense"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%positive%]+" + 10 * this.m.TurnsLeft + "%[/color] Ranged Defense"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/morale.png",
				text = "No morale check triggered upon losing hitpoints"
			}
		];
	}

	function resetTime()
	{
		this.m.TurnsLeft = 4;
	}

	function onUpdate( _properties )
	{
		_properties.MeleeDefenseMult *= 1.0 + 0.1 * this.m.TurnsLeft;
		_properties.RangedDefenseMult *= 1.0 + 0.1 * this.m.TurnsLeft;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.isAttack() && !_skill.isRanged())
		{
			_properties.DamageTotalMult *= 1.0 - 0.1 * this.m.TurnsLeft;
		}
	}

	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.applySideEffects();
			this.removeSelf();
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.Actor, this.getContainer().getActor().getPos(), this.Math.rand(100, 115) * 0.01 * this.getContainer().getActor().getSoundPitch());
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.Actor, this.getContainer().getActor().getPos(), this.Math.rand(100, 115) * 0.01 * this.getContainer().getActor().getSoundPitch());
	}

	function onCombatFinished()
	{
		this.applySideEffects();
		this.skill.onCombatFinished();
	}

	function applySideEffects()
	{
		local chance = 20;
		local bro = this.getContainer().getActor();

		if (bro.getBackground() != null && bro.getBackground().getID() == "background.wildman")
		{
			chance = chance - 10;
		}

		if (bro.getSkills().hasTrait(::Legends.Trait.Strong))
		{
			chance = chance - 10;
		}

		if (bro.getSkills().hasTrait(::Legends.Trait.Tough))
		{
			chance = chance - 10;
		}

		if (bro.getSkills().hasTrait(::Legends.Trait.Athletic))
		{
			chance = chance - 10;
		}

		if (bro.getSkills().hasTrait(::Legends.Trait.Survivor))
		{
			chance = chance - 10;
		}

		if (bro.getSkills().hasTrait(::Legends.Trait.Fragile))
		{
			chance = chance + 10;
		}

		if (bro.getSkills().hasTrait(::Legends.Trait.Gluttonous))
		{
			chance = chance + 10;
		}

		if (bro.getSkills().hasTrait(::Legends.Trait.Old))
		{
			chance = chance + 10;
		}

		if (bro.getSkills().hasTrait(::Legends.Trait.Spartan))
		{
			chance = chance + 10;
		}

		if (bro.getSkills().hasTrait(::Legends.Trait.Tiny))
		{
			chance = chance + 10;
		}

		if (bro.getSkills().hasTrait(::Legends.Trait.Huge))
		{
			chance = chance - 10;
		}

		if (bro.getSkills().hasTrait(::Legends.Trait.Ailing))
		{
			chance = chance + 10;
		}

		if (bro.getSkills().hasTrait(::Legends.Trait.Lucky))
		{
			chance = chance - 10;
		}

		if (this.Math.rand(1, 100) <= this.Math.max(5, chance))
		{
			local effect = this.new("scripts/skills/injury/sickness_injury");
			this.getContainer().getActor().getSkills().add(effect);
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " is now sick");
		}
	}

});

