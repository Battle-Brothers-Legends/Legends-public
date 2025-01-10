::mods_hookExactClass("skills/effects/debilitated_effect", function(o) {
	o.m.TurnsLeft <- 3;

	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Description = "This character has been debilitated";
	}

	o.getDescription <- function()
	{
		return "This character is debilitated and will only do [color=" + this.Const.UI.Color.NegativeValue + "] 75% [/color] damage and take [color=" + this.Const.UI.Color.NegativeValue + "] 115% [/color] damage for [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color] more turn(s).";
	}

	o.onAdded <- function()
	{
		this.m.TurnsLeft = this.Math.max(1, 3 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);

		if (this.getContainer().hasTrait(::Legends.Trait.Ailing))
		{
			++this.m.TurnsLeft;
		}
	}

	o.onUpdate = function( _properties )
	{
		_properties.DamageTotalMult *= 0.75;
		_properties.DamageReceivedTotalMult *= 1.15;
	}

	o.onTurnEnd = function()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}
});