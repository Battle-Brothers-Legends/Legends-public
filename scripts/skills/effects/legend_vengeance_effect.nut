this.legend_vengeance_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendVengeance);
		this.m.Icon = "ui/perks/vengeance_circle.png";
		this.m.IconMini = "mini_vengeance";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "Having just received a blow, this character is determined to fight even harder! The next attack will inflict double damage to a single target. If multiple targets are hit, only the first one will receive increased damage. If the attack misses, the effect is wasted.";
	}

	function onUpdate( _properties )
	{
		_properties.DamageTotalMult *= 2.0;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_targetEntity == null)
		{
			return;
		}

		local actor = this.getContainer().getActor();

		if (_targetEntity == actor)
		{
			return;
		}

		if (!this.m.IsGarbage && !_targetEntity.isAlliedWith(actor))
		{
			this.removeSelf();
		}
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		this.removeSelf();
	}

});

