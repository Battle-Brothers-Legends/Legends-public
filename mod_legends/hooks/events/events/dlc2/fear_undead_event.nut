::mods_hookExactClass("events/events/dlc2/fear_undead_event", function(o) {
	o.m.excludedBackgrounds <- [
		::Legends.Backgrounds.getID(::Legends.Background.Companion),
		::Legends.Backgrounds.getID(::Legends.Background.Crusader),
		::Legends.Backgrounds.getID(::Legends.Background.Gravedigger),
		::Legends.Backgrounds.getID(::Legends.Background.Graverobber),
		::Legends.Backgrounds.getID(::Legends.Background.HedgeKnight),
		::Legends.Backgrounds.getID(::Legends.Background.Wildman),
		::Legends.Backgrounds.getID(::Legends.Background.LegendCompanionMelee),
		::Legends.Backgrounds.getID(::Legends.Background.LegendCompanionRanged),
		::Legends.Backgrounds.getID(::Legends.Background.LegendCrusader)
	];
	o.m.excludedTraits <- [
		::Legends.Trait.Bloodthirsty,
		::Legends.Trait.Brave,
		::Legends.Trait.Determined,
		::Legends.Trait.Fearless,
		::Legends.Trait.FearUndead,
		::Legends.Trait.HateUndead
	];

	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_26.png[/img]{%brother% looks around at the others around the campfire, then looks at the ground for a few minutes before exploding.%SPEECH_ON%Am I the only one here who is sane? How is no one else losing their farking minds over the dead walking the earth again? What the hell, where are the old gods in all this, they just farking gonna watch this shitshow?%SPEECH_OFF%The company tries to temper the fears, but %brother% goes back to a ponderous silence of a person with too much to think about and no one willing, or wanting, to truly listen.}";
				s.Options[0].Text = "This is taking a toll on the company."
			}
		}
	}

	o.onUpdateScore = function () {
		if (this.World.Assets.getOrigin().getID() == "scenario.legend_risen_legion") {
			return;
		}

		local fallen = [];
		local fallen = this.World.Statistics.getFallen();

		if (fallen.len() < 2)
			return;

		if (fallen[0].Time < this.World.getTime().Days || fallen[1].Time < this.World.getTime().Days)
			return;

		if (this.World.Statistics.getFlags().getAsInt("LastCombatFaction") != this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).getID() && this.World.Statistics.getFlags().getAsInt("LastCombatFaction") != this.World.FactionManager.getFactionOfType(this.Const.FactionType.Zombies).getID())
			return;

		local brothers = this.World.getPlayerRoster().getAll();

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

		this.m.Casualty = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = 50;
	}
});
