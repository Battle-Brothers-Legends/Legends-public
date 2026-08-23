::mods_hookExactClass("items/weapons/named/named_warbow", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [1, 2, 3, 4, 5];
		this.setVariant(this.m.Variants[::Math.rand(0, this.m.Variants.len() - 1)]);
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Defensive | this.Const.Items.ItemType.TwoHanded;
		this.m.RangeMax = 8;
		this.m.RangeIdeal = 8;
	}

	o.addSkill <- function( _skill )
	{
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.AimedShot))
		{
			::Legends.Actives.grant(this.weapon, ::Legends.Active.LegendFullDraw);
			return;
		}

		weapon.addSkill(_skill);
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		// ::Legends.Actives.grant(this, ::Legends.Active.LegendVolley);
	}
});
