this.legend_fear_nobles_event <- this.inherit("scripts/events/event", {
	m = {
		Casualty = null,
		ExcludedBackgrounds = [
			::Legends.Background.AdventurousNoble,
			::Legends.Background.LegendAdventurousLady,
			::Legends.Background.Companion,
			::Legends.Background.LegendDisownedLady,
			::Legends.Background.DisownedNoble,
			::Legends.Background.HedgeKnight,
			::Legends.Background.LegendCommanderNoble,
			::Legends.Background.LegendCompanionMelee,
			::Legends.Background.LegendCompanionRanged,
			::Legends.Background.LegendNoble2h,
			::Legends.Background.LegendNobleRanged,
			::Legends.Background.LegendNobleShield
		],
		ExcludedTraits = [
			::Legends.Trait.Bloodthirsty,
			::Legends.Trait.Brave,
			::Legends.Trait.Determined,
			::Legends.Trait.Fearless,
			::Legends.Trait.LegendFearNobles,
			::Legends.Trait.LegendHateNobles
		]
	},
	function create() {
		this.m.ID = "event.legend_fear_nobles";
		this.m.Title = "During camp...";
		this.m.Cooldown = 25.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_26.png[/img]{You find %brother% arguing with several other companions at camp. From what you gather the group observed a noble dueling tournament in the last town.%SPEECH_ON%I\'m telling ye, \'ee moved way too fast! That speed 'aint normal! What the fark am I gonna do if I face that in a fight? Bleed all over his pretty armor and hope \'ee slips in it? I mean, the big \'uns with the plate and the \'ammers is one thing, but those lunging fops... fark me.%SPEECH_OFF%No amount of cajoling or improbable war stories from the rest of the company seems able to break %brother% out of this defeatist mood.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "They are still just men, underneath the finery.",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.Characters.push(_event.m.Casualty.getImagePath());
				::Legends.Traits.grant(_event.m.Casualty, ::Legends.Trait.LegendFearNobles, function(_trait) {
					this.List.push({
						id = 10,
						icon = _trait.getIcon(),
						text = _event.m.Casualty.getName() + " now fears the nobility."
					});
				}.bindenv(this));
			}
		});
	}

	function onUpdateScore() {
		local fallen = ::World.Statistics.getFallen();
		if (fallen.len() < 2)
			return;

		if (fallen[0].Time < this.World.getTime().Days || fallen[1].Time < ::World.getTime().Days)
			return;

		if (this.World.Statistics.getFlags().getAsInt("LastCombatFaction") != this.World.FactionManager.getFactionOfType(this.Const.FactionType.NobleHouse).getID())
			return;

		local brothers = this.World.getPlayerRoster().getAll();
		if (brothers.len() < 2)
			return;

		local candidates = brothers.filter(function (_, _bro) {
			if (_bro.getLevel() > 7)
				return false;
			if (::Legends.S.any(this.m.ExcludedBackgrounds, @(_bg) ::Legends.Backgrounds.has(_bro, _bg)))
				return false;
			if (::Legends.S.any(this.m.ExcludedTraits, @(_trait) _bro.getSkills().hasTrait(_trait)))
				return false;
			return true;
		}.bindenv(this));

		if (candidates.len() == 0)
			return;

		this.m.Casualty = candidates[::Math.rand(0, candidates.len() - 1)];
		this.m.Score = 50;
	}

	function onPrepare() {
	}

	function onPrepareVariables(_vars) {
		_vars.push([
			"brother",
			this.m.Casualty.getName()
		]);
	}

	function onClear() {
		this.m.Casualty = null;
	}

});

