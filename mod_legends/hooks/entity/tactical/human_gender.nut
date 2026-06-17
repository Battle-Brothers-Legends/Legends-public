::mods_hookDescendants("entity/tactical/human", function (o) {
	if ("create" in o) {
		local create = o.create;
		o.create = function () {
			create();
			if (this.m.Gender == -1) {
				// if not forced before by specific human implementation
				this.setGender(this.randomizeHumanGender());
			}
		}
	}

	o.randomizeHumanGender <- function () {
		if (::Math.rand(1, 100) <= ::Legends.Mod.ModSettings.getSetting("FemaleGenderPercent").getValue()) {
			return 1;
		} else {
			return 0;
		}
	}

	o.randomizeEnemyGender <- function () {
		if (::Math.rand(1, 100) <= ::Legends.Mod.ModSettings.getSetting("EnemyFemaleGenderPercent").getValue()) {
			return 1;
		} else {
			return 0;
		}
	}
})
