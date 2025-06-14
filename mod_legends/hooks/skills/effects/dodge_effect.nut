::mods_hookExactClass("skills/effects/dodge_effect", function(o) {

	o.getTooltip = function ()
	{
		local bonus = this.getBonus();
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
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + bonus + "[/color] Melee Defense"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + bonus + "[/color] Ranged Defense"
			}
		];
	}

	o.onAfterUpdate = function( _properties )
	{
		_properties.MeleeDefense += this.getBonus();
		_properties.RangedDefense += this.getBonus();
	}

	o.getBonus <- function()
	{
		local actor = this.getContainer().getActor();
		local baseBonus = this.Math.floor(this.Math.min(50, 100 - actor.getHitpointsMax()) * 0.30);
		return this.Math.floor(actor.getInitiative() * (baseBonus * 0.01 + 0.15));
	}
});