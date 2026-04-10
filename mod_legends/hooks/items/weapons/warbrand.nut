::mods_hookExactClass("items/weapons/warbrand", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.Value = 1700;
		this.m.Variants = [0, 1, 2];
		this.setVariant(this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/melee/warbrand_01" + v + "_70x70.png";
		this.m.IconLarge = "weapons/melee/warbrand_01" + v + ".png";
		this.m.ArmamentIcon = "icon_scythe_01" + v;
	}

	o.addSkill <- function( _skill )
	{
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.Slash))
			_skill.m.IsGreatBreachSlash = true;

		this.weapon.addSkill(_skill);
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendIntoTheFray);
	}
});
