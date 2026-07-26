this.legend_throw_backup_spear_skill <- this.inherit("scripts/skills/actives/throw_javelin", {
	m = {}
	function create() {
		this.throw_javelin.create();
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendThrowBackupSpear);
		this.m.Description = "Hurl your backup spear at a target. Can not be used while engaged in melee.";
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 20;
	}

	function getTooltip () {
		local tooltip = this.getRangedTooltip(this.getDefaultTooltip());

		local ammo = this.getAmmo();
		if (ammo > 0) {
			tooltip.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Has [color=%positive%]%_ammo%[/color] javelins left",
				param = [["_ammo", ammo]]
			});
		}
		else {
			tooltip.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]No javelins left[/color]"
			});
		}

		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions())) {
			tooltip.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=%negative%]Can not be used because this character is engaged in melee[/color]"
			});
		}

		return tooltip;
	}
});
