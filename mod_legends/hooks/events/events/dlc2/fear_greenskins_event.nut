::mods_hookExactClass("events/events/dlc2/fear_greenskins_event", function(o) {
	o.m.excludedBackgrounds <- [
		::Legends.Backgrounds.getID(::Legends.Background.Companion),
		::Legends.Backgrounds.getID(::Legends.Background.HedgeKnight),
		::Legends.Backgrounds.getID(::Legends.Background.OrcSlayer),
		::Legends.Backgrounds.getID(::Legends.Background.LegendRanger),
		::Legends.Backgrounds.getID(::Legends.Background.Wildman),
		::Legends.Backgrounds.getID(::Legends.Background.LegendCompanionMelee),
		::Legends.Backgrounds.getID(::Legends.Background.LegendCompanionRanged),
	];
	o.m.excludedTraits <- [
		::Legends.Trait.Bloodthirsty,
		::Legends.Trait.Brave,
		::Legends.Trait.Determined,
		::Legends.Trait.Fearless,
		::Legends.Trait.FearGreenskins,
		::Legends.Trait.HateGreenskins
	];

	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_26.png[/img]{%brother% stares at the campfire with their hands bridged between their knees.%SPEECH_ON%Fark, man. I don\'t know if I can look at a greenskin again. They\'re so much stronger and faster than us! We, we shouldn\'t face them again until we got at least, two, no three times as many mercenaries!%SPEECH_OFF%You tell the company to keep an eye on %brother%. Fear is justified but spreading it sure as hell ain\'t.}";
				s.Options[0].Text = "This is taking a toll on the company."
			}
		}
	}

	o.onUpdateScore = function () {
		if (::World.Assets.getOrigin().getID() == "scenario.legends_risen_legion") {
			return;
		}

		local fallen = [];
		local fallen = ::World.Statistics.getFallen();

		if (fallen.len() < 2)
			return;

		if (fallen[0].Time < ::World.getTime().Days || fallen[1].Time < ::World.getTime().Days)
			return;

		if (::World.Statistics.getFlags().getAsInt("LastCombatFaction") != ::World.FactionManager.getFactionOfType(::Const.FactionType.Orcs).getID() && ::World.Statistics.getFlags().getAsInt("LastCombatFaction") != ::World.FactionManager.getFactionOfType(::Const.FactionType.Goblins).getID())
			return;

		local brothers = ::World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
			return;

		local candidates = [];

		foreach( bro in brothers ) {
			if (bro.getLevel() > 7)
				continue;

			foreach (background in this.m.excludedBackgrounds)
				if (bro.getBackground().getID() == background)
					continue;

			foreach (trait in this.m.excludedTraits)
				if (bro.getSkills().hasTrait(trait))
					continue;

			candidates.push(bro);
		}

		if (candidates.len() == 0)
			return;

		this.m.Casualty = candidates[::Math.rand(0, candidates.len() - 1)];
		this.m.Score = 50;
	}
});
