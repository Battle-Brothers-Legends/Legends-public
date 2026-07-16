this.legend_blacksmith_craft_armor <- this.inherit("scripts/events/event", {
	m = {
		Blacksmith = null,
		NumIngots = null,
		Town = null
	},
	function create()
	{
		this.m.ID = "event.legend_blacksmith_craft_armor";
		this.m.Title = "At %townname%";
		this.m.Cooldown = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_01.png[/img]While walking around the town shopping you notice %blacksmith% looks like he has his mind on something else.%SPEECH_ON%What\'s the matter %blacksmith%?%SPEECH_OFF%%SPEECH_ON%Sir I don\'t know how to say this but you see we have this tradition in a craft smith community where we compete in the art of craft to prove who is worthy of a name \"King of Craftsmen\" and are proud to hold that title!%SPEECH_OFF% Is he talking about that legendary contest where smiths from all over the world gather and they craft the best items that are worthy to withstand blows of a behemoth?%SPEECH_ON%What is it that you need from me?%SPEECH_OFF%%SPEECH_ON% I need 10,000 to enter the contest to buy the metal and other supplies.%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [{
				Text = "Here it is",
				getResult = @(_event) ::Math.rand(1, 100) <= 50 ? "B" : "C"
			}, {
				Text = "We can\'t spare money on this",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.Characters.push(_event.m.Blacksmith.getImagePath());
				if (_event.m.NumIngots != null && _event.m.NumIngots >= 3) {
					this.Options.push({
						Text = "Use the Iron we have in stash instead",
						getResult = @(_event) ::Math.rand(1, 100) <= 60 ? "D" : "E"
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_31.png[/img]You give him the money and %blacksmith% in no time gets up and sets off to seek the best metal and begin working. As he finishes his work, he tells a story of a blacksmith who was called by a king. The king had summoned all of the guild masters. Calling them to the throne one at a time, he questioned each, then sent them to the opposite side of the hall from those who had not yet been questioned. The first craftsman that he spoke with was a carpenter. The king asked what he made. %SPEECH_ON% I make all things of wood. Houses, wagons, wheels, looms and so on. %SPEECH_OFF% The king asked where he got his tools, and the carpenter answered that he got them from the blacksmith. The second craftsman was a weaver. The king asked the weaver where he got his tools, the weaver said that he got them from the blacksmith. The third craftsman was a potter. When the king questioned him, he admitted that he too got his tools from the blacksmith. Finally, the king called the %blacksmith% to the throne. When he asked the blacksmith where he got His tools, the %blacksmith% answered %SPEECH_ON%I made them myself, for no one else could make tools for the working of iron.%SPEECH_OFF% The king announced that he had made his decision. Since the blacksmith was the only craftsman who did not have to obtain his tools from someone else but made them for himself, that henceforth and forever more, the Blacksmith would be known as the King of Craftsmen",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "A masterwork!",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.Characters.push(_event.m.Blacksmith.getImagePath());
				local item = ::Const.World.Common.pickArmor([
					[1, ::Legends.Armor.Named.named_golden_lamellar_armor]
				]);
				item.m.Upgrades[::Const.Items.ArmorUpgrades.Plate].m.Name = _event.m.Blacksmith.getNameOnly() + "\'s Golden Lamellar Armor";

				this.List.push(::Legends.EventList.changeMoney(-10000));
				this.List.extend(::Legends.EventList.addItems([item], ::World.Assets.getStash()));
				this.List.push(::Legends.EventList.changeMood(_event.m.Blacksmith, 2.0, "Created a masterwork Armor"));
			}
		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_31.png[/img]You give him the money and %blacksmith% in no time gets up and sets off to seek the best metal and begin working. As he finishes, he wipes the soot from his brown and sits down, defeated. You look at the freshly forged armor - a sturdy and functional suit, yet lacking the masterwork sheen",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "Failure...",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.Characters.push(_event.m.Blacksmith.getImagePath());
				local item = this.Const.World.Common.pickArmor([
					[1, ::Legends.Armor.Standard.heavy_lamellar_armor]
				]);
				item.m.Name = _event.m.Blacksmith.getNameOnly() + "\'s Failed Masterpiece";

				this.List.push(::Legends.EventList.changeMoney(-10000));
				this.List.extend(::Legends.EventList.addItems([item], ::World.Assets.getStash()));
			}
		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_31.png[/img]You give him the money and %blacksmith% in no time gets up and sets off to seek the best metal and begin working. As he finishes his work, he tells a story of a blacksmith who was called by a king. The king had summoned all of the guild masters. Calling them to the throne one at a time, he questioned each, then sent them to the opposite side of the hall from those who had not yet been questioned. The first craftsman that he spoke with was a carpenter. The king asked what he made. %SPEECH_ON% I make all things of wood. Houses, wagons, wheels, looms and so on. %SPEECH_OFF% The king asked where he got his tools, and the carpenter answered that he got them from the blacksmith. The second craftsman was a weaver. The king asked the weaver where he got his tools, the weaver said that he got them from the blacksmith. The third craftsman was a potter. When the king questioned him, he admitted that he too got his tools from the blacksmith. Finally, the king called the %blacksmith% to the throne. When he asked the blacksmith where he got His tools, the %blacksmith% answered %SPEECH_ON%I made them myself, for no one else could make tools for the working of iron.%SPEECH_OFF% The king announced that he had made his decision. Since the blacksmith was the only craftsman who did not have to obtain his tools from someone else but made them for himself, that henceforth and forever more, the Blacksmith would be known as the King of Craftsmen",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "A masterwork!",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.Characters.push(_event.m.Blacksmith.getImagePath());
				local item = ::Const.World.Common.pickArmor([
					[1, ::Legends.Armor.Named.named_golden_lamellar_armor]
				]);
				item.m.Upgrades[::Const.Items.ArmorUpgrades.Plate].m.Name = _event.m.Blacksmith.getNameOnly() + "\'s Golden Lamellar Armor";

				this.List.push(::Legends.EventList.changeMoney(-5000));
				this.List.extend(_event.removeIngots());
				this.List.extend(::Legends.EventList.addItems([item], ::World.Assets.getStash()));
				this.List.push(::Legends.EventList.changeMood(_event.m.Blacksmith, 2.0, "Created a masterwork Armor"));
			}
		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_31.png[/img]You give him the money and %blacksmith% in no time gets up and sets off to seek the best metal and begin working. As he finishes, he wipes the soot from his brown and sits down, defeated. You look at the freshly forged armor - a sturdy and functional suit, yet lacking the masterwork sheen",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "Failure...",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.Characters.push(_event.m.Blacksmith.getImagePath());
				local item = this.Const.World.Common.pickArmor([
					[1, ::Legends.Armor.Standard.heavy_lamellar_armor]
				]);
				item.m.Name = _event.m.Blacksmith.getNameOnly() + "\'s Failed Masterpiece";

				this.List.push(::Legends.EventList.changeMoney(-5000));
				this.List.extend(_event.removeIngots());
				this.List.extend(::Legends.EventList.addItems([item], ::World.Assets.getStash()));
			}
		});
	}

	function removeIngots() {
		local list = [];
		local stash = ::World.Assets.getStash().getItems();
		local numIngots = 0;
		foreach (i, item in stash) {
			if (item != null && item.getID() == "misc.legend_iron_ingots") {
				stash[i] = null;
				list.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You lose " + item.getName()
				});
				numIngots++;
			}

			if (numIngots >= 3)
				break;
		}
		return list;
	}

	function onUpdateScore() {
		if (!this.World.getTime().IsDaytime)
			return;

		if (this.World.Assets.getMoney() < 15000)
			return;

		local towns = ::World.EntityManager.getSettlements();
		local closestTown = ::Legends.S.getClosestSettlement(@(_, t) t.getSize() >= 3 && t.isAlliedWithPlayer());
		if (closestTown.getTile().getDistanceTo(::World.State.getPlayer().getTile()) > 3)
			return;

		this.m.Town = closestTown;
		local brothers = ::World.getPlayerRoster().getAll();
		local candidates_blacksmith = [];

		foreach (bro in brothers) {
			if (bro.getLevel() > 9 && ::Legends.Backgrounds.has(bro, ::Legends.Background.LegendBlacksmith))
				candidates_blacksmith.push(bro);
		}

		if (candidates_blacksmith.len() < 1)
			return;

		this.m.Blacksmith = candidates_blacksmith[::Math.rand(0, candidates_blacksmith.len() - 1)];

		local stash = ::World.Assets.getStash().getItems();
		this.m.NumIngots = stash.filter(@(_, item) item != null && item.getID() == "misc.legend_iron_ingots").len();
		this.m.Score = 25;
	}

	function onPrepare() {}

	function onPrepareVariables(_vars) {
		_vars.push([
			"blacksmith",
			this.m.Blacksmith.getName()
		]);
		_vars.push([
			"townname",
			this.m.Town.getName()
		]);
	}

	function onClear() {
		this.m.Blacksmith = null;
		this.m.NumIngots = null;
		this.m.Town = null;
	}
});

