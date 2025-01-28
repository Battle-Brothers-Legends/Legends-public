::mods_hookExactClass("skills/actives/root_skill", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Unleash roots from the ground to ensnare your foes. Fatigue and AP costs reduced while raining and with staff mastery. ";
		this.m.Icon = "skills/roots_square.png";
		this.m.IconDisabled = "skills/roots_square_bw.png"
	}

	o.onAfterUpdate <- function ( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInStaves ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
		this.m.ActionPointCost = _properties.IsSpecializedInStaves ? 5 : 6;

		if (this.getContainer().hasEffect(::Legends.Effect.LegendRain))
		{
			this.m.FatigueCost -= 10;
			this.m.ActionPointCost -= 1;
		}

	}

	o.isUsable <- function ()
	{
		return this.skill.isUsable() && !this.getContainer().getActor().isEngagedInMelee();
	}

});
