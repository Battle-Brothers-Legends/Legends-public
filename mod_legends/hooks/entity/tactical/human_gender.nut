::mods_hookDescendants("entity/tactical/human", function (o) {
	if ("create" in o) {
		local create = o.create;
		o.create = function ()
		{
			create();
			if (this.m.Gender == -1) { // if not forced before by specific human implmentation
				if (this.Math.rand(1, 100) <= 25 && ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled")
					this.setGender(1);
				else
					this.setGender(0);
			}
		}
	}
})
