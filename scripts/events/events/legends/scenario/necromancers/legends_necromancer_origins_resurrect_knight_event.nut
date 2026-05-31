this.legends_necromancer_origins_resurrect_knight_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.legends_necromancer_origins_resurrect_knight";
		this.m.Title = "A last stand...";
		this.m.Cooldown = 125.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({ //— \n |
			ID = "A",
			Text = "[img]gfx/ui/events/event_28.png[/img]{As you trapse through the woods, something catches your eye — a freshly fallen knight. It has no particular livery you would recognise, and lies in a crumpled mess between two trees. \nThis lone wolf now lies silent, but you sense a feeling coming from this corpse. A feeling that this would be a powerful minion indeed. \n\nHowever, the knight has been here for some time, and coaxing that vigor out of it would be very difficult. \n\nIn these woods it would be unwise to stay for long.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Try to raise it.",
					function getResult( _event )
					{
						if (this.Math.rand(1, 100) <= 50)
						{
							return "B";
						}
						else
						{
							return "C";
						}
					}
				},
				{
					Text = "Leave it be.",
					function getResult( _event )
					{
						return "D";
					}
				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_25.png[/img]{Taking every precaution you can, a ritual circle is formed and the process begins. Even in death, the knight fights you — attempting to twist away from your control. \n\nEventually, it\'s strength gives out and relents. It is now bound to itself once more, with much stronger energy than those currently with you.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "You will serve nicely.",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude = null;
						return 0;
					}
				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
 				_event.m.Dude.getFlags().add("PlayerZombie");
				_event.m.Dude.getFlags().add("undead");
				_event.m.Dude.getFlags().add("zombie_minion");
				_event.m.Dude.setStartValuesEx([
					"legend_lonewolf_background"
				]);
				_event.m.Dude.addLightInjury();
				_event.m.Dude.getBaseProperties().Initiative += 25;
				_event.m.Dude.getBaseProperties().Hitpoints += 5;
				_event.m.Dude.getBaseProperties().Stamina += 15;
				_event.m.Dude.getBaseProperties().MeleeSkill += 6;
				_event.m.Dude.getBaseProperties().RangedDefense += 1;
				_event.m.Dude.getBaseProperties().MeleeDefense += 2;
				_event.m.RawDescription = "This one, in normal circumstances, would be marked for greatness. That is — if they were not foolish enough to die in the first place.";
				::Legends.Traits.grant(this, ::Legends.Trait.LegendRottenFlesh);
				::Legends.Perks.grant(this, ::Legends.Perk.LegendZombieBite);
				this.Characters.push(_event.m.Dude.getImagePath());
				this.List.push({
					id = 16,
					icon = "ui/icons/special.png",
					text = "[color=" + this.Const.UI.Color.NegativeEventValue + "]"Your reputation with everyone has decreased slightly"[/color]"
				});

				this.List.push({
					id = 16,
					icon = "ui/icons/special.png",
					text = "[color=" + this.Const.UI.Color.PositiveEventValue + "]"Your reputation with the undead has increased slightly"[/color]"
				});

				local nobles = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse);
				local settlement = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.Settlement);
				local oriental = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.OrientalCityState);
				local undead = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.Undead);

				foreach( n in nobles )
				{
					n.addPlayerRelation(-5.0, "Became a greater threat");
				}
				foreach( n in settlement )
				{
					n.addPlayerRelation(-10.0, "Became a greater threat");
				}
				foreach( n in oriental )
				{
					n.addPlayerRelation(-5.0, "Became a greater threat");
				}
				foreach( n in undead )
				{
					n.addPlayerRelation(20.0, "You should not see this");
				}
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_25.png[/img]{Taking every precaution you can, a ritual circle is formed and the process begins. Even in death, the knight fights you — attempting to twist away from your control. \n\nEventually, your hold gives out, but not before you pull a fragment of itself back into the corpse. It is now bound to itself once more, but much duller than you hoped.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Fark it.",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude = null;
						return 0;
					}
				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
 				_event.m.Dude.getFlags().add("PlayerZombie");
				_event.m.Dude.getFlags().add("undead");
				_event.m.Dude.getFlags().add("zombie_minion");
				_event.m.Dude.setStartValuesEx([
					"legend_puppet_background"
				]);
				_event.m.Dude.addLightInjury();
				::Legends.Traits.grant(this, ::Legends.Trait.LegendRottenFlesh);
				::Legends.Perks.grant(this, ::Legends.Perk.LegendZombieBite);
				this.Characters.push(_event.m.Dude.getImagePath());
				this.List.push({
					id = 16,
					icon = "ui/icons/special.png",
					text = "[color=" + this.Const.UI.Color.NegativeEventValue + "]"Your reputation with everyone has decreased slightly"[/color]"
				});

				this.List.push({
					id = 16,
					icon = "ui/icons/special.png",
					text = "[color=" + this.Const.UI.Color.PositiveEventValue + "]"Your reputation with the undead has increased slightly"[/color]"
				});

				local nobles = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse);
				local settlement = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.Settlement);
				local oriental = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.OrientalCityState);
				local undead = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.Undead);

				foreach( n in nobles )
				{
					n.addPlayerRelation(-5.0, "Became a greater threat");
				}
				foreach( n in settlement )
				{
					n.addPlayerRelation(-10.0, "Became a greater threat");
				}
				foreach( n in oriental )
				{
					n.addPlayerRelation(-5.0, "Became a greater threat");
				}
				foreach( n in undead )
				{
					n.addPlayerRelation(20.0, "You should not see this");
				}
			}
		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_04.png[/img]{You ignore the possibility, instead opting to turn out what remains in their mouldy knapsack.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Let\'s go.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local money = this.Math.rand(311, 718);
				this.World.Assets.addMoney(money);
				this.World.Assets.getStash().add(this.new("scripts/items/supplies/cured_rations"));
				this.World.Assets.getStash().add(this.new("scripts/items/supplies/cured_venison_item"));
				this.World.Assets.getStash().add(this.new("scripts/items/supplies/medicine_item"));
				this.World.Assets.getStash().add(this.new("scripts/items/loot/jade_broche_item"));
				this.World.Assets.getStash().add(this.new("scripts/items/loot/signet_ring_item"));
			}
		});
	}

	function onUpdateScore()
	{
		//see 'static_functions' ::Legends.S.humansOnly for more details.
		if (this.World.Assets.getOrigin().getID() != "scenario.legends_solo_necro" && this.World.Assets.getOrigin().getID() != "scenario.legends_necro" && bro.getFlags().has("PlayerZombie")) //if not either of these origin, skip event
		{
			return;
		}

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.Type == this.Const.World.TerrainType.Forest && !currentTile.Type == this.Const.World.TerrainType.LeaveForest)
		{
			return;
		}

		this.m.Score = 3;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"joiner",
			this.m.Dude.getName()
		]);
	}

	function onClear()
	{
		this.m.Dude = null;
	}

});

