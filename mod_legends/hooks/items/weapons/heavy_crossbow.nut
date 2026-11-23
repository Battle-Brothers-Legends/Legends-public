::mods_hookExactClass("items/weapons/heavy_crossbow", function(o) {

	local create = o.create;
	o.create = function() {
		create();
		this.m.RangeMax = 6;
		this.m.RangeIdeal = 6;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Defensive | this.Const.Items.ItemType.TwoHanded;
		this.m.Variants = [0, 1, 2];
		this.setVariant(this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.updateVariant <- function() {
		local v = this.getVariant() == 0 ? "" : "_" + this.getVariant();
		this.m.Icon = "weapons/ranged/crossbow_03" + v + "_70x70.png";
		this.m.IconLarge = "weapons/ranged/crossbow_03" + v + ".png";
		this.m.ArmamentIcon = "icon_crossbow_03" + v;
	}

	o.addSkill <- function( _skill )
	{
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.ShootStake))
		{
			::Legends.Actives.grant(this.weapon, ::Legends.Active.ShootStake, function (_skill)
			{
				_skill.m.Name = "Shoot Heavy Bolt";
			}.bindenv(this));
			return;
		}

		this.weapon.addSkill(_skill);
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendPiercingBolt);
		::Legends.Actives.grant(this, ::Legends.Active.LegendStrafingRun);
		::Legends.Actives.grant(this, ::Legends.Active.ReloadBolt);
		::Legends.Actives.grant(this, ::Legends.Active.KnockOut, function (_skill) {
			_skill.m.IsRangedKnockOut = true;
		}.bindenv(this));
	}

	o.onCombatFinished = function ()
	{
		this.weapon.onCombatFinished();
		this.setLoaded(true);
	}
});
