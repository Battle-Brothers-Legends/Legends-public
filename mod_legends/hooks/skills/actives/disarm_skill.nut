::mods_hookExactClass("skills/actives/disarm_skill", function(o)
{
	o.getTooltip = function () {
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]100%[/color] chance to disarm on a hit"
		});
		return ret;
	}
/*
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.HitChanceBonus = -20;
	}

	o.onAfterUpdate = function ( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInCleavers ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers)
		{
			this.m.HitChanceBonus += 10;
		}
	}*/
});
