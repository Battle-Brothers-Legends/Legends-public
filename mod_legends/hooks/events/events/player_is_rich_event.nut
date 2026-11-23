::mods_hookExactClass("events/events/player_is_rich_event", function(o) {
	o.onUpdateScore = function () {
		if (this.World.Assets.getOrigin().getID() == "scenario.lone_wolf")
			return;

		if (this.World.Assets.getMoney() <= 30000)
			return;

		if (this.World.getPlayerRoster().getSize() < 5)
			return;

		if (this.World.Retinue.hasFollower("follower.paymaster"))
			return;

		local brothers = this.World.getPlayerRoster().getAll();
		local numBros = 0;

		foreach( bro in brothers ) {
			if (bro.getBackground().getID() != "background.slave" && !bro.isStabled()) {
				numBros = ++numBros;
			}
		}

		if (numBros < 2)
			return;

		this.m.Score = (this.World.Assets.getMoney() - 30000) * 0.0005;
	}
})
