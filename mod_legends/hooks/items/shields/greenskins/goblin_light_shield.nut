::mods_hookExactClass("items/shields/greenskins/goblin_light_shield", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Variants = [1, 2];
		this.m.Variant = this.m.Variants[::Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.MeleeDefense = 4;
		this.m.RangedDefense = 8;
		this.m.Block = 4;
		this.m.RegularDamage = 5;
		this.m.RegularDamageMax = 10;
		this.m.Condition = 14;
		this.m.ConditionMax = 14;
		this.m.Value = 65;
	}

	o.getTooltip <- function () {
		local tooltip = this.shield.getTooltip();
		tooltip.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Gain [color=%positive%]5%[/color] of Initiative as Melee Defense, Ranged Defense and Block"
		});
		return tooltip;
	}

	o.onEquip = function () {
		this.shield.onEquip();
		::Legends.Actives.grant(this, ::Legends.Active.LegendBucklerBash);
		::Legends.Effects.grant(this.getContainer().getActor(), ::Legends.Effect.LegendBucklerDefense);
	}

	o.onUnequip <- function () {
		this.shield.onUnequip();
		::Legends.Effects.remove(this.getContainer().getActor(), ::Legends.Effect.LegendBucklerDefense);
	}
});
