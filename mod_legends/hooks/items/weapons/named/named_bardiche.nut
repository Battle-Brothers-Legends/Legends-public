::mods_hookExactClass("items/weapons/named/named_bardiche", function(o) {

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1, 2, 3, 4, 5];
		this.setVariant(this.m.Variants[::Math.rand(0, this.m.Variants.len() - 1)]);
	}

	// o.addSkill <- function( _skill )
	// {
	// 	if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.SplitShield))
	// 	{
	// 		::Legends.Actives.grant(this.weapon, ::Legends.Active.Swing);
	// 		::Legends.Actives.grant(this.weapon, ::Legends.Active.SplitShield, function (_skill) {
	// 			_skill.setApplyAxeMastery(true);
	// 			_skill.setFatigueCost(_skill.getFatigueCostRaw() + 5);
	// 		}.bindenv(this));
	// 		return;
	// 	}

	// 	this.weapon.addSkill(_skill);
	// }

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendHaftstrike);
	}
});
