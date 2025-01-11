this.legend_inventor_prosthetic_nose <- this.inherit("scripts/events/event", {
	m = {
		Inventor = null,
		Nofoot = null
	},
	function create()
	{
		this.m.ID = "event.legend_inventor_prosthetic_nose";
		this.m.Title = "During camp...";
		this.m.Cooldown = 35 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/legend_inventor_general.png[/img]%inventor% offers to fix %nofoot%\'s nose. He asks for coin to cover the cost, and requires the use of company tools.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Alright. Here\'s 800 crowns. Take 10 tools from the tents.",
					function getResult( _event )
					{
						return "B";
					}
				},
				{
					Text = "We can\'t spare resources on this right now.",
					function getResult( _event )
					{
						return "C";
					}
				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Inventor.getImagePath());
				this.Characters.push(_event.m.Nofoot.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/legend_inventor_general.png[/img]%inventor% attaches an artificial nose to %nofoot%\'s face. Which they immeditely sneeze out of.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Let\'s try it out!",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Inventor.getImagePath());
				this.Characters.push(_event.m.Nofoot.getImagePath());
				this.World.Assets.addMoney(-800);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You spend [color=" + this.Const.UI.Color.NegativeEventValue + "]800[/color] Crowns"
				});

				this.World.Assets.addArmorParts(-10);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_supplies.png",
					text = "You spend [color=" + this.Const.UI.Color.NegativeEventValue + "]10[/color] Tools and Supplies"
				});

				local trait = ::Legends.Traits.grant(_event.m.Nofoot, ::Legends.Trait.LegendProstheticNose, function (_trait) {
					this.List.push({
						id = 10,
						icon = _trait.getIcon(),
						text = _event.m.Nofoot.m.Name + " receives a " + _trait.m.Name
					});
				});

				local maimed_foot_bye = this.new("scripts/skills/injury_permanent/missing_nose_injury");
				_event.m.Nofoot.getSkills().removeByID("injury.missing_nose");
				this.List.push({
						id = 10,
						icon = maimed_foot_bye.getIcon(),
						text = _event.m.Nofoot.m.Name + " no longer has a " + maimed_foot_bye.m.Name
				});

				_event.m.Inventor.improveMood(2.0, "Created a " + trait.m.Name + " for " + _event.m.Nofoot.m.Name);
				_event.m.Nofoot.improveMood(2.0, "Received a " + trait.m.Name + " from " + _event.m.Inventor.m.Name);
			}
		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/legend_inventor_general.png[/img]You tell %inventor% that the %companyname% has no resources to spare for such things at this time.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Perhaps another time.",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Inventor.getImagePath());
				this.Characters.push(_event.m.Nofoot.getImagePath());
			}
		});
	}

	function onUpdateScore()
	{
		this.m.Score = 0;
		return;

		local brothers = this.World.getPlayerRoster().getAll();
		local inventor_candidates = [];
		local nofoot_candidates = [];


		if (this.World.Assets.getMoney() < 1500 || this.World.Assets.getArmorParts() < 20)
		{
			return;
		}


		foreach (bro in brothers)
		{
			if (bro.getSkills().hasPerk(::Legends.Perk.LegendInventorAnatomy))
			{
				inventor_candidates.push(bro);
			}
		}
		if (inventor_candidates.len() < 1)
		{
			return;
		}
		else
		{
			this.m.Inventor = inventor_candidates[this.Math.rand(0, inventor_candidates.len() - 1)];
		}


		foreach (bro in brothers)
		{
			if (bro.getSkills().hasSkill("injury.missing_nose") && !bro.getSkills().hasTrait(::Legends.Trait.LegendProstheticNose))
			{
				nofoot_candidates.push(bro);
			}
		}
		if (nofoot_candidates.len() < 1)
		{
			return;
		}
		else
		{
			this.m.Nofoot = nofoot_candidates[this.Math.rand(0, nofoot_candidates.len() - 1)];
		}


		this.m.Score = 5.0 + ((this.m.Inventor.getLevel() * 10.0) / this.Const.LevelXP.len());
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"inventor",
			this.m.Inventor.m.Name
		]);
		_vars.push([
			"nofoot",
			this.m.Nofoot.m.Name
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Inventor = null;
		this.m.Nofoot = null;
	}
});
