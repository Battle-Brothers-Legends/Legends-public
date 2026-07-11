this.legion_origin_legendary_crypt_event <- this.inherit("scripts/events/event", {
	m = {
		LootTable = [
			"misc/legend_masterwork_metal",
			"misc/legend_masterwork_fabric",
			"misc/legend_masterwork_tools",
			"misc/legend_ancient_scroll_item",
			"misc/legend_masterwork_metal",
			"misc/legend_masterwork_fabric",
			"misc/legend_masterwork_tools"
		]
	},
	function create()
	{
		this.m.ID = "event.legion_origin_legendary_crypt";
		this.m.Title = "As you approach...";
		this.m.Cooldown = 40.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({ // \n\n —
			ID = "A",
			Text = "[img]gfx/ui/events/event_128.png[/img]{These forests are infested with greenskins — a remarkably vile addition to the legion\'s combat record, and one that you are poorly equipped to fight.\n On high alert, a legionary picks up a new trail. Following the trail you begin to feel a sense of otherworldly warmth. There is something very familiar and very powerful here. In the back of your fractured mind, you feel some familiarity.\n\n The landscale shifts into a clearing. Down into a hidden grove lies several crypts, long since subsided and buried within the hills. Many are completely covered while a few have unwelcome squatters — greenskins. Of the larger variety.\n The sense of power lingers down into their camp. It will be a dangerous fight, but likely worthwhile.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Lead the legion down into the camp.",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "Let\'s not disturb what rests here.",
					function getResult( _event )
					{
						if (this.World.State.getLastLocation() != null)
						{
							this.World.State.getLastLocation().setVisited(false);
						}

						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({ //\n\n —
			ID = "B",
			Text = "[img]gfx/ui/events/event_93.png[/img]{The greenskins initially ignore your approach — optin to go about their business fighting one another or thinking about fighting one another. However, as you descend down the hill, more of them take notice and ready their weapons. The tide of metal and flesh is near endless, with a particually large lump of a creature leading from the front.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "For the Emperor!",
					function getResult( _event )
					{
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.CombatID = "Event";
						properties.Music = this.Const.Music.OrcsTracks;
						properties.IsAutoAssigningBases = false;
						properties.Entities = [];
						this.Const.World.Common.addUnitsToCombat(properties.Entities, this.Const.World.Spawn.OrcBoss, this.Math.rand(220), this.Const.Faction.Enemy);
						this.World.State.startScriptedCombat(properties, false, false, true);
						return 0;
					}
				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({ //\n\n —
			ID = "Victory",
			Text = "[img]gfx/ui/events/event_81.png[/img]{The last brute is slain — even half dead or partially dismembered they continue to put up a fight as slash after slash rains down on them. You take time to scout the tombs, many of which have been defiled. Skin hangs as parchment across the antechambers, with large fists and fat hands marking something significant. A receeded sarcophagus in a central room is filled with a black-brown broth, which bubbles of its own accord.\n\n %companyname% begins excavating the sealed tombs. After several false starts and dashed hopes, a few remain mostly intact. One item in particular stands out. Wielding it, the humming in your mind ceases.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "We got what we came for.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Title = "After the battle...";

				if (this.World.State.getLastLocation() != null)
				{
					this.World.State.getLastLocation().die();
				}

				this.World.Assets.getStash().makeEmptySlots(1);
				local item = this.new("scripts/items/weapons/legendary/legend_ram_hammer");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + item.getName()
				});
				// this.World.Flags.set("IsMastabaDefeated", true);
			}

		});
		this.m.Screens.push({ //\n\n —
			ID = "Defeat",
			Text = "[img]gfx/ui/events/event_73.png[/img]You beat a hasty retreat from the clearing — you turn this way and that through the trees, bushes and overgrown ruins.\n\n What remains of the company waits on your orders. However, you realise that while you lost your persuers you also lost the trail leading back into the hidden grove. You will need to come back again to find it later...",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "We should return here when we are more ready.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Title = "After the battle...";

				if (this.World.State.getLastLocation() != null)
				{
					this.World.State.getLastLocation().setVisited(false);
				}
			}

		});
	}

	function addLootToScriptedCombat( _properties )
	{
		for (local i = 0; i < ::Math.rand(4, 5); ++i)
		{
			_properties.Loot.push("scripts/items/" + ::MSU.Array.rand(m.LootTable));
		}
	}

	function onUpdateScore()
	{
		local currentTile = this.World.State.getPlayer().getTile();

		//see 'static_functions' ::Legends.S.humansOnly for more details.
		if (::World.Assets.getOrigin().getID() != "scenario.legend_risen_legion") {
			return;
		}

		local hasSkeleton = false;
		foreach (bro in ::World.getPlayerRoster().getAll()) {
    		if (bro.getFlags().has("PlayerSkeleton")) {
				hasSkeleton = true;
				break;
			}
		}

		if (!hasSkeleton) {
    		return; 
		}

		local locations = this.World.EntityManager.getLocations();
		local nearSite = false;
		local currentTile = this.World.State.getPlayer().getTile();

		foreach( v in locations )
		{
			if (v.getTypeID() == "location.goblin_city" && v.getTile().getDistanceTo(currentTile) < 6)
			{
				nearSite = true;
				break;
			}
		}

		if (!nearSite)
		{
			return;
		}

		this.m.Score = 65;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}

});

