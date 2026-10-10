::mods_hookExactClass("skills/actives/ignite_firelance_skill", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		this.m.HitChanceBonus = 40;
	}

	o.getTooltip = function () {
		local tooltip = this.getDefaultTooltip();

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Can hit up to 2 targets"
		});
		local ammo = this.getAmmo();

		if (ammo > 0) {
			tooltip.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Has [color=%positive%]%_ammo%[/color] charge left",
				param = [["_ammo", ammo]]
			});
		}
		else {
			tooltip.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]No charges left[/color]"
			});
		}

		return tooltip;
	}
});
