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
				text = "[color=%positive%]+" + bonus + "[/color] Melee Defense"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%positive%]+" + bonus + "[/color] Ranged Defense"
			}
		];
	}

	o.onAfterUpdate = function( _properties )
	{
		_properties.MeleeDefense += this.getBonus();
		_properties.RangedDefense += this.getBonus();
	}

	o.getBonus <- function() {
		local actor = this.getContainer().getActor();
		local bonus = this.Math.maxf(1.0, this.Math.minf(2.0, 2.0 - (actor.getHitpointsMax().tofloat() - 50.0) / 50.0));
		return this.Math.floor(actor.getInitiative() * bonus * 0.15);
	}

});
