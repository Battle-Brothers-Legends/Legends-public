::mods_hookExactClass("skills/effects/possessing_undead_effect", function (o) {
	o.m.IsControlledByPlayer <- false;

	o.getDescription <- function () {
		return "Concentrating on possessing an undead.";
	}

	o.setPlayerControlled <- function (_v) {
		this.m.IsControlledByPlayer = _v;
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "Possessing an undead";
	}
});
