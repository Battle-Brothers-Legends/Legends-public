::mods_hookExactClass("skills/perks/perk_dodge", function (o) {
	o.onAdded <- function () {
		::Legends.Effects.grant(this, ::Legends.Effect.Dodge, function (_skill) {
			_skill.m.NormalBonus = this.getContainer().getActor().isPlayerControlled() ? true : false;
		}.bindenv(this));
	}

	o.onCombatStarted = function () {}

	o.getDynamicTooltip <- function (_actor = null) {;
		local bonus = ::Math.floor(_actor.getInitiative() * ::Math.maxf(1.0, ::Math.minf(2.0, 2.0 - (_actor.getHitpointsMax().tofloat() - 50.0) / 50.0)) * 0.15);
		return [
			{
				id = 3,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=%positive%]+" + bonus + "[/color] Melee Defense"
			},
			{
				id = 3,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%positive%]+" + bonus + "[/color] Ranged Defense"
			}
		];
	}
});
