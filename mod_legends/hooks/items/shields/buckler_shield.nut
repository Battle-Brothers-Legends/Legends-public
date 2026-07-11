::mods_hookExactClass("items/shields/buckler_shield", function(o) {
	o.m.PrimaryOffhandAttack <- null;

	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description += " Gains defense depending on how many enemies are within 1 tile.";
		this.m.MeleeDefense = 5;
	}

	local onEquip = o.onEquip;
	o.onEquip = function ()
	{
		onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendBucklerBash, function (_skill) {
			this.m.PrimaryOffhandAttack = ::MSU.asWeakTableRef(_skill);
		}.bindenv(this));
		::Legends.Effects.grant(this, ::Legends.Effect.LegendBuckler, function(_effect) {
			_effect.m.Order = this.Const.SkillOrder.UtilityTargeted + 1;
			_effect.setItem(this);
			this.m.SkillPtrs.push(_effect);
		}.bindenv(this));
	}

	o.onUnequip <- function()
	{
		this.shield.onUnequip();
		this.m.PrimaryOffhandAttack = null;
	}

	o.getPrimaryOffhandAttack <- function()
	{
		return this.m.PrimaryOffhandAttack;
	}
});
