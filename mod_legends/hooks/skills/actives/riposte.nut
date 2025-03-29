::mods_hookExactClass("skills/actives/riposte", function(o)
{
	o.isUsable = function ()
	{
		return !this.m.IsSpent && this.skill.isUsable() && !this.getContainer().hasEffect(::Legends.Effect.Riposte);
	}

	o.onAfterUpdate = function ( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInSwords ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}
});
