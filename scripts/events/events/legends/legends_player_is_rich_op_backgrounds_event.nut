this.legends_player_is_rich_op_backgrounds_event <- this.inherit("scripts/events/event", {
	m = {
		OPBro1 = null,
		OPBro2 = null,
		TraderCmr = null,
		Uniquebros = null,
		Regularbros = null,
		Compensation = null,
	},
	function create()
	{
		this.m.ID = "event.legend_player_is_rich_op_backgrounds_event";
		this.m.Title = "During camp...";
		this.m.Cooldown = 100.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_06.png[/img] Over time, you\'ve come to acquire a great deal of money. While you keep the war chest under lock and key, you can\'t help but notice a few brothers have gotten a bit greedier over the time they\'ve spent in the company. Recently, you have heard rumors of the men demanding higher pay. Finally, the breaking point has been reached when an arguement between %bro1% and %bro2% nearly came to blows. %SPEECH_ON%Who contributed the most to the hoard of coin %companyname% possess?%SPEECH_OFF%The belligerents looked like they were ready to kill each other to resolve this dispute.",
			Image = "",
			List = [],
			Characters = [],
			Options = [],
			function start( _event )
			{
				this.Options.push({
					Text = "Aye, it\'s fine time you all get a raise.",
					function getResult( _event )
					{
						return "B";
					}
				});
				this.Options.push ({
					Text = "You all signed the dotted line and get paid according to it.",
					function getResult( _event )
					{
						return "C";
					}
				});
				if (_event.m.TraderCmr != null && !_event.m.TraderCmr.isNull())
				{
					this.Options.push ({
						Text = "There\'s no need to argue, we can work it out.",
						function getResult( _event )
						{
							this.m.Compensation = this.Math.round(0.04 * UniquebrosNumber * cash);
							return "D";
						}
					});
				}

				this.Characters.push(_event.m.OPBro1.getImagePath());
				this.Characters.push(_event.m.OPBro2.getImagePath());

				foreach( bro in _event.m.Uniquebros )
				{
					if (bro.getMoodState() >= this.Const.MoodState.Neutral) {
						this.List.push(::Legends.EventList.changeMood(bro, -2.0, "Rivalry!"));
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_04.png[/img]Preempting any sort of mutiny or raise requests, you announce that the group shall have a company-wide raise. Four crowns a day for everyone, triple of that for those most deserving and share of loot right now. As it turns out, the men are quite fond of this move and cheer your name with a huzzah!",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "You\'ve earned it, boys!",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.OPBro1.getImagePath());
				this.Characters.push(_event.m.OPBro2.getImagePath());

				this.World.Assets.addMoney(-_event.m.Compensation);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You spend [color=" + this.Const.UI.Color.NegativeEventValue + "]" + _event.m.Compensation + "[/color] Crowns"
				});

				foreach( bro in _event.m.Uniquebros )
				{
					bro.getBaseProperties().DailyWage += 12;
					this.List.push(::Legends.EventList.changeMood(bro, 2.0, "Got a pay raise"));
				}

				foreach( bro in _event.m.Regularbros )
				{
					bro.getBaseProperties().DailyWage += 4;
					this.List.push(::Legends.EventList.changeMood(bro, 2.0, "Got a pay raise"));
				}
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_64.png[/img]Before anyone gets any ideas, you step up before the whole company and announce that there will be no raises. As far as you are concerned, every man present signed the contract. Any prospect of earning more pay shall be done by experience only, and that is only done by doing what sellswords do best: kill.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "That\'s how it works with the %companyname%.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.OPBro1.getImagePath());
				this.Characters.push(_event.m.OPBro2.getImagePath());
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getSkills().hasTrait(::Legends.Trait.Player))
					{
						continue;
					}

					if (bro.getSkills().hasTrait(::Legends.Trait.Greedy))
					{
						this.List.push(::Legends.EventList.changeMood(bro, -2.0, "Was denied a pay raise"));
					}
					else if (!bro.getBackground().isExcluded(::Legends.Traits.getID(::Legends.Trait.Greedy)))
					{
						if (this.Math.rand(1, 100) <= 20)
						{
							::Legends.Traits.grant(bro, ::Legends.Trait.Greedy, function (_trait) {
								this.List.push({
									id = 10,
									icon = _trait.getIcon(),
									text = bro.getName() + " gets greedy"
								});
							}.bindenv(this));
						}
						else
						{
							this.List.push(::Legends.EventList.changeMood(bro, -1.0, "Was denied a pay raise"));
						}
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_04.png[/img]Preempting any sort of mutiny or raise requests, you managed to talk it out with these most discontent. Eighth crowns a day rise and immediate share of some spoils to keep their mounts shut. At least for now.  Keeping this transaction a secret prevented additional expenses.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Keep this between us...",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.OPBro1.getImagePath());
				this.Characters.push(_event.m.OPBro2.getImagePath());

				this.World.Assets.addMoney(-_event.m.Compensation);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You spend [color=" + this.Const.UI.Color.NegativeEventValue + "]" + _event.m.Compensation + "[/color] Crowns"
				});

				foreach( bro in _event.m.Uniquebros )
				{
					bro.getBaseProperties().DailyWage += 8;
					this.List.push(::Legends.EventList.changeMood(bro, 2.0, "Got a pay raise"));
				}
			}
		});
	}

	function onUpdateScore()
	{
		if (this.World.Assets.getMoney() <= 30000)
		{
			return;
		}

		if (this.World.getPlayerRoster().getSize() < 3)
		{
			return;
		}

		if (this.World.Retinue.hasFollower("follower.paymaster"))
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidate_opbackground = [];
		local candidate_rest = [];
		local thetrader;

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasTrait(::Legends.Trait.Player) && bro.getBackground().getID() != "background.legend_commander_trader")
			{
				continue;
			}
			switch (bro.getBackground().getID())
			{

				case "background.legend_commander_trader":
					thetrader.push(bro);
					break;
				case "background.assassin":
				case "background.legend_crusader":
				case "background.legend_berserker":
				case "background.legend_necro":
				case "background.legend_witch":
				case "background.legend_trader":
				case "background.legend_ranger":
				case "background.regent_in_absentia":
					candidate_opbackground.push(bro);
					break;
				default:
					candidate_rest.push(bro);
			}
		}
		if (candidate_opbackground.len() <= 2)
		{
			return;
		}

		this.m.Uniquebros = candidate_opbackground;
		this.m.Regularbros = candidate_rest;
		this.m.TraderCmr = thetrader;

		local UniquebrosNumber = this.Math.floor(candidate_opbackground.len());
		local cash = this.World.Assets.getMoney();
		this.m.Compensation = this.Math.round(0.05 * cash + (0.05 * UniquebrosNumber * cash));

		local r = this.Math.rand(0, candidate_opbackground.len() - 1);
		this.m.OPBro1 = candidate_opbackground[r];
		candidate_opbackground.remove(r);
		r = this.Math.rand(0, candidate_opbackground.len() - 1);
		this.m.OPBro2 = candidate_opbackground[r];
		candidate_opbackground.remove(r);



		this.m.Score = candidate_opbackground.len() * (this.World.Assets.getMoney() - 30000) * 0.0005;
		// this.m.Score = 9999;
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"bro1",
			this.m.OPBro1.getName()
		]);
		_vars.push([
			"bro2",
			this.m.OPBro2.getName()
		]);
	}

	function onClear()
	{
		this.m.OPBro1 = null;
		this.m.OPBro2 = null;
		this.m.TraderCmr = null;
		this.m.Uniquebros = null;
		this.m.Regularbros = null;
		this.m.Compensation = null;
	}

});

