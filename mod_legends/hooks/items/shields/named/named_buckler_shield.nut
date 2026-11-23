::mods_hookExactClass("items/shields/named/named_buckler_shield", function (o) {
	o.m.PrimaryOffhandAttack <- null;

	local create = o.create;
	o.create <- function () {
		create();
		this.m.Description += " Gains defense depending on how many enemies are within 1 tile.";
		this.m.Variants = [1];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
	}

	o.addSkill <- function( _skill )
	{
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.KnockBack))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendBucklerBash, function (_skill) {
				this.m.PrimaryOffhandAttack = ::MSU.asWeakTableRef(_skill);
			}.bindenv(this));
			return;
		}

		shield.addSkill(_skill);
	}

	local onEquip = o.onEquip;
	o.onEquip = function () {
		onEquip();
		::Legends.Effects.grant(this, ::Legends.Effect.LegendBuckler, function (_effect) {
			_effect.m.Order = this.Const.SkillOrder.UtilityTargeted + 1;
			_effect.setItem(this);
			this.m.SkillPtrs.push(_effect);
		}.bindenv(this));
	}

	o.onUnequip <- function () {
		this.shield.onUnequip();
		this.m.PrimaryOffhandAttack = null;
	}

	o.getPrimaryOffhandAttack <- function () {
		return this.m.PrimaryOffhandAttack;
	}
});
