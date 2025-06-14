::mods_hookExactClass("skills/actives/disarm_skill", function(o)
{
	o.onAfterUpdate = function ( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInCleavers ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers)
		{
			this.m.HitChanceBonus += 10;
		}
	}
});
