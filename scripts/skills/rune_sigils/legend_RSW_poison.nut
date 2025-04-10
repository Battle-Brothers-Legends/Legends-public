this.legend_RSW_poison <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendRswPoison);
		this.m.Description = "Rune Sigil: Poison";
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

		if (_targetEntity.getFlags().has("undead"))
		{
			return;
		}

		if (_targetEntity.getCurrentProperties().IsImmuneToPoison || _targetEntity.getHitpoints() <= 0)
		{
			return;
		}

		if (!_targetEntity.isHiddenToPlayer())
		{
			local poisonSound = [
				"sounds/combat/poison_applied_01.wav",
				"sounds/combat/poison_applied_02.wav"
			];

			this.Sound.play(poisonSound[this.Math.rand(0, poisonSound.len() - 1)], this.Const.Sound.Volume.Actor, _targetEntity.getPos());
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_targetEntity) + " is poisoned.");
		}

		local runePoison = ::Legends.Effects.get(_targetEntity, ::Legends.Effect.LegendRswPoisonEffect);
		local gobboPoison = ::Legends.Effects.get(_targetEntity, ::Legends.Effect.GoblinPoison);

		if (runePoison == null && gobboPoison == null)
		{
			::Legends.Effects.grant(_targetEntity, ::Legends.Effect.LegendRswPoisonEffect, function (_effect) {
				_effect.setStats(this.getItem().getRuneBonus1(), this.getItem().getRuneBonus2());
			}.bindenv(this));
		}
		else if (runePoison != null && gobboPoison == null)
		{
			runePoison.setStats(this.getItem().getRuneBonus1(), this.getItem().getRuneBonus2());
			runePoison.resetTime();
		}
		else if (runePoison == null && gobboPoison != null)
		{
			gobboPoison.resetTime();
		}
	}
});
