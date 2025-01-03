::mods_hookExactClass("events/events/dlc2/addict_steals_potion_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Options = [
				{
					Text = "I just hope you\'ll heal in time. (Morals increased)",
					function getResult( _event ) {
						this.World.Assets.addMoralReputation(1);
						return 0;
					}
				},
				{
					Text = "This needs to stop now, %addict%.",
					function getResult( _event ) {
						return this.Math.rand(1, 100) <= 33 ? "C" : "D";
					}
				},
				{
					Text = "Enough. I\'ll have this bloody demon whipped out of you! (Morals decreased)",
					function getResult( _event ) {
						this.World.Assets.addMoralReputation(-1);
						return "B";
					}
				}
				];
			}
		}
	}
});
