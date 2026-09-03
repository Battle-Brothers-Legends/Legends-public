::mods_hookExactClass("items/shields/ancient/coffin_shield", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Variants = [
			1,
			2,
			3,
			4
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.m.MeleeDefense = 15;
		this.m.RangedDefense = 20;
		this.m.Condition = 36;
		this.m.ConditionMax = 36;
		this.m.Block = 25;
		this.m.RegularDamage = 10;
		this.m.RegularDamage = 25;
	}

	o.getTooltip <- function () {
		local result = this.shield.getTooltip();
		result.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Reduces any ranged damage taken by [color=%negative%]15%[/color]"
		});
		return result;
	}

	o.onUpdateProperties <- function (_properties) {
		this.shield.onUpdateProperties(_properties);
		_properties.DamageReceivedRangedMult *= 0.85;
	}

	o.onEquip = function () {
		this.shield.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.Shieldwall, function (_skill) {
			_skill.m.Icon = "skills/fortify_square.png";
			_skill.m.IconDisabled = "skills/fortify_square_bw.png";
		});
		::Legends.Actives.grant(this, ::Legends.Active.LegendSafeguard);
	}
});
