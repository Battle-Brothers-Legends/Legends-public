this.legend_reserve_gets_fat_event <- this.inherit("scripts/events/event", {
	m = {
		FatGuy = null
	},
	function create()
	{
		this.m.ID = "event.legend_reserve_gets_fat";
		this.m.Title = "At meal time..";
		this.m.Cooldown = 30.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/legend_glutton.png[/img]%fatguy% has been in reserves, and has filled %their% spare time with food. Snacking through the day and taking second helpings at meal times, it is starting to impact your supplies. Perhaps %they% needs more movement, or less food.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "This will impact the bottom line",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.FatGuy.getImagePath());
				::Legends.Traits.grant(_event.m.FatGuy, ::Legends.Trait.Gluttonous, function (_trait) {
					this.List = [{
						id = 10,
						icon = _trait.getIcon(),
						text = _event.m.FatGuy.getName() + " is now gluttonous"
					}];
				});
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.Assets.getOrigin().getID() == "scenario.legend_risen_legion")
		{
			return;
		}

		if (this.World.Assets.getFood() < 100)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.isInReserves())
			{
				if(bro.getFlags().get("IsSpecial") || bro.getFlags().get("IsPlayerCharacter") || bro.getBackground().getID() == "background.legend_puppet" || bro.getBackground().getID() == "background.legend_donkey"){
					continue;
				}
				if (!bro.getSkills().hasTrait(::Legends.Trait.Gluttonous))
				{
				candidates.push(bro);
				}
			}
		}

		if (candidates.len() > 0)
		{
			this.m.FatGuy = candidates[this.Math.rand(0, candidates.len() - 1)];
			this.m.Score = candidates.len() * 5;
		}
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"fatguy",
			this.m.FatGuy.getName()
		]);
		this.Const.LegendMod.extendVarsWithPronouns(_vars, this.m.FatGuy.getGender());
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.FatGuy = null;
	}

});

