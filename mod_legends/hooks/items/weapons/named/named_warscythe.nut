::mods_hookExactClass("items/weapons/named/named_warscythe", function(o) {

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1,2,3];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() -1)];
		this.updateVariant();
		this.m.WeaponType = this.Const.Items.WeaponType.Cleaver | this.Const.Items.WeaponType.Polearm;
		this.setCategories("Cleaver/Polearm, Two-Handed");
	}

	o.addSkill <- function( _skill )
	{
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.Strike))
		{
			::Legends.Actives.grant(this.weapon, ::Legends.Active.LegendScytheCleave); // replace strike with scythe cleave
			return;
		}

		weapon.addSkill(_skill);
	}
});
