::mods_hookExactClass("skills/traits/impatient_trait", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Excluded.extend([
			::Legends.Traits.getID(::Legends.Trait.LegendSureshot),
			::Legends.Traits.getID(::Legends.Trait.LegendSlack)
		]);
	}

	o.getTooltip = function () {
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Acts first in turn order, but slower than characters under the effect of [color=%status%]Adrenaline[/color]"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/warning.png",
				text = "Is unable to use wait in combat"
			}
		];
	}

	o.onUpdate = function (_properties) {
		if (this.getContainer().getActor().isPlacedOnMap()) {
			_properties.InitiativeForTurnOrderAdditional += 1000;
		}
	}

	o.onTurnStart <- function () {
		this.getContainer().getActor().setWaitActionSpent(true);
	}
});
