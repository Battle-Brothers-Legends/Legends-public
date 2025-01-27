this.legend_RSW_bleeding <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effects.LegendRswBleeding);
		this.m.Description = "Rune Sigil: Bleeding";
		this.m.Icon = "ui/rune_sigils/legend_rune_sigil.png";
		this.m.Type = this.Const.SkillType.Special | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (this.getItem() == null)
		{
			return;
		}

		local actor = this.getContainer().getActor();

		if (!actor.isAlive() || actor.isDying())
		{
			return;
		}

		if (!_targetEntity.isAlive() || _targetEntity.isDying())
		{
			return;
		}

		if (!_targetEntity.getCurrentProperties().IsImmuneToBleeding)
		{
			::Legends.Effects.grant(_targetEntity, ::Legends.Effect.LegendRswBleedingEffect, function (_effect) {
				_effect.setActor(this.getContainer().getActor());
				_effect.setStats(this.getItem().getRuneBonus1(), this.getItem().getRuneBonus2());
			});

			if (!_targetEntity.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_targetEntity) + " is bleeding.");
			}
		}
	}
});
