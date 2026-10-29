::mods_hookExactClass("items/weapons/named/named_rusty_warblade", function(o) {

	local create = o.create;
	o.create = function () {
		create();
		this.m.WeaponType = ::Const.Items.WeaponType.Cleaver;
		this.m.Condition = 66.0;
		this.m.ConditionMax = 66.0;
		this.m.StaminaModifier = -16;
		this.m.RegularDamage = 85;
		this.m.RegularDamageMax = 105;
		this.m.DirectDamageMult = 0.35;
		this.m.DirectDamageAdd = 0.1;
		this.m.ShieldDamage = 0;
		this.m.IsAgainstShields = false;
		this.m.Value = 4100;
	}

	o.randomizeValues <- function ()
	{
		this.m.Condition = 66.0;
		this.m.ConditionMax = 66.0;
		this.m.StaminaModifier = -16;
		this.m.RegularDamage = 85;
		this.m.RegularDamageMax = 105;
		this.m.DirectDamageMult = 0.35;
		this.m.DirectDamageAdd = 0.1;
		this.named_weapon.randomizeValues();
	}

	o.onEquip = function () {
		this.weapon.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendHew, function (_skill) {
			_skill.m.Icon = "skills/active_182.png";
			_skill.m.IconDisabled = "skills/active_182_sw.png";
			_skill.m.Overlay = "active_182";
		}.bindenv(this));
		::Legends.Actives.grant(this, ::Legends.Active.LegendHarvest);
		::Legends.Actives.grant(this, ::Legends.Active.LegendExsanguinate);
	}
});
