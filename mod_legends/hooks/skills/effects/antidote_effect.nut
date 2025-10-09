::mods_hookExactClass("skills/effects/antidote_effect", function (o) {
	local onAdded = o.onAdded;
	o.onAdded = function () {
		onAdded();
		while (this.getContainer().hasEffect(::Legends.Effect.LegendRedbackSpiderPoison)) {
			::Legends.Effects.remove(this.getContainer(), ::Legends.Effect.LegendRedbackSpiderPoison);
		}
	}
})
