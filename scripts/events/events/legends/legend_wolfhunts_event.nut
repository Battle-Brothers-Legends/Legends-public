this.legend_wolfhunts_event <- this.inherit("scripts/events/event", {
	m = {
		Wolfhandler = null,
		Wolf = null,
		Town = null
	},
	function create()
	{
		this.m.ID = "event.legend_wolfhunts_event"; //— \'
		this.m.Title = "Near %townname%";
		this.m.Cooldown = 60.0 * ::World.getTime().SecondsPerDay; //wolf picks up a scent and catches a bandit, brings anotehr wolf back or hunts an animal
		this.m.Screens.push({
			ID = "A",
			Text = "%townImage%Some distance from %townname%, the company makes camp. Far enough away to escape any drunk militia, but close enough to make a break for safety. The sun wanes and as it does so, your wolf becomes more agitated — this creature is far from the dogs more common in these lands, and laity often gawk at having such a wild beast so close at all times. To them, your wolf may as well be bound by magic, which you hope is the case consdiering how much it trashes around in it's clearly-too-small of a cage. %wolfhandler% stands by, chin crandled in hand and deep in thought. %SPEECH_ON%I'd let it out, but I can't be sure what it'd do. These aren't the normal dogs. If it bolts it'll be gone for good and I ain't gettin' in it's way...%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "Open the cage.",
				getResult = @(_event) "B" //pt.2
			}, {
				Text = "It'll get out on our next contract.",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.Characters.push(_event.m.Wolfhandler.getImagePath());
			}
		});
		this.m.Screens.push({ //\n\n
			ID = "B",
			Text = "%townImage%%wolfhandler% grimaces, and with a practiced motion, %they% pulls the partion up and the wolf, in some confusion, stays put. You wonder if it thought it'd get this far at all. Your handler quickly wraps a chain around it's neck, which the wolf surprisingly does not seem to mind. \nAfter a few moments, the wolf hoists it's nose up in the air and gingerly exits the cage fully...",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "I hope we don't regret this...",
				function getResult(_event) {
					local r = ::Math.rand(1, 100);
					if (r <= 35)
						return "C"; //runs away
					if (r <= 40)
						return "D"; //catch bear (weaker reward)
					if (r <= 65)
						return "E"; //catch bandit (moderate reward)
					return "F"; //find item (best reward)
				}
			}],
			function start(_event) {
				this.Characters.push(_event.m.Wolfhandler.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "C", //runs away
			Text = "[img]gfx/ui/events/event_36.png[/img]The wolf takes great care around the camp, absorbing all the sights and smells it comes across. At times it yanks on the chain of %wolfhandler%, but no more than a curious and distracted dog would. After the third pass around the camp, the wolf has devised an escape plan — through careful testing of how strong a grip the chain has on it, it quickly doubles back between the legs of %houndhandler%, pulling %them% downwards and then along the muck. In shock and pain, their grip loosens enough for a firm and final yank.\n\nBefore you can process what happened, the clattering of the chain disappears into the night.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "Fark it.",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.Characters.push(_event.m.Wolfhandler.getImagePath());
				_event.m.Wolf.getContainer().unequip(_event.m.Wolf);
				this.List.push({
					id = 10,
					icon = "ui/items/" + _event.m.Wolf.getIcon(),
					text = _event.m.Wolf.getName() + " escapes."
				});
			}

		});
		this.m.Screens.push({
			ID = "D", //do drugs, fight a bear //\n\n
			Text = "[img]gfx/ui/events/event_44.png[/img]The wolf tracks a figure around the camp, plotting a course to the outskirts. It freezes dead and looks into a secluded corpse of trees. In the next moment, undaunted, it yanks %wolfhandler% towards the treeline, who shoots you a concerned look as they are dragged ever closer to the darkness.\n\nUnder the treeline now, the moon barely touches the land here — tall bushes begin to look like men lying in wait, whistling wind starts to feel as if arrows have just missed you and every movement of the trees your mind takes account of. %houndhandler% suddenly stops, almost falling over the wolf as it comes to a dead halt. Then the growling starts.\n\n A bear, slick with blood and moving at a stumble, emerges from a hollow. Your wolf slips the chain and bounds at the giant, cutting into it's flank before retreating out of range. It looks at you both with a quiet intelligence, expecting you to act. This is not an idle expediton, you are part of the pack now.\n%houndhandler% raises their weapon and charges in, followed by yourself. The wounded bear stands little chance against three attackers from differant angles, and falls quickly.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "A good hunt!",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.Characters.push(_event.m.Wolfhandler.getImagePath());
				this.List.extend(::Legends.EventList.addItems([
					::new("scripts/items/supplies/legend_bear_meat_item"),
					::new("scripts/items/supplies/legend_bear_meat_item"),
					::new("scripts/items/loot/legend_bear_fur_item")
				], ::World.Assets.getStash()));
			}
		});
		this.m.Screens.push({
			ID = "E", //catch bandit //\n\n
			Text = "[img]gfx/ui/events/event_39.png[/img]%wolf% begins at a steady pace, only to pick up once you come across a foot trail in a furrow. It looks both ways and moves up and down the track for some time, before comitting to the east. The moon plaes the path as you quietly make your down into a cluster of trees. You are some way away from camp now — but another fire sets the shadows alight. A group of brigands camps in the forest, nursing wounds and tending their weapons. The wolf, however, picks a lone prey far away from the camp, chossing a brigand relieving himself against a tree. With his back turned, %wolfhandler% senses the plan and lets loose with a cheerful grin.\n\nThe wolf bounds at the man, pushing him against the tree and biting his head, which his helmet barely protects him from. Shaking the wolf loose, he makes a dash for the camp. %SPEECH_ON%THER'S A FARKIN' MONSTER I' TH' WOODS!%SPEECH_OFF% Brigands being true to their nature, snatch whatever is to hand and spread out into the darkness, the wolf still in hot pursuit of it's quarry.\n\n As you pick through the camp, the wolf returns with bloody crumpled helmet in their jaws, dropping it like a ball to rest by the still flickering fire. Not much was in the camp to begin with, but the brigands did leave their lockbox behind...",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "At least someone is earning their keep.",
				getResult = @(_event) 0
			}],
			function start( _event ) {
				this.Characters.push(_event.m.Wolfhandler.getImagePath());
				this.List.push(::Legends.EventList.changeMoney(::Math.rand(721, 1578)));
			}
		});
		this.m.Screens.push({
			ID = "F", //find item (best reward) //\n\n —
			Text = "[img]gfx/ui/events/event_83.png[/img]%wolf% darts into the treeline, completely slipping the chain of %wolfhandler%. Flying like an arrow, the wolf bounds into the brush with no hesitation. You squint in the darkness and in doing so, are met with a hail of arrows in response. The whole company is now on alert, and quickly rushes into the woods after their wolf. \n\nThe ambush site is a massacre — dead and dying greenskins litter the roots, %wolf% is engaged with a more ornately armoured and scarred goblin, who is quickly overpowered by the beast twice his size. His skull collapses with a sickening crunch as your wolf pins him down.\n A handful of stragglers remain, which are quickly finished off by the company. If not for your furry friend, your camp might've looked similar as the night went on. %wolfhandler% picks over the corpse of the goblin leader, finding a well crafted bow in the process.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "Good boy.",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.Characters.push(_event.m.Wolfhandler.getImagePath());
				this.List.extend(::Legends.EventList.addItems([
					::new("scripts/items/weapons/named/named_goblin_heavy_bow")
				], ::World.Assets.getStash()));
			}
		});
	}

	function onUpdateScore() {
		if (::World.getTime().IsDaytime)
			return;

		local closestTown = ::Legends.S.getClosestSettlement(@(_, t) t.isAlliedWithPlayer());
		if (closestTown == null || closestTown.getTile().getDistanceTo(::World.State.getPlayer().getTile()) > 5)
			return;

		local brothers = ::World.getPlayerRoster().getAll();
		local candidates = [];

		foreach (bro in brothers) {
			local item = bro.getItems().getItemAtSlot(::Const.ItemSlot.Accessory);
			if (item != null && (item.getID() == "accessory.legend_wolf_item")) {
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
			return;

		this.m.Wolfhandler = candidates[::Math.rand(0, candidates.len() - 1)];
		this.m.Wolf = this.m.Wolfhandler.getItems().getItemAtSlot(::Const.ItemSlot.Accessory);
		this.m.Town = closestTown;
		this.m.Score = candidates.len() * 10;
	}

	function onPrepareVariables(_vars) {
		_vars.push([
			"wolfhandler",
			this.m.Wolfhandler.getNameOnly()
		]);
		_vars.push([
			"wolf",
			this.m.Wolf.getName()
		]);
		_vars.push([
			"townname",
			this.m.Town.getName()
		]);
	}

	function onClear() {
		this.m.Wolfhandler = null;
		this.m.Wolf = null;
		this.m.Town = null;
	}
});
