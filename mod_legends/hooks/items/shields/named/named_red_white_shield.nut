::mods_hookExactClass("items/shields/named/named_red_white_shield", function(o) {
	o.randomizeValues <- function ()
	{
		this.m.MeleeDefense = 25;
		this.m.RangedDefense = 25;
		this.m.StaminaModifier = -20;
		this.m.Condition = 96;
		this.m.ConditionMax = 96;
		this.m.Block = 30;
		this.m.RegularDamage = 10;
		this.m.RegularDamage = 25;
		this.m.Value = 1400;
		this.named_shield.randomizeValues();
	}

	o.onEquip = function () {
		this.named_shield.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Shieldwall, function (_skill) {
			_skill.m.Icon = "skills/fortify_square.png";
			_skill.m.IconDisabled = "skills/fortify_square_bw.png";
		});
		::Legends.Actives.grant(this, ::Legends.Active.LegendSafeguard);
	}
});
