this.legend_RSW_feeding <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendRswFeeding);
		this.m.Description = "Rune Sigil: Feeding";
		this.m.Icon = "ui/rune_sigils/legend_rune_sigil.png";
		this.m.Type = this.Const.SkillType.Special | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_damageInflictedHitpoints <= 0)
		{
			return;
		}

		if (this.getItem() == null)
		{
			return;
		}

		local drain = this.getItem().getRuneBonus1() / 100.0;
		local actor = this.getContainer().getActor();
		actor.setFatigue(this.Math.max(0, actor.getFatigue() - this.Math.ceil(_damageInflictedHitpoints * drain)));
		this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " recovers " + this.Math.ceil(_damageInflictedHitpoints * drain) + " fatigue.");
	}
});
