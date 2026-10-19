::mods_hookExactClass("skills/traits/athletic_trait", function (o) {
	o.m.HasMoved <- false;

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
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "The first tile of movement each turn costs no Action Points and refunds used Fatigue (capped at your current Fatigue)"
			}
		];
	}

	o.onUpdate = function (_properties) {}

	o.onAdded <- function () {
		if (!::MSU.isKindOf(this.getContainer().getActor(), "player")) {
			this.onCombatStarted();
		}
	}

	o.onCombatStarted <- function () {
		this.m.HasMoved = false;
	}

	o.onTurnStart <- function () {
		this.m.HasMoved = false;
	}
});
