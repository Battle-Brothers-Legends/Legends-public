::mods_hookExactClass("skills/effects/double_strike_effect", function(o) {

	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Icon = "skills/status_effect_doublestrike.png";
		this.m.IconMini = "mini_doublestrike_circle";
	}

	o.getDescription = function()
	{
		return "Having just landed a hit, this character is ready to perform a powerful follow-up strike! The next attack will inflict [color=%positive%]20%[/color] damage to a single target and refund [color=%negative%]20%[/color] of the fatigue cost. If the attack misses, the effect is wasted, but the fatigue cost will be refunded.";
	}

	o.onAdded = function()
	{
	}

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		if (!_skill.isAttack())
			return;

		if (_targetEntity == null || !_targetEntity.isAttackable())
			return;

		if (!this.m.IsGarbage && this.m.TimeAdded + 0.1 < this.Time.getVirtualTimeF() && !_targetEntity.isAlliedWith(this.getContainer().getActor()))
		{
			local actor = this.getContainer().getActor();
			actor.setFatigue(this.Math.max(0, actor.getFatigue() - this.Math.floor(_skill.getFatigueCost() * 0.2)));
			_properties.DamageTotalMult *= 1.25;
			this.removeSelf();
		}
	}

	o.onTurnEnd <- function()
	{
		this.removeSelf();
	}

	o.onTargetMissed <- function( _skill, _targetEntity )
	{
		this.removeSelf();
	}
});
