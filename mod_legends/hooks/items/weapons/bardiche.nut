::mods_hookExactClass("items/weapons/bardiche", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.IsAoE = true;
		this.m.Variant = this.Math.rand(1, 2);
		this.updateVariant();
	}

	o.updateVariant <- function ()
	{
		this.m.IconLarge = "weapons/melee/bardiche_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/bardiche_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_bardiche_0" + this.m.Variant;
	}

	o.addSkill <- function( _skill )
	{
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.SplitShield))
		{
			::Legends.Actives.grant(this.weapon, ::Legends.Active.Swing, function (_skill) {
				_skill.setApplyAxeMastery(true);
			}.bindenv(this));
			::Legends.Actives.grant(this.weapon, ::Legends.Active.SplitShield);
			return;
		}

		weapon.addSkill(_skill);
	}
});
