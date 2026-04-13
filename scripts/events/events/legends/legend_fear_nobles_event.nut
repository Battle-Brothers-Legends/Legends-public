this.legend_fear_nobles_event <- this.inherit("scripts/events/event", {
	m = {
		Casualty = null,
		excludedBackgrounds = [
			"companion",
			"disowned_noble",
			"female_disowned_noble",
			"adventurous_noble",
			"hedge_knight",
			"legend_noble_2h",
			"legend_noble",
			"legend_commander_noble",
			"legend_noble_ranged",
			"legend_noble_shield"
		],
		excludedTraits = [
			"fear_nobles",
			"legend_fear_nobles",
			"hate_nobles",
			"legend_hate_nobles",
			"fearless",
			"brave",
			"determined",
			"bloodthirsty"
		]
	},
	function create()
	{
		this.m.ID = "event.legend_fear_nobles";
		this.m.Title = "During camp...";
		this.m.Cooldown = 25.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_26.png[/img]{You find %brother% arguing with several other companions at camp. From what you gather the group observed a noble dueling tournament in the last town.%SPEECH_ON%I\'m telling ye, \'ee moved way too fast! That speed 'aint normal! What the fark am I gonna do if I face that in a fight? Bleed all over his pretty armor and hope \'ee slips in it? I mean, the big \'uns with the plate and the \'ammers is one thing, but those lunging fops... fark me.%SPEECH_OFF%No amount of cajoling or improbable war stories from the rest of the company seems able to break %brother% out of this defeatist mood.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "They are still just men, underneath the finery.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
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

	function onUpdateScore()
	{
		if (!this.Const.DLC.Unhold)
		{
			return;
		}

		local fallen = [];
		local fallen = this.World.Statistics.getFallen();

		if (fallen.len() < 2)
		{
			return;
		}

		if (fallen[0].Time < this.World.getTime().Days || fallen[1].Time < this.World.getTime().Days)
		{
			return;
		}

		if (this.World.Statistics.getFlags().getAsInt("LastCombatFaction") != this.World.FactionManager.getFactionOfType(this.Const.FactionType.NobleHouse).getID())
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
		{
			return;
		}

		local candidates = [];

		foreach( bro in brothers )
		{
			foreach (background in this.m.excludedBackgrounds)
			{
				if (bro.getBackground().getID() == "background." + background)
					continue;
			}
			if (bro.getLevel() > 7)
				continue;

			foreach (trait in this.m.excludedTraits)
			{
				if (bro.getSkills().hasSkill("trait." + trait))
					continue;
			}
			candidates.push(bro);
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Casualty = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = 50;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"brother",
			this.m.Casualty.getName()
		]);
	}

	function onClear()
	{
		this.m.Casualty = null;
	}

});

