::mods_hookExactClass("items/weapons/named/named_exesword", function(o) {

	local create = o.create;
	o.create = function () {
		create();
		this.m.WeaponType = ::Const.Items.WeaponType.Cleaver;
		this.m.Categories = "Cleaver, Two-Handed";
		this.m.IsAgainstShields = false;
		this.m.Value = 4500;
		this.m.Variants = [1, 2];
		this.setVariant(this.m.Variants[::Math.rand(0, this.m.Variants.len() - 1)]);
	}

	o.randomizeValues <- function ()
	{
		this.m.StaminaModifier = -18;
		this.m.ArmorDamageMult = 1.2;
		this.m.ShieldDamage = 0;
		named_weapon.randomizeValues();
	}

	o.onEquip = function () {
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendHew, function (_skill) {
			_skill.m.Icon = "skills/active_239.png";
			_skill.m.IconDisabled = "skills/active_239_sw.png";
			_skill.m.Overlay = "active_239";
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.LegendHarvest);
		::Legends.Actives.grant(this, ::Legends.Active.Decapitate, function (_skill) {
			_skill.m.IsTwoHand = true;
		}.bindenv(this));
	}
});
