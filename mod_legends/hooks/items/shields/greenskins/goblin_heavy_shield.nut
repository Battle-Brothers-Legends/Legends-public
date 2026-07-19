::mods_hookExactClass("items/shields/greenskins/goblin_heavy_shield", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [
			1,
			2
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.m.MeleeDefense = 5;
		this.m.RangedDefense = 10;
		this.m.Block = 10;
		this.m.RegularDamage = 5;
		this.m.RegularDamage = 10;
		this.m.Condition = 18;
		this.m.ConditionMax = 18;
	}

	o.onEquip = function () {
		::Legends.Actives.grant(this, ::Legends.Active.LegendBucklerBash);
		::Legends.Effects.grant(this, ::Legends.Effect.LegendBuckler, function(_effect) {
			_effect.m.Order = this.Const.SkillOrder.UtilityTargeted + 1;
			_effect.setItem(this);
			this.m.SkillPtrs.push(_effect);
		}.bindenv(this));
	}
});
