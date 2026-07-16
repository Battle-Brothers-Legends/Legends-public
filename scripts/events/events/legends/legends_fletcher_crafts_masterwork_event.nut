this.legends_fletcher_crafts_masterwork_event <- this.inherit("scripts/events/event", {
	m = {
		Bowyer = null
	},
	function create() {
		this.m.ID = "event.legends.fletcher_crafts_masterwork";
		this.m.Title = "During camp...";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]%bowyer% the fletcher comes to you with a bit of request: %they_bowyer% wish to build a weapon for the ages. Apparently, %bowyer% has been attempting to build a quiver of legendary qualities for many years, but now that %they_bowyer%\'s been on the road %they_bowyer%\'s picked up a few things to fill in the gaps of knowledge. Truly, %bowyer% believes %they_bowyer% can get it right this time. All the mercenary needs is a few resources to help procure the elements needed to construct it. A sum of 500 crowns is humbly requested, and the unhold skin you carry.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "Build me a quiver of legends!",
				getResult = @(_event) ::Math.rand(1, 100) <= 60 ? "B" : "C"
			}, {
				Text = "We don\'t have time for this.",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.Characters.push(_event.m.Bowyer.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_05.png[/img]{The quiver isn\'t quite legendary, but it is quite good. It\'s light on the shoulder, well constructed and holds a huge amount of arrows. You have never seen such a well stitched quiver, or a shoulder strap so comfortable. You congratulate the fletcher.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "A masterwork!",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.Characters.push(_event.m.Bowyer.getImagePath());

				local item = ::Const.World.Common.pickItem([
					[1, "ammo/legend_huge_quiver_of_arrows"],
					[1, "ammo/legend_huge_quiver_of_bolts"]
				], "scripts/items/");
				item.m.Name = _event.m.Bowyer.getNameOnly() + "\'s " + item.m.Name;

				this.List.push(::Legends.EventList.changeMoney(-500));
				this.List.push(_event.loseHide());
				this.List.extend(::Legends.EventList.addItems([item], ::World.Assets.getStash()));
				this.List.push(::Legends.EventList.changeMood(_event.m.Bowyer, 2.0, "Created a masterwork"));
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_05.png[/img]Is this thing a child\'s attempt? It barely holds any shafts, the string it hangs from is tied together with a rough knot, and you swear it is held together with spit and wishes.\n\nYou ease the fletcher\'s pain by blaming yourself for not understanding the worksmanship, but %randombrother% and %randombrother2% both give it a try and come to even worse results. The fletcher eventually shuffles off, cradling the construction before tossing it onto the stockpile of weapons where it looks just like any other cheap quiver.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "I see now why you\'re no longer working as a fletcher.",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.Characters.push(_event.m.Bowyer.getImagePath());

				local item = ::Const.World.Common.pickItem([
					[1, "ammo/quiver_of_arrows"],
					[1, "ammo/quiver_of_bolts"]
				], "scripts/items/");
				item.m.Name = _event.m.Bowyer.getNameOnly() + "\'s " + item.m.Name;

				this.List.push(::Legends.EventList.changeMoney(-500));
				this.List.push(_event.loseHide());
				this.List.extend(::Legends.EventList.addItems([item], ::World.Assets.getStash()));
				this.List.push(::Legends.EventList.changeMood(_event.m.Bowyer, -1.0, "Failed in creating a masterwork"));
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_05.png[/img]You tell the bowyer that the %companyname% has no resources to spare. %Their_bowyer% teeth grind, and apparently whatever words were going to be said, for the artisan says nothing and turns on heels and stomps off. In the distance you finally hear what kindness %they_bowyer% had in store for you - a litany of swearing and cursing and eventually moaning disappointment.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "Pull yourself together.",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.Characters.push(_event.m.Bowyer.getImagePath());
				this.List.push(::Legends.EventList.changeMood(_event.m.Bowyer, -2.0, "Was denied a request"));
			}

		});
	}

	function loseHide() {
		local stash = ::World.Assets.getStash().getItems();
		foreach (i, item in stash) {
			if (item != null && item.getID() == "misc.unhold_hide") {
				stash[i] = null;
				return {
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You lose " + item.getName()
				};
			}
		}
	}

	function onUpdateScore() {
		if (this.World.Assets.getMoney() < 2000)
			return;

		local brothers = this.World.getPlayerRoster().getAll();
		if (brothers.len() < 3)
			return;

		local candidates = [];
		foreach (bro in brothers) {
			if (bro.getLevel() >= 6 && ::Legends.Backgrounds.has(bro, ::Legends.Background.Bowyer)) {
				candidates.push(bro);
			}
		}
		if (candidates.len() == 0)
			return;

		local stash = this.World.Assets.getStash().getItems();
		local numWood = 0;

		foreach (item in stash) {
			if (item != null && item.getID() == "misc.unhold_hide") {
				numWood++;
				break;
			}
		}

		if (numWood == 0) {
			return;
		}

		this.m.Bowyer = candidates[::Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 4;
	}

	function onPrepareVariables(_vars) {
		_vars.push([
			"bowyer",
			this.m.Bowyer.getNameOnly()
		]);
	}

	function onClear() {
		this.m.Bowyer = null;
	}

});

