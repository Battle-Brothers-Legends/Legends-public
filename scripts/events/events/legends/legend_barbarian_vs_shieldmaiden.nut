this.legend_barbarian_vs_shieldmaiden <- this.inherit("scripts/events/event", {
	m = {
		Barbarian = null,
		Shieldmaiden = null,
		Flag = "legend_barbarian_vs_shieldmaiden"
	},
	function create()
	{
		this.m.ID = "event.legend_barbarian_vs_shieldmaiden";
		this.m.Title = "During camp...";
		this.m.Cooldown = 45.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_06.png[/img]You find %barbarian% and %shieldmaiden% arguing with one another. The Barbarian\'s voice is raised.%SPEECH_ON%The best defence is the good offence! That\'s why I rush to a battle first!%SPEECH_OFF%Also raising her voice, and clenching a shield at her side, the Shieldmaiden shakes her head.%SPEECH_ON%Why are you even talking to me? I have no desire to get to know someone who is only going to get killed by rushing into battle before thinking!%SPEECH_OFF%The fighting words kick off a scuffle.\n\n",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "Are you both done?",
				getResult = @(_event) 0
			}],
			function start(_event) {
				if (::Math.rand(1, 100) <= 50) {
					this.Text = this.Text + " %barbarian% rushes at %shieldmaiden% with a full swing of a weapon, as if trying to cut her in half, but she raises her shield to deftly deflect the blow and immedietly counters with a quick jab of her shield that stuns and knocks %barbarian% back.%SPEECH_ON%See I told you! you rush without thinking and now you are laying on the ground...%SPEECH_OFF%";
					_event.m.Shieldmaiden.getFlags().add(_event.m.Flag);
					this.List.extend([
						::Legends.EventList.changeMeleeDefense(_event.m.Shieldmaiden, ::Math.rand(2, 4)),
						::Legends.EventList.addLightInjury(_event.m.Shieldmaiden),
						::Legends.EventList.changeMood(_event.m.Shieldmaiden, 1.0, "Victorious in a brawl"),
						::Legends.EventList.addInjury(_event.m.Barbarian, ::Const.Injury.Brawl)
					]);
					local entry = ::Legends.EventList.changeMood(_event.m.Barbarian, -0.5, "Overpowered by " + _event.m.Shieldmaiden.getName());
					if (_event.m.Barbarian.getMoodState() < ::Const.MoodState.Neutral) {
						this.List.push(entry);
					}
				} else {
					this.Text = this.Text + " %barbarian% rushes at %shieldmaiden% who tries to react by blocking the blow with her shield but the Barbarian easily circumvents her defence and knocks her to the ground, before stopping a strike an inch from her head.%SPEECH_ON%See I told you! Best defence is a good offence%SPEECH_OFF%";
					_event.m.Barbarian.getFlags().add(_event.m.Flag);
					this.List.extend([
						::Legends.EventList.changeMeleeSkill(_event.m.Barbarian, ::Math.rand(2, 4)),
						::Legends.EventList.addLightInjury(_event.m.Barbarian),
						::Legends.EventList.changeMood(_event.m.Barbarian, 1.0, "Victorious in a brawl"),
						::Legends.EventList.addInjury(_event.m.Shieldmaiden, ::Const.Injury.Brawl)
					]);
					local entry = ::Legends.EventList.changeMood(_event.m.Barbarian, -0.5, "Overpowered by " + _event.m.Barbarian.getName());
					if (_event.m.Barbarian.getMoodState() < ::Const.MoodState.Neutral) {
						this.List.push(entry);
					}
				}
			}
		});
	}

	function onUpdateScore() {
		local brothers = ::World.getPlayerRoster().getAll();
		if (brothers.len() < 3)
			return;

		brothers = brothers.filter(@(_, bro) bro.getLevel() > 3 && !bro.getFlags().has(this.m.Flag));

		local barbarian_candidates = brothers.filter(@(_, bro) ::Legends.Backgrounds.hasAny(bro,
			::Legends.Background.Barbarian,
			::Legends.Background.Raider
		));

		if (barbarian_candidates.len() == 0)
			return;

		local shieldmaiden_candidates = brothers.filter(@(_, bro) ::Legends.Backgrounds.hasAny(bro,
			::Legends.Background.LegendShieldmaiden
		));

		if (shieldmaiden_candidates.len() == 0)
			return;

		this.m.Barbarian = barbarian_candidates[::Math.rand(0, barbarian_candidates.len() - 1)];
		this.m.Shieldmaiden = shieldmaiden_candidates[::Math.rand(0, shieldmaiden_candidates.len() - 1)];
		this.m.Score = (barbarian_candidates.len() + shieldmaiden_candidates.len()) * 3;
	}

	function onPrepare() {}

	function onPrepareVariables(_vars) {
		_vars.push([
			"shieldmaiden",
			this.m.Shieldmaiden.getNameOnly()
		]);
		_vars.push([
			"barbarian",
			this.m.Barbarian.getNameOnly()
		]);
	}

	function onClear() {
		this.m.Shieldmaiden = null;
		this.m.Barbarian = null;
	}
});

