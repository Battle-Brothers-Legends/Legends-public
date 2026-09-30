this.legend_charming_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},

	function create() {
		this.character_trait.create();
		::Legends.Traits.onCreate(this, ::Legends.Trait.LegendCharming);
		this.m.Description = "Some say you can get almost anywhere with a trustworthy demeanor and a warm smile.";
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Pessimist),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.LegendDoubleTongued),
		];
	}

	function getTooltip() {
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
				icon = "ui/icons/morale.png",
				text = "Has a [color=%positive%]10%[/color] chance to boost up company morale at the start of a combat"
			},
		];
	}

	function onCombatStarted() {
		this.skill.onCombatStarted();

		if (::Math.rand(1, 10) < 10) {
			return;
		}

		local allies = ::Tactical.Entities.getInstancesOfFaction(this.getContainer().getActor().getFaction());
		local ownID = this.getContainer().getActor().getID();

		foreach (ally in allies) {
			if (ally.getID() == ownID) {
				continue;
			}
			local ally_morale = ally.getMoraleState();

			if (ally_morale < ::Const.MoraleState.Confident) {
				ally.setMoraleState(ally_morale + 1);
			}
		}
	}
});
