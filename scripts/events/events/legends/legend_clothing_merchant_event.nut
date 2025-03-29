this.legend_clothing_merchant_event <- this.inherit("scripts/events/event", {
	m = {
		Bought = 0,
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.legend_clothing_merchant";
		this.m.Title = "Along the road...";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_158.png[/img]{A merchant comes into view, but this one seems to travel alone with various boxes and baggage gently josttling in the back of her cart. The wagon rocks back and fourth along the road like an uneasy animal finding it\'s feet, while two donkeys — one much more worse for wear than the other, pull the cart along.\n The woman is dressed in a mix of southern and northern silks, leather, mail and other parts that are stitched togeather to make something very memorable.%SPEECH_ON%Crownlings, Mercenaries, yes? You look like one or the other but I\'d rather know which i\'m talkin\' to before I tell you what I have — one has more of an urge for robbery than the other. I\'ll let you guess which.%SPEECH_OFF%Before you can muster a reply, she stands on the wagon seat — the whole contrapion rocks and wakes gently as the merchant finds her footing.%SPEECH_ON%I carry some of the finest cloths, silks and rare items you might find. As you can tell from what I wear — the best parts are not for sale. However, there is much more that could be yours. Tell me, are you of the gambling sort?%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Maybe, what\'s the stake?",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "Not interested, thanks.",
					function getResult( _event )
					{
						return "E";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_60.png[/img]{She grins.%SPEECH_ON%Well, you really have nothing to lose. In the back here I have a fine selection of items that I can give you for a very low price, all you have to do is pay up one-hundred-and-twenty-five crowns and I will pull a random item from a box without looking — whatever the result, you will always get something! %SPEECH_OFF%She scratches her chin, quite pleased with her performance thus far. Down below her the more sickly donkey hacks and coughs as if it were turning inside out.%SPEECH_ON%Don\'t mind him. He is almost as old as I am now. I found him grazing in a battlefield of all places.%SPEECH_OFF%She shoots the mule a piercing stare, which quickly cows the animal into silence.%SPEECH_ON%So, what will it be?%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "125 crowns? I\'ll take that gamble.",
					function getResult( _event )
					{
						_event.m.Bought = 1;
						return "C";
					}

				},
				{
					Text = "I'll take the mule instead, lets say for 3000 crowns?",
					function getResult( _event )
					{
						_event.m.Bought = 2;
						return "C";
					}

				},
				{
					Text = "Not interested.",
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
			ID = "C",
			Text = "[img]gfx/ui/events/event_98.png[/img]{You toss a bag of crowns to the merchant, who carefully counts each one as you count her with your eyes. She smiles down to you and gives you the change. After you make an exchange of coin and goods, she gets back up on her cart and brushes under her chin%SPEECH_ON%Be seeing you, friend.%SPEECH_OFF%The mules begin to lead the cart away, gently swaing along the path until they are out of sight. You have a feeling you may meet again.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "We\'ve got places to be.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				switch(_event.m.Bought)
				{
				case 1:
					local item = ::new(::MSU.Class.WeightedContainer([
						[1, "scripts/items/legend_helmets/vanity/legend_helmet_southern_top_tail"],
						[1, "scripts/items/legend_helmets/vanity/legend_helmet_wizard_cowl"],
						[1, "scripts/items/legend_helmets/vanity/legend_helmet_wreath"],
						[1, "scripts/items/legend_helmets/vanity/legend_helmet_warlock_hood"],
						[1, "scripts/items/legend_helmets/vanity/legend_helmet_royal_hood"],
						[1, "scripts/items/legend_helmets/vanity/legend_helmet_lion_pelt"],
						[1, "scripts/items/legend_armor/tabard/legend_noble_vest"],
						[1, "scripts/items/legend_helmets/vanity/legend_helmet_noble_buckle"],
						[1, "scripts/items/legend_armor/cloak/legend_noble_shawl"],
						[1, "scripts/items/legend_armor/cloth/legend_southern_noble_surcoat"],
						[1, "scripts/items/legend_helmets/vanity/legend_helmet_ponytail"],
						[1, "scripts/items/legend_helmets/vanity/legend_helmet_royal_hood"],
						[1, "scripts/items/legend_helmets/vanity/legend_helmet_southern_silk_headscarf"]
					]).roll());

					this.World.Assets.getStash().add(item); //add random item from above, take money, capitalism.
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
					});
					this.World.Assets.addMoney(-125);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "You spend [color=" + this.Const.UI.Color.NegativeEventValue + "]125[/color] Crowns"
					});
					break;

				case 2: //donkey bought and joins
					local roster = this.World.getTemporaryRoster();
					_event.m.Dude = roster.create("scripts/entity/tactical/player");
					_event.m.Dude.setStartValuesEx([
						"legend_donkey_background"
					]);

					_event.m.Dude.getBaseProperties().Hitpoints -= 35;
					_event.m.Dude.getBaseProperties().Stamina -= 25;
					_event.m.Dude.getBaseProperties().Initiative -= 40;

					this.World.getPlayerRoster().add(_event.m.Dude);
					this.World.getTemporaryRoster().clear();
					_event.m.Dude.onHired();

					this.World.Assets.addMoney(-2800);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "You spend [color=" + this.Const.UI.Color.NegativeEventValue + "]2800[/color] Crowns"
					});
					break;
				}
			}
		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_98.png[/img]{The merchant shrugs and gently sits back on the wagon.%SPEECH_ON%You\'ll be back.%SPEECH_OFF%She encourages the donkeys to move, and the sick donkey protests a little more before moving off.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Maybe next time.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_158.png[/img]{You nod and the merchant nods back, continuing on their journey.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "I wish I had that much free time...",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		if (this.World.Assets.getMoney() < 3500)
		{
			return;
		}

		if (this.World.Assets.getStash().getNumberOfEmptySlots() < 1)
		{
			return;
		}

		this.m.Score = 7;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
		this.m.Bought = 0;
		this.m.Dude = null;
	}

});

