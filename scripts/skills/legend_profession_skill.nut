this.legend_profession_skill <- this.inherit("scripts/skills/skill", {
	m = {},

	function onAdded() {
		::Legends.Professions.setProfessionEffect(::Legends.Professions.findById(this.getID()));
	}

	// the bro still has the skill while this runs, so they are left out of the count
	function onRemoved() {
		::Legends.Professions.setProfessionEffect(::Legends.Professions.findById(this.getID()), this.getContainer().getActor());
	}

	// a dismissed bro is still in the roster at that point too
	function onDismiss() {
		::Legends.Professions.setProfessionEffect(::Legends.Professions.findById(this.getID()), this.getContainer().getActor());
	}

	// also runs when a bro leaves through an event, they are still in the roster at that point. A bro that is only struck down stays and keeps counting
	function onDeath(_fatalityType) {
		local leaving = _fatalityType != ::Const.FatalityType.Unconscious ? this.getContainer().getActor() : null;
		::Legends.Professions.setProfessionEffect(::Legends.Professions.findById(this.getID()), leaving);
	}
});
