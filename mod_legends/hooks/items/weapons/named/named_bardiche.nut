::mods_hookExactClass("items/weapons/named/named_bardiche", function(o) {

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1, 2, 3, 4, 5];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
	}

	o.addSkill <- function( _skill )
	{
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.SplitShield))
		{
			::Legends.Actives.grant(this.weapon, ::Legends.Active.Swing, function (_skill) {
				_skill.setApplyAxeMastery(true);
			}.bindenv(this));
			::Legends.Actives.grant(this.weapon, ::Legends.Active.SplitShield, function (_skill) {
				_skill.setApplyAxeMastery(true);
				_skill.setFatigueCost(_skill.getFatigueCostRaw() + 5);
			}.bindenv(this));
			return;
		}

		this.weapon.addSkill(_skill);
	}
});
