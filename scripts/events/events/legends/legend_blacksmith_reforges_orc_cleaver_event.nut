this.legend_blacksmith_reforges_orc_cleaver_event <- this.inherit("scripts/events/event", {
	m = {
		Blacksmith = null
	},
	function create() {
		this.m.ID = "event.legend_blacksmith_reforges_orc_cleaver"; //—
		this.m.Title = "During camp...";
		this.m.Cooldown = 60.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]While at a short rest, %blacksmith% is ideally amusing %themselves_blacksmith% by digging through the company stash — reorganising various items to be in better order. Eventually %they_blacksmith% come across a worn orc cleaver that has seen better days. %blacksmith% notices you and brings the weapon to your attention. %SPEECH_ON%If I were two foot taller and about half as smart I\'d say this is almost a decent weapon.%SPEECH_OFF% The blacksmith carefully turns the blade in %their_blacksmith% hands, inspecting every angle as an artist would a painting. %SPEECH_ON%There\'s a warp running along the blade and the spine \'as a crack in it, you\'ve got a really bad amount of edge damage around the tip here as well. On top of that — it is far too heavy to swing and I can barely hold it in one hand. If I swung this thing too hard I\'d likely go with it...%SPEECH_OFF% %blacksmith% scratches %their_blacksmith% chin and gently puts the blade back in the cart. %SPEECH_ON%I don\'t know what its made of, but I can have a try at just reforging the whole thing if you give me a thousand crowns to cover my materials and I can start right now — but the blade may already be too far gone...%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "It is worth the risk.",
				getResult = @(_event) ::Math.rand(1, 100) <= 60 ? "Success" : "Fail"
			}, {
				Text = "We don\'t have time for this.",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.Characters.push(_event.m.Blacksmith.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "Success",
			Text = "[img]gfx/ui/events/event_05.png[/img]%blacksmith% warms up the blade and hammers on it for some time — quickly twisting it this way and that as the blade cycles between hot and cold. %They_blacksmith% fights with the crude weapon until it begins to take a more sleek and finer form, losing some of the bloated mass of metal from both sides.\n %They_blacksmith% takes it to the grindstone and slowly resharpen all the edges from haft to tip, lastly dressing the handle in something more comfortable for human hands.\n\n While not an artistic masterpiece, you can\'t deny that improvements have been made to the performance of the weapon overall.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "Much better!",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.Characters.push(_event.m.Blacksmith.getImagePath());
				this.List.push(::Legends.EventList.changeMoney(-1000));
				this.List.push(_event.loseItem());
				this.List.extend(::Legends.EventList.addItems([
					::new("scripts/items/weapons/named/named_orc_cleaver")
				], ::World.Assets.getStash()));
				this.List.push(::Legends.EventList.changeMood(_event.m.Blacksmith, 1.5, "Reforged a primitive weapon"));
			}

		});
		this.m.Screens.push({
			//Fail
			ID = "Fail",
			Text = "[img]gfx/ui/events/event_05.png[/img]%blacksmith% warms up the blade and hammers on it for some time — quickly twisting it this way and that as the blade cycles between hot and cold. %They_blacksmith% fight with the crude weapon until it begins to take a more sleek and finer form, %blacksmith% begins to curse under %their_blacksmith% breath as %they_blacksmith% puts the weapon back into %their_blacksmith% forge to reheat it. This happens again several times more as %they_blacksmith% fights with the metal more and more.\n\n After the fourth attempt, the blade eventually cracks and snaps in two under the weight of %their_blacksmith% hammer. %blacksmith% gracefully accepts this by whispering insults at the blade before tossing it into the undergrowth with an almighty force.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "Shame.",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.Characters.push(_event.m.Blacksmith.getImagePath());
				this.List.push(::Legends.EventList.changeMoney(-1000));
				this.List.push(_event.loseItem());
				this.List.push(::Legends.EventList.changeMood(_event.m.Blacksmith, -1.0, "Failed to reforge a weapon"));
			}
		});
	}

	function findItem() {
		local stash = ::World.Assets.getStash().getItems();
		foreach (item in stash) {
			if (item != null && item.getID() == "weapon.orc_cleaver")
				return item;
		}
		return null;
	}

	function loseItem() {
		local item = this.findItem();
		::World.Assets.getStash().remove(item);
		return {
			id = 10,
			icon = "ui/items/" + item.getIcon(),
			text = "You lose " + ::Const.Strings.getArticle(item.getName()) + item.getName()
		};
	}

	function onUpdateScore() {
		local brothers = ::World.getPlayerRoster().getAll();
		local candidates = [];

		foreach (bro in brothers) {
			if (bro.getLevel() >= 7 && ::Legends.Backgrounds.has(bro, ::Legends.Background.LegendBlacksmith)){
				candidates.push(bro);
			}
		}
		if (candidates.len() == 0)
			return;

		if (this.findItem() == null)
			return;

		this.m.Blacksmith = candidates[::Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 4;
	}

	function onPrepare() {}

	function onPrepareVariables(_vars) {
		_vars.push([
			"blacksmith",
			this.m.Blacksmith.getNameOnly()
		]);
	}

	function onClear() {
		this.m.Blacksmith = null;
	}
});

