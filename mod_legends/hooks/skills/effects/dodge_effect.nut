::mods_hookExactClass("skills/effects/dodge_effect", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.IsRemovedAfterBattle = false;
		this.m.IsSerialized = false;
	}

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

	o.getBonus <- function() {
		local actor = this.getContainer().getActor()
		local mult = 0.15
		local hp50Diff = this.Math.abs(actor.getHitpointsMax() - 50.0)
		local cappedDiff = this.Math.min(hp50Diff, 50.0)

		mult += (1.0 - cappedDiff / 50.0) * 0.15

		return this.Math.floor(actor.getInitiative() * mult)
	}
	
	
});
