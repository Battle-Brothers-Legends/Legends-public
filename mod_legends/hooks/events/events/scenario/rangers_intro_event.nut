::mods_hookExactClass("events/events/scenario/rangers_intro_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.start <- function (_event) {
					this.Banner = "ui/banners/" + this.World.Assets.getBanner() + "s.png";
				}
			}
		}
	}
})
