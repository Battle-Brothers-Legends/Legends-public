this.legend_inventor_prosthetic_hand <- this.inherit("scripts/events/event", {
	m = {
		Inventor = null,
		Nohand = null
	},
	function create()
	{
		this.m.ID = "event.legend_inventor_prosthetic_hand";
		this.m.Title = "During camp...";
		this.m.Cooldown = 40 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/legend_inventor_general.png[/img]As you take in the scenery you find %inventor% sitting by a tree, seemingly deep in thought, startling him as you approach.%SPEECH_ON%Oh, hey there, captain! I didn\'t see you there.%SPEECH_OFF%He stands up and enthusiastically steps up to you.%SPEECH_ON%You know.. I\'ve been thinking of ways to help %nohand% with his problem, and I think I might have come up with a solution.%SPEECH_OFF%He scratches his head nervously as he continues..%SPEECH_ON%I.. will need some coin in order to cover the material cost for this little experiment, however, and any leftover tools that we can spare.%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Here\'s 1750 crowns. Take 15 tools from the tents. Show me what you can do.",
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
				this.Characters.push(_event.m.Nohand.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/legend_inventor_general.png[/img]You hand him some coin and he takes his leave. You stroll around the camp for some time and then, from out of nowhere, %inventor% appears before you, holding something behind his back.%SPEECH_ON%It\'s finished! Are you ready?%SPEECH_OFF% With eyes the size of saucers, he spins around and then hands you what looks like.. a hand?%SPEECH_ON%It\'s a new hand! I\'m sure this will be of great help to %nohand%.%SPEECH_OFF%He bows to you and scurries off. Well, I guess we\'ll find out.",
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
				this.Characters.push(_event.m.Nohand.getImagePath());
				this.World.Assets.addMoney(-1750);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You spend [color=" + this.Const.UI.Color.NegativeEventValue + "]1750[/color] Crowns"
				});

				this.World.Assets.addArmorParts(-15);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_supplies.png",
					text = "You spend [color=" + this.Const.UI.Color.NegativeEventValue + "]15[/color] Tools and Supplies"
				});

				local trait = ::Legends.Traits.grant(_event.m.Nohand, ::Legends.Trait.LegendProstheticHand, function (_trait) {
					this.List.push({
						id = 10,
						icon = _trait.getIcon(),
						text = _event.m.Nohand.m.Name + " receives a " + _trait.m.Name
					});
				}.bindenv(this));

				local pros_hand_works = _event.m.Nohand.getItems();
				pros_hand_works.getData()[this.Const.ItemSlot.Offhand][0] = null;

				local missing_hand_bye = this.new("scripts/skills/injury_permanent/missing_hand_injury");
				_event.m.Nohand.getSkills().removeByID("injury.missing_hand");
				this.List.push({
						id = 10,
						icon = missing_hand_bye.getIcon(),
						text = _event.m.Nohand.m.Name + " no longer has a " + missing_hand_bye.m.Name
				});

				_event.m.Inventor.improveMood(2.0, "Created a " + trait.m.Name + " for " + _event.m.Nohand.m.Name);
				_event.m.Nohand.improveMood(2.0, "Received a " + trait.m.Name + " from " + _event.m.Inventor.m.Name);
			}
		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/legend_inventor_general.png[/img]You tell %inventor% that the %companyname% has no resources to spare for such things at this time. The inventor lowers his head and lets out a sigh.%SPEECH_ON%I understand. Perhaps later, then. I\'ll be around.%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Yes, perhaps another time.",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Inventor.getImagePath());
				this.Characters.push(_event.m.Nohand.getImagePath());
			}
		});
	}

	function onUpdateScore()
	{
		this.m.Score = 0;
		return;

		local brothers = this.World.getPlayerRoster().getAll();
		local inventor_candidates = [];
		local nohand_candidates = [];


		if (this.World.Assets.getMoney() < 2000 || this.World.Assets.getArmorParts() < 40)
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
			if (bro.getSkills().hasSkill("injury.missing_hand") && !bro.getSkills().hasTrait(::Legends.Trait.LegendProstheticHand))
			{
				nohand_candidates.push(bro);
			}
		}
		if (nohand_candidates.len() < 1)
		{
			return;
		}
		else
		{
			this.m.Nohand = nohand_candidates[this.Math.rand(0, nohand_candidates.len() - 1)];
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
			"nohand",
			this.m.Nohand.m.Name
		]);
	}

	function onClear()
	{
		this.m.Inventor = null;
		this.m.Nohand = null;
	}
});
