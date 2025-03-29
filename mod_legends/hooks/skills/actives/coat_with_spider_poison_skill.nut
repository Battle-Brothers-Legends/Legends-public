::mods_hookExactClass("skills/actives/coat_with_spider_poison_skill", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Description = "Coat your weapons and arrowtips with poison. Can not be used while engaged in melee. Costs 0 Action Points during the first round of combat.";
	}

	o.onAfterUpdate <- function ( _properties )
	{
		if (this.Time.getRound() == 1)
		{
			this.m.ActionPointCost = 0;
		}
	}
});
