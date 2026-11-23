::mods_hookExactClass("ambitions/ambitions/roster_of_12_ambition", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.SuccessText = "[img]gfx/ui/events/event_80.png[/img]Having finally gathered the coin and equipment, you manage to assemble a full complement of twelve able fighters. When next you walk down %currenttown%\'s main street, the men break into a full-throated marching song. A few of the townsfolk mutter under their breath about dirty mercenaries taking over the town, but others walk alongside and shout the words with you. %SPEECH_ON%Stand tall, brothers. People can see this is a real mercenary company now, and not a handful of wandering vagabonds.%SPEECH_OFF%%highestexperience_brother% declares.%SPEECH_ON%We trade in strength, and now that our numbers have gone up, so will our price.%SPEECH_OFF%It appears %they_veteranbrother% has the right of it. You notice one particularly fat nobleman sizing up the company as if he already has a task in mind. The %companyname% are now a force to be reckoned with. Once the men have settled in for a celebratory drink, perhaps you should take another stroll through town to see if any more lucrative contracts may be available.";
	}

	o.onUpdateScore = function () {
		if (this.World.Assets.getOrigin().getID() == "scenario.militia"	|| this.World.Assets.getOrigin().getID() == "scenario.lone_wolf") {
			return;
		}

		if (this.World.Ambitions.getDone() < 1	&& this.World.Assets.getOrigin().getID() != "scenario.deserters" && this.World.Assets.getOrigin().getID() != "scenario.raiders") {
			return;
		}

		if (this.World.Assets.getBrothersMax() < 12) {
			return;
		}

		local previous = this.World.Ambitions.getAmbition("ambition.legend_roster_of_6");
		if (previous.getScore() != 0 && !previous.isDone()) {
			return;
		}

		if (this.World.getPlayerRoster().getSize() >= 12) {
			this.m.IsDone = true;
			return;
		}

		this.m.Score = 1 + this.Math.rand(0, 5);
	}

});
