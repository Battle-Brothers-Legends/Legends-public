::mods_hookDescendants("skills/backgrounds/character_background", function(o) {
	o.randomizeHumanGender <- function () {
		if (::Math.rand(1, 100) <= ::Legends.Mod.ModSettings.getSetting("FemaleGenderPercent").getValue()) {
			return 1;
		} else {
			return 0;
		}
	}

	o.setCommanderGender <- function () {
		if(::Legends.Mod.ModSettings.getSetting("CommanderAvatarGender").getValue() == "Female"){
			return 1;
		} else if(::Legends.Mod.ModSettings.getSetting("CommanderAvatarGender").getValue() == "Male") {
			return 0;
		} else if (::Math.rand(1, 100) <= ::Legends.Mod.ModSettings.getSetting("FemaleGenderPercent").getValue()) {
			return 1;
		} else {
			return 0;
		}
	}
});
