::mods_hookExactClass("items/shields/buckler_shield", function (o) {
	o.m.PrimaryOffhandAttack <- null;

	local create = o.create;
	o.create = function () {
		create();
		this.m.MeleeDefense = 5;
		this.m.Block = 5;
		this.m.RegularDamage = 5;
		this.m.RegularDamageMax = 10;
		this.m.Value = 85;
	}

	o.addSkill <- function (_skill) {
		if (_skill.getID() == ::Legends.Actives.getID(::Legends.Active.KnockBack)) {
			::Legends.Actives.grant(this, ::Legends.Active.LegendBucklerBash);
			return;
		}

		this.shield.addSkill(_skill);
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

	local onEquip = o.onEquip;
	o.onEquip = function () {
		onEquip();
		::Legends.Effects.grant(this.getContainer().getActor(), ::Legends.Effect.LegendBucklerDefense);
	}

	o.onUnequip <- function () {
		this.shield.onUnequip();
		::Legends.Effects.remove(this.getContainer().getActor(), ::Legends.Effect.LegendBucklerDefense);
	}
});
