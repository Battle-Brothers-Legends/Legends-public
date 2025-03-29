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
		return "Having just landed a hit, this character is ready to perform a powerful follow-up strike! The next attack will inflict [color=" + this.Const.UI.Color.PositiveValue + "]+20%[/color] damage to a single target. If the attack misses, the effect is wasted.";
	}

	o.onAdded = function()
	{
	}

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
	}

	o.onUpdate <- function( _properties )
	{
		_properties.DamageTotalMult *= 1.2;
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