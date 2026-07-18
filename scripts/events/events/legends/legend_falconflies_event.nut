this.legend_falconflies_event <- this.inherit("scripts/events/event", {
	m = {
		Falconhandler = null,
		Falcon = null,
		Town = null
	},
	function create() {
		this.m.ID = "event.legend_falconflies"; //—
		this.m.Title = "At %townname%";
		this.m.Cooldown = 60.0 * this.World.getTime().SecondsPerDay; //falcon flies into a house and steals something
		this.m.Screens.push({
			ID = "A",
			Text = "%townImage%While in %townname%, you take the time to provision and make ready for the next part of your journey. %falconhandler% starts to wrestle with their birdcage, trying to keep it under control as the angry avian is desperate to get out. %They_falconhandler% mounts %their_falconhandler% bodyweight onto the cage and instead ends up having %their_falconhandler% fingers clipped and clawed by the animal inside for the effort. %SPEECH_ON%I think she wants out \'fer a bit.%SPEECH_OFF% The bird begins to calm down a little and chirps like a songbird in agreement — as if it knew exactly what was going on.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "Alright, let her out for a bit.",
				getResult = @(_event) "B"
			}, {
				Text = "Get the bird under control and let\'s get going.",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.Characters.push(_event.m.Falconhandler.getImagePath());
			}
		});
		this.m.Screens.push({
			//pt.2
			ID = "B",
			Text = "%townImage%%falconhandler% sets down the cage on a nearby bench, much to the curiosity of the onlookers. %falconhandler% lays down the rest of %their_falconhandler% gear and begins to unbolt the cage, much to the delight of the prisoner inside who is now trying to help lift the bolt with its beak. %falconhandler% pinches the bolt between %their_falconhandler% fingers and turns back to you. %SPEECH_ON%Look, if I pull this door open, she might not be comin\' back. I ain\'t learnt to fly yet so unless you can we\'d be missin\' a bird. %SPEECH_OFF%The bird jostles in agreement. Or protest? You don\'t speak bird.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "I\'m sure. Let her out.",
				getResult = @(_event) "C"
			}, {
				Text = "I\'ve changed my mind. Keep her inside.",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.Characters.push(_event.m.Falconhandler.getImagePath());
			}
		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_20.png[/img]The falcon launches itself out of the cage at a blistering speed, barely clearing the head of an onlooker. It perches at the very apex of a large townhouse and eyes you in contempt before unfurling their wings for all to see.\n The falcon spies a target in the distance and pushes off from the rooftop in a manner both graceful and forceful.\n\n A few moments turn into minutes.\n Then the minutes into something much longer as you are waiting for something else to happen. %falconhandler% scratches %their_falconhandler% chin and picks up the empty cage, which a lone merchant is already eying up to make an offer on. %SPEECH_ON%Uh...capt\'n?%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "Off she goes!",
				getResult = @(_event) ::Math.rand(1, 100) <= 66 ? "FlyAway" : "Reward"
			}],
			function start(_event) {
				this.Characters.push(_event.m.Falconhandler.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "FlyAway",
			Text = "[img]gfx/ui/events/event_64.png[/img]Maybe we should wait a little longer?",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "Any minute now...",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.Characters.push(_event.m.Falconhandler.getImagePath());
				_event.m.Falcon.getContainer().unequip(_event.m.Falcon);
				this.List.push({
					id = 10,
					icon = "ui/items/" + _event.m.Falcon.getIcon(),
					text = _event.m.Falcon.getName() + " flies away."
				});
			}

		});
		this.m.Screens.push({
			ID = "Reward", //reward
			Text = "[img]gfx/ui/events/event_20.png[/img]The winged terror comes back into view after circling the sky for a moment or two, just before tucking in its wings and falling into a controlled dive. The avian arrow swoops into an open window — where a cacophony of screams, falling pans, overturned furniture and more screaming of both bird and man alike can be heard.\n\n The falcon quickly egresses from the window as a tattered and bleeding man screams for help from the balcony. The bird beats a hasty retreat into the cage, which %falconhandler% is holding aloft %their_falconhandler% head with the cage door wide open. The bird nestles down on their perch and closes the cage door itself with a bloody beak.\n It is at this point that you both notice a small bag tightly gripped in one claw, which she is now playfully ripping at as if disembowelling a mouse. Between the claws and beak you can make out faint glimmers of gold.",
			Image = "",
			List = [],
			Characters = [],
			Options = [{
				Text = "Never a doubt in my mind!",
				getResult = @(_event) 0
			}],
			function start(_event) {
				this.Characters.push(_event.m.Falconhandler.getImagePath());
				this.List.push(::Legends.EventList.changeMoney(::Math.rand(103, 314)));
			}
		});
	}

	function onUpdateScore() {
		if (!this.World.getTime().IsDaytime)
			return;

		local town = ::Legends.S.getClosestSettlement(@(_, t) t.isAlliedWithPlayer());
		if (town == null || town.getTile().getDistanceTo(::World.State.getPlayer().getTile()) > 3)
			return;

		local candidates = ::World.getPlayerRoster().getAll().filter(function (_, _bro) {
			local item = _bro.getItems().getItemAtSlot(::Const.ItemSlot.Accessory);
			return item != null && (item.getID() == "accessory.falcon");
		});
		if (candidates.len() == 0)
			return;

		this.m.Falconhandler = candidates[::Math.rand(0, candidates.len() - 1)];
		this.m.Falcon = this.m.Falconhandler.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);
		this.m.Town = town;
		this.m.Score = candidates.len() * 15;
	}

	function onPrepare() {}

	function onPrepareVariables(_vars) {
		_vars.push([
			"falconhandler",
			this.m.Falconhandler.getNameOnly()
		]);
		_vars.push([
			"falcon",
			this.m.Falcon.getName()
		]);
		_vars.push([
			"townname",
			this.m.Town.getName()
		]);
	}

	function onClear() {
		this.m.Falconhandler = null;
		this.m.Falcon = null;
		this.m.Town = null;
	}
});

