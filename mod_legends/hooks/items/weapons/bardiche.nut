::mods_hookExactClass("items/weapons/bardiche", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.IsAoE = true;
		this.setVariant(this.Math.rand(0, 2));
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/bardiche_01" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/bardiche_01" + v + ".png";
		this.m.ArmamentIcon = "icon_bardiche_01" + v;
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
