::mods_hookExactClass("events/events/special/retinue_slot_event", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		this.m.Cooldown = 33.0 * this.World.getTime().SecondsPerDay;

		foreach (s in this.m.Screens) {
			if (s.ID == "A") {
				s.Text = "[img]gfx/ui/events/event_26.png[/img]{The prestige and renown of the %companyname% is growing. Everywhere you go, people are looking to join - and not just sellswords, but followers who may be of other use! | With every battle your sellswords fight, the renown of the company grows. As this fame rises, more people, and not just sellswords, will be looking to join the %companyname%. Perhaps it is time the company invests in some special equipment? | Followers of the %companyname% need tools to fill their roles, and said tools would prove helpful to the survival of those around them...}";
			}
		}
	}
})
