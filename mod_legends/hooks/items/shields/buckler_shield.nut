::mods_hookExactClass("items/shields/buckler_shield", function(o) {
	o.m.PrimaryOffhandAttack <- null;

	local create = o.create;
	o.create = function () {
		create();
		this.m.Description += " Gains [color=%positive%]5%[/color] of Initiative as Melee Defense, Ranged Defense and Block.";
		this.m.MeleeDefense = 5;
		this.m.Block = 10;
		this.m.RegularDamage = 5;
		this.m.RegularDamage = 10;
	}

	o.addSkill <- function( _skill ) {
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.KnockBack))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendBucklerBash);
			return;
		}

		shield.addSkill(_skill);
	}

	local onEquip = o.onEquip;
	o.onEquip = function () {
		onEquip();
		::Legends.Effects.grant(this, ::Legends.Effect.LegendBuckler, function(_effect) {
			_effect.m.Order = this.Const.SkillOrder.UtilityTargeted + 1;
			_effect.setItem(this);
			this.m.SkillPtrs.push(_effect);
		}.bindenv(this));
	}
});
